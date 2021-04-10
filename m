Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F535ACAE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhDJKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhDJKNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 06:13:04 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87548C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 03:12:50 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x8so4210945ybx.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 03:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CARFTmdzvVOf8CR8k8TSb1Bj3En1zT2VabMkTx+vpaY=;
        b=TDlQvmZUjGwNXEEdC49UUFP0nlWgNVZoZCpX1EVJDcg5cOECaKzX9/dCC0OHkrEvx4
         woz3TqfsopHp4fGMFzPzvztvlcy2bUMpofjVo+v8y8/O4msdYmEeFD2y9FNpo5WLTGRD
         2/GFlvWEtZ7gFkD3FIWzvn+bqNgHqtFDhg3iUkJbI9VB95sHFYa/cu7vb2Ku5JjRCJzl
         He2PqTywv/q5pCsd5zdmG9OkjgLD/ZJ85ui3gqLLqJqMbFps/kiGUg4aZLRury5rZwKA
         qWKPTLwlibYDdag1jPj3B5b6dOIRzvg93vZI5D/zpWGCFdWSi2BTEaE9+AXX4gKXHADz
         bA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CARFTmdzvVOf8CR8k8TSb1Bj3En1zT2VabMkTx+vpaY=;
        b=JDz+Upd+gAB0eXU7oMPYV6iW8N1YE0vUtG+DCOQFXCi6FYbcq8teuhZ/k2Mn/zMqJh
         s3Q7/eFdXEXamdV7qjtusGkvNmBSFsbeeCc2Z/pgyruaQLo6vIrg2Llrxj5VvzNQZ8AK
         D/Fdk+66LaPkhSmc0VxnzpXs4NWWoM9wCULsIaHWflS9jM1LrdN2nrsTvyQn9VLm+sL8
         ImR9Zm74hP/fTqU7Y1Hw29BwPjPXA+3SCBpkC1tEVl576d05ijFz8XuJ74Oe02E8ibBP
         ijd5QjngyH2Sf4lYIoP9uReTddZW3st3RZU9fs/1Zp8eWj/3wg27/fiHlIK67G1ASq21
         YUBQ==
X-Gm-Message-State: AOAM532ETwzVUjskYcyLXwheOTerIi0LJQFYthlJjnJrerXy3VRiaOs6
        2YPHvhhtcSyn2BTSO8hmDsnatalT3RqM1bmkmFW/6w==
X-Google-Smtp-Source: ABdhPJykbc2kIdAnxojWnWmjTXLCoqiYIos3RQmPBSfwujcYI0ykjnGLqgi5HdHhuXcv19zMpV1TEG7oxIWIWF+Gpak=
X-Received: by 2002:a25:7e01:: with SMTP id z1mr26393090ybc.253.1618049569299;
 Sat, 10 Apr 2021 03:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210410095149.3708143-1-phil@philpotter.co.uk>
In-Reply-To: <20210410095149.3708143-1-phil@philpotter.co.uk>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 10 Apr 2021 12:12:38 +0200
Message-ID: <CANn89iJdoaC9P_Nd=BrXVRyMS43YOg-DX=VciDO89mH_JPVRTg@mail.gmail.com>
Subject: Re: [PATCH] net: core: sk_buff: zero-fill skb->data in __alloc_skb function
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     davem@davemloft.net, kuba@kernel.org, willemb@google.com,
        linmiaohe@huawei.com, linyunsheng@huawei.com, alobakin@pm.me,
        elver@google.com, gnault@redhat.com, dseok.yi@samsung.com,
        viro@zeniv.linux.org.uk, vladimir.oltean@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:51 AM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> Zero-fill skb->data in __alloc_skb function of net/core/skbuff.c,
> up to start of struct skb_shared_info bytes. Fixes a KMSAN-found
> uninit-value bug reported by syzbot at:
> https://syzkaller.appspot.com/bug?id=abe95dc3e3e9667fc23b8d81f29ecad95c6f106f
>
> Reported-by: syzbot+2e406a9ac75bb71d4b7a@syzkaller.appspotmail.com
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  net/core/skbuff.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 785daff48030..9ac26cdb5417 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -215,6 +215,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
>          * to allow max possible filling before reallocation.
>          */
>         size = SKB_WITH_OVERHEAD(ksize(data));
> +       memset(data, 0, size);
>         prefetchw(data + size);


Certainly not.

There is a difference between kmalloc() and kzalloc()

Here you are basically silencing KMSAN and make it useless.

Please fix the real issue, or stop using KMSAN if it bothers you.
