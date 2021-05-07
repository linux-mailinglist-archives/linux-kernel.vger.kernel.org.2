Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C05376B38
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhEGUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhEGUlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:41:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5F4961451;
        Fri,  7 May 2021 20:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620420055;
        bh=kuhZl1cpux8KIahaPtnjkqBK3+KnZu5S/hlyXMn3NGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXyiiYiJ3Y5BsCajBgft+PmS4Sv/U1tkuNTGEOAmHEdLN2eIxz/oXUGnyRGMOijek
         2NMdcNZ61cvlDUiTXbvmXD4jAaY5/KMbMLmW0Gm1koVkPRZSlTsZuSTxoXo9KvCVSX
         LoJ6l0sKfEiCTunEuPdi9xn1lbCbTCS0kwutB5y9hMeGGsIpy5qML37ZjICfOaUcLw
         fX+zGhgGFccCV1y5IUTbkjrfaKNvyhWl2LmE39iYiazXBG637hrBrwkUwsMcYpFmi+
         kyn9qm5nc+YIUuPG2fVSJ7/EIib3uFzqUGKXLYJKeMpzJKn1OoB2qZBmVAzV7Fasrc
         xuW3pK2UPyxYQ==
Date:   Fri, 7 May 2021 13:40:52 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 01:26:11PM -0700, Sagi Grimberg wrote:
> 
> > > > > I would also mention, that a crash is not even the scariest issue that
> > > > > we can see here, because if the request happened to be reused we are
> > > > > in the silent data corruption realm...
> > > > 
> > > > If this does happen, I think we have to come up with some way to
> > > > mitigate it. We're not utilizing the full 16 bits of the command_id, so
> > > > maybe we can append something like a generation sequence number that can
> > > > be checked for validity.
> > > 
> > > That's actually a great idea. scsi needs unique tags so it encodes the
> > > hwq in the upper 16 bits giving the actual tag the lower 16 bits which
> > > is more than enough for a single queue. We can do the same with
> > > a gencnt that will increment in both submission and completion and we
> > > can validate against it.
> > > 
> > > This will be useful for all transports, so maintaining it in
> > > nvme_req(rq)->genctr and introducing a helper like:
> > > rq = nvme_find_tag(tagset, cqe->command_id)
> > > That will filter genctr, locate the request.
> > > 
> > > Also:
> > > nvme_validate_request_gen(rq, cqe->command_id) that would
> > > compare against it.
> > > 
> > > 
> > > And then a helper to set the command_id like:
> > > cmd->common.command_id = nvme_request_command_id(rq)
> > > that will both increment the genctr and build a command_id
> > > from it.
> > > 
> > > Thoughts?
> > > 
> > 
> > Well, that would require a modification to the CQE specification, no?
> > fmds was not amused when I proposed that :-(
> 
> Why would that require a modification to the CQE? it's just using say
> 4 msbits of the command_id to a running sequence...

I think Hannes was under the impression that the counter proposal wasn't
part of the "command_id". The host can encode whatever it wants in that
value, and the controller just has to return the same value.
