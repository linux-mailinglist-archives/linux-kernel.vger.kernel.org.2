Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC82325086
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhBYNbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:31:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhBYN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614259650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmhocK8JvxeFvqznSPmVOrjmguqn5DklCKcUL2w9cKA=;
        b=UPTQRptALDnF6j3Mxg+yY4UnM+76++3siI6Mdxi8CsbCwsP4scbiisuOBxzmtXMHazQxOd
        xBnslBWoOOH7Vr3e2ky6CuMKzxnrcAAOF0tyjC9kZ13s94pbdLlTOHJV8q8H3P7LIIrMTu
        7enANNrMKiG/TSNg3O+u9wm7yYgS/Vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-YUcj0nl0NBq2qTP1Br-cZQ-1; Thu, 25 Feb 2021 08:27:25 -0500
X-MC-Unique: YUcj0nl0NBq2qTP1Br-cZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFD280196C;
        Thu, 25 Feb 2021 13:27:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-4.ams2.redhat.com [10.36.114.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89E715D9E2;
        Thu, 25 Feb 2021 13:27:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 19A4C18000A7; Thu, 25 Feb 2021 14:27:22 +0100 (CET)
Date:   Thu, 25 Feb 2021 14:27:22 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Zack Rusin <zackr@vmware.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] drm/vkms: Add support for virtual hardware mode
Message-ID: <20210225132722.s2deh35qwhan5kkf@sirius.home.kraxel.org>
References: <20210224105509.yzdimgbu2jwe3auf@adolin>
 <CAKMK7uFwdHaaGs8BPSAah1Vp5pJWTzxoruLgOWxQu1aDAyCKLQ@mail.gmail.com>
 <20210225102520.uysa4muovemqi66n@sirius.home.kraxel.org>
 <YDd8qOETBy8z/qDh@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDd8qOETBy8z/qDh@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:32:08AM +0100, Daniel Vetter wrote:
> On Thu, Feb 25, 2021 at 11:25:20AM +0100, Gerd Hoffmann wrote:
> > On Thu, Feb 25, 2021 at 10:09:42AM +0100, Daniel Vetter wrote:
> > > On Wed, Feb 24, 2021 at 11:55 AM Sumera Priyadarsini
> > > <sylphrenadin@gmail.com> wrote:
> > > >
> > > > Add a virtual hardware or vblank-less mode as a module to enable
> > > > VKMS to emulate virtual graphic drivers. This mode can be enabled
> > > > by setting enable_virtual_hw=1 at the time of loading VKMS.
> > > >
> > > > A new function vkms_crtc_composer() has been added to bypass the
> > > > vblank mode and is called directly in the atomic hook in
> > > > vkms_atomic_begin(). However, some crc captures still use vblanks
> > > > which causes the crc-based igt tests to crash. Currently, I am unsure
> > > > about how to approach one-shot implementation of crc reads so I am
> > > > still working on that.
> > > 
> > > Gerd, Zack: For virtual hw like virtio-gpu or vmwgfx that does
> > > one-shot upload and damage tracking, what do you think is the best way
> > > to capture crc for validation? Assuming that's even on the plans
> > > anywhere ...
> > > 
> > > Ideally it'd be a crc that the host side captures, so that we really
> > > have end-to-end validation, including the damage uploads and all that.
> > 
> > Disclaimer:  Not knowing much about the crc thing beside having noticed
> > it exists and seems to be used for display content checking.
> > 
> > > For vkms we're going for now with one-shot crc generation after each
> > > atomic flip (or DIRTYFB ioctl call). Will need a pile of igt changes,
> > > but seems like the most fitting model.
> > > Other option would be that we'd wire up something on the kernel side
> > > that generates a crc on-demand every time igt reads a new crc value
> > > (maybe with some rate limiting). But that's not really how virtual hw
> > > works when everything is pushed explicitly to the host side.
> > 
> > igt runs inside the guest, right?
> 
> Yup. There's some debugfs files for capture crc on a specific CRTC. So
> supporting this would mean some virtio-gpu revision so you could ask the
> host side for a crc when you do a screen update, and the host side would
> send that back to you on a virtio channel as some kind of message.

Waded through the source code a bit.  So, the vkms crc code merges all
planes (specifically the cursor plane) before calculating the crc.
Which is a bit of a problem, we try to avoid that and rarely actually
merge the planes anywhere in the virtualization stack.  Instead we
prefer to pass through the cursor plane separately, so we can -- for
example -- use that to simply set the cursor sprite of the qemu gtk
window.  It's much more snappy because moving+rendering the pointer
doesn't need a round-trip to the guest then.

So, it would be quite some effort on the host side, we would have to
merge planes just for crc calculation.

> > You can ask qemu to write out a screen dump.

Hmm, the (hardware) cursor is not in the screen dump either.

A software cursor (when using for example cirrus which has no cursor
plane) would be there.

> > Another option to access the screen would be vnc.

vnc clients can get the cursor sprite.  They can't get the position
though, only set it (it's a one-way ticket in the vnc protocol).
Typically not a problem because desktops set the position in response
to the pointer events so guest + host position match nevertheless.
But for test cases which don't look at input events and set the cursor
to a fixed place this is a problem ...

> > On-demand crc via debugfs or ioctl would work too, but yes that wouldn't
> > verify the host-side.  At least not without virtio protocol extensions.
> > We could add a new command asking the host to crc the display and return
> > the result for on-demand crc.  Or add a crc request flag to an existing
> > command (VIRTIO_GPU_CMD_RESOURCE_FLUSH probably).
> 
> Yup, I think that's what would be needed. The question here is, what do
> you think would be the most natural way for virtio host side stack to
> support this?

virtio has feature flags, so we can easily introduce an extension in a
backward compatible way.  Each command sends a reply, with optional
payload, so it would make sense to send the crc with the
VIRTIO_GPU_CMD_RESOURCE_FLUSH reply.

Alternatively introduce a communication channel independent of the gpu,
using for example virtio-serial or vsock, let the guest send crc
requests to qemu that way.  Which would work with all qemu display
devices, not only virtio-gpu.

take care,
  Gerd

