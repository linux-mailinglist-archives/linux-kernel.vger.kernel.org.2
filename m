Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833163FA180
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhH0Wad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhH0Wac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:30:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDF9C061796
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:29:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m18so3210469lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFaSbuczchhLDZy5IY7CfcdpB7jHvLBT1t633LMuncw=;
        b=nubkUMFUVkgLxbDco9G/dSh/5gNYK+UmcBJkqiQ1Pwn2Lq2j4Ghj/IxwiVMOnG6fcz
         SLZLmU/ldK7b2wdBPVZgC8eYngHHpU5ciHMUPtr9br7uMvnf1oTUggd2LoDqWiuwx6W6
         0+6VLbcRUiocf66sK8aGIDOOaYOADHY1UO37LXTb8RlD15+QSDXAyqFU/FEWidfsnes6
         kfeVg2Qzg11qyOUWTskLNCrlletWXtrX4JO5FlMN6QqjI2pIv2MxBhNmfeNKm494jtoJ
         Sxw0UWRaAbAJnR9xImqNtMEyHhbRf1RW3LIIggbpOwBLfkKd+KmDIfCqh50tsdMO4FMq
         maQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFaSbuczchhLDZy5IY7CfcdpB7jHvLBT1t633LMuncw=;
        b=b97PmjFsDLO28KeMmEq4X5/1YRIpG55Z/yE7MWGEcxdGUMh5cf8OBXAPhbWSPFMFob
         bC6dzrcHd2lh4VUlcKuUeD/rrc76V7nf+CH4pPJ9AGy++P8x57d2z+LAjMZhSMq2dXN1
         mULUusUnQXoqEkzApOVDx+zSsFrQBgCSOaArR4GekTk1mW0GCdQrtQEL+nOxrgFkkOFo
         OzFw0DMrlHw8KTLRw2WBY1CfvImXs7Ami3MwFEOPQlK5P5btyqfniOtWP+6fUgaUSNN8
         KR3H/u47aK6zKhnDJLcrEudQAVD3pP8ZqfOVvTJykD6aY8YmbHFLYjjBmtkFSpATKrK3
         a4Ew==
X-Gm-Message-State: AOAM532plu5DN1/4OQEDOQCH1tdjMhxhpxHAuEyR4GXoRaGJIIrka41h
        NdsgJNiXHzPJgz4ldD/MOSGHMqKyHb8wrB5MRTJ/yA==
X-Google-Smtp-Source: ABdhPJx2q28ldwj0ajOBA8MBETJnfnHIp6VwYvSBdVZJ/w8UN+S70Nk9fgNBGp3ebW9iNqwY/6pGtBki98f/G9yOGXQ=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr8177132lfu.291.1630103381632;
 Fri, 27 Aug 2021 15:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210823112204.243255-1-aardelean@deviqon.com> <20210823112204.243255-3-aardelean@deviqon.com>
In-Reply-To: <20210823112204.243255-3-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Aug 2021 00:29:30 +0200
Message-ID: <CACRpkdbrh5WX6whZYXbN44HDY1S-ztCHy3E_6X4oDfvMALwWyA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iio: st_sensors: remove st_sensors_deallocate_trigger()
 function
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 1:22 PM Alexandru Ardelean
<aardelean@deviqon.com> wrote:

> This change converts the st_sensors_allocate_trigger() to use
> device-managed functions.
>
> The parent device of the IIO device object is used. This is based on the
> assumption that all other devm_ calls in the ST sensors use this reference.
>
> That makes the st_sensors_deallocate_trigger() function un-needed, so it
> can be removed.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
