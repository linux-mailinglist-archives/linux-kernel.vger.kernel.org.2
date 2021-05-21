Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D814C38C9FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhEUPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhEUPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:22:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D9EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:20:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q6so11142874pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OiBDMugbtJAkTVkSWchgyW9CFAPkp7vQcuPZ3ZQ10UI=;
        b=NFfmrnY3R2CQSHpLQX3vHhwpQM5O+6kV1pZkgSLV/qkmHYCgEDnOGVTJd9QhxJ6jod
         O/2ZlToBpPLDS8+WKqGs3/r7lUva/j8ggmr4YN1PHqsoVh7Wq4HVF+quChQGfyNtB9G4
         Sh82l+boONbTd1o+vclYxTT/HYEF8FjV9aRqRuLBNhKJ8lhMGYRy6NSijrDBxzYKNS0l
         aCceuWRUS7FuJwQmJkMTr4ciSmezskeJ99wjSWtZKXBmQZo4BbingkoFnH6oCOPLZ71q
         nsQ1eru0i/0lfiuMV+VwdPZzDEm3iz34iVepct5rtcIZa2Zo1zQ02PkigThOnvg7A0Gd
         lZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OiBDMugbtJAkTVkSWchgyW9CFAPkp7vQcuPZ3ZQ10UI=;
        b=oduxYX6S4DnmvxqpLkB362m6GzSK4cbp4BGPJpt7m9lCqIvNvx8SiV2Cj8qVv8jWz1
         mRtjCJ8w3ufmusk8tZrV6xzgxRStENXl3bXqUNs57CfdfzFGtuzEoQB2OIO9uPCA3C9R
         YGl88a4COghx17u00Iw3u9P6EZLh4b/izfjicHhfyhNRuW3TK1TVwfavHPpT4hkfk1Xv
         nuDI3IfWHNpMMXQ+t1ynK4RQG9f/baBqlLJnjWwCvNKEh71QVxDlAZ9tlwUcGyHcdJlu
         KPRr0DXaTK5YJ5pyByxm7OITZtdPsEQYuwUmWuV4tvd6Co2t3hcgpe38cybo+qy7Qc/n
         t5Rg==
X-Gm-Message-State: AOAM530ZJ9v6HiKHpIqSDGAslakwQHxtgyscbSZC9kMmdIJHT4gv7Nj/
        ydLvuPIDdoo24GsP3meZD4U=
X-Google-Smtp-Source: ABdhPJxz7yr4Q8aauUe8k1t2ZNUEUTGrYVzhUxJ7+CkUD7/HSMdqBxTq3ZL80qoD0P9WP6r/Zp9fzw==
X-Received: by 2002:a17:903:20cc:b029:f0:cc11:51c2 with SMTP id i12-20020a17090320ccb02900f0cc1151c2mr12638112plb.32.1621610435742;
        Fri, 21 May 2021 08:20:35 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f83sm4776670pfa.163.2021.05.21.08.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 08:20:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] firmware: arm_scmi: fix deps arm-smccc-discovery
 deps in Kconfig
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
 <20210521151528.pjbwkumfj4g6nu3q@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <713c4c93-4dc9-ac5f-0749-f69f1763f876@gmail.com>
Date:   Fri, 21 May 2021 08:20:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210521151528.pjbwkumfj4g6nu3q@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/2021 8:15 AM, Sudeep Holla wrote:
> + Florian
> 
> On Fri, May 21, 2021 at 03:40:51PM +0200, Etienne Carriere wrote:
>> ARM_SCMI_PROTOCOL depends one either MAILBOX or HAVE_ARM_SMCCC_DISCOVERY,
>> not MAILBOX only. This change fixes this in Kconfig file and driver
>> private header file.
>>
> 
> Since HAVE_ARM_SMCCC_DISCOVERY depends on ARM_PSCI_FW, I want to check
> if this is used on any 32-bit platforms w/o ARM_PSCI_FW

Not on ARCH_BRCMSTB, there is no SMCCC without PSCI.
-- 
Florian
