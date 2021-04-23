Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3461D368D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbhDWHEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:04:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36200 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:04:47 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZprG-00030i-Dr
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 07:04:10 +0000
Received: by mail-wr1-f69.google.com with SMTP id 88-20020adf95610000b029010758d8d7e2so3132422wrs.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6OTJ8nwJ9QH/vOYRJ/lKw2Zze+GhAGRCcxguGQb/Ofo=;
        b=pGxggYXo8VszF6zye2+KA/nGYKqri7EF9ITJ/1woA1iKAh4Y+J7lExakRMS8S3Qqn7
         BZ2fMM9vmvOJQ0jr1F0FxDkn6ZIi5zKdQhfaVWlCc6C+aUTWYEkKyBa0iMobmcS5ItiL
         ezSWfaIwGGYMANlFY/rSZQvzm7b9jpMeFNZEmWUnLcueiRhlVhAJj8Z3hX9z1CfFIqG5
         m9xM1jzlnfyf3jwaGxOTxus5bWbrSHnEkQi3TMfYRswdxZGS1xxc64++rZkSJ+oVYia4
         8r4CeKK2vNdsEslAC1HiuEjbNpMnnCp0zvzjGogbTzKdSmSwLekkuuKZUgiuIINHY4DI
         bDTQ==
X-Gm-Message-State: AOAM530+Amb0RBEDiyi3LY5BalaKldBysNsJt//63i0qloNg/8RntqVi
        WG5EBzu4SD4xIa4EDcCITs3nV7eYLUoOFqmMjU80C/9ShrgjujakvkwcO2/pC4sBsscrRPHLnqH
        VJEWaa9OLe8F/OAJuyBtW+K9ebXoUVVb8Uf6kP5lLyw==
X-Received: by 2002:a05:6000:1ac5:: with SMTP id i5mr2720714wry.412.1619161450205;
        Fri, 23 Apr 2021 00:04:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLgHzE2ruZNhHHOewzD5BqENY0Py4skf0E/cE5rjXhjpb1kjw4TCu7EiKjupVYKcZdWnq1gw==
X-Received: by 2002:a05:6000:1ac5:: with SMTP id i5mr2720702wry.412.1619161450099;
        Fri, 23 Apr 2021 00:04:10 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id e9sm7800169wrs.84.2021.04.23.00.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:04:09 -0700 (PDT)
Subject: Re: [PATCH 006/190] Revert "media: exynos4-is: Fix a reference count
 leak"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-7-gregkh@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e9fd0218-5ef6-784f-8702-22013b4e1593@canonical.com>
Date:   Fri, 23 Apr 2021 09:04:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-7-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> This reverts commit 64157b2cb1940449e7df2670e85781c690266588.
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
>  drivers/media/platform/exynos4-is/mipi-csis.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)


This looks like a good commit but should be done now in a different way
- using pm_runtime_resume_and_get().  Therefore I am fine with revert
and I can submit later better fix.


Best regards,
Krzysztof


Best regards,
Krzysztof
