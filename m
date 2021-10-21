Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414CC43600E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJULTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJULTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:19:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E3C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:16:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so250881wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TkY3Svf+jR72hx5ROuq6eTRYE3vfUHwyg63NSQqMqvc=;
        b=IxiVGbRQzN4sl/IDtFliVGIOp++xgr7C5UQ2VGnkQDxW8AvH3eLyJUylnErT9qpg7z
         IC5Zd/TcQaGdkwPRkBZiBJFymA+qItkMgv1Yk6HavV4H91kZ8XTl1WGOVTr7DeHZylXF
         d3qHcKqsyjEa9lI+ojlA+kJ8QBrdpkaJWVJcSDEaRn9I8HhT6ylzkAuJOivTGUlU3qOj
         JHQnHCxEFjYr0wd8wQHrTnjJ4wZ4A3iZSxfjP8FIsJVAaZ1DMMvAm+ed59c89l/lGSEy
         HNDVFqzQdoGLYkH7UcxQb5x+neppKuNPhraKuqV7sh1zLG0O7241HZVqLcEtFVELsfsO
         /LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TkY3Svf+jR72hx5ROuq6eTRYE3vfUHwyg63NSQqMqvc=;
        b=GZ4lKZSLBdZmqeKpxvX2CK6u/mm2cM21Tg4U4hB/nmT8GdZMTaAG50JIxRQKTDhp8K
         8XJIBW10saDtDO5nagQM9EwalQ0oBwxUPgFUfqGPSyoHaLdMKTI34Tz/PaiXcFf7cEIi
         gY07HOnYaPZpCDF2DlBXKeLAGKkHxxfkIT31e/8T61wFV9BeYlNxuSQH2Ew1kkNolF17
         c+Pe7+xt6kmEbZHglg3710CsMIZ50iHkfCWm4lN5MzRlJiaQdwZwX8X2qlmzUwyXWYJf
         WhUun0uYO1ZaFpOnlN6SxXpVk8KwnNc1AW5XQGwxoNB3ycg1eEX0rXsqyhqPRBUg1bQt
         W8GQ==
X-Gm-Message-State: AOAM5337vee/c6EHT7SR2YB+RPArY0nX35aNg/uUnSU1xX28/64242hh
        OaVCEJ0/smau1sT2cHVtKInLr0H2vhI=
X-Google-Smtp-Source: ABdhPJxoymnSzYSFfSzwucWCLcXA0Cu7bz8TZz5pGq1sASt0Zf240xgvNM9pL5BAzKf1IF4dByDuhg==
X-Received: by 2002:adf:bbc8:: with SMTP id z8mr6416011wrg.281.1634815011264;
        Thu, 21 Oct 2021 04:16:51 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id l124sm8212515wml.8.2021.10.21.04.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:16:50 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:16:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: replace snprintf in show functions with sysfs_emit
Message-ID: <YXFMIUNWxUiYplsx@google.com>
References: <1634280592-4722-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1634280592-4722-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021, Qing Wang wrote:

> show() must not use snprintf() when formatting the value to be
> returned to user space.
> 
> Fix the following coccicheck warning:
> drivers/mfd/janz-cmodio.c:157: WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/mfd/janz-cmodio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've fixed the subject line for you and applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
