Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3040FF95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbhIQSrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242488AbhIQSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:47:04 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE199C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:45:41 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 13so4077773vkl.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RvSQRCy0ovXt/FmmWH2788dY71Jl29iCo4AO7EInHqg=;
        b=MXZSuKIFIXGE2SeJq4pv8+OQP6qkexgM5waJOa2JIOUwVK/JSetb6/04DRlLE8mZ6V
         U67Ztsiz9fLxIQFHDL3ZG+PHJggkJfNN/rUQHRG3yszYaKRsOs4JcWNdXuexUKluWEOT
         b8edHg7iurIoMdxWs7X4iUOt2rkMW/YV3aCl0GDdg4LeQeP2e/lKFApvxRpEdjqgTY/O
         aImvGVcZe/dctssX1OGsL/W7i7uI+ef2Di8uFrHlH4pm5ZTn59UUyGWXv0BwT2+p57us
         iV750i4zcRdV7Hae75MaibCihUAL/hxHNjycybXMGuQ+/si0ciWztcJWlK3s43gLcjQ5
         ybNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RvSQRCy0ovXt/FmmWH2788dY71Jl29iCo4AO7EInHqg=;
        b=SCYnRnN1900z3W1EchLS9sPxC612w5mJHYUX83fc/254EY63TDTsPM4hltiVgeqXCu
         MSmnU+80TiK16seLRCIb9hWhX6xmhh/BgbNgz/rVNjWQZNdWwQTt8VO2G2Zw+iFAKC3H
         szLxbPD/x19hBgxuCe2Adc923yAbs9gKsQgvQ7gEkQxA8+Yupc0n1NU9jWgTsmHyQLf+
         y9aux+6AnFNKuLes7W37XhrnOXXSoYyeFKKLBKolSy+46hvRc9qjmqU7nhXyDTe8JJfR
         yGQynM2oY2YDh3QQrt3bIlG99k4HDJxemMjy3gG3S8Xz0Oaf4e3p9pTb/foTQpIpUlAd
         Psow==
X-Gm-Message-State: AOAM531u8RTpMPrqyrVzV+4gie95kCvbWLxhorYnqEt4NdD4t59aepOg
        cYzNONfjxNPsttb4QH2RKkHdW2L7Peav00Gjral81w==
X-Google-Smtp-Source: ABdhPJz4GSLeKdIq+YBijrcjm+yTAgO/vW82LHVjl4SVIHIXWHkTLOM1j8NMG+tnPSzmw5b5i3ngVq/xkxr/VHyuDno=
X-Received: by 2002:a1f:a006:: with SMTP id j6mr9454879vke.14.1631904340631;
 Fri, 17 Sep 2021 11:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <CAOUHufahZsYOddtioPEqf=wFtD_HQ4pTo3XJLaSkcm4T3T5MZA@mail.gmail.com> <87zgsb5gaq.fsf@disp2133>
In-Reply-To: <87zgsb5gaq.fsf@disp2133>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 17 Sep 2021 12:45:28 -0600
Message-ID: <CAOUHufbFG5aQSjnQ0ux+8NJ5smJi0PA9S4DjDMjyA4g6fwBSqQ@mail.gmail.com>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 10:17 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > On Wed, Sep 15, 2021 at 4:42 PM Jordan Glover
> > <Golden_Miller83@protonmail.ch> wrote:
> >>
> >> On Wednesday, September 15th, 2021 at 9:02 PM, <ebiederm@xmission.com>=
 wrote:
> >>
> >> > Jordan Glover Golden_Miller83@protonmail.ch writes:
> >> >
> >> > > Hi, recently I hit system freeze after I was closing few container=
ized apps on my system. As for now it occurred only once on linux 5.14.3. I=
 think it maybe be related to "Count rlimits in each user namespace" patchs=
et merged during 5.14 window
> >> > >
> >> > > https://lore.kernel.org/all/257aa5fb1a7d81cf0f4c34f39ada2320c42847=
71.1619094428.git.legion@kernel.org/T/#u
> >> >
> >> > So that warning comes from:
> >> >
> >> > void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
> >> >
> >> > {
> >> >
> >> > struct ucounts *iter;
> >> >
> >> > for (iter =3D ucounts; iter; iter =3D iter->ns->ucounts) {
> >> >
> >> >       long dec =3D atomic_long_dec_if_positive(&iter->ucount[type]);
> >> >
> >> >       WARN_ON_ONCE(dec < 0);
> >> >     }
> >> >     put_ucounts(ucounts);
> >> >
> >> >
> >> > }
> >> >
> >> > Which certainly looks like a reference count bug. It could also be a
> >> >
> >> > memory stomp somewhere close.
> >> >
> >> > Do you have any idea what else was going on? This location is the
> >> >
> >> > symptom but not the actual cause.
> >> >
> >> > Eric
> >>
> >> I had about 2 containerized (flatpak/bubblewrap) apps (browser + music=
 player) running . I quickly closed them with intent to shutdown the system=
 but instead get the freeze and had to use magic sysrq to reboot. System lo=
