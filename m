Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E140EB64
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbhIPULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhIPULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:11:37 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858F5C061574;
        Thu, 16 Sep 2021 13:10:16 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso9879711otp.1;
        Thu, 16 Sep 2021 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nCj291iYdzn3C2RPg/47JjMb6RQUwi2qeIIirdT5j1c=;
        b=MIZ8dRZxEex/Bs4B1bw0D1k8uL2NVJ/mfkhQR1I4dGv8i0jKlFdLnE+72H1etkjaTh
         Dtr5k34j/ssiPB0Iv0YIAxNSTylgVDcgn4CsCcU+casC6/AXwhYsuZSOChQaeHliCm8h
         bd561/KwbHvF7dh/fgv0VtpSE3VibGyHF/VCv6B4KW1Wq5l7Vrb2vBlljPEFUKEqRKsr
         WMDauVvXnLA0FtsSLW+E0SNLZpAmcLne8h0c+DTvOB0pNhF21DplEvKzKLeRufhyRCKw
         E2RbmVQ6u5U3RQzh6QjEusPPV1Mt0py0zXaomu7MHEE/zir9QkxX+oISR2xv5UOuDQCl
         fCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nCj291iYdzn3C2RPg/47JjMb6RQUwi2qeIIirdT5j1c=;
        b=IOl6BKPjrkebvWsYbZHx/0zRPI4J/jemfzVP+YTQgp7bIx8ttRfJfUGd9ncAd62EGR
         Q0u6KcA1Z43QrutoIvEAs4wwd3QPdJudgPUCAGkus38tjK+StVEIElKWWXpBUIrVdAhn
         2HqJeUz649wlmfYMLy2foJgYb+kpXghL3Ho4UBDiV71jgAtl838Y0JGvm5qpZeBTwUC6
         c5otoQ/7weCWJVd/eu1l7+byJ7/po4XU9pcNxZLwmODpOZNxvC2BN0+j5A6Zj+d0A3xd
         or9a2s6UeAnele2C2+8uRkPgK4f+fW/dbUbI0vWLePCTe5w4Avf1jtHkb/amQ/h0ySF1
         HIbQ==
X-Gm-Message-State: AOAM531/mdrt5B1nft5cWJEtW/18vi4WHmJIh5I+awym4m32lSfVzTqt
        8okK0qq8vIwkl+nWy8tPJ/s=
X-Google-Smtp-Source: ABdhPJwyq77mehwAXAwvPkSy9lKiRqT7JK8SksZPBulxemZ02Mbsgg5km4nbDJVxZQooVfHN9DlFYg==
X-Received: by 2002:a05:6830:4084:: with SMTP id x4mr6092876ott.280.1631823015949;
        Thu, 16 Sep 2021 13:10:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bj27sm858771oib.58.2021.09.16.13.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 13:10:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [GIT PULL] parisc architecture warning fix for kernel v5.15-rc2
To:     Randy Dunlap <rdunlap@infradead.org>, Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <YUNi6hTcS8nUrrpF@ls3530>
 <b3d13e4f-c9cd-495b-5df2-1080ca4d3aa3@roeck-us.net>
 <f3713fe6-2806-9d65-618b-a9d210193e60@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <26cfe07e-98b0-ec46-9665-01d2f8761c40@roeck-us.net>
Date:   Thu, 16 Sep 2021 13:10:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f3713fe6-2806-9d65-618b-a9d210193e60@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 1:03 PM, Randy Dunlap wrote:
> On 9/16/21 12:45 PM, Guenter Roeck wrote:
>> On 9/16/21 8:29 AM, Helge Deller wrote:
>>> Hi Linus,
>>>
>>> please pull one parisc architecture warning fix for kernel 5.15-rc2 from:
>>>
>>>    http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-4
>>>
>>> One patch which fixes a build warning when using the PAGE0 pointer.
>>>
>>
>> Grumble:
>>
>> Building parisc:allmodconfig ... failed
>> --------------
>> Error log:
>> In file included from drivers/net/phy/dp83640.c:23:
>> drivers/net/phy/dp83640_reg.h:8: error: "PAGE0" redefined [-Werror]
>>      8 | #define PAGE0                     0x0000
>>
>> No, I didn't see that coming either. It _was_ there before, I just didn't notice.
>>
>> Looks like that define isn't even used anywhere.
>> I'll send a patch to remove it.
> 
> Already merged in the net tree.
> 
> 

Ah, ok. Sorry for the noise (I already sent that patch).

Guenter
