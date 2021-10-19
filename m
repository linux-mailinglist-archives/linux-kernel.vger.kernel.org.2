Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30E943346F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhJSLM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhJSLM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:12:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C467C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:10:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so46848573wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S0H3mAMadsGTXDygzsfO5yJNWGRhuy7yoGGr65U8IrU=;
        b=D2eK5Vu+R9WcvpsaOdKxtlnnHGI725lbjLRYKl7wEmaNfkWNHM3wFGvsjZ/08es/rQ
         l6tXr6iuETVixkLmWA/OOjxhcheRQf7qh7PxMgIcNNYuJKQDAHigP+CtMC9OxrxGIkdK
         IkqwZX/j9BpsTFVqFc2gxYBBbRJAF6kU14HCfhL9FGKj1flX9R09Hb+I/uilsyvqL+Yk
         OYEcDDH2DNx3fSmbMfX97Z/hGhJ5e6INpqi18BnwQnHxf/Jia69nRneqeSOEmVsK8AOL
         H1M7AnWbaJbWUbUr8ovkJYOGnOSrCig2pt/BhN7FGwmEBGFPLnpaS0BHV/qgcvCh9r5N
         3LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S0H3mAMadsGTXDygzsfO5yJNWGRhuy7yoGGr65U8IrU=;
        b=QqaXyLRs44ubbDDgbFC7TR1m/0CltNR/jiz07Jbk9shnjtdngCZFQMRKtbHxK1uXpe
         43f4rEN/b2b+ne2IgZIDUlMratPv9+bX7FaKrkM81hfjfyKAQZrvItbgNX9nGuCIWJnO
         OfQU5jObw/9yPDL2eB6i12lwG9m1sdzbrHG+bBy4zskDVpaBlVbtyf8Nm3X2BOzPkiSF
         5EtV1Qhbn6cBkEt0nWKkXDRWmrPy6CfrjMxt9V8Ov7sY67e2TgkYmiUJra2NUpIBTEA0
         pNYpyarPDvRziGOJud6wxx35ODRU9qvwHfzXRGeXR4envn9YlXZ0KE0KL6eJNdRNphAs
         jcag==
X-Gm-Message-State: AOAM531lxWCRUvHrM5hL+rIgf5jfqFKmCRVgO/M+QawASdKx9sGsQqEG
        jkOkosqtEK8rREPmEvxV+3RX/A==
X-Google-Smtp-Source: ABdhPJwreKt6Ikbh4cV5zeQTHxQeFcev/wc/pe38SAolbF5C0cw32H+TNx58vXwFSKTqzP5jTkp7Iw==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr31565245wro.298.1634641812517;
        Tue, 19 Oct 2021 04:10:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c590:9206:d20a:23bd? ([2a01:e34:ed2f:f020:c590:9206:d20a:23bd])
        by smtp.googlemail.com with ESMTPSA id g10sm1474475wmq.13.2021.10.19.04.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:10:12 -0700 (PDT)
Subject: Re: [PATCH v3 00/17] clocksource/arm_arch_timer: Add basic ARMv8.6
 support
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
References: <20211010114306.2910453-1-maz@kernel.org>
 <20211011110243.GB4068@willie-the-truck> <87mtnfptni.wl-maz@kernel.org>
 <2cf7b564-63c2-ac6c-a083-f7ac2caab6fc@linaro.org>
 <877decotwi.wl-maz@kernel.org>
 <d0c55386-2f7f-a940-45bb-d80ae5e0f378@linaro.org>
 <20211019110912.GF13251@willie-the-truck>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <51dd3a7d-5f85-6935-39e8-10d66e5aacb2@linaro.org>
Date:   Tue, 19 Oct 2021 13:10:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019110912.GF13251@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 13:09, Will Deacon wrote:

[ ... ]

>> Ok, thanks. I've updated the branch accordingly.
>>
>> Let me know if everything is fine, so I can prepare a PR for the 'tip' tree.
> 
> Thanks, I've pulled that branch into the arm64 tree so please don't rebase
> it now.

Noted, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
