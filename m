Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6015A34478C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhCVOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCVOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:39:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8531EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:39:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt15so12193815ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TXIAzs7ODPCN7iZy43nksfNW6HufOrO6NqQ6lp2JKNk=;
        b=fzFcTmvdQB1Z3gYdtplKY27OZvpdrfFgdelEat5TIsAfvmLyCQUmSTUAxJy85Ky79h
         rQ/bi1/OT/2/S77lYNpIK8kUF8Cx5YqxwKMKxX5m4uRU+tsckIFIXsep50LqWF9ZeQFv
         wE3DAYdKbwWF/e4dSjV554689dAziwJr5+L4YRtCnJ2zEnTZp1ny2Nfsf43MbD/hS0/h
         S5KjZgbAI36pRkMCiN1eKcpnWLqis7x6wpJk/TU3cxChvyMMUEAjXRQghPMXEe1WdsaX
         KgFnNlSGuE11/cm5erPv4OAAa1StCrJAoZXhqTdXw9YWDyKCZogpDoF2yIHC/rclGwEw
         kLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TXIAzs7ODPCN7iZy43nksfNW6HufOrO6NqQ6lp2JKNk=;
        b=iV04hRSNWYISkwDwrkPkHLgRawJVMpQR/jMIQwGDnt5cdqHeTkn5uBoiDI6w2uViD+
         oL5TA5CvkosFzKIQEnY9gK3TBZ8PSJnagWZvCbvH50dNWKKkNjks/+ItbLHxGz2Ud9zR
         P9KsstXCzPv/5deVj/cTUz1NIsxjQOu+7a8cF2cr8ydM6G2A/BNsbQQSoPnIrUo+pcEA
         DGqFRNiK5S+GkrV/xizv3t2qUyqFUOJzTfe5otEsKNzNr/QJJ4m2O2CGuZ4Wse89uCTj
         LUhZKgnKNn6l+52lIMEy9vCjCP/Nv8rrP225oMF8wAwsd8nDud/laKBQRRJmIxpmvqpC
         qmVA==
X-Gm-Message-State: AOAM532/8MyGJmM4fv4gK4WVz/wjVzuyUjiDsJid9a1CFcWCEwB1neS3
        Wykr9l06ICHPFZSZiAQK3E12vw==
X-Google-Smtp-Source: ABdhPJwjnE+4zguVphSa1djQs9Wuml3H9Q1i/WM+T+mjAcv1ZcGIk7V9UUB7Ax89ZjLb++99zSONTA==
X-Received: by 2002:a17:906:3b47:: with SMTP id h7mr26243ejf.377.1616423966271;
        Mon, 22 Mar 2021 07:39:26 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id hd37sm9399818ejc.114.2021.03.22.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:39:25 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:39:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mfd: core: Remove support for dangling device
 properties
Message-ID: <20210322143924.GV2916463@dell>
References: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
 <20210301144222.31290-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301144222.31290-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021, Andy Shevchenko wrote:

> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> From now on only accepting complete software nodes.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/mfd-core.c   | 6 ------
>  include/linux/mfd/core.h | 4 ----
>  2 files changed, 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
