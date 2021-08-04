Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0E53DFAF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhHDFOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhHDFOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:14:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1374FC061798
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 22:14:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e21so1758565pla.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TgttGRrn42Wk3tVPMIYmGm1GfuxDDOvbYQ1YEYQrY5s=;
        b=Cfvijs9NjDh9/cHQq4TuO/oE5weZBw1NKPW07ktsuth/aPd0GMJmrt4+CvVvSnq/c5
         RD1zlyeKdVcJqAUyL0yuwyoYcS4uTw2HSsoBgc6+ffWoNW76wY05eQ4Zimo13HH5aVoQ
         BCdEqLza0BvdY5gZEK/YB1i/yXKn8se0sjeZITBtYE8/jA+/tC3F9tuucqfBzGF62lYG
         1sU4HEv6bNnc4BnfpXgEkoRLDGFR/AF8guh+J04VaaXdG3svY85wBUhz8Pd+wCI4eSYQ
         5U0wy0Ucy9BdWiI1WXlJIRdStsdE3oJKvxK7ufMdE4VuRotrJk5iytZnI6gZ2XMaH9Rz
         OqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TgttGRrn42Wk3tVPMIYmGm1GfuxDDOvbYQ1YEYQrY5s=;
        b=JYCg6s5kT7gZehTqUkVRf1ERKTQKhu+tOuz93jHj7174uTxxM+8LdlWRWlwBDvaji2
         Jvt05WXavryo1Q2rWydr/d4agJ5cKyfuP4v7/CJDucYp3yr9aifCyikn0Mg7qyYkJgX/
         MTKV9ABnd88/CKDWv8K55/uvcA7nCP/HkqAm9Gqs+qKWU6INjpNlr5glyoldCDEcfoQR
         xjnw2fGixLB39Y2bx5GagcSAdPx6TXG1oLAz2ucY6VKOcb0H8T8e8j1TqmCqxp//yNpf
         3nbUoMJEFPqgog8e+HguZda0yty35IDWcrfvq6llzCeLDXZlGoQVb3Ry4xHHmUyYobK+
         VRbA==
X-Gm-Message-State: AOAM532/a4+WbcTEbn2tgHEmzZQqws1m4Yo0gzNYDWDP534KnfHAfgx4
        C2iE3BJcEOb6r81UsZkh7Q/K9Q==
X-Google-Smtp-Source: ABdhPJwqL4AK2HoFKfE6/E3/tmh2ol5nX6WaH9kwoRTC543TL+kYoaJbR4i8jXRVxTsiuiG1oM3MOA==
X-Received: by 2002:a17:90a:8404:: with SMTP id j4mr8003213pjn.66.1628054068622;
        Tue, 03 Aug 2021 22:14:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f66sm1007015pfa.21.2021.08.03.22.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:14:28 -0700 (PDT)
Date:   Tue, 03 Aug 2021 22:14:28 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Aug 2021 22:14:23 PDT (-0700)
Subject:     Re: [PATCH v3] lib: Use PFN_PHYS() in devmem_is_allowed()
In-Reply-To: <668986ec-bdc5-482f-39ed-8e059008016d@huawei.com>
CC:     wangliang101@huawei.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org, wangle6@huawei.com,
        kepler.chenxin@huawei.com, nixiaoming@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-9a8d70d0-a3d6-4e2b-8bad-46bf87abc80c@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2021 22:01:46 PDT (-0700), wangkefeng.wang@huawei.com wrote:
>
> On 2021/7/31 10:50, Liang Wang wrote:
>> The physical address may exceed 32 bits on 32-bit systems with
>> more than 32 bits of physcial address,use PFN_PHYS() in devmem_is_allowed(),
>> or the physical address may overflow and be truncated.
>> We found this bug when mapping a high addresses through devmem tool,
>> when CONFIG_STRICT_DEVMEM is enabled on the ARM with ARM_LPAE and devmem
>> is used to map a high address that is not in the iomem address range,
>> an unexpected error indicating no permission is returned.
>>
>> This bug was initially introduced from v2.6.37, and the function was moved
>> to lib when v5.11.
>>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Fixes: 087aaffcdf9c ("ARM: implement CONFIG_STRICT_DEVMEM by disabling access to RAM via /dev/mem")
>> Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
>> Cc: stable@vger.kernel.org # v2.6.37
>> Signed-off-by: Liang Wang <wangliang101@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Weird, it's still only your replies that are coming through.  Given that 
this only manifests on 32-bit Arm systems, I'm going to leave this up to 
them for now.

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
