Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA13FA492
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhH1IvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhH1IvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 04:51:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CD9C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 01:50:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s11so8238841pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X/1S2Gl51kTwRIc4I7gdOAuHqJXlOOyNqmUcc/x8ic8=;
        b=AiC1ReYxlFXJF9uWSLkW8Q39/md/6MGcwt0oySlCQTZ6r9YJ1CSbzwDC4pVINYyd7M
         IjN0b+e0p61+Y9f+OGurS189ilQSNQhCvEp+uGhTmhhQorArsFIW0GFpxMpRJy375Qdp
         2qxGVH9D/D1vKX3HuY9puc0FF1FoMS2/PS5QUn39K2TZaf2rwqsHVyWUswGqPQVxUeek
         3Bk+Q3rj+38Is1wUlkGrAfWm2J8q3xVII9+WL2YXqe028S9Rp9y3IldsIt5/EKyEV0KU
         w0KTQfu/3qlLDbWn1GzF8B9qkvIJxGXGfzoYsebdFHs3hAWRO+tJc1ORXdzgUvieLQi8
         tmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X/1S2Gl51kTwRIc4I7gdOAuHqJXlOOyNqmUcc/x8ic8=;
        b=P8/owmim2RwfPr7sgH8pk8GuKk9nYrg0KBMbpwlaSYM81s8Qg1Jrzr/27EipDSblq1
         4qJ4qwJgND1rKnV0pAgJfCK9PvLp5A6q4IVt3oJWNrIlZrOH0acyf890auGBaXgr3hqN
         TAKDFMXriWIKyZwTbordNWGSm8GCithq1B0CXSYN5zkPiZHWQ+n0a8vMmI9UC6SR65eh
         JNDowpygLCkiwBS0U8a1UHZc3syGpjGqYg0NI/x/KN2wT1kQehlPUKg48ZURY/CooOEP
         Sk5A6hVm6FdEy9SJhOdMWr+0BINn3VxF/2pUTbFp+YO68Wx65qlcgp3oX5QEwtc1n6O3
         ASGQ==
X-Gm-Message-State: AOAM530QFhkwwWHzC7Ima5p+2T4zGZck42BEGJvVfMYMpTy9yHQxvtBw
        AfzRS8X/LgrZl4Welqj7XTU=
X-Google-Smtp-Source: ABdhPJw/1VmJdb1PVKw9B03+c7Tplv3F6dHN+AMBwSpWXg5IhaIyH60DjsQBkmJOPbO9k6UofNtejQ==
X-Received: by 2002:a63:cd4e:: with SMTP id a14mr11352157pgj.429.1630140619946;
        Sat, 28 Aug 2021 01:50:19 -0700 (PDT)
Received: from localhost ([49.206.124.188])
        by smtp.gmail.com with ESMTPSA id i11sm9557119pgo.25.2021.08.28.01.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 01:50:19 -0700 (PDT)
Date:   Sat, 28 Aug 2021 14:20:17 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] staging: r8188eu: fix sparse warnings
Message-ID: <20210828085017.d5l63yrxkaxqgpgu@xps.yggdrasil>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629563318.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/23 10:30PM, Aakash Hemadri wrote:
> Hi,
> 	This patch series fixes some sparse warnings in rtw_br_ext.c
> 
> Changes in v3 -> v4
> - Added this changelog, as requested by Greg's patch bot
> 
> Changes in v2 -> v3
> - Fixed incorrect usage/removal of endian swaps and checks
> 
> Changes in v1 -> v2
> - Split patch
> 
> Aakash Hemadri (5):
>   staging: r8188eu: restricted __be16 degrades to int
>   staging: r8188eu: cast to restricted __be32
>   staging: r8188eu: incorrect type in csum_ipv6_magic
>   staging: r8188eu: restricted __be16 degrades to int
>   staging: r8188eu: incorrect type in assignment
> 
>  drivers/staging/r8188eu/core/rtw_br_ext.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 093991aaadf0fbb34184fa37a46e7a157da3f386
> -- 
> 2.32.0
>

Hello greg, if there are any issues with the patchset do let me know,
Larry & Philip acked the previous ver of this patch.

I'd rather not add noise to the ml unnecessarily.
Also this patchset doesn't apply cleanly to the current staging-testing
I can resend fixing that if that's the issue.

-Aakash
