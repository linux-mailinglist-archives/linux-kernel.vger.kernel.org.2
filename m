Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF23A5A36
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhFMTsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhFMTsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 15:48:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F258C061574;
        Sun, 13 Jun 2021 12:46:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so8426396wms.3;
        Sun, 13 Jun 2021 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=N8m6uFtpHPt63aEJlkKD3SdHW0SajvD30NS0Rd4Qo+k=;
        b=lRWuG60Pn95OAxSatBAlmMy19HDLDCGoUsetku6uhi9wG0qcfmQ7Jzojl2aGj9CAIy
         4Kn3wJFBXA2HW8n6f7AqKo3twLF76v0fCoU8E2M+jH70Od/0NEur8Ex98d9qPCXV8hoU
         aWgu5eL9nc67Y9zrCq8Pg00z5kWAtgvqkv0sHn7Fs4ZTv1wKHjJ80iQ+A1r6I0cLuRI2
         9chQTJnyyQpdXMDYSSbdRejANZkDYpKj26sFPh/LSJglMbIqrWl567yunXo51tVQxagy
         N6R43+//fxgm5QMKNQpxfWSnSrSK3NKrcBEN2sCwoAZcmZ6RNdDNyQcjVZ+c4H1BAkM5
         XdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N8m6uFtpHPt63aEJlkKD3SdHW0SajvD30NS0Rd4Qo+k=;
        b=rAoFiKWCjAX8m8i+Ox36bHvueOiHfZNbH0d2YzmhBeyF/WbnNSpQkqC+afgrvEq2K0
         ATiYnyRw8ovnWPsuH1dGRy3Jp4boofp01DybiGxsDW+BytegA6WWF5IUrceK0pEn9n99
         bQO1eQuu8FXz22auFVRKTnMD1fLxJW4XlMhzb4hTFT4BK9itWOk4rUZRF5t7sYQqOlzS
         USZvbAosEs7DkxiL+uKTfyRD9fhI0LrZbIHMVtgCIsaMi33ZtlqJTFUpd7LNR8B1U4p0
         cyerQZ4M2iP4dBclZJlfMp+87jtefsN5ZeArA48EA3o+JaBFa/zFiLkbB8/LJk/4140K
         YhTg==
X-Gm-Message-State: AOAM532MKZe10FS8WhgZ9gcdi0MAUFEg1pkI3dlZCij8zF1C7xlAguq7
        34631NaGW1qSSxynt3pf477p7M27SdSPvA==
X-Google-Smtp-Source: ABdhPJwnYb7VWxcB6pq0hc1Q2Vb1Oe8cgwv/DW88rxAVYr7biFEV04PeXTQMgZSoO4AH/eVFz/WhGQ==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr13187552wma.85.1623613578136;
        Sun, 13 Jun 2021 12:46:18 -0700 (PDT)
Received: from localhost.localdomain (haganm.plus.com. [212.159.108.31])
        by smtp.gmail.com with ESMTPSA id a10sm12579796wrr.48.2021.06.13.12.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 12:46:17 -0700 (PDT)
Subject: Re: [PATCH 2/4] ARM: dts: NSP: disable sp804 ccbtimers by default
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210613094639.3242151-1-mnhagan88@gmail.com>
 <20210613094639.3242151-2-mnhagan88@gmail.com>
 <89d2a415-a9a3-f778-bd40-e39e01e219ef@gmail.com>
From:   Matthew Hagan <mnhagan88@gmail.com>
Message-ID: <58b60b8f-6c86-f44f-38d2-fc260aa59de0@gmail.com>
Date:   Sun, 13 Jun 2021 20:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <89d2a415-a9a3-f778-bd40-e39e01e219ef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2021 17:22, Florian Fainelli wrote:

>
> On 6/13/2021 2:46 AM, Matthew Hagan wrote:
>> The sp804 ccbtimers are enabled by default, however they may or may not
>> be present on the board. This patch disables them by default, requiring
>> them to be enabled only where applicable.
> The timers are always part of the SoC, so they should always be enabled,
> and if there was some board specific wiring, in that maybe one of the
> times was fed a different clock source than iprocslow, we could deal
> with that on a per-board basis.
>
> If someone does not want a specific timer to be used, it could be
> unbound once the kernel has booted for instance.

I should have spent more time to look at the issue rather rather than
proposing to disable parts of the SoC.

In my case with ccbtimer0, ccbtimer1 both enabled:

[    0.000181] clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 15290083572 ns
[    0.000209] Failed to initialize '/axi@18000000/timer@35000': -22

but with ccbtimer0 disabled, ccbtimer1 now initialises correctly:

[    0.000186] clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 15290083572 ns

Will investigate this further, but yes this patch should be dropped.

Thanks,
Matthew

