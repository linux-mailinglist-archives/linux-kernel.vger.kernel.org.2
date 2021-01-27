Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C659306119
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhA0QgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhA0QfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:35:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADBDC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:34:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g15so1693425pjd.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LwOa5mhLaXrDlVZ7y1N0pASQsm7d4/OBObUTzGqDPgA=;
        b=s5UbS0im4j206cD2flPBaSsYXt7Pz5F1ruUNDn/hfmsDCYCK58dt5Wwbntnq5Q/0NW
         v99KEm9W3nga7/Gtx9aiPG0j947kF67B/xKEjVV9DGS+8IgtK21ExMGx88ceEpSUvFJd
         mnwM6RRfIGhAcrphnK1mTzVuDdrW30ydU+HNpjRj/5Zgivdh59BoUCUwBxIPFyGnERKk
         aB+4tFVzro/Oag8va0rMT4Dv8mVE4/9yAEaWDha9GmdxWsywxTSwoevJetL9b4/hCHD7
         ulB598fyJ+B4JOg0zwPaAboka8jpI5UiPyoWMOKyVxMnJ8zs1TDXaKp0A9bcrqm3g4mB
         Y/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LwOa5mhLaXrDlVZ7y1N0pASQsm7d4/OBObUTzGqDPgA=;
        b=Bfgcus9BkDcyQFqd9T+t9pWF/NBxDieFwREw6y7GRsTxAmWqf+cThYWglrJqnLdeDA
         WVrq6gO2sK3InSW68CazRRpAbgXt+yIqdxFYJlfMunwI223ji++uoAiOFSABUuQaoSKW
         yMM0EO6bc1E01QzaAr84TgXd1BD54RG8KYwPC1wKyTDmDgBZYkW9xcSas/7BV5t1S8/R
         /E3HmZ8stLFys4Zs3G9HyfrMFGuGrcKNdSTCJKj6jbAtwqSTBe1VtX4zSkm6YoCaV0+F
         zkHyN1y0m7eIzaXrjkvt4yS8H2nD9MuQIOe9spzQzE/GO3gEV3VH7tTi7KeF+QLsmmz8
         tDzA==
X-Gm-Message-State: AOAM531pqauB7psTAPL9e7uIjFpcUXLov4F460KQwzTDwfcXxGPI3CLt
        iPq3JrhbWSuiPnvWPqqp/01jnw==
X-Google-Smtp-Source: ABdhPJwu72vZw4Rvp6EbsllyTsc6G2fh9UxtX6o2Rj4y9aKcFm5WL6r+29C+hJadzIGoTT4ctEY9Ig==
X-Received: by 2002:a17:902:ba93:b029:e0:b6f:8a88 with SMTP id k19-20020a170902ba93b02900e00b6f8a88mr12198403pls.16.1611765269614;
        Wed, 27 Jan 2021 08:34:29 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id fy20sm2771517pjb.54.2021.01.27.08.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:34:28 -0800 (PST)
Subject: Re: [PATCH] zram: remove redundant NULL check
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1611739922-3365-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3536853-5b3e-2cfe-f7c3-1eac89326209@kernel.dk>
Date:   Wed, 27 Jan 2021 09:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611739922-3365-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 2:32 AM, Abaci Team wrote:
> Fix below warnings reported by coccicheck:
> ./drivers/block/zram/zram_drv.c:534:2-8: WARNING: NULL check before some
> freeing functions is not needed.

Already fixed/queued for 5.12:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.12/drivers&id=294ed6b9f00665acc22253044890257c5d9d18c1

-- 
Jens Axboe

