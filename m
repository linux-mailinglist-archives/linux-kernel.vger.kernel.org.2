Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86D3EC7F2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhHOH3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 03:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbhHOH3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 03:29:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABB6C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 00:28:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso22457735pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cn/+Frc54mS+Ha2Lobee22sCIkMscZ5re9djGEP3QzE=;
        b=HdF3gao57FQhc4op+Z08XKW7iXonIW2f6C3zevEzMN2PvVcasXubg4GMGjhXCJpQMB
         omJGL2L6u+Zt3mySJUtN+bP79cYystJ/tRH6r7xfuPVduVkdUUO0/2EupWHZrUg2tqBv
         s8pVdNsqqzzi2Dokaxn/3/k9fqNBU7zo0hElBpOHGQsO7h2bOwTFDJKdpz2/NUe+N6Eu
         nb1Gt6hMcWW7iM94QlnNYV95IdoSepr7T11KXJB3uGlLUyVbY2jelQtl/bjtpKUyymYS
         whxEHhv6+OTsPwilpIV+jLDK7hj6aq+4DoSEzRuQhdnbIUlHjdI2gyH1Dh5SDgQ/Cd4h
         FXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cn/+Frc54mS+Ha2Lobee22sCIkMscZ5re9djGEP3QzE=;
        b=svLsxHk05ONJrCIZfEfh9uN49T25/s8oIp5md2xVjzPVVkA7tl8qz7cnVAfg4JNruo
         J+70C/CqQG7p6T4K8FjcW2Z8lGBILiG1mitgjuQ+jUsGlZehU7DuENccRy6HECJ2uqlj
         owOsp83M7aj2uk77T1+QyF6xcFkm9wmv5Zfm4X0aPfKtCv16RjKqhPtYxJQrs0VB/Qrd
         905czHnuwJshyAf/oI6mPgY4+knw1NSgwYU+xJH7t4SjlcJ2JqnNoIQXXoTIIOCaFzIy
         oD86yjA0FvIYRXTnwQasgN3uDZ5a2uljr10ap+SIOvJLa5q+TwHKxQmxuu/cjO72uIvg
         8Ppg==
X-Gm-Message-State: AOAM530+LOWaEdGATUUjb7weSzrCVjx9QQeR+OoLk+lPCYBsu0QpRpM/
        9QD+mrc1WM/Y6YylVkkmXBY=
X-Google-Smtp-Source: ABdhPJwrWmWWu+2lk+8Z95VUhJyjjEWzMM/tLQbMaiOwf/18RoS/YvsL7l9/7O3QkubasGwB6fM+kg==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr10192429pgv.370.1629012533446;
        Sun, 15 Aug 2021 00:28:53 -0700 (PDT)
Received: from [10.230.32.65] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id b17sm8375667pgl.61.2021.08.15.00.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 00:28:52 -0700 (PDT)
Subject: Re: [PATCH 0/5] arm64: Survival kit for SCR_EL3.HCE==0 conditions
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
References: <20210812190213.2601506-1-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7ffa35bb-1f2c-19ff-fe4b-33267fba80e8@gmail.com>
Date:   Sun, 15 Aug 2021 09:28:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812190213.2601506-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2021 9:02 PM, Marc Zyngier wrote:
> Anyone vaguely familiar with the ARMv8 architecture would quickly
> understand that entering the kernel at EL2 without enabling the HVC
> instruction is... living dangerously. But as it turns out [0], there
> is a whole range of (*cough*) "high quality" (*cough*) Broadcom
> systems out there configured exactly like that.

Some Broadcom systems, namely the 4908 and all of those using CFE, they 
later switched to u-boot and ATF and got it right.

> 
> If you are speechless, I'm right with you.
> 
> These machines have stopped being able to boot an upstream kernel
> since 5.12, where we changed the way we switch from nVHE to VHE, as
> this relies on the HVC instruction being usable... It is also worth
> noting that these systems have never been able to use KVM. Or kexec.
> 
> This small series addresses the issue by detecting an UNDEFing HVC in
> a fairly controlled environment, and in this case pretend that we have
> booted at EL1. It also documents the requirement for SCR_EL3.HCE to be
> set to *1* if the kernel is entered at EL2. Turns out that we really
> have to state the obvious.
> 
> This has been tested on a FVP model with a hacked-up boot-wrapper.
> 
> Note that I really don't think any of this is -stable material, except
> maybe for the documentation. It isn't 5.14 material either. Best case,
> this is 5.15, or maybe even later. If ever.

While I am very appreciative of the work you have done here to try to 
get the dysfunctional systems to warn and continue to boot, I would 
rather we try to load a minimal shim at EL3 capable of fixing up any 
incorrect EL3 register setting ahead of loading the kernel provided this 
is possible at all on a commercially available system. Rafal, is this 
something that CFE allows you to do (as I could not get a straight 
answer from that team), if so have you tried it?
-- 
Florian
