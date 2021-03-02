Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3966C32A13E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347566AbhCBFcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 00:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574308AbhCBDac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 22:30:32 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4EAC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 19:29:51 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id o9so5328757iow.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 19:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QHLKhdUUdwdRLFZK3F36sZslkyOvdxJOY0pkf8sRrCY=;
        b=jVCCiWqHUoHLga4iGh8Ma+SZk6bvTG5vcI1KcHM9X+lCng6cHpNJWedN/NJdIhs3M2
         BycoDJBxIfYb7xwcFLXuuUznHddk7IH4F+O6VkpYMqT+77S+TzoYZ5FDkau2cT6/zCAa
         QRcmLxr3lG2yTcKxtBBX0AVpJTBqvKhOELByBjXvmyZ70Z2TNIGU8+Qw6DqzAp1J37Hi
         8+kxkBXfZVvhXWQe8msmkkdruC8gwKS/r/GbzqHtV0MtOnsgR+yPilfbe0BIEA/x4sHa
         07hPcsugXNL3GR5nxWfcJi6R9aFpDH8a6UDB51IlBUov9YQ/dbTLriP213PB3ujw+WKC
         fiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QHLKhdUUdwdRLFZK3F36sZslkyOvdxJOY0pkf8sRrCY=;
        b=bX1TCHPFJy0N1wzU4t7pZ/C0D/wY1JwBKVLMl+j/by7FvVVFNGVR1xYtALtAEnUuo2
         9fZuafresjBKKUjrY4xIzFp+OPlDN4n/BcXMHDhTxhwgOVWAvbtlthyK7LElWXADWD+k
         D6MSqFew8pyEiL26HF9hRlLUYUzUvglpUnR+n8FNPKHY5ftJ4A08Ib1oOOOUrRlkPmkJ
         gkZ3GCqgxdr9hOrvy4QlfFniFy1lXxL7yZqgYCaq65AkzLH251FvkkUQgAtgxDQ4SRAU
         j/plcbTb1sA7ulBqGAAb1DrofeazKNVBGqZkZetIv++7zZT8paXGqroB/HkPmXUexAYx
         dk4Q==
X-Gm-Message-State: AOAM532jLVC7bpludosCiebWQi1qsX+j066GmkfQT8xh72SaS4q3O33b
        InMauVAiDPxIoRimOgcJuds/w1qFPnZPVLVrHuYedEWONOUDMw==
X-Google-Smtp-Source: ABdhPJwZFxbYkaK1x/n2mPmqwrkdkJfTD3bFbuvnwCTUAnk14zDPZ6u4tK6pUXcU11f7peeTlXIx6q7ZXdV+9FAv9Rc=
X-Received: by 2002:a6b:5818:: with SMTP id m24mr16051243iob.144.1614655790958;
 Mon, 01 Mar 2021 19:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20210228044625.171151-1-ztong0001@gmail.com> <da187130-8a73-8490-4c70-aed3055081bf@suse.de>
In-Reply-To: <da187130-8a73-8490-4c70-aed3055081bf@suse.de>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 1 Mar 2021 22:29:40 -0500
Message-ID: <CAA5qM4BunmAAgq3jf7+=3H_z+RN4EriuJbpmyMOi3JioUOFwbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/fb-helper: only unmap if buffer not null
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

I think the issue could be possibly caused by the following,
Please correct me if I'm wrong.

drm_fb_helper_single_fb_probe() can fail with
"Cannot find any crtc or sizes"
which will cause fb_helper->funcs->fb_probe not being called,
thus fb_helper->buffer remains NULL --
Since there could be the case that the fb_probe is never called,
a subsequent modprobe -r will cause the following
drm_client_buffer_vunmap(NULL) in drm_fbdev_cleanup()

Best,
- Tong

