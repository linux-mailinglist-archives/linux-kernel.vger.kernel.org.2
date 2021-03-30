Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60F434ED9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhC3QTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232456AbhC3QT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617121166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFv1ahKTG3Hg+q8+rh0hBintBsqnTi45PnEj6YrihWg=;
        b=fh38Y1q6BSDPUTmsnCPzdU8eLgeAlMWduSsSQfShQQb21TYMw9FbMeIAM7dO5AOpCnSXGv
        eDlrJRMjcyetUqGXR+TAjpTgmlvyiWCDD2uo2cgwGdcABgstRI9YexHAazaZpO7CDBQP0W
        1nuhBizc1CoAhEDUfco6TjfFR9nUKsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-iEFJhmOSM5eE0JPGdTRcog-1; Tue, 30 Mar 2021 12:19:22 -0400
X-MC-Unique: iEFJhmOSM5eE0JPGdTRcog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EAA91005D5A;
        Tue, 30 Mar 2021 16:19:20 +0000 (UTC)
Received: from ovpn-112-207.phx2.redhat.com (ovpn-112-207.phx2.redhat.com [10.3.112.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C71D39A66;
        Tue, 30 Mar 2021 16:19:18 +0000 (UTC)
Message-ID: <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Date:   Tue, 30 Mar 2021 12:19:18 -0400
In-Reply-To: <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
References: <20210301175601.116405-1-dwagner@suse.de>
         <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
         <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
         <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-15 at 10:16 -0700, Sagi Grimberg wrote:
> > Hi Sagi,
> > 
> > On Fri, Mar 05, 2021 at 11:57:30AM -0800, Sagi Grimberg wrote:
> > > Daniel, again, there is nothing specific about this to nvme-tcp,
> > > this is a safeguard against a funky controller (or a different
> > > bug that is hidden by this).
> > 
> > As far I can tell, the main difference between nvme-tcp and
> > FC/NVMe,
> > nvme-tcp has not a FW or a big driver which filter out some noise
> > from a
> > misbehaving controller. I haven't really checked the other
> > transports
> > but I wouldn't surprised they share the same properties as FC/NVMe.
> > 
> > > The same can happen in any other transport so I would suggest
> > > that if
> > > this is a safeguard we want to put in place, we should make it a
> > > generic one.
> > > 
> > > i.e. nvme_tag_to_rq() that _all_ transports call consistently.
> > 
> > Okay, I'll review all the relevant code and see what could made
> > more
> > generic and consistent.
> > 
> > Though I think nvme-tcp plays in a different league as it is
> > exposed to
> > normal networking traffic and this is a very hostile environment.
> 
> It is, but in this situation, the controller is sending a second
> completion that results in a use-after-free, which makes the
> transport irrelevant. Unless there is some other flow (which is
> unclear
> to me) that causes this which is a bug that needs to be fixed rather
> than hidden with a safeguard.
> 

The kernel should not crash regardless of any network traffic that is
sent to the system.  It should not be possible to either intentionally
of mistakenly contruct packets that will deny service in this way.

-Ewan



