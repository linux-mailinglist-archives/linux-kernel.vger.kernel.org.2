Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EFD37FF66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhEMUpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhEMUpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:45:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23854C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 13:43:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id c22so13577706ejd.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zsi1VS1/M5Q4gHLg9ba2wD4/Zt4MEUxOebW8zMEgFb8=;
        b=o6CmiB2EKAmYIWJvXeSOnrp0mEYkKXWDYisDmuTXFnFKVW4P7SmWp98YmjZZQ8s5vf
         B86DUjzYxVkGaiR4+5WEwdC1xamBzEEpPQA19HHsPVWzZ5G7eX43w4tMyiPfn+sKc07h
         ejU1ZP37ip8XzGNSzrBYoFqhP+ScCX3Ca+zu/Inz0toFv1zTGktFcaH3TJd9g43pipOn
         grx6nIPteA+3NqiMB7uksSQuq7AKrfCEbBEZQ7035/3XDguTAJZlyqcmc7S9dXrUy+jn
         eDI98aGEqHNHj0UD77DQeNg65Wz5/Vs+SpuxBd6HnqoEJnXoyUqeAuaYIoB+Y/uu8krz
         v4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zsi1VS1/M5Q4gHLg9ba2wD4/Zt4MEUxOebW8zMEgFb8=;
        b=R7D+lBzc0lWYwcCH5lldL9xgs/T2a60TA611gmchUBRep2HCgEKZfWmYwHPb0fPlkN
         JCVto7bOB9QFZcrY09Gya6rFNNCYPIFrM9NJkd+xUoMkQWFWWfX2+X346d9Cr4TC7t2w
         xCKM5sSIl2eCiePmpd1wfBXd/gjGTNSDIkAhBEKUGacy2nVtvMGXpAXIOsiLXiKpbKgo
         QyUYCA7MNkdWjj3G5qrkhvbvT6GxHp+uB6eQtc5NigoMnRL/Bb/Yy27McAq+9uAbe8ih
         132z/2q80dSotOXUtd0NDsKhinNZzcurVkPo2rinPvJRQB1pQOoFFcsvoUSg17cAx24y
         10+w==
X-Gm-Message-State: AOAM530+mhGpt+WMWCYaKZZOPNQgW23Zduu6zWZc1dIEvw338HGK9ztm
        LJJ/wqK1ng6MD+Wvl5UH27Xg8ZXANZjZ7Q==
X-Google-Smtp-Source: ABdhPJxQr0d4hqkn0aGBWFGU7et1v9pMDM1gQWm3upk99L08FxwNZS3q1uSYiNZRyiXBo3daUdgPgA==
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr46619432ejc.316.1620938635648;
        Thu, 13 May 2021 13:43:55 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id p14sm3045799eds.28.2021.05.13.13.43.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 13:43:54 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id l14so28090557wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 13:43:54 -0700 (PDT)
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr52466335wri.327.1620938634068;
 Thu, 13 May 2021 13:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com> <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
 <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com> <CAOEp5Ocm9Q69Fv=oeyCs01F9J4nCTPiOPpw9_BRZ0WnF+LtEFQ@mail.gmail.com>
 <CACGkMEsZBCzV+d_eLj1aYT+pkS5m1QAy7q8rUkNsdV0C8aL8tQ@mail.gmail.com>
 <CAOEp5OeSankfA6urXLW_fquSMrZ+WYXDtKNacort1UwR=WgxqA@mail.gmail.com>
 <CACGkMEt3bZrdqbWtWjSkXvv5v8iCHiN8hkD3T602RZnb6nPd9A@mail.gmail.com>
 <CAOEp5Odw=eaQWZCXr+U8PipPtO1Avjw-t3gEdKyvNYxuNa5TfQ@mail.gmail.com>
 <CACGkMEuqXaJxGqC+CLoq7k4XDu+W3E3Kk3WvG-D6tnn2K4ZPNA@mail.gmail.com>
 <CAOEp5OfB62SQzxMj_GkVD4EM=Z+xf43TPoTZwMbPPa3BsX2ooA@mail.gmail.com>
 <CACGkMEu4NdyMoFKbyUGG1aGX+K=ShMZuVuMKYPauEBYz5pxYzA@mail.gmail.com> <CAOEp5Oe7FQQFbO7KDiyBPs1=ox+6rOimOwounTHBuVki2Y3DAg@mail.gmail.com>
In-Reply-To: <CAOEp5Oe7FQQFbO7KDiyBPs1=ox+6rOimOwounTHBuVki2Y3DAg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 13 May 2021 16:43:16 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfr4gLwx0PaRCB1K=TUE_yawpnWx05U9yO0eQ1B+Pa+bg@mail.gmail.com>
Message-ID: <CA+FuTSfr4gLwx0PaRCB1K=TUE_yawpnWx05U9yO0eQ1B+Pa+bg@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To:     Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>,
        davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        mst <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > So the question is what to do now:
> > > > > A)
> > > > > Finalize patches for guest TX and respective QEMU patches
> > > > > Prepare RFC patches for guest RX, get ack on them
> > > > > Change the spec
> > > > > Finalize patches for guest RX according to the spec
> > > > >
> > > > > B)
> > > > > Reject the patches for guest TX
> > > > > Prepare RFC patches for everything, get ack on them
> > > > > Change the spec
> > > > > Finalize patches for everything according to the spec
> > > > >
> > > > > I'm for A) of course :)
> > > >
> > > > I'm for B :)
> > > >
> > > > The reasons are:
> > > >
> > > > 1) keep the assumption of tun_set_offload() to simply the logic and
> > > > compatibility
> > > > 2) it's hard or tricky to touch guest TX path only (e.g the
> > > > virtio_net_hdr_from_skb() is called in both RX and TX)
> > >
> > > I suspect there is _some_ misunderstanding here.
> > > I did not touch virtio_net_hdr_from_skb at all.
> > >
> >
> > Typo, actually I meant virtio_net_hdr_to_skb().
> OK.
> 2) tun_get_user() which is guest TX - this is covered
> 3) tap_get_user() which is guest TX - this is covered
> 4) {t}packet_send() which is userspace TX - this is OK, the userspace
> does not have this feature, it will never use USO

What do you mean exactly? I can certainly imagine packet socket users
that could benefit from using udp gso.

When adding support for a new GSO type in virtio_net_hdr, it ideally
is supported by all users of that interface. Alternatively, if some
users do not support the flag, a call that sets the flag has to
(continue to) fail hard, so that we can enable it at a later time.