gs end with what I posted and before there is nothing suspicious.
> >>
> >> Maybe it's some random fluke. I'll reply if I hit it again.
> >
> > I have been able to steadily reproduce this for a while. But I haven't
> > had time to look into it. I'd appreciate any help.
>
> It would be very helpful if you could look farther back in your logs and
> see if you can also see:
> WARNING: CPU: 1 PID: 351 at kernel/ucount.c:253 dec_ucount+0x43/0x5
>
> Or anything else preceding the use-after-free.
>
> I am inclined to think they are the same issue but without seeing the
> WARN_ON_ONCE I can't safely conclude that.

It was either the WARN_ON_ONCE or the KASAN before my kernel crashed.
(KASAN is on for both cases.)

[ 3049.540734] ------------[ cut here ]------------^M
[ 3049.545557] WARNING: CPU: 0 PID: 8369 at kernel/ucount.c:253
dec_ucount+0xb0/0xd8^M
[ 3049.553293] Modules linked in: vhost_vsock vhost vhost_iotlb
vmw_vsock_virtio_transport_common vsock rfcomm algif_hash
algif_skcipher af_alg uinput uvcvideo videobuf2_vmalloc venus_enc
venus_dec videobuf2_dma_contig videobuf2_memops cros_ec_typec typec
hci_uart btqca bluetooth ecdh_generic ecc venus_core v4l2_mem2mem
videobuf2_v4l2 videobuf2_common qcom_q6v5_mss ipa qcom_pil_info
qcom_q6v5 qcom_common xt_MASQUERADE rmtfs_mem fuse ath10k_snoc
qmi_helpers ath10k_core ath mac80211 lzo_rle lzo_compress cfg80211
zram smsc smsc95xx usbnet mii joydev^M
[ 3049.603135] CPU: 0 PID: 8369 Comm: kworker/0:2 Not tainted
5.14.0-lockdep+ #4^M
[ 3049.610506] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)^M
[ 3049.617230] Workqueue: events free_user_ns^M
[ 3049.621494] pstate: a0400009 (NzCv daif +PAN -UAO -TCO BTYPE=3D--)^M
[ 3049.627694] pc : dec_ucount+0xb0/0xd8^M
[ 3049.631489] lr : dec_ucount+0x50/0xd8^M
[ 3049.635280] sp : ffffffc019ff7b50^M
[ 3049.638707] x29: ffffffc019ff7b50 x28: ffffffd5b5d8b710 x27:
ffffff80884cae90^M
[ 3049.646083] x26: dfffffc000000000 x25: ffffffd5b5de98a0 x24:
0000000000000001^M
[ 3049.653460] x23: ffffff80d2597100 x22: 0000000000000000 x21:
dfffffc000000000^M
[ 3049.660838] x20: ffffff80d2597120 x19: ffffff80d2597100 x18:
1ffffff01b4b3f48^M
[ 3049.668210] x17: 1ffffff01b4b3f47 x16: 0000000000000000 x15:
0000000000000000^M
[ 3049.675585] x14: 0000000000000000 x13: 000000002b0cc34b x12:
0000000024966d0f^M
[ 3049.682960] x11: 0000000000000000 x10: dfffffc000000001 x9 :
0000000000000000^M
[ 3049.690334] x8 : ffffff80d259791f x7 : 0000000000000000 x6 :
ffffffd5b3de71c4^M
[ 3049.697709] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
ffffffd5b3391ca4^M
[ 3049.705086] x2 : 0000000000000001 x1 : 0000000000000008 x0 :
0000000000000001^M
[ 3049.712459] Call trace:^M
[ 3049.715003]  dec_ucount+0xb0/0xd8^M
[ 3049.718443]  free_user_ns+0x1b0/0x288^M
[ 3049.722242]  process_one_work+0x7b4/0x10ec^M
[ 3049.726485]  worker_thread+0x800/0xcf4^M
[ 3049.730377]  kthread+0x2a8/0x358^M
[ 3049.733736]  ret_from_fork+0x10/0x18^M
[ 3049.737445] irq event stamp: 0^M
[ 3049.740612] hardirqs last  enabled at (0): [<0000000000000000>] 0x0^M
[ 3049.747092] hardirqs last disabled at (0): [<ffffffd5b331413c>]
copy_process+0xcb0/0x2a54^M
[ 3049.755521] softirqs last  enabled at (0): [<ffffffd5b3314164>]
copy_process+0xcd8/0x2a54^M
[ 3049.763954] softirqs last disabled at (0): [<0000000000000000>] 0x0^M
[ 3049.770432] ---[ end trace fa55518c981c0c5d ]---^M
