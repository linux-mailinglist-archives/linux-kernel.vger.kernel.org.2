Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FB3BC811
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhGFIs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhGFIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625561145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TmP/CP+r95G7grSdPIW18dia2dKSqY5syV3kf7Ux4EM=;
        b=GdSW6oqNEcupBQEiXETQCqhfTDzKZnkfTVyfMv4WAbmA7JUxu6A95OEcN1LEoboPa49IlM
        Uy0KnoN01TsCOodNR0hxc3cPK+lg475Zx9DXBQVt207D3Q8Z3xjxUtNuCIUfncRoHUudpd
        +EPDGI7QLZ/i2wL8R22d/VJlV019LvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-_MVr4dIrOki0r5CkufaFbA-1; Tue, 06 Jul 2021 04:45:44 -0400
X-MC-Unique: _MVr4dIrOki0r5CkufaFbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD0AC9126B;
        Tue,  6 Jul 2021 08:45:42 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84E6B2EB17;
        Tue,  6 Jul 2021 08:45:35 +0000 (UTC)
Date:   Tue, 6 Jul 2021 16:45:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <YOQYKn+POVR2g/h1@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
 <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
 <YOQGRwLfLaFGqlVA@T590>
 <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 10:10:10AM +0200, Daniel Wagner wrote:
> On Tue, Jul 06, 2021 at 03:29:11PM +0800, Ming Lei wrote:
> > > and this seems to confirm, no I/O in flight.
> > 
> > What is the output of the following command after the hang is triggered?
> > 
> > (cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -aH . {} \;)
> > 
> > Suppose the hang disk is nvme0n1.
> 
> see attachement
> 
> > No, percpu_ref_is_zero() is fine to be called in atomic mode.
> 
> Okay, that is what I hoped for :)

> /sys/kernel/debug/block/nvme0c0n1# find . -type f -exec grep -aH . {} \;

It is the mpath device's debugfs, what is output for the nvmef's
debugfs?


Thanks,
Ming

