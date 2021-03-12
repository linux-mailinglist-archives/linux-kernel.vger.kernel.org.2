Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D893393DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhCLQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhCLQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:47:17 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C2C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:47:16 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id m9so26046124ybk.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P32cze7a2DbaaHVivt3tjV61Cys7jJYG2tRw+9iO+48=;
        b=sfH0qkB7X8pdt3swnbz6eV8GQgHxxoEqWQqarJBZE7wdJAmbVZMphPeQlS3JnTZj1f
         E1biaHjBI05u1CzRjkNX9S+zLeaG+HjIzPoiwNuHOGV1kXeDDBBitwga49KRPzUyZZ6N
         zRk1s/mB7eMkMmJ1YBlTGw+862OF1kyy+d7BensxtVS1XtP5ce0XQ1WnqG5vxHXzR0ok
         zsyKeii/tdejtSf3rTEY+fAASZWxBibSIuf7h6Yn/rCFKf00wfFxSze1jkDomKUWAvk8
         yupy5VJKB4r53OxOqC8/H6oqC5P3YGntS8SzZ9wJtxH/413CwwBigtlEFFGK118pvM2a
         18iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P32cze7a2DbaaHVivt3tjV61Cys7jJYG2tRw+9iO+48=;
        b=WvutW5FvEAQSt1QkRHvhkb5jfJvZbwwi9b73bq+lfdYkutcZHS4IuW04ObPt/v+8J0
         FeeVBxFAy1MlCwq+tdFN9k0G92m1QG/N4+1lAOPM+MCExUuTzyzCSnGv3B52qwmXR5k6
         ul8KDFubFJ8O8YEzgLVl6G1D/yqCVRBtfCKICSKnpBvKpIAOyA/IPGel59Vi5lybPdab
         KvUSQgE8Pf6WewX7dIDMKWeeeIFLJls3I3V9JOQ7ThREldc/XLG9nJrLlVPuEd+wVGc/
         kA/ce9/fVoM86UPvY50Yo0vdR+V2cFKfgB+OgQzy6hAz3j8dL8c7kh+FRYxESiHNVUu3
         N9gg==
X-Gm-Message-State: AOAM533pfRuhepH7kl2oGfaazyqBvNoGoiHMj0SqzJDI+2jwc/JvVTrj
        7Xw7MURBeLCmJ5Jl+av42f4+9TNiwUw5vKxxnfE3lQ==
X-Google-Smtp-Source: ABdhPJxlfGBuV8O8dpfV9g917LWVwkhQO4WFE7G/mTO10v2YywLLxguBDQnC1ahEN5ImIji/Ra6/uReC0bLOnFYZkH0=
X-Received: by 2002:a5b:78f:: with SMTP id b15mr20331332ybq.234.1615567635381;
 Fri, 12 Mar 2021 08:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20210312162127.239795-1-alobakin@pm.me> <20210312162127.239795-3-alobakin@pm.me>
In-Reply-To: <20210312162127.239795-3-alobakin@pm.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 12 Mar 2021 17:47:04 +0100
Message-ID: <CANn89iJvmakwfLFb6QS1ettiJM-D3cJ89bFPvZ=Gk2YyGpxQuw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] gro: don't dereference napi->gro_hash[x]
 multiple times in dev_gro_receive()
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, Wei Wang <weiwan@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Taehee Yoo <ap420073@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 5:22 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> GRO bucket index doesn't change through the entire function.
> Store a pointer to the corresponding bucket on stack once and use
> it later instead of dereferencing again and again.
>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  net/core/dev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index adc42ba7ffd8..ee124aecb8a2 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5957,6 +5957,7 @@ static void gro_flush_oldest(struct napi_struct *napi, struct list_head *head)
>  static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
>  {
>         u32 bucket = skb_get_hash_raw(skb) & (GRO_HASH_BUCKETS - 1);
> +       struct gro_list *gro_list = &napi->gro_hash[bucket];
>         struct list_head *head = &offload_base;
>         struct packet_offload *ptype;
>         __be16 type = skb->protocol;
> @@ -6024,7 +6025,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
>         if (pp) {
>                 skb_list_del_init(pp);
>                 napi_gro_complete(napi, pp);
> -               napi->gro_hash[bucket].count--;
> +               gro_list->count--;
>         }
>
>         if (same_flow)
> @@ -6033,10 +6034,10 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
>         if (NAPI_GRO_CB(skb)->flush)
>                 goto normal;
>
> -       if (unlikely(napi->gro_hash[bucket].count >= MAX_GRO_SKBS)) {
> +       if (unlikely(gro_list->count >= MAX_GRO_SKBS)) {
>                 gro_flush_oldest(napi, gro_head);
>         } else {
> -               napi->gro_hash[bucket].count++;
> +               gro_list->count++;
>         }
>         NAPI_GRO_CB(skb)->count = 1;
>         NAPI_GRO_CB(skb)->age = jiffies;
> @@ -6050,7 +6051,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
>         if (grow > 0)
>                 gro_pull_from_frag0(skb, grow);
>  ok:
> -       if (napi->gro_hash[bucket].count) {
> +       if (gro_list->count) {
>                 if (!test_bit(bucket, &napi->gro_bitmask))
>                         __set_bit(bucket, &napi->gro_bitmask);
>         } else if (test_bit(bucket, &napi->gro_bitmask)) {
> --
> 2.30.2
>
>

This adds more register pressure, do you have precise measures to
confirm this change is a win ?

Presumably the compiler should be able to optimize the code just fine,
it can see @bucket does not change.
