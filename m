Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE76B32C92A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356895AbhCDBFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451797AbhCDAiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:38:09 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7B7C0613F0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 16:35:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t29so17542064pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 16:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rlj4D0v5bpekL9ZaI7FDQkL4vH4D+M9HhI76IRu/Vd8=;
        b=vcidAvXUFJ5S3F/YYqF0IMaBhef7A9GhmSY50pMOvgDEDXJXVBEmw3Ag1eeyPR/Dh7
         q3PK4MSEMxFsioI/cj5bI8w+OiqvsfnZ+47+p1/ymzKZXgZkM4x9K9Q3ijtr8STi20dS
         48GpjPHezERblpAiwrVycGBbRDTlLUXSXn+Prkw1V6L1Q99DioRlHA5X7yfL441LVK4+
         4NTrVzEG0eiRxOYMszBuNV2+7KsvBv+f2iCHeSSbKCw2+XKfwfL/lJwIpg1CYc46Qkph
         7IHrkeXwpLU8TF/lnXGiA55aUitUBPA86uq7vOA2lpcFdl47RIjNS1EQRYg6t/4ylBo1
         2mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rlj4D0v5bpekL9ZaI7FDQkL4vH4D+M9HhI76IRu/Vd8=;
        b=kDuZzWNVzTFGUPfnZnwQVIULsSh7eeAnGx80Q3T+z0frMURxSFiLhPD+h7UHTYaz8f
         zsIgzwPkFtRTITYr68KkEq5l3mRPDDH8tWbUtpvcIB1wj/sFsvdphtb6vy6836sBJIlQ
         t6L4yKg8fLiegOYLWqm6hoShe5cO1u/zsVRbvS0ae2OZ5jQISUnbxUrBmkGrfnwykOfT
         GbWWD8+MRYjMOaCd1+XydCEXmFl6LpWWYD1WR34+gE/nqPrFEnjLM2IlSj9OdEswe4B+
         edxOE7X+C4QOzAtKJb+5FWWIMeAmCFAWSH3Bx+hP2ViZdN6PNGnBp+nrhAKeHE9iGMc+
         LQww==
X-Gm-Message-State: AOAM530drh+9SbBWegVvhEjRKxjMRANenp9+5z8CLdpoYEhyToZn4ilt
        EQq91uwNpYCmH3558KW2KCn/odXG6EmJb8yh
X-Google-Smtp-Source: ABdhPJwRQAn94MhcX8TKlZS+MSRaKoYOW66JAkTdlFY0xdUVssxjuQJG7SXBUSlpXdVuyBdNO6bsYw==
X-Received: by 2002:a63:c702:: with SMTP id n2mr1331072pgg.382.1614818148909;
        Wed, 03 Mar 2021 16:35:48 -0800 (PST)
Received: from ?IPv6:2600:380:7540:52b5:3f01:150c:3b2:bf47? ([2600:380:7540:52b5:3f01:150c:3b2:bf47])
        by smtp.gmail.com with ESMTPSA id y8sm27901045pfe.36.2021.03.03.16.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 16:35:48 -0800 (PST)
Subject: Re: [PATCH] [v2] sata_dwc_460ex: Fix missing check in sata_dwc_isr
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210303073408.461-1-dinghao.liu@zju.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0e734791-d008-eb93-c6f9-b054e9c6bb88@kernel.dk>
Date:   Wed, 3 Mar 2021 17:35:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303073408.461-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/21 12:34 AM, Dinghao Liu wrote:
> The return value of ata_qc_from_tag() is checked in the whole
> kernel except for two calls in sata_dwc_isr(), which may lead
> to null-pointer-dereference. Add return value checks to avoid
> such case.

Applied, thanks.

-- 
Jens Axboe

