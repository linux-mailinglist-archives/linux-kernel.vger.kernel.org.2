Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9DF40BB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhINWX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhINWXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:23:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:22:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q26so637520wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9miw9SxWD4u0MzKWwOg5JNvsX0BNeRBeHfRb+p9jelo=;
        b=kxU9zo4bB3SNnuVhnb9/SuNygbOih4SJg2h89xELrhbMHYuAjSXDklDxEQOxGAcr8T
         RXn0JhJtIPIv6RMUMmW/aQjaLwyFRt7MBlK2xlJkWdYZfeKdGtq7CoAhw3iTmNi5gC4F
         7+H95ozTYtjb2vAWufgiY1Ug9p5O3YFPZ+ftCd+w4QrWcbY4KIv8o0Z0rorun2NP4bMS
         zG6nuUakNwhVeRynoPAzLxiZoQYYxjOMv+BPRIjwIs6N1KxNloTo/0xxU+iCcJ80HHCT
         ZG/TsL+kcKhEBITH/dEy/JLaarEXKtKteLGDcJIA8SCHX6sAlImib98GoSknoCFA6mMj
         k+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9miw9SxWD4u0MzKWwOg5JNvsX0BNeRBeHfRb+p9jelo=;
        b=RJxFk0X3RFbYzS94IRmGu0dhSS9dqLlPOwkzNKZVjEX8LjvJwryGjgJoasrjFkvM5K
         cJWX3YlimwhI+5MEA8X0GrVOagWqsyAPflA7dza8L7U3HXfn5VkMzJqjppkw8kEz4Ywr
         WZ3J0PstpPEXFVr1O23sQQw08P5c5LTs5x58uV1yUy//CEOPbGXuFl8pipop5m1U+MHn
         DDAbwLpe3UtxeTmtJYUn8Ck90duIyEA2tv2l9aFkf37JUT2oajCjuDcTRrjyFp89RsVV
         3igjgs9aTI3abBm5BU9XRT1F/RrsUKpPvTQwErnyeU4Vuw7TLgMwTj28IpyW/iGvYE2d
         p2Zg==
X-Gm-Message-State: AOAM530kE/4jIQOC2vJ34Md9lHhm19WiTiT3BMGE1hkOQma+Ka0QxbMV
        3HKXxViO5Fdcf3nhOEavoNfhQg==
X-Google-Smtp-Source: ABdhPJz/EPJVQ00Dz/FRmjo9aidF8nvyBR0G6x7XpAg7VIfv950GLcNFFMZjEAzut3+gF2d7BXJF8w==
X-Received: by 2002:adf:80eb:: with SMTP id 98mr1459440wrl.348.1631658149357;
        Tue, 14 Sep 2021 15:22:29 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id h15sm11271408wrc.19.2021.09.14.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:22:28 -0700 (PDT)
Date:   Tue, 14 Sep 2021 23:22:26 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: r8188eu: remove unused fields from struct
 hal_data_8188e
Message-ID: <YUEgoipiosdhiXdq@equinox>
References: <20210914121352.26052-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914121352.26052-1-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:13:48PM +0200, Michael Straube wrote:
> This series removes some unused fields from struct hal_data_8188eu.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (4):
>   staging: r8188eu: remove unused macros from rtl8188e_hal.h
>   staging: r8188eu: remove write-only fields from struct hal_data_8188e
>   staging: r8188eu: remove unused enums from rtl8288e_hal.h
>   staging: r8188eu: remove unused field from struct hal_data_8188e
> 
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  5 -----
>  .../staging/r8188eu/include/rtl8188e_hal.h    | 22 -------------------
>  2 files changed, 27 deletions(-)
> 
> -- 
> 2.33.0
> 

Dear Michael,

Looks good, built and tested here and working fine - as you say though
these are removals of unused code/properties so I was expecting it to
work anyway :-)

One small thing to change though: the subject line of PATCH 3/4 should
refer to rtl8188e_hal.h, rather than rtl8288e_hal.h.

Many thanks,
Phil
