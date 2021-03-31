Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4B93508B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhCaVC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhCaVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617224509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VK3wZ2uZxurW5NHYBbFfGkqs4fcBNPjrFax0D4qhIZg=;
        b=EYa8Cibp1d+Tah81lcga/f3ImhkRWT32tjnCscpyEXnOxq8GQ0E+A30265OK/yWj2hi7ei
        G29maTvVzp6G0BRJKA5b4mr/K/JcCtNXekdPdmas+16Ni8Pw33cVf1xlOrfVE9ffYuI9U6
        owLOBc1mnP/xqdhOBRLU7+AMhREohQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-nqaMPqcBPYiIv5xBLk0AZQ-1; Wed, 31 Mar 2021 17:01:45 -0400
X-MC-Unique: nqaMPqcBPYiIv5xBLk0AZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94E93501F8;
        Wed, 31 Mar 2021 21:01:43 +0000 (UTC)
Received: from ovpn-112-207.phx2.redhat.com (ovpn-112-207.phx2.redhat.com [10.3.112.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7E059451;
        Wed, 31 Mar 2021 21:01:42 +0000 (UTC)
Message-ID: <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Wed, 31 Mar 2021 17:01:41 -0400
In-Reply-To: <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
References: <20210301175601.116405-1-dwagner@suse.de>
         <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
         <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
         <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
         <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
         <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
         <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
         <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-31 at 09:11 +0200, Hannes Reinecke wrote:
> On 3/31/21 1:28 AM, Keith Busch wrote:
> > On Tue, Mar 30, 2021 at 10:34:25AM -0700, Sagi Grimberg wrote:
> > > 
> > > > > It is, but in this situation, the controller is sending a
> > > > > second
> > > > > completion that results in a use-after-free, which makes the
> > > > > transport irrelevant. Unless there is some other flow (which
> > > > > is
> > > > > unclear
> > > > > to me) that causes this which is a bug that needs to be fixed
> > > > > rather
> > > > > than hidden with a safeguard.
> > > > > 
> > > > 
> > > > The kernel should not crash regardless of any network traffic
> > > > that is
> > > > sent to the system.  It should not be possible to either
> > > > intentionally
> > > > of mistakenly contruct packets that will deny service in this
> > > > way.
> > > 
> > > This is not specific to nvme-tcp. I can build an rdma or pci
> > > controller
> > > that can trigger the same crash... I saw a similar patch from
> > > Hannes
> > > implemented in the scsi level, and not the individual scsi
> > > transports..
> > 
> > If scsi wants this too, this could be made generic at the blk-mq
> > level.
> > We just need to make something like blk_mq_tag_to_rq(), but return
> > NULL
> > if the request isn't started.
> >  
> > > I would also mention, that a crash is not even the scariest issue
> > > that
> > > we can see here, because if the request happened to be reused we
> > > are
> > > in the silent data corruption realm...
> > 
> > If this does happen, I think we have to come up with some way to
> > mitigate it. We're not utilizing the full 16 bits of the
> > command_id, so
> > maybe we can append something like a generation sequence number
> > that can
> > be checked for validity.
> > 
> 
> ... which will be near impossible.
> We can protect against crashing on invalid frames.
> We can _not_ protect against maliciously crafted packets referencing
> any
> random _existing_ tag; that's what TLS is for.
> 
> What we can do, though, is checking the 'state' field in the tcp
> request, and only allow completions for commands which are in a state
> allowing for completions.
> 
> Let's see if I can whip up a patch.

That would be great.  BTW in the crash dump I am looking at now, it
looks like pdu->command_id was zero in nvme_tcp_recv_data(), and
blk_mq_tag_to_rq() returned a request struct that had not been used.
So I think we do need to check that the tag was actually allocated.

-Ewan

> 
> Cheers,
> 
> Hannes

