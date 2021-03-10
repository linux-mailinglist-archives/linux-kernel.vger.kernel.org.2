Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE83348CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhCJUWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhCJUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:21:54 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1390C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:21:53 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id r7so1175728ilb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=16SMPeE21CushitzJ7QMJXGi9ZvpBG0rD0GsXsI6hkU=;
        b=spJ0UNdk80g6IuuuMgwcY1AR/MlQcbuEaGPdCTXj/1jApxV2p8lLCbpw2FXeZARvWw
         y/3ktMyTJ21jResBV0RdchCy0MqpQWNv6dER4WFlnhzYk11bwv9aqcm+KgHMLqKIFAg9
         wF9GAaMI7rlW6A9bWBqHeVNEog/S6909mlwkSYh4TiTs7CPTx7DyMRuCfR5rgcfLGNPw
         7niYk993aUFxdD50MZMH/zMHbKSz3aFLl/hTPoGJ9DZoAjDfDnhpA9Yejl0H8WuBPrrr
         mEbiTH3WB8Tk5vq0oyUEyB0M7QqkyfIHA/kpU0TP4QB2m7ME4eNl4B6QEjUSfovzkZcb
         hE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=16SMPeE21CushitzJ7QMJXGi9ZvpBG0rD0GsXsI6hkU=;
        b=toypPmm8URCm7Lq4GCDhZd2FCQGJdVXNuiPU45IffE9Hww24vTUm5i8VYdoISr+kl4
         Cz3Ckm0H0PcsS//woX6R+5kILUKcNxur5ZRvYoOarb6fDeen53P9LnyYTGeFAr851L99
         ZwUocuQQj9MPqU4LhUEB39ApipDSNanTKyXXxtfDQHjdrLmupC0IX/ZRuS53SLEN0GwK
         5/v+LTU1ns4JR20YjIyjPukQvrRojRTsNDokzReiUq0mFb+Zndt6mx+XWc3ru057o3cz
         X3072Mkkuj1Ide1paZMGQeUG6+bQuRiViTqeIi07oY4KctYk7A+mn9/EHpzev8A/xK18
         +vcA==
X-Gm-Message-State: AOAM532Q6a5RraxAEN80bdFLxC/t9lSdp7pna+rEr0R63xk9UDNei0ce
        p4PHz50BKCwYyJ2EGN5sVqQ0Sg==
X-Google-Smtp-Source: ABdhPJzg7g/La5YMg5wKnM0/F2ii9+d2ML0g09VHJPp0z1r9WLx+9Fj1ToRDzy/DzFD7axi1WAT7xQ==
X-Received: by 2002:a92:1312:: with SMTP id 18mr3843559ilt.92.1615407713037;
        Wed, 10 Mar 2021 12:21:53 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h15sm199377ils.73.2021.03.10.12.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 12:21:52 -0800 (PST)
Subject: Re: -Walign-mismatch in block/blk-mq.c
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99cf90ea-81c0-e110-4815-dd1f7df36cb4@kernel.dk>
Date:   Wed, 10 Mar 2021 13:21:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 11:23 AM, Nathan Chancellor wrote:
> Hi Jens,
> 
> There is a new clang warning added in the development branch,
> -Walign-mismatch, which shows an instance in block/blk-mq.c:
> 
> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
> 32-byte aligned parameter 2 of 'smp_call_function_single_async' may
> result in an unaligned pointer access [-Walign-mismatch]
>                 smp_call_function_single_async(cpu, &rq->csd);
>                                                     ^
> 1 warning generated.
> 
> There appears to be some history here as I can see that this member was
> purposefully unaligned in commit 4ccafe032005 ("block: unalign
> call_single_data in struct request"). However, I later see a change in
> commit 7c3fb70f0341 ("block: rearrange a few request fields for better
> cache layout") that seems somewhat related. Is it possible to get back
> the alignment by rearranging the structure again? This seems to be the
> only solution for the warning aside from just outright disabling it,
> which would be a shame since it seems like it could be useful for
> architectures that cannot handle unaligned accesses well, unless I am
> missing something obvious :)

It should not be hard to ensure that alignment without re-introducing
the bloat. Is there some background on why 32-byte alignment is
required?

-- 
Jens Axboe

