Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5197A33D99F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhCPQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbhCPQjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:39:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:39:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n17so13660789plc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ml5FEt+zK0js4fhzjALMp1tOuNCzjM/T8NaL99/Vggc=;
        b=ANm9GbxUUrHzlnbEEnYCqkeoIj5CcEKzRhvXRsIkAvSiEaP3nPwUnwXlEiXWEXa5XV
         09mmDIqzAKZ0FllK59ppoxw1umbG45v4FlwlrO1zjibVE6L8mTBcZR5ykAe6uIK1LEdx
         ohZO2BIOhHQmJtDgmE30xdtzFcV6nMs30h5Bzeu2ghobfarnvBRtxIE2eBet1DBC9QK8
         AuTzzQu6MFMyl8tqQMe8DULEFcPfTIXAEnglYZFio4XUUGyb2xONgVfIjTdwHJdx4n35
         jQ3Ms8ZCdNbLtFpMg2xztv8C+x/y/WA5BamTPv00ZZEWcWmasHyo2Hw4lF7Hx9vUe95k
         /9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ml5FEt+zK0js4fhzjALMp1tOuNCzjM/T8NaL99/Vggc=;
        b=PsrWe+I8fNgF3ym4+TjG8BnoUIN3GM6VVE0kZRNJYVEBpzoUTTSaF8gQ27akZGFfyl
         J5Tb9dEXx47fWwJ2PkN6oMqApf/830+85oZBePpdJRdJEqOtvfGW6Id3vcpSdH6UPZ2v
         fI1dwzgKl+kgv22j5UsEmoF3tJs+58N8Ew19qn5C1R1JZiZarkr0oDIDksZ9OdNR8ZOq
         uhxvNzaZGc8EVCDNlGxOJ7p79CqiyqFlRsmK67OUST5Bp9ndJbbk3zcuHJYX68hAxceP
         N7lDDe2W1fgmymI9NtvVdWNpDubUezwM3g9VT8ialJDNvUYwJxa6+k5HnmrfA0IrbRtu
         VjkA==
X-Gm-Message-State: AOAM533qt9JCbo5lAyNKwIUPzzWzKPqo8f6YjLbMcsKtwhwVOVq8pG5C
        BaxckZa6Ey3MO9GOwsAOEnyvB8zcbDQ=
X-Google-Smtp-Source: ABdhPJzcxSC7CoT4IZvbNMEGydRAHZ27B/c/yhgrPgOBtM6vc5qSYcGCb5boOecmTCMoh2ZDdL9bqA==
X-Received: by 2002:a17:903:92:b029:e4:bf7c:cbf with SMTP id o18-20020a1709030092b02900e4bf7c0cbfmr250210pld.55.1615912779685;
        Tue, 16 Mar 2021 09:39:39 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p7sm6061410pgj.2.2021.03.16.09.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 09:39:39 -0700 (PDT)
Subject: Re: [PATCH] reset: RESET_BRCMSTB_RESCAL should depend on ARCH_BRCMSTB
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210316133733.2376745-1-geert+renesas@glider.be>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <edf3dd53-3404-205f-efab-e07b54635a09@gmail.com>
Date:   Tue, 16 Mar 2021 09:39:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316133733.2376745-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2021 6:37 AM, Geert Uytterhoeven wrote:
> The Broadcom STB RESCAL reset controller is only present on Broadcom
> BCM7216 platforms.  Hence add a dependency on ARCH_BRCMSTB, to prevent
> asking the user about this driver when configuring a kernel without
> BCM7216 support.
> 
> Also, merely enabling CONFIG_COMPILE_TEST should not enable additional
> code, and thus should not enable this driver by default.
> 
> Fixes: 4cf176e52397853e ("reset: Add Broadcom STB RESCAL reset controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
