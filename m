Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE5396E99
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhFAINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhFAINt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:13:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:12:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r13so7083397wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Nsp6tgdli24TKrlr3j1Fk9ZPdazgFsIx2+NfZS4RGkA=;
        b=lwXorZPIygSdJ+nzd/v2e4sUSTxay9zZa7YryXQ4Lj8JOg1eAqyMIC9pGXSRBj5eSE
         Rnj6tzywhsubBOxL3AWdOVrEKco7htDQGPPbhGisE5MYhcIWK2E0Jd6qHMrufdSaaZls
         p0J5UhipQ4nLAC89GuTuAX0hUEjPC2hvQxy5NVtvMGqtmZ701oPr081fiK9v5t5KNBEJ
         l+mZ4efyzxULQvX6UxGLDelMANg8TdtZnHFnWVYCkCMkJMFRTd9ioqI4Zpvae5jGjUvB
         ZVAtAivoVCuVHAC85xHHegfKH7gGxOD3+KWJsMeQ2WkjN0/5FWA6LMFHkyq5VBDKgjDI
         J6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Nsp6tgdli24TKrlr3j1Fk9ZPdazgFsIx2+NfZS4RGkA=;
        b=duT3K/hZ3cdWG9TlvoXsBy9K7avepg9HlaFv1YiDwcWG4HuhaYcnNucqyAeh8Lm7HB
         f7cZ5YgvYSN2wUa5KHg5Fh7wrZC8INJGnUyZ6jWQCwXbFu/kSLDTXafZGGN2bSy+fZ02
         PmmqcETYTmdEMZNAptTWjeMc12IChq4WEobzJR5jvIgYEL/m4mkEBRFZKOkJENKcRixy
         jQ7K50lrXpRlduQ0yqCByyhvm1p3RplkxeImOGNMKHhKtCTk4Qc/etymNk8OrxBYWEkC
         /8k374Bp8kU+Bmij8O97guD6YogPmwRbXddxTZ7Y4rPcUGHL/O+6ulJvMAlcg4zwsCFC
         zlmg==
X-Gm-Message-State: AOAM530ZCfD0I7Iex5gxhYpeJ5D/TfMVysFhgxfcb8YXyXnAZERposta
        1bsT9idb2vjL3ncII8jdQ3F1q0EBCXBDTA==
X-Google-Smtp-Source: ABdhPJzWu1psz7lKT8UBrl5ht44eDwi6KFLhX5P23trCepFWa2RN1GpxNkSDerGntk4CekpMmi/KiQ==
X-Received: by 2002:a05:600c:4ec9:: with SMTP id g9mr24195864wmq.173.1622535126994;
        Tue, 01 Jun 2021 01:12:06 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id m23sm1805643wmc.29.2021.06.01.01.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:12:06 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:12:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH -next] mfd: db8500-prcmu: fix some doc warnings
Message-ID: <20210601081204.GT543307@dell>
References: <20210531144740.24466-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210531144740.24466-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021, Yang Yingliang wrote:

> Fix the following W=1 warnings:
> 
>   drivers/mfd/db8500-prcmu.c:624: warning: expecting prototype for prcmu_get_current_mode(). Prototype was for prcmu_get_xp70_current_state() instead
>   drivers/mfd/db8500-prcmu.c:908: warning: expecting prototype for db8500_set_ape_opp(). Prototype was for db8500_prcmu_set_ape_opp() instead
>   drivers/mfd/db8500-prcmu.c:2303: warning: expecting prototype for db8500_prcmu_reset_modem(). Prototype was for db8500_prcmu_modem_reset() instead

Thanks for the patch.

These are already fixed in -next.

> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mfd/db8500-prcmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
