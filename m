Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E2C334180
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhCJP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhCJP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615390092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2utDrrGE5PCioOv1cmRGw92qDJ4cE08OYCs2ZdVyTE=;
        b=A8T5K96mQ4RF21r8JpcxBypIORGTFi7Jj9DlwWoljfugEC5o7m6ljY7SIzThtP6/c78D9y
        zl4+yB1+naCquzLudj+H/D4cU1MuBP+0o0c0wwEC9hpiew+PNjtJq+eplEAi2Lf6EntWZY
        R2HDPDuxBe4KxeK8ipcv9auvK5QFF64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-ck0P-rG2PuGhFUdgzqOCdg-1; Wed, 10 Mar 2021 10:28:10 -0500
X-MC-Unique: ck0P-rG2PuGhFUdgzqOCdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89C77801596;
        Wed, 10 Mar 2021 15:28:09 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC98E1002F12;
        Wed, 10 Mar 2021 15:28:05 +0000 (UTC)
Date:   Wed, 10 Mar 2021 08:28:05 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>, cohuck@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com
Subject: Re: [PATCH v1 02/14] vfio: Update vfio_add_group_dev() API
Message-ID: <20210310082805.29813cad@omen.home.shazbot.org>
In-Reply-To: <20210310121913.GR2356281@nvidia.com>
References: <161523878883.3480.12103845207889888280.stgit@gimli.home>
        <161524006056.3480.3931750068527641030.stgit@gimli.home>
        <20210310074838.GA662265@infradead.org>
        <20210310121913.GR2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 08:19:13 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 10, 2021 at 07:48:38AM +0000, Christoph Hellwig wrote:
> > On Mon, Mar 08, 2021 at 02:47:40PM -0700, Alex Williamson wrote:  
> > > Rather than an errno, return a pointer to the opaque vfio_device
> > > to allow the bus driver to call into vfio-core without additional
> > > lookups and references.  Note that bus drivers are still required
> > > to use vfio_del_group_dev() to teardown the vfio_device.
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> > 
> > This looks like it is superseded by the
> > 
> >   vfio: Split creation of a vfio_device into init and register ops  
> 
> Yes, that series puts vfio_device everywhere so APIs like Alex needs
> to build here become trivial.
> 
> The fact we both converged on this same requirement is good

You're ahead of me in catching up with reviews Christoph, but
considering stable backports and the motivations for each series, I'd
expect to initially make the minimal API change and build from there.
Thanks,

Alex

