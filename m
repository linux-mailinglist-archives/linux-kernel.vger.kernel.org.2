Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF353245E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhBXVk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbhBXVkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:40:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5368EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:39:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u187so1083848wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BD4TMcGc8znR7jXz+3t4kYsLronkqlh6PWWcuwDtmDE=;
        b=gb27Ajne2JYQESFv0ps4F6yxTV8s8btpnsDzB9WmJxYo+0fmLxL7RH/nNK+e8GInV2
         vVK661clcGzlWVU0velttreF5aSmB4ZcD+WBYEKji9pygGPXhFBnuX6Y67/ltEjqvPqh
         osEq77Kn/RfaWWiNo8VExEcChLXJcqxAZBAz501dlfouR1PQuB/Z6NF18FF/qYl1plX9
         czl1ev4fZzyxZSVqT3w5/18J+sgSDL7mfKKcQi6b+Q2jMwqVrag28OvttlQo0s/H9IfT
         GoCz0UI7O1NlvkF1Eg02/958Zd7HeHUo2YZK/fxV8nIsQgq1t7pS2T3vLtASnIHTtak0
         zWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BD4TMcGc8znR7jXz+3t4kYsLronkqlh6PWWcuwDtmDE=;
        b=OKGkeEyBEf/QUyLkQc8FpOfuIoyaRWNV1Y7ahCXyk/evCssSrAkePqOA+A3ePdhyb+
         3G9Lx96u7PayGmxX2Diu1fp68nDaVXI2ubdQ6BteOFIpZ1X2f7V5m/QKXH1ZqmxuGwka
         ayIcgpoVtUA/29g69WosRLtKEqkLxaR9D8ttm8Ewpi+DTcXNzB6ALot5guI+6BAsXKcH
         O5CIPlZGunM9sKqCTHbbqhgr9DTLTVu7z8VExrNt7r0rUm/7p1gsZSWfygksohjrP+7J
         gwSO8v7pw8aXPNxJ9eGco5p4FC0B9Ma0vF5iMMpg+LuHfk7C40oKt8iyiNcr4jtOrmbF
         qlQA==
X-Gm-Message-State: AOAM533/ogy7z3ylWOS7xVNaP+KD40fCLQHW3WpSeBLsDF3bIrYY+bce
        ErfwrKris2BMWdMpLoBmrV0=
X-Google-Smtp-Source: ABdhPJwdvUV9eo5JBZfZQpCJZHtLJscksD5TKytwbKtbxJ94zcN/F3Ipi51/9KeFReIlTVBZGVEUBw==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr65061wmb.59.1614202783912;
        Wed, 24 Feb 2021 13:39:43 -0800 (PST)
Received: from [192.168.0.105] (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id f7sm5227549wre.78.2021.02.24.13.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 13:39:43 -0800 (PST)
Subject: Re: next/master bisection: baseline.login on r8a77960-ulcb
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <60346234.1c69fb81.cd55e.770d@mx.google.com>
 <7ac4a45f-b95e-acc0-f5bc-e4f870ac0bf1@collabora.com>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Message-ID: <db197ccf-3b55-098e-bc19-ca8adc98c6b2@gmail.com>
Date:   Wed, 24 Feb 2021 22:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7ac4a45f-b95e-acc0-f5bc-e4f870ac0bf1@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph and all,

On 23.02.21 10:56, Guillaume Tucker wrote:
> Hi Christoph,
> 
> Please see the bisection report below about a boot failure on
> r8a77960-ulcb on next-20210222.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
> 
> The log shows a kernel panic, more details can be found here:
> 
>    https://kernelci.org/test/case/id/6034bde034504edc9faddd2c/
> 
> Please let us know if you need any help to debug the issue or try
> a fix on this platform.

I am also seeing this problem on an iMX8MQ board and can help test if 
you have a fix.

BR
-- 
Heiko
