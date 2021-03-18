Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CD3403C0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCRKp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhCRKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:44:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A52C06174A;
        Thu, 18 Mar 2021 03:44:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f26so6866976ljp.8;
        Thu, 18 Mar 2021 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZZzq/9McYqHi4InJGaReUkavQ57VQ1UkA2ucnh78uI=;
        b=gTbIM+eVxHGNlcaYXsqO6C0ktHAtRqi8q20fGcwHQ7semqVJMZXtpkH3pUFPSQzVYl
         +WeAtppdRYVyjxzgwUh+BgHpEe4qAn3IgFJE50GSbAeZlhxYE1NhbzyWcz0qANY02xD9
         WP/N8IHj1Xbipui8Hxo0TpkS0cIx3pOqI+fEMQahZIx3V9BTkJvMMa+O4GB3oqVFmtOe
         PcYtWLGkWX1vePVvpC7ryqpXjGSLfeD9PLLYAl2nESHcF6eZHkofYB/GOLFT3CpPW+cG
         454A9TWQJ4AC+2RGIkZZU0S6hK9JCBBXxB3v2kxS2/Soah9MHXBtHvehAqnp3ZeAXTMk
         xD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZZzq/9McYqHi4InJGaReUkavQ57VQ1UkA2ucnh78uI=;
        b=cA6hRWkFE5QGmIZebR5CU8VvqaWt2pv2XfEKyM4ZFeYwdmu1GeuiFzOqU6qjvrH04o
         casrI3RfpUYfnt+WWUcBR6Nqhgg5JEnlNNNK+YyZu7iNIQVmZKT85/J6e99ABgmZo94O
         lY35j4hu5K3q62SDBeWSHc/k/dOSebN5XMmwP7+ytFwPA+LKElv8Nseb2xdDI+Qd0ebx
         ZZRZvEndH0omQbJELpa6so46jf79GCpydZOuNfaPNIZl5qbfUtfwbeQxIYfOxB9hjrL4
         RB4WoPhzKZf3stPutyY3+PNqJj8yrE05XVweWrwsn2Kw7qghWn9h9/MbaaZDU984ICRN
         D7Eg==
X-Gm-Message-State: AOAM5318WkY2JDhgDZ7IiIzag436r3VtktkZ+8varTmal4VVNCPPH8lg
        eCQ8Kb7rPOxFBQ6t4T3DCr7xGZodIvM=
X-Google-Smtp-Source: ABdhPJyZkPBz604XveIMMKnivIAAlI3Kq+ffrnq13fyiOfAK/uWCFgXw6pG59Ahla1dsNA6XD5eWHQ==
X-Received: by 2002:a2e:974d:: with SMTP id f13mr4956977ljj.210.1616064290378;
        Thu, 18 Mar 2021 03:44:50 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id a1sm191289ljb.76.2021.03.18.03.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 03:44:50 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] clk: tegra: Fix refcounting of gate clocks
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210317193006.29633-1-digetx@gmail.com>
 <20210317193006.29633-3-digetx@gmail.com>
 <20210318091219.GA18038@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <768dcbd3-a29b-33c1-2147-e59e3847e75c@gmail.com>
Date:   Thu, 18 Mar 2021 13:44:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318091219.GA18038@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.03.2021 12:12, Michał Mirosław пишет:
> On Wed, Mar 17, 2021 at 10:30:01PM +0300, Dmitry Osipenko wrote:
>> The refcounting of the gate clocks has a bug causing the enable_refcnt
>> to underflow when unused clocks are disabled. This happens because clk
>> provider erroneously bumps the refcount if clock is enabled at a boot
>> time, which it shouldn't be doing, and it does this only for the gate
>> clocks, while peripheral clocks are using the same gate ops and the
>> peripheral clocks are missing the initial bump. Hence the refcount of
>> the peripheral clocks is 0 when unused clocks are disabled and then the
>> counter is decremented further by the gate ops, causing the integer
>> underflow.
> [...]
>> diff --git a/drivers/clk/tegra/clk-periph-gate.c b/drivers/clk/tegra/clk-periph-gate.c
>> index 4b31beefc9fc..3c4259fec82e 100644
>> --- a/drivers/clk/tegra/clk-periph-gate.c
>> +++ b/drivers/clk/tegra/clk-periph-gate.c
> [...]
>> @@ -91,21 +108,28 @@ static void clk_periph_disable(struct clk_hw *hw)
>>  
>>  	spin_lock_irqsave(&periph_ref_lock, flags);
>>  
>> -	gate->enable_refcnt[gate->clk_num]--;
>> -	if (gate->enable_refcnt[gate->clk_num] > 0) {
>> -		spin_unlock_irqrestore(&periph_ref_lock, flags);
>> -		return;
>> -	}
>> +	WARN_ON(!gate->enable_refcnt[gate->clk_num]);
>> +
>> +	if (gate->enable_refcnt[gate->clk_num]-- == 1)
>> +		clk_periph_disable_locked(hw);
> 
> Nit: "if (--n == 0)" seems more natural, as you want to call
> clk_periph_disable_locked() when the refcount goes down to 0.
> 
> [...]
>>  	/*
>> -	 * If peripheral is in the APB bus then read the APB bus to
>> -	 * flush the write operation in apb bus. This will avoid the
>> -	 * peripheral access after disabling clock
>> +	 * Some clocks are duplicated and some of them are marked as critical,
>> +	 * like fuse and fuse_burn for example, thus the enable_refcnt will
>> +	 * be non-zero here id the "unused" duplicate is disabled by CCF.
> 
> s/id/if/ ?

I'll update this patch over the weekend, thanks!
