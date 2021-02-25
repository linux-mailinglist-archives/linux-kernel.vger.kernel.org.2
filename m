Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812FA324E89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhBYKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbhBYKcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:32:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5809C061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:32:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i9so3904079wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=taF2ZUSISoHL0uxheF5RWmxC7JF8zzGP42t+etSfucA=;
        b=FLaenk7OTQYJOvi4g86Zfe8W/Hd2Ss14qAGaU6wGr7uj7E72JW/9tS5yU6m3JJfjJq
         R4wkiD/MAaRT4DE68JiVQ9734OrUbpuKjK+aScAkJmP3Q2R9dnzp4UYmfI2OaKyYmwWG
         ZcnGQ4hRBmTXIplhew1fweBjw5aoIaNyw/5lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=taF2ZUSISoHL0uxheF5RWmxC7JF8zzGP42t+etSfucA=;
        b=OYZVIGwUzdGKlyBVBDV06+U1/7Dua0BETSVzk1HO6Mu2Wi6IGR4tUHpgQSFcAoFDwJ
         x25zZeVwNBNKqgg82qfj/a3HkgcoLKf9DwbCbkCP4sgwlwLWuArQheOdRQ/IhueRe4uN
         bxVVqheVAmK2iFJ8o40dcPH2MWE2hZOKTzZe+cbY4183On8yQlWXJso25wOSkqiemf2Q
         XKCA6MBRWDZA2bpDkyMEbHKYrqxQijevGkvkLwl6PPYmypjH9zSfBgivr2ysbwL1KBdj
         VLxRShsDbSIjbzlnfZSwtIgxBybkCPYD6Jny5xjvkxHB+MtBqCusbXRNgjND1U5qDty+
         VSzA==
X-Gm-Message-State: AOAM533X1IBTGviQfgo3sZE2gjWi7zM6UhS6c0+2R1p2cIF+5QQ/hf71
        IUBLl2V/wkGHiCk+4WZ+MWW/mA==
X-Google-Smtp-Source: ABdhPJxhIIlgxvYQ4k58cN9/kibFEn+GgsA+3/MzOcGr1U9H58L4KIKN0cDwDr6HAfb3A0fmWiTq8g==
X-Received: by 2002:a05:600c:35c6:: with SMTP id r6mr2550267wmq.83.1614249131381;
        Thu, 25 Feb 2021 02:32:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c18sm11597938wmk.0.2021.02.25.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:32:10 -0800 (PST)
Date:   Thu, 25 Feb 2021 11:32:08 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Zack Rusin <zackr@vmware.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] drm/vkms: Add support for virtual hardware mode
Message-ID: <YDd8qOETBy8z/qDh@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Zack Rusin <zackr@vmware.com>, Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210224105509.yzdimgbu2jwe3auf@adolin>
 <CAKMK7uFwdHaaGs8BPSAah1Vp5pJWTzxoruLgOWxQu1aDAyCKLQ@mail.gmail.com>
 <20210225102520.uysa4muovemqi66n@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225102520.uysa4muovemqi66n@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:25:20AM +0100, Gerd Hoffmann wrote:
> On Thu, Feb 25, 2021 at 10:09:42AM +0100, Daniel Vetter wrote:
> > On Wed, Feb 24, 2021 at 11:55 AM Sumera Priyadarsini
> > <sylphrenadin@gmail.com> wrote:
> > >
> > > Add a virtual hardware or vblank-less mode as a module to enable
> > > VKMS to emulate virtual graphic drivers. This mode can be enabled
> > > by setting enable_virtual_hw=1 at the time of loading VKMS.
> > >
> > > A new function vkms_crtc_composer() has been added to bypass the
> > > vblank mode and is called directly in the atomic hook in
> > > vkms_atomic_begin(). However, some crc captures still use vblanks
> > > which causes the crc-based igt tests to crash. Currently, I am unsure
> > > about how to approach one-shot implementation of crc reads so I am
> > > still working on that.
> > 
> > Gerd, Zack: For virtual hw like virtio-gpu or vmwgfx that does
> > one-shot upload and damage tracking, what do you think is the best way
> > to capture crc for validation? Assuming that's even on the plans
> > anywhere ...
> > 
> > Ideally it'd be a crc that the host side captures, so that we really
> > have end-to-end validation, including the damage uploads and all that.
> 
> Disclaimer:  Not knowing much about the crc thing beside having noticed
> it exists and seems to be used for display content checking.
> 
> > For vkms we're going for now with one-shot crc generation after each
> > atomic flip (or DIRTYFB ioctl call). Will need a pile of igt changes,
> > but seems like the most fitting model.
> > Other option would be that we'd wire up something on the kernel side
> > that generates a crc on-demand every time igt reads a new crc value
> > (maybe with some rate limiting). But that's not really how virtual hw
> > works when everything is pushed explicitly to the host side.
> 
> igt runs inside the guest, right?

Yup. There's some debugfs files for capture crc on a specific CRTC. So
supporting this would mean some virtio-gpu revision so you could ask the
host side for a crc when you do a screen update, and the host side would
send that back to you on a virtio channel as some kind of message.

> You can ask qemu to write out a screen dump.  Reading that and calculate
> a crc from it should be easy.  But the tricky part is how to coordinate
> guest and host then.  qemu autotesting typically runs on the host,
> connected to qemu (monitor) and guest (ssh or serial console) so it can
> control both host and guest side.
> 
> Another option to access the screen would be vnc.  With user networking
> and a guest forwarding rule it should be possible to allow the guest
> access the qemu vnc server for its own display.  Would be more effort to
> capture the display, but it would for the most part take the host out of
> the picture.  The guest could coordinate everything on its own then.
> 
> On-demand crc via debugfs or ioctl would work too, but yes that wouldn't
> verify the host-side.  At least not without virtio protocol extensions.
> We could add a new command asking the host to crc the display and return
> the result for on-demand crc.  Or add a crc request flag to an existing
> command (VIRTIO_GPU_CMD_RESOURCE_FLUSH probably).

Yup, I think that's what would be needed. The question here is, what do
you think would be the most natural way for virtio host side stack to
support this? If it ever happens ofc.

igt does support some other ways to capture crc (chamelium boards acting
as display sink). The nice thing with having this in the kernel driver as
part of the "hardware" is that you can guarantee that the frames are a
match. Maybe more relevant for real hw with vblank, where it's also
interesting to know whether the screen did update on the right frame.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
