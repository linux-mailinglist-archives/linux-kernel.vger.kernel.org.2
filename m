Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2DA3A1D73
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFITHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFITHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:07:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001DFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 12:05:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v11so4649326ply.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WyVHMM5ILT7w3D2NVrQcsqMfiyYFUWtDHAg3cnHrRv8=;
        b=rMnvmR5VWnCtbpC9u52+Ur80I2YOxuFcfixZUzAGaKYRbsdkfYfHyL8pWnaOye0GhA
         Dud79bLmF/kWXbh+J0g4j8gZt+Vxq6Bs8LEHbqkcQwx1M5xjBVSDkoUYbRg/dvyVGeY4
         z9dNAI1834E/+93t9vt6qMSLqiMel26dZ1G7OXqJeXarIz1sou3RI/X1JVVbReGuZEMi
         vgaONUwoEZyuAltoUOjdmkky2ZdLQGjPi4ocTiNftU57c2lInK2C/++R1WMzrWZjovQD
         sYhZojl1F2R/PLQ6J0jAoSi8bxJCBiE5/kZXa5NVSlyQ93LwGybKjBT1Vl4hEZc83bSI
         uPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WyVHMM5ILT7w3D2NVrQcsqMfiyYFUWtDHAg3cnHrRv8=;
        b=DhJDO+3H66e2NyJIHJwaPjpiCcwmL05kePYS1GKR7aIc261SzAtUEJ3zGz3BDZ03Vj
         RbKqOmEpqzc7IMsI/hdcVW6CGt/P7GjIcvwaYJxlG26P+alMBBSZ+7j/yVVAvUYbzOJy
         FNqs4XZmAsCRIju5LpYCgKOMtrw/As05zNzCv+X8fsyKgao3FAjhCH1sRR/JNs5FhvSW
         ex3pFLZwtGa+xREDPSP+g4KkKX7d3ws9L726zE9XzsgkNTu3elJFkVOezdRiWC1SiRfF
         JtP9WD1lQz3iHnhphhB2/oL4yh9OXZ7VaoC2f2TZkqWIDJowhQJJHQRvgAtYYqsV1gqJ
         doeQ==
X-Gm-Message-State: AOAM5321j13/1o6IkxpmNEWeQ6ZLc6LaxDb1cn0JTj9nBe98bQSAMEe5
        dlYdEKB3rDJUo1qLWyWGREc=
X-Google-Smtp-Source: ABdhPJx3SWEvB+jTYKy/KnBFNg6qRQXQsvu8SdBm73QbDzBHBLLgISpmA9IAwYZcPJZ7JpSNFmNoDw==
X-Received: by 2002:a17:90a:880c:: with SMTP id s12mr1083968pjn.66.1623265520433;
        Wed, 09 Jun 2021 12:05:20 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r9sm275169pfq.158.2021.06.09.12.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 12:05:19 -0700 (PDT)
Subject: Re: [GIT PULL v2 1/1] bcm2835-dt-next-2021-06-08-v2
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20210608211012.1386151-1-nsaenzju@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1d894fb1-16d2-b695-862f-3f30ab186f3a@gmail.com>
Date:   Wed, 9 Jun 2021 12:05:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608211012.1386151-1-nsaenzju@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2021 2:10 PM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-06-08-v2
> 
> for you to fetch changes up to 21c6bf8304f0141af6460cfe404dbbdeb96bdd62:
> 
>   arm64: dts: broadcom: Add reference to RPi 400 (2021-06-08 23:06:34 +0200)
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Nicolas!
-- 
Florian
