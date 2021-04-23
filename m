Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D526C368D91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbhDWHFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:05:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36216 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbhDWHFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:05:06 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZprZ-00032L-Db
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 07:04:29 +0000
Received: by mail-wr1-f71.google.com with SMTP id 88-20020adf95610000b029010758d8d7e2so3132783wrs.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e++k2gJAXfJ0S7BvuuKCZqY/YBh3pdBsESBVlHSVllc=;
        b=UgL1D16gqA5kjeejsKEwfRFp4P4ymBUoJKUQ7JekefiUF0TqLxFp7lwu/hdfmbocF5
         RzQak01OfjMmr22xXdsUrajTy7xj2ypZMC6dSpIuN7NjI8Dk/4k1AtImHcxntFRU51G6
         xlTtj/Mob3VN02Od/j3Sw29ubjgodqrF8/asjfCukD8HjHEl8BsxmPBrkc91JspFF4s0
         kR86lEs23eKDnHzlZ9xiYGxebh0OE/A6/p6oDhHT39XCCEdyGtRq/G/1w8YYCq2A69pW
         uY/jpvvumvjY+iZaoAfokxBA9zEk7Hg/7wm5grNWEPxEEM1Oa0X5bMShpBHF7Gn9oIjk
         ml1w==
X-Gm-Message-State: AOAM533KiNNHJ+8QQtIdtA1iSqGruDGBtnMUHHEBNCxhw6/NRmMANAeF
        55PIhQDQvr5BRa9ovcd7vyRrB5qsQcXxnmW/Tw60aV27XgobbF8I4CKl6FVnxqQ2HtHFwz8H/jj
        clGMBeMpXCkG+ZQQG+IxhexDFQ43GHa2aC3KDEDQVvg==
X-Received: by 2002:adf:ce08:: with SMTP id p8mr2696188wrn.153.1619161468588;
        Fri, 23 Apr 2021 00:04:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtJc2LK1bhAzeTipMs31xzH2U87YK6mXPU/f/xXdnqzknE6IY1L3FX2flSqZkzlV12EUScJg==
X-Received: by 2002:adf:ce08:: with SMTP id p8mr2696174wrn.153.1619161468432;
        Fri, 23 Apr 2021 00:04:28 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id g5sm7786979wrq.30.2021.04.23.00.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:04:28 -0700 (PDT)
Subject: Re: [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count
 leak"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-10-gregkh@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com>
Date:   Fri, 23 Apr 2021 09:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-10-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> This reverts commit 78741ce98c2e36188e2343434406b0e0bc50b0e7.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

This looks like a good commit but should be done now in a different way
- using pm_runtime_resume_and_get().  Therefore I am fine with revert
and I can submit later better fix.


Best regards,
Krzysztof


Best regards,
Krzysztof
