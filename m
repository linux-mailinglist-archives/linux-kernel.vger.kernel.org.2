Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B10230B3BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBAXzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBAXzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:55:08 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922ABC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 15:54:28 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id d1so18125573otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aDojUkHo90pEvXpZkv6t3T7DNgGSpgLl4Ya1KVsoDg=;
        b=SfPPo5qo4TCbx8PCc9ZAnK4vquw07MtaBluOtSn9+pBr7hKOO71zebkb3RW6fx/IeT
         Y6Hq9g1voseYoRkM4LcKZmrUSzv4UOoi99X4mPdw78ccW0i4g29tBt0zNsn1vMLdL6wj
         1KzJZgmHRJFHrQaIqyn5pnD6NaNn4Oh6EZN/BU/8Ac+sjZDVsow1+gNQY54dEKSmZhAf
         QBONNo+qg0r+pC+wSDgvpYet+6RKa8uzd5AaZ5GkzoOkPK6Ul/PLHNhIeVx+8KiMZlXO
         kfcYhfVko/xwTPeaSSG82Eztsry2ESa3icu0OboHvKHlkRCpiuNsOC/KQkHmvONE4SdB
         DaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aDojUkHo90pEvXpZkv6t3T7DNgGSpgLl4Ya1KVsoDg=;
        b=ipEOTVgd4goV4vYP2rzJjxOi8cUmDhdNes1ksXCqAtMHwASigqLrNOtuX6xr0zkCs2
         sERAJTCnQHBrtSdk761499kuRx46DZS/fuio0jDPK0/h1iOKA9ByoOfeWYZqABQmcva4
         8E0ei7yANKUZXNHF/64TxvChHXQgmJ3QdD1IcDme9jc4uL3dILy1DiIbjOXZPAXKbS0o
         2a/uHwA6aj+iwhpbZ9cH51gnALYtt0emeHVrvuW/EguriEReW8a7hPeF1gnBWDfW2E6R
         ZU5kH5QuZCHQ1P/4c2EHJew3ykuHnY4187gObEom6m1xYwI0+zv8SQtUpcQIjISop/xt
         lqsw==
X-Gm-Message-State: AOAM532Mm/OK0N4Zc6H6XhJts6Dl3lSn9tQldWkpkb2gUddapHLPdwnR
        yDgFLCb0sKRfRQQIS3r0T+zg8pF08sXY0wGF6tQ=
X-Google-Smtp-Source: ABdhPJwQYlfkagOgAez/IT1Hbig0YufGodBOSs2aQZQSR8SNzoXURKsbDPAmOs6KWJBgQa/EvaxKVa2clF7JDJ/XAWE=
X-Received: by 2002:a05:6830:15c5:: with SMTP id j5mr13495926otr.185.1612223667775;
 Mon, 01 Feb 2021 15:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20210201233254.91809-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20210201233254.91809-1-rikard.falkeborn@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 1 Feb 2021 15:54:15 -0800
Message-ID: <CAE1WUT4DJJyHM7zJLFxThJvfmrGRpCamuUn0V19JqjYVddF=LA@mail.gmail.com>
Subject: Re: [PATCH] mm/swap_state: Constify static struct attribute_group
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 3:37 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> The only usage of swap_attr_group is to pass its address to
> sysfs_create_group() which takes a pointer to const attribute_group.
> Make it const to allow the compiler to put it in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  mm/swap_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d0d417efeecc..3cdee7b11da9 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -901,7 +901,7 @@ static struct attribute *swap_attrs[] = {
>         NULL,
>  };
>
> -static struct attribute_group swap_attr_group = {
> +static const struct attribute_group swap_attr_group = {
>         .attrs = swap_attrs,
>  };
>
> --
> 2.30.0
>

Looks all good to me - there aren't any dependencies on it anywhere else.

Reviewed-by: Amy Parker <enbyamy@gmail.com>
