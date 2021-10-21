Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73505435C94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhJUIGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhJUIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:06:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68875C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:04:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so832906lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WVuVc/pTL60G1S+pyJWiP1YTmMHNb2+xE6ALYVAi/xw=;
        b=IEEro4gNH3DIejCXpe0LTEo03FXaRhBYkaROjLXCHDflecMHf3lv+ZnmPuKnlnT5Fy
         je52KNQ/4D9i2+nXYvvuP+an1Pnlw7PxN4XUfbxmSd1diABe1aysqs6pFnLw0TQalFe6
         Vb0q1sKA7Q/KMsvD+g9kIlKuxrBAdqSDmOUHhclAI52k5RjWxo1RpFfwMIVTAUG5Tqpv
         lmd65eKglHQZDWRKqtpnDYnUPHiF9jt7Oq67BAwl1HYkwfS4SSPZ0vYVIhqMHhCaMpm+
         eoPoiDcs2osNu6vsHNgwY4FzxNKjBkhWPi/d8z/Q37rh46hLiVx/SqVJlpmWiMrVxDsb
         0gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WVuVc/pTL60G1S+pyJWiP1YTmMHNb2+xE6ALYVAi/xw=;
        b=qzihnj8qs4f7OI44/dQpFbn+gIuPvm0YT4ETNDrdnBQwHyIMiZQC3HNLKMKRMYSrmn
         acd7Nc7rEZXOKaZk783mk6TZHGeg/LG8FEMDudZYowQCa/foCmqykfngLFwCfLLmAtxK
         00LZaXvU79t37Y03PCxYAvchcgwATDSi6nh/OBXLa+xLmpquEmy91C0+k55Fp0yiX9Ve
         1qHtU6o5mypu0XmXIruCmx6y1Cjmq6lsUnLKZN7olF6Jk2r6n49wkuew4tVeS3iSY1OK
         voBvbvyRIIgyluz3Wb1Yj2pHaaVqJXrPOijuHzcX/3DLMKHpvwSOwCQ87LYr/IbDrZFW
         gjPw==
X-Gm-Message-State: AOAM530mBb8GBe3npuxUoJt6K0S6zfNUAAsVs0fIHiuI/hBipCIeLWre
        5W7g/QUIqjYYLI9ZPdtduIhDyOFUAbE48g==
X-Google-Smtp-Source: ABdhPJwH6CfInm0R8kLy2CulWi4rcXhCTIo2C2PA9o2nT1Cjc31WnBrrJLTnA3vNKuAFp0LelU1v2w==
X-Received: by 2002:a05:6512:3055:: with SMTP id b21mr4173674lfb.316.1634803451737;
        Thu, 21 Oct 2021 01:04:11 -0700 (PDT)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id u25sm391601lfr.279.2021.10.21.01.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:04:11 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] memblock: exclude MEMBLOCK_NOMAP regions from
 kmemleak
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        linux-kernel@vger.kernel.org
References: <20211021070929.23272-1-rppt@kernel.org>
 <20211021070929.23272-3-rppt@kernel.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <5fb2f209-e048-f6f9-4ad3-96645d23fce8@linaro.org>
Date:   Thu, 21 Oct 2021 11:03:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211021070929.23272-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 10/21/21 10:09 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Vladimir Zapolskiy reports:
> 
> commit a7259df76702 ("memblock: make memblock_find_in_range method private")
> invokes a kernel panic while running kmemleak on OF platforms with nomaped
> regions:
> 
>    Unable to handle kernel paging request at virtual address fff000021e00000
>    [...]
>      scan_block+0x64/0x170
>      scan_gray_list+0xe8/0x17c
>      kmemleak_scan+0x270/0x514
>      kmemleak_write+0x34c/0x4ac
> 
> The memory allocated from memblock is registered with kmemleak, but if it
> is marked MEMBLOCK_NOMAP it won't have linear map entries so an attempt to
> scan such areas will fault.
> 
> Ideally, memblock_mark_nomap() would inform kmemleak to ignore
> MEMBLOCK_NOMAP memory, but it can be called before kmemleak interfaces
> operating on physical addresses can use __va() conversion.
> 
> Make sure that functions that mark allocated memory as MEMBLOCK_NOMAP take
> care of informing kmemleak to ignore such memory.
> 
> Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
> Link: https://lore.kernel.org/all/c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com
> Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> Reported-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

this change variant also solves the reported problem, thank you.

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir
