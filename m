Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4E433138
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhJSIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:42:29 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36236
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234592AbhJSIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:42:28 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E5DC140007
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634632814;
        bh=Oor8RTrlmsEN48luONw/N1nWvDIt2v+vgwt+AyOlKOw=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=GvKfyAmf8aA4jbz+eXz9aJBhSx+dcIm52lg7fbV+gCVIUJ2KJLOTuwtCealo13gm7
         f7ccmNEX9Kjv+xJ67Iu5X2+7hLRDCWcMmzH4pdWhHCgQtuyXkxHjd8xkB9x9D21Iui
         rgLOsceubNzuAIIsETHq11L01NRK7hnGhSWD73Sa97vkeeHcAj7n3yjqI2724g3YGL
         nMobfiDJjqSnlr4IU5Pq3BUNrgkSWH+r/o+9lS3vKUKbrOrNr9RJisWvDltgfRdwLX
         d2ve0NtChcPQIy4yy4rGn1BqKmazhNBhqLrkL9/gmKzB1EEEcZnxReJtlvO0jq2tUK
         /JfKDwjhS55+A==
Received: by mail-lj1-f199.google.com with SMTP id h5-20020a2e9005000000b00210d01099b3so610648ljg.17
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oor8RTrlmsEN48luONw/N1nWvDIt2v+vgwt+AyOlKOw=;
        b=KyU8b+unNq3fBuPQeirXuA4Qa8nBdM30B1ZHFAzSBhCvuZDAt3g3ul4lt10EdFOFQU
         dey2mI5nolQwVhi/H1zL9TurB1me1gd1VaNOP9mfw5n45XSeMg837B297Ea/foO5dEoa
         slrL2wTGv3mRNBjmowhB8bbFJDhTcS6RfWlolMhQ0qEJYH45c056NFfKKlLCYrGAbq0N
         UPpvc5Of/qL3SbYspp+hkNMWHcKteHUH2xcAoOyTHGBMOQgKc+6JRMntunCQFafaqHD3
         K95FO8cl0mRo36vdSxvJb6qJdWkP9J7s/OoYkr4JdlltceHeV8YY1iUMC9aJ47166nwH
         ssPQ==
X-Gm-Message-State: AOAM531RTwAS6KzATvfRWmxM3HPRBGfj1DYGVThCZsema/hGKmquif+h
        twBpoC8UjECFLGe/ri8VujGI3z8pv/a9keN96twzo2p5DvvvyGQ8DJaWoqrB6RcFkkynShQWefc
        iSnNy9cUinn/A+yrIhbBMv8JSk+Whk6oKlcRPvK4+ng==
X-Received: by 2002:a05:6512:2284:: with SMTP id f4mr4821164lfu.489.1634632813453;
        Tue, 19 Oct 2021 01:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/DCtam+TMmVk6rVhZw7QiHJeII0jI9LLFQfSbkNULeX7J1V2erkSiMc1YeZNWvHUyMMFxmQ==
X-Received: by 2002:a05:6512:2284:: with SMTP id f4mr4821147lfu.489.1634632813288;
        Tue, 19 Oct 2021 01:40:13 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f6sm2001725ljo.36.2021.10.19.01.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 01:40:12 -0700 (PDT)
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <1634632294-27413-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH -next] memory: tegra20-emc: replace
 DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <46704f75-ce6c-0687-7d50-f3ff27de7baf@canonical.com>
Date:   Tue, 19 Oct 2021 10:40:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1634632294-27413-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 10:31, Yang Li wrote:
> Fix the following coccicheck warning:
> ./drivers/memory/tegra/tegra20-emc.c:915:0-23: WARNING:
> tegra_emc_debug_max_rate_fops should be defined with
> DEFINE_DEBUGFS_ATTRIBUTE
> ./drivers/memory/tegra/tegra20-emc.c:885:0-23: WARNING:
> tegra_emc_debug_min_rate_fops should be defined with
> DEFINE_DEBUGFS_ATTRIBUTE
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

Where is the report? If it is not public, it's not reported-by.


> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

NAK, it's the 6th patch for DEFINE_SIMPLE_ATTRIBUTE in Tegra memory
controller drivers. Several folks from alibaba and zte.com.cn keep
sending patches replacing only one line each time. Leaving all others
not touched.

It's my mistake I actually accepted this, so this ends now.

This is not a warning, this is not a bug. It is rather a coding
convention, so sending such one-by-one is unnecessary churn. Pointless
patches...

Replace all of such patterns or don't send it.

Best regards,
Krzysztof
