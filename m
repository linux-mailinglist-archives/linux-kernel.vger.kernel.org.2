Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44238FD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhEYIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhEYIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:47:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78024C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:46:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t15so35198081edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0mOGGUg/bu/CknpssTacwWNPFfoWLfNDXxmfhzHrcLM=;
        b=XtDdl6yYoHieW45I8AVX7GeHg4rYOMimvKp7NNSxGGfj914RlItEmLNN93gpkjIx0z
         fWgwMFJY9a8JBGRw2LD9Wl07B1pFhmULqNgXtSKWxxjizLZj0/VG690lIx+9hWg1GF4Z
         JMCICCrHtxQPpBf1PlTCAYhxYrrlc8/obxZHdw/Ojg9mfpfHXhB6TNM7tAOOe+BStUWy
         EsEnxWllnkJtREZmZRbU0Eas4UNmgSNl4q3SrGVknp7e8t6JlMOQOj5oylyi7ve809k0
         j6NFeUpa7HydO8/LKKVnwh/w+4qIyxi+/XYCSTW/CxS2V4uZ0rVszMyBv8TPBxi4CJ5L
         Ocjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0mOGGUg/bu/CknpssTacwWNPFfoWLfNDXxmfhzHrcLM=;
        b=BkHVWoxHyjiEGNOnno/s/+rJekSzK3aQTC1RPbMNW9XVPE3sEFSacLzzgjnx4JHXFB
         P6BfFz7N0maNo4sMGh+OMUWFHHO9CSJjkVbF0s2kEUnr5HnTst7C1+RDuAJYQcYEafuW
         5uj3E9QXHNqzA6khFFvGCBhNrn8F4Qx+vPW0pisnF8PqAs7bBs02kvFXrr7+zqSnwmc1
         HC3k45WGcFPAmItrr7ijxWvOR7mTrw72FVRUnQ4DkFjEySBRkSp6eAwkpUkZyUE1AssS
         HozIVIkJuO9POFjl7h6DLJAm4XIKhcBvmx9BLb8BjFx0qf/tdQ5kwMnH7KZFuatbNCvf
         TL/g==
X-Gm-Message-State: AOAM532bJahA5DesfSFwGujeHGO1LF3ErJoCXYDBsXhb7ei2w1KhQ7L1
        GHjE6z5WpN1lNhczqfAQaR6PjjzMFa/9ymAsU9eMCWb1hQ==
X-Google-Smtp-Source: ABdhPJzDQ+VbFBOHHRrpSe/yU0A2AhbPiH3uUIxFsL/0tVNlhffQ9MyGpRFq/GYi8ZABtg77Cp461Sih0ZrXX9voJ2I=
X-Received: by 2002:aa7:cd55:: with SMTP id v21mr31274388edw.344.1621932367121;
 Tue, 25 May 2021 01:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210525045838.1137-1-xieyongji@bytedance.com> <75e26cf1-6ee8-108c-ff48-8a23345b3ccc@redhat.com>
In-Reply-To: <75e26cf1-6ee8-108c-ff48-8a23345b3ccc@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 25 May 2021 16:45:56 +0800
Message-ID: <CACycT3s1VkvG7zr7hPciBx8KhwgtNF+CM5GeSJs2tp-2VTsWRw@mail.gmail.com>
Subject: Re: Re: [PATCH] virtio-net: Add validation for used length
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/5/25 =E4=B8=8B=E5=8D=8812:58, Xie Yongji =E5=86=99=E9=81=
=93:
> > This adds validation for used length (might come
> > from an untrusted device) to avoid data corruption
> > or loss.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/net/virtio_net.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c4711e23af88..2dcdc1a3c7e8 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -668,6 +668,13 @@ static struct sk_buff *receive_small(struct net_de=
vice *dev,
> >               void *orig_data;
> >               u32 act;
> >
> > +             if (unlikely(len > GOOD_PACKET_LEN)) {
> > +                     pr_debug("%s: rx error: len %u exceeds max size %=
lu\n",
> > +                              dev->name, len, GOOD_PACKET_LEN);
> > +                     dev->stats.rx_length_errors++;
> > +                     goto err_xdp;
> > +             }
>
>
> Need to count vi->hdr_len here?
>

We did len -=3D vi->hdr_len before.

>
> > +
> >               if (unlikely(hdr->hdr.gso_type))
> >                       goto err_xdp;
> >
> > @@ -739,6 +746,14 @@ static struct sk_buff *receive_small(struct net_de=
vice *dev,
> >       }
> >       rcu_read_unlock();
> >
> > +     if (unlikely(len > GOOD_PACKET_LEN)) {
> > +             pr_debug("%s: rx error: len %u exceeds max size %lu\n",
> > +                      dev->name, len, GOOD_PACKET_LEN);
> > +             dev->stats.rx_length_errors++;
> > +             put_page(page);
> > +             return NULL;
> > +     }
> > +
> >       skb =3D build_skb(buf, buflen);
> >       if (!skb) {
> >               put_page(page);
> > @@ -822,6 +837,13 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
> >               void *data;
> >               u32 act;
> >
> > +             if (unlikely(len > truesize)) {
> > +                     pr_debug("%s: rx error: len %u exceeds truesize %=
lu\n",
> > +                              dev->name, len, (unsigned long)ctx);
> > +                     dev->stats.rx_length_errors++;
> > +                     goto err_xdp;
> > +             }
>
>
> There's a similar check after the XDP, let's simply move it here?

Do we still need that in non-XDP cases?

>
> And do we need similar check in receive_big()?
>

It seems that the check in page_to_skb() can do similar things.

Thanks,
Yongji
