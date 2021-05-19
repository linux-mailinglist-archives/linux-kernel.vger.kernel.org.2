Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9E388D54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352898AbhESL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352823AbhESL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:57:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A66C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:56:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x8so13710835wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tywEFb4vp0ELML71nnp+3Fg0yJB6HJRt5hv7Bnh2ISE=;
        b=zHRh08vDkJN66J2tWvBYCucBoSBvHiDxBECiPzMCzRNK21lcuuPtpyCi2Dypq3rAbR
         PXctT9x/1L2rWQUplaqdeFfccWRnDjlI+wVyHQcGHHn5clpG/7js1sDp+6wHG6yLFhf5
         ym7xls6t8CpUCce7QtSytRJYwenWMUSn7Q6E2lT1wew3YM5vsrcEvGjfR6YAYkP5L0RK
         yfV+tI4+yKioRuo4+664vYINpCSEBo3EW2bgt9aCHE/2jFExl5kk6PchqGmj9ANAgPAn
         cOtYfIan8XZv8RPbJSM3npF485fFueG2p8gsuC4sl6mw5UgQc93OCcju/qbF3RObctfL
         TezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tywEFb4vp0ELML71nnp+3Fg0yJB6HJRt5hv7Bnh2ISE=;
        b=CrFA+nHZgR/SAQYT3stnQNd8qcsrg6RZln6vcZXnLuqiKmRwV95ANwS/09rmePFwa2
         3cdgaLkUvNLR0wzWnI2YFjk1e48wRYccBD4hpx9KR3kAiPfFHRR64WAA67aJqoyMQT39
         /YDNhEpHUTH91/xovBX7Dt/908veWXXZ/Pnaxe3Aa5U644fKteen/b3Q5QrBE1eV5fc3
         usivm9U/o3Crh89gS3spH4GL44sf1p/P1W48WIdnXO67G3JO6Euk8RuTNf3BUGO7JExA
         XU+wrl8p9ZOffZIcTUcr8NX3/fRre7U8mkPj85T6zn0U2n12Qh56V6w9bqt7v8IAi4KX
         eKFA==
X-Gm-Message-State: AOAM530UxsRx+CLGnP5OKIryY8nRJ5R88GoeByXdv2jtQzL3Nq1OwKji
        ecZT9AHJZQpx5ZG692dUVfg6HlsBc3/d3Q==
X-Google-Smtp-Source: ABdhPJz2vIsE2USfXvF8zgxO5QbHoPaqhASWfvswHoU/c0B0fm/bi2xlXJYtE+upEc4pNIB3/lVx3w==
X-Received: by 2002:a5d:5508:: with SMTP id b8mr13664638wrv.278.1621425388572;
        Wed, 19 May 2021 04:56:28 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id h14sm31788062wrq.45.2021.05.19.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:56:28 -0700 (PDT)
Date:   Wed, 19 May 2021 12:56:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jian Dong <dj0227@163.com>
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com,
        Jian Dong <dongjian@yulong.com>
Subject: Re: [PATCH] mfd: si476x-cmd: fix two typos
Message-ID: <20210519115626.GE2403908@dell>
References: <1620379295-144373-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620379295-144373-1-git-send-email-dj0227@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2021, Jian Dong wrote:

> From: Jian Dong <dongjian@yulong.com>
> 
> Fix two typos retured --> returned
> 
> Signed-off-by: Jian Dong <dongjian@yulong.com>
> ---
>  drivers/mfd/si476x-cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
