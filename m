Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A643F3BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhHURYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhHURX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:23:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A62AC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:23:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u15so7714925plg.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgSKf2nq4ZeNmXzm2HLOaXRnUpP2wevjMWH3/GY16uM=;
        b=Rn29nY7MAE884Ua/QgTZmO+tx9rci1wbOk7FuiieNr54B+2mPbssg94R5/7PIcCZJC
         +XFG688G+qHaq96dsJciv+9QYr1UegUpd8zEfB8oN+pzI73k1Ew1eyi1/JI/EJ7C3+Wz
         1pE9GRBEjdllgLyNW7ReOy/8kqe/uxKRDFJC1TjxwPBjOhH5y5LLV2aoja9xYPLAf03P
         7SNGxYXIdAYT2eU37QLrs8owmsaJTm9k1Nm1uF1PlfJcatT9AUw6tz//E1opTU8eMyuQ
         N7K/EmUSwmjJyZ7NNj5qaMn4EWoaulPx0y7SC5IhO8H4+bxn8MN1YBI5HMYEHXHwgyY/
         MO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgSKf2nq4ZeNmXzm2HLOaXRnUpP2wevjMWH3/GY16uM=;
        b=Fp5++2dgN40akCDAlnMBWX2n1wVp6FlXhwgdgz2VZ9PPno2IZMMqKe3rDNmFsfihId
         y9OaCSelCXd9rD1z9EmnUj7qU01MCyipNIarp9orAXmfKwIumY1DmXcE8oDntTnmHoYW
         TtZdmiSklfrM1vd3Jf4t5LbZn87qn3un+gXbhg6MRo2/d9cIAzopZ6gkDnBqN7TnaTde
         bsGSSm6EQspoNI4yDsCS0UFORo3kUTqhibKbnYkHpTAvibq/RoVpztGyAN3nPEzli4I6
         uEezmeS5jmlYoaAmzxxpJF6EwoFPrkijA9T+q+LbbCXTgxhYa0sAnaW/WQCUvVD/YNyI
         zYhg==
X-Gm-Message-State: AOAM531iyeteM6GSdwS7tV8edAYO5dJp2ttYhODf3JXZ0tvSYvjHaUZP
        izYb5LXYd+yP7yK3jx1nvT1NWS/HqyxGKTUf/6dKMA==
X-Google-Smtp-Source: ABdhPJx0A+af2++jJHfLsdlb6E3H2MXjYcN1tlRw8aIhDheoxarpNlOZMKj5/0sYK9BEDTDt/vgmn598jvxpcCwzIwY=
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr10801337pjy.225.1629566599590;
 Sat, 21 Aug 2021 10:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629562355.git.aakashhemadri123@gmail.com> <7572c80d90b499df7e9feb4781c07967fa31bf88.1629562355.git.aakashhemadri123@gmail.com>
In-Reply-To: <7572c80d90b499df7e9feb4781c07967fa31bf88.1629562355.git.aakashhemadri123@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:23:08 +0100
Message-ID: <CAA=Fs0=jkOB25NM=7fbaguco-WqV_emKsEkk6UXasn=wc9ndcQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] staging: r8188eu: restricted __be16 degrades to int
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 at 17:18, Aakash Hemadri <aakashhemadri123@gmail.com> wrote:
>
> Fix sparse warning:
> > rtw_br_ext.c:73:23: warning: restricted __be16 degrades to integer
>
> Here tag->tag_len is be16, use be16_to_cpu()
>
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index ee52f28a1e56..f6d1f6029ec3 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
>         struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
>         int data_len;
>
> -       data_len = tag->tag_len + TAG_HDR_LEN;
> +       data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
>         if (skb_tailroom(skb) < data_len) {
>                 _DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
>                 return -1;
> --
> 2.32.0
>

Thanks for this - looks good from what I can see.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