On Mon, Mar 1, 2021 at 3:26 AM Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 28.02.21 um 05:46 schrieb Tong Zhang:
> > drm_fbdev_cleanup() can be called when fb_helper->buffer is null, hence
> > fb_helper->buffer should be checked before calling
> > drm_client_buffer_vunmap(). This buffer is also checked in
> > drm_client_framebuffer_delete(), so we should also do the same thing fo=
r
> > drm_client_buffer_vunmap().
>
> I think a lot of drivers are affected by this problem; probably most of
> the ones that use the generic fbdev code. How did you produce the error?
>
> What I'm more concerned about is why the buffer is NULL. Was ther eno
> hotplug event? Do you have a display attached?
>
> Best regards
> Thomas
>
>
> >
> > [  199.128742] RIP: 0010:drm_client_buffer_vunmap+0xd/0x20
> > [  199.129031] Code: 43 18 48 8b 53 20 49 89 45 00 49 89 55 08 5b 44 89=
 e0 41 5c 41 5d 41 5e 5d
> > c3 0f 1f 00 53 48 89 fb 48 8d 7f 10 e8 73 7d a1 ff <48> 8b 7b 10 48 8d =
73 18 5b e9 75 53 fc ff 0
> > f 1f 44 00 00 48 b8 00
> > [  199.130041] RSP: 0018:ffff888103f3fc88 EFLAGS: 00010282
> > [  199.130329] RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffffff=
f8214d46d
> > [  199.130733] RDX: 1ffffffff079c6b9 RSI: 0000000000000246 RDI: fffffff=
f83ce35c8
> > [  199.131119] RBP: ffff888103d25458 R08: 0000000000000001 R09: fffffbf=
ff0791761
> > [  199.131505] R10: ffffffff83c8bb07 R11: fffffbfff0791760 R12: 0000000=
000000000
> > [  199.131891] R13: ffff888103d25468 R14: ffff888103d25418 R15: ffff888=
103f18120
> > [  199.132277] FS:  00007f36fdcbb6a0(0000) GS:ffff88815b400000(0000) kn=
lGS:0000000000000000
> > [  199.132721] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  199.133033] CR2: 0000000000000010 CR3: 0000000103d26000 CR4: 0000000=
0000006f0
> > [  199.133420] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [  199.133807] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [  199.134195] Call Trace:
> > [  199.134333]  drm_fbdev_cleanup+0x179/0x1a0
> > [  199.134562]  drm_fbdev_client_unregister+0x2b/0x40
> > [  199.134828]  drm_client_dev_unregister+0xa8/0x180
> > [  199.135088]  drm_dev_unregister+0x61/0x110
> > [  199.135315]  mgag200_pci_remove+0x38/0x52 [mgag200]
> > [  199.135586]  pci_device_remove+0x62/0xe0
> > [  199.135806]  device_release_driver_internal+0x148/0x270
> > [  199.136094]  driver_detach+0x76/0xe0
> > [  199.136294]  bus_remove_driver+0x7e/0x100
> > [  199.136521]  pci_unregister_driver+0x28/0xf0
> > [  199.136759]  __x64_sys_delete_module+0x268/0x300
> > [  199.137016]  ? __ia32_sys_delete_module+0x300/0x300
> > [  199.137285]  ? call_rcu+0x3e4/0x580
> > [  199.137481]  ? fpregs_assert_state_consistent+0x4d/0x60
> > [  199.137767]  ? exit_to_user_mode_prepare+0x2f/0x130
> > [  199.138037]  do_syscall_64+0x33/0x40
> > [  199.138237]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  199.138517] RIP: 0033:0x7f36fdc3dcf7
> >
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >   drivers/gpu/drm/drm_fb_helper.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_h=
elper.c
> > index b9a616737c0e..f6baa2046124 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -2048,7 +2048,7 @@ static void drm_fbdev_cleanup(struct drm_fb_helpe=
r *fb_helper)
> >
> >       if (shadow)
> >               vfree(shadow);
> > -     else
> > +     else if (fb_helper->buffer)
> >               drm_client_buffer_vunmap(fb_helper->buffer);
> >
> >       drm_client_framebuffer_delete(fb_helper->buffer);
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>
