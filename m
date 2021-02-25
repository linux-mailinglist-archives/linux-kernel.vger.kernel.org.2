Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4BE324E86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhBYKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:48:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235541AbhBYK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614248727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ypTa3inN3myqZyj0TrRQjMS6xlcjWVaVwQu0mECVBzY=;
        b=MrCf98QyMtUdOcfqPNv1rHjlAQfDdj6cjX1LrmtAThjMZDq9Wf72/AFXOj3hkcHGfY0PC9
        e4pReZ2k7JLfiTytsesvpsR6nY2C2PdKWWc1/MqZV4PGPBxD5HTW0vM3gTahqS0jiV0lVS
        q1ChMrQhgQHY4muBx5xjv6RUaM6IUPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-ZeIqJevEPgudTbsJh2jYBw-1; Thu, 25 Feb 2021 05:25:24 -0500
X-MC-Unique: ZeIqJevEPgudTbsJh2jYBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6EFE106BB24;
        Thu, 25 Feb 2021 10:25:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-4.ams2.redhat.com [10.36.114.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 638A550B44;
        Thu, 25 Feb 2021 10:25:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5CBBF18000A7; Thu, 25 Feb 2021 11:25:20 +0100 (CET)
Date:   Thu, 25 Feb 2021 11:25:20 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Zack Rusin <zackr@vmware.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] drm/vkms: Add support for virtual hardware mode
Message-ID: <20210225102520.uysa4muovemqi66n@sirius.home.kraxel.org>
References: <20210224105509.yzdimgbu2jwe3auf@adolin>
 <CAKMK7uFwdHaaGs8BPSAah1Vp5pJWTzxoruLgOWxQu1aDAyCKLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFwdHaaGs8BPSAah1Vp5pJWTzxoruLgOWxQu1aDAyCKLQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:09:42AM +0100, Daniel Vetter wrote:
> On Wed, Feb 24, 2021 at 11:55 AM Sumera Priyadarsini
> <sylphrenadin@gmail.com> wrote:
> >
> > Add a virtual hardware or vblank-less mode as a module to enable
> > VKMS to emulate virtual graphic drivers. This mode can be enabled
> > by setting enable_virtual_hw=1 at the time of loading VKMS.
> >
> > A new function vkms_crtc_composer() has been added to bypass the
> > vblank mode and is called directly in the atomic hook in
> > vkms_atomic_begin(). However, some crc captures still use vblanks
> > which causes the crc-based igt tests to crash. Currently, I am unsure
> > about how to approach one-shot implementation of crc reads so I am
> > still working on that.
> 
> Gerd, Zack: For virtual hw like virtio-gpu or vmwgfx that does
> one-shot upload and damage tracking, what do you think is the best way
> to capture crc for validation? Assuming that's even on the plans
> anywhere ...
> 
> Ideally it'd be a crc that the host side captures, so that we really
> have end-to-end validation, including the damage uploads and all that.

Disclaimer:  Not knowing much about the crc thing beside having noticed
it exists and seems to be used for display content checking.

> For vkms we're going for now with one-shot crc generation after each
> atomic flip (or DIRTYFB ioctl call). Will need a pile of igt changes,
> but seems like the most fitting model.
> Other option would be that we'd wire up something on the kernel side
> that generates a crc on-demand every time igt reads a new crc value
> (maybe with some rate limiting). But that's not really how virtual hw
> works when everything is pushed explicitly to the host side.

igt runs inside the guest, right?

You can ask qemu to write out a screen dump.  Reading that and calculate
a crc from it should be easy.  But the tricky part is how to coordinate
guest and host then.  qemu autotesting typically runs on the host,
connected to qemu (monitor) and guest (ssh or serial console) so it can
control both host and guest side.

Another option to access the screen would be vnc.  With user networking
and a guest forwarding rule it should be possible to allow the guest
access the qemu vnc server for its own display.  Would be more effort to
capture the display, but it would for the most part take the host out of
the picture.  The guest could coordinate everything on its own then.

On-demand crc via debugfs or ioctl would work too, but yes that wouldn't
verify the host-side.  At least not without virtio protocol extensions.
We could add a new command asking the host to crc the display and return
the result for on-demand crc.  Or add a crc request flag to an existing
command (VIRTIO_GPU_CMD_RESOURCE_FLUSH probably).

take care,
  Gerd

