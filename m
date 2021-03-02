Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35D532A9A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581205AbhCBSlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbhCBPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:45:47 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B3CC061224
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:45:23 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id n16so15049052lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGJOP12tupXeQzv6wdlSO3ZQYDh1j4tIYt4tuTAcn/U=;
        b=MkX36FfrOg4u+MTeophtlKAX8UbmwTTdKjjFTorOoqGJtS+RrsUp/xOsSbzYKfT6J0
         lpd/tM1pY1pKQ4ADeALiVtm7GQvcWENljUipa1UUjgYKEWe72q33io2NKiwFF4yd/G4A
         0MUdf7of7eXnBDcf0W1ABzX6XzTtFruFrjKUOUTnjv0VfRuGE8HYt7lrXqEZ5dLtXthh
         TJunfeoVzeMHsaucK6DSGgwsCKunaF6prF7AjoMXnCQ4ciuSfedXkFdRfJFHTaMVLFwn
         5Y/Q5j3yVdjbA+PaSIXQVlhBYeEBkqNw80IBz80d06KoulG79yzyIDIKLsqIKsybU/ZK
         j7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGJOP12tupXeQzv6wdlSO3ZQYDh1j4tIYt4tuTAcn/U=;
        b=kJxqlsBR3Z+n4DDzH5jglRUAA3XIjahWRRBH/xv4M5kfPw9TFxSRKCUnkKAXD86ZIr
         /jLalts25uF38rvpAb5QFnzOq82OellgTwEPquBMra+pUj/6dX19Mp3d4w3fjS3dnPDq
         MhbkdttjENQoYIPLzNGhchBN36LNDQnT4w8+fKJSBk4Vio87xbJnugcrXMZup+4j2zDd
         rlmWvC3qkUiDq5Pt9rb4LGIEOckBpmu7SV1Df4drWCr0Zv3wWCecn9NixRnDhCusnEIg
         zB1W4GnasgqGH81L4/rwOyMC64dRyaq4YLkqYNQfRprz05xUcCbkkA6AZ/MNXs9CP3Sq
         0Qyg==
X-Gm-Message-State: AOAM531NVFjQt5BGdfLvMr1xAX1pg1+2nKm2M3LNZgzUFNSEDqyeuQxM
        mKQtpm1W+qdj+k5IxOsYrXEcPjfP6/0DqsrIsCFYFw==
X-Google-Smtp-Source: ABdhPJx0RIrrlnkScevwvrpR+lstf82IYBP88jWB85tZXFlSItGYjVwG0JvQMBSn2ESQm6rxTUsuMcPPhqwAobDtBok=
X-Received: by 2002:a19:6b13:: with SMTP id d19mr12421144lfa.291.1614699921790;
 Tue, 02 Mar 2021 07:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20210301080421.13436-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20210301080421.13436-1-dinghao.liu@zju.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:45:10 +0100
Message-ID: <CACRpkdZMrQNncocSdqQXbFCdTB9N=PuoNSvW5sU_DLZ8Es0feg@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix error handling in mpu3050_trigger_handler
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 9:04 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> There is one regmap_bulk_read() call in mpu3050_trigger_handler
> that we have caught its return value bug lack further handling.
> Check and terminate the execution flow just like the other three
> regmap_bulk_read() calls in this function.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

OK that makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
