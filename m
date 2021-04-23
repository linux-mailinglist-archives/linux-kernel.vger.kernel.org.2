Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2C368D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhDWHEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:04:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36167 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbhDWHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:04:11 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZpqg-0002xq-Hv
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 07:03:34 +0000
Received: by mail-wm1-f71.google.com with SMTP id 26-20020a05600c021ab029012e366eff83so349521wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V38j0qcwNTGkM7Oe+SGtrgoJmBSn3ZlecfCYAX/KXuM=;
        b=mjvdkqb2lj60AhoHbpV73yjZsY7pFUIvYMGFkE1EfEdRylniIwHSZXgxEsRDCc2WoH
         jrNNWM/Lsry2TSjB9Poxe9qfdA2noRp3F6xjUjI5U7BTImMjeOffnSk1xCRgC0AMJL7Z
         CeoOK/fI5c4FyX8dANK2NTHu0+Dui+CYAJag2HxmwF5gCjX3H2L6t0nTfZ3waEoKG5Es
         03z3r8VkcAXb6JSdomH2T5YQygrVjtzyK9i8B4PRlMXjqEukBnq3g4H3GTuiVOWCekMf
         X6Y/RFVWSdyh2S4j/NpJh4hf18ViSJzWR6v5YF/xbycOGEKr6Ve/bftiy5WLmN4SQfHk
         WtvA==
X-Gm-Message-State: AOAM532wQLNAeSMOKhCcMBs+uHafe7rJuGwDKxXt8Hzs/BbEcw/i5Mb7
        Jb6rkUW23+50iFrrprlJM2XC5p7XY27F86S72w0PLxT2nMumICK4838aiGEP1a8WVKOMDFpC88R
        uM7/qXnkiifeveQ3V0PHf4DQzklCK6a7Ks/Mual3Pcw==
X-Received: by 2002:a5d:45ce:: with SMTP id b14mr2676104wrs.357.1619161414304;
        Fri, 23 Apr 2021 00:03:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO59qk5YeDRA+kiPdKbggmrUajmisQRCiN+3ylFMCG0okSSvLVuBDRIx1AxMLoeNtV9f9omg==
X-Received: by 2002:a5d:45ce:: with SMTP id b14mr2676092wrs.357.1619161414191;
        Fri, 23 Apr 2021 00:03:34 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id z18sm9236166wrr.9.2021.04.23.00.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:03:33 -0700 (PDT)
Subject: Re: [PATCH 005/190] Revert "media: exynos4-is: Fix a reference count
 leak due to pm_runtime_get_sync"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-6-gregkh@linuxfoundation.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a3433d00-2fd5-f7a5-703f-76d348884449@canonical.com>
Date:   Fri, 23 Apr 2021 09:03:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-6-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> This reverts commit c47f7c779ef0458a58583f00c9ed71b7f5a4d0a2.
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
>  drivers/media/platform/exynos4-is/media-dev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 


This looks like a good commit but should be done now in a different way
- using pm_runtime_resume_and_get().  Therefore I am fine with revert
and I can submit later better fix.


Best regards,
Krzysztof


Best regards,
Krzysztof
