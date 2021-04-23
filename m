Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF8368D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbhDWHDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:03:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36151 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhDWHDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:03:47 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZpqI-0002wI-St
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 07:03:10 +0000
Received: by mail-wr1-f72.google.com with SMTP id t14-20020a5d6a4e0000b029010277dcae0fso14659915wrw.22
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q9o8Y6rAUXarCk5E5vEyZU1S3x3i8TzQWYqRhA6WmKI=;
        b=aScOjQGiTjhkET+/Mrf2sjr6l+ENoQ+y/UOtxrvy83uh1BkVxN/vUuIv1Gm+j77W7z
         667NrSPdFy5Dsuz/sHWRY9CBHooaIwv8Uis+lqaqYz8izBTfX+lrcFUCtiEMV/Bj0OPz
         rt2BbgtcwkS1RiUVXjPeVbm1ixw59COAm6ZZaVV46D/zHwgnQq/2GVJBgedXm3n8CTT5
         MRLyW7SKtXKF/egEnD3rYc35L9cXqtjZXZSq7s+5Ms//mJxmWkxR2julGr38AdWy6ySf
         vjnu0thW1UnI9QumPJlOwIupZrF5QL2gN7bg8H170n/BrxeTSHgkArujFi/wJ9OqbWlR
         VCjQ==
X-Gm-Message-State: AOAM530WEJkd8mgy7KL6JO6IhsrTBkU/iCZxpGk+FofF159SPNl6wcDT
        xQBCZacPKWpWhVyg6rMwN95vr3iJ/R3+nW+UqS47uxEUMAbYdI5B4bQS7n6hWCYBvP3tFmBcQr1
        fulzmMIM0Rd/VY2YAp7iIFwT4Y5kBLslHZYth9vDeNw==
X-Received: by 2002:a05:6000:1786:: with SMTP id e6mr2715833wrg.243.1619161390574;
        Fri, 23 Apr 2021 00:03:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1954prirX0Ucte6UWS6e//PqK9MExKxC701KF+JdNhjiaLJdrv8wZdyCJ5jDE0EdXJig1MA==
X-Received: by 2002:a05:6000:1786:: with SMTP id e6mr2715812wrg.243.1619161390423;
        Fri, 23 Apr 2021 00:03:10 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id n9sm7661295wrq.86.2021.04.23.00.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:03:10 -0700 (PDT)
Subject: Re: [PATCH 004/190] Revert "media: exynos4-is: Fix several reference
 count leaks due to pm_runtime_get_sync"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-5-gregkh@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <00de22ab-e482-84a2-046f-3fe65707e817@canonical.com>
Date:   Fri, 23 Apr 2021 09:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-5-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 14:57, Greg Kroah-Hartman wrote:
> This reverts commit 7ef64ceea0008c17e94a8a2c60c5d6d46f481996.
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
>  drivers/media/platform/exynos4-is/fimc-isp.c  | 4 +---
>  drivers/media/platform/exynos4-is/fimc-lite.c | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

This looks like a good commit but should be done now in a different way
- using pm_runtime_resume_and_get().  Therefore I am fine with revert
and I can submit later better fix.


Best regards,
Krzysztof
