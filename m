Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3834F165
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhC3TCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhC3TCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:02:22 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AFCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:02:21 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d12so17480712oiw.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qRUADsNexwQJ5AK1zhgDj9nFAcKrUHDQ7pCsYBlcPNg=;
        b=VxsUgV/9FyE0P1bYn/jIBt2QhQGsFOdit/Z0YqX9kRwJdXLjW9qx83lALMnJ6j4ur0
         o4P7pvmUBmeBXDFozpFG5hMyuTbMXoP+R6ktoFFbc9esPfMG6EwmTrmb3ZNf2E+9CXu2
         nYjTsFAEvuv8iBWuVVL4Om23t4rXxqPleLqxBgVwAcQCldXurbMsNjLTTSq6MaJTvrSM
         o65hI997ZPxtkKrg7r9UJSs8oLKn4CI1tTzsq3zUTTi4thePaIB+fJvbI/TQsYZXxdSR
         iAaKh9uCmUkJiRktaH5Y0Yq3kgZlpThHV9AC7OR4LhJB01ijuln2zMPSP8S3eJ2BC711
         Y+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qRUADsNexwQJ5AK1zhgDj9nFAcKrUHDQ7pCsYBlcPNg=;
        b=my2ov8HyWk9OR1KAOXa1eODypyDO7qNQEi1IUFrMHqL8zgnhukDgOG7dmTSMRtMLbd
         1HlbT3GAf55Gl4Xkf3NsHrBoSb2XsheTJXs9u4EvO2QckOnJGnBLkQbJ/KH0V011pVYf
         vO7VC2w96PRPxAU5q77GGfp6AsdC5YsMKt/T8XKZXP7aBBE9Nmi5GbKqtVgCoFW+vis5
         OnRG86t+NoHeynx+Kclz+qrijE/ExZX0Azh8lbH0P9LhbrQojAwQM+vsRu+2sh89W1Mx
         LHyKI5anWo13Kq/mKG5+Lpo93PSWeX2hgYY016hVIfFBsLNQgwiDLqv3eHXf3Br9LbtY
         +EXw==
X-Gm-Message-State: AOAM530ZUzoDsiwvfnrZCU4Hl04DU4ZAanlFXtor8LeFwLKe818Eluc3
        Z+mZ6jdEHMy97Zb05MOZWqc=
X-Google-Smtp-Source: ABdhPJx5pu+RMJra/rUnSLm3qOoWg3Jh0yJbizRmsC4F3Dr8CYoMvjkAi6LOnUcmygrIXc3pG4RTRg==
X-Received: by 2002:aca:b9c1:: with SMTP id j184mr4202039oif.5.1617130941154;
        Tue, 30 Mar 2021 12:02:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h59sm5318040otb.29.2021.03.30.12.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 12:02:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Enable write protect for supervisor
 SVM
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210322175338.GA24424@roeck-us.net> <20210330105200.418bc42b@jacob-builder>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d43efcb9-23bd-bea4-1b27-429a171dcb65@roeck-us.net>
Date:   Tue, 30 Mar 2021 12:02:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210330105200.418bc42b@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 10:52 AM, Jacob Pan wrote:
> Hi Guenter,
> 
> On Mon, 22 Mar 2021 10:53:38 -0700, Guenter Roeck <linux@roeck-us.net>
> wrote:
> 
>> On Tue, Mar 02, 2021 at 02:13:57AM -0800, Jacob Pan wrote:
>>> Write protect bit, when set, inhibits supervisor writes to the read-only
>>> pages. In supervisor shared virtual addressing (SVA), where page tables
>>> are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
>>> CR0.WP bit in the CPU.
>>> This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.
>>>
>>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---  
>>
>> ia64:defconfig:
>>
>> drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
>> drivers/iommu/intel/pasid.c:536:22: error: implicit declaration of
>> function 'read_cr0' drivers/iommu/intel/pasid.c:539:23: error:
>> 'X86_CR0_WP' undeclared
>>
>> Maybe it _is_ time to retire ia64 ?
> 
> Good catch, sorry for the late reply. I guess otherwise I will have to do
> some #ifdef?
> 

I really can't tell you how to resolve this.

> There are many basic x86 helpers are missing in ia64.
> 
I'd say that Intel needs to decide what to do with the ia64 architecture.

Guenter

> +Tony
> 
> Thanks,
> 
> Jacob
> 

