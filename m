Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2D64529EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhKPFmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbhKPFlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:41:53 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897BBC0EEBC4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 19:00:43 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t23so7825563oiw.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 19:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=o88lqLbXiByZSEm5Oe3EmBOSlVPhL0Q4BRAUKBtJ+uQ=;
        b=K/OlInL0tAUwrXGjW3e7hdI1Qt+9UmNZVEpQgea9WXJXbENuBOLJJXO978bLVgPL09
         frIs9LsU4LJ4YRMhIgJih/o6S1uai/SIAxRI01cA1OofrEg2xMjCE26bBzki7279KAON
         hKVeoTTbJP6pKrQjFgTiDg1y548bOvJCEwYr3eYNwHX21KWkjWQwv4n2nLXbXSl1NDtW
         2YlVgaf0hEE/JCQxTTnn5z87bT6Z7AiSM0jjgaH50T+a/5jfL/Fb5Kyyr7hTOmSYVo82
         hgz8goirDLehCMGmD/tjKRW7/U+e3OkcaS2ju8jHpawV0ZiQnMWo0sX+iWh3ANKBUvE0
         EfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=o88lqLbXiByZSEm5Oe3EmBOSlVPhL0Q4BRAUKBtJ+uQ=;
        b=1w2JvLjv3sIwH7aRkDbtxQv0aGAbNzyvRxGr338TXLrIZjVLsxDR6lHXjAE0SlOapq
         G6xrPmJ765OuiVQoir3IlQPmyDdewcmY9JqGfffJ5A9bfB+m3WsxEPRQ3HIxs1JYpyPv
         krPCAu3U3BfOx7RyCsboDFCEPIN9ehoC1sd3qC2EvtMKY2ZquB1FCNpofyejSM+iWpmW
         x6bAYYTykpy7pHf/KOrXcMYNiASIqFwmgVN81eqZ5Tlb+PiE5jwV4t2GA5IPtM3NN35y
         IaJwIxZNRbAuaRAKnED3U2Ei2JwiY836oBUC85xg11HTzuBP7jiERrXZCzBsbTDVzfTX
         7TwA==
X-Gm-Message-State: AOAM532oOQQCf2P5tgIvaNyhzf43KZqMZvNOAvxcnX6gp2PXzeiL2rF6
        83qUjWDAJygeocJf4odHkTbb3Q==
X-Google-Smtp-Source: ABdhPJxvP2FW2Cw2JHL4/3O5X2lE/MNb0RjTAl1y9dgNVehB47HDHZ69W5LnyJsjv575FrQUClNSkg==
X-Received: by 2002:a05:6808:1814:: with SMTP id bh20mr49231251oib.31.1637031642978;
        Mon, 15 Nov 2021 19:00:42 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id g10sm3350916otg.10.2021.11.15.19.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 19:00:42 -0800 (PST)
Message-ID: <43528a0b-678c-f1c1-c9af-ad8ea324cb85@kali.org>
Date:   Mon, 15 Nov 2021 21:00:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] cpufreq: freq_table: Initialize cpuinfo.max_freq to
 correct max frequency.
Content-Language: en-US
From:   Steev Klimaszewski <steev@kali.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>, rafael@kernel.org,
        viresh.kumar@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20211115195011.52999-1-thara.gopinath@linaro.org>
 <5ae2c644-4743-c62c-b17c-96945a0e6a01@kali.org>
In-Reply-To: <5ae2c644-4743-c62c-b17c-96945a0e6a01@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/21 7:23 PM, Steev Klimaszewski wrote:
> Hi Thara,
> <snip>
>
> And it doesn't go up, I even tried adding a sleep of 1 second between 
> the echo 1/0/1 lines and while 2956800 goes up to 28 (but never uses 
> it) it seems like, unless I do it manually once I've logged in, which 
> I'm assuming is a lot slower than waiting 1 second between them, it's 
> not quite giving us 2956800 "easily".
>
> If the email wasn't clear, please let me know! I tried to explain as 
> best I could what I am seeing here.
>
> -- steev
>
So after more testing... *sometimes* it works, with the jiggle, but not 
always.  I'm really not sure why though, so if there's any guidance, I'm 
all for it!

-- steev

