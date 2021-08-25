Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4CF3F7AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbhHYQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbhHYQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:33:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF48C0617AE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:33:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q68so236292pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bJ8q72vvv8af9UefuPzvZs4y1mrRvEamTAHXnSUV49Q=;
        b=kUwL/GfDGQbVWdJofI/x6kmzfiXlb/BxsOg5V6u3WOImVNuJRh5nQbIQCJPmsFzFWD
         xlzLoEx72efiqQdSM96FavAizMZrMMF0N10TUJkQVh4nU/+kId3q/NnimG8q30kBq2h/
         LpB/M5ejiFwEkSmpLJt3mgiyXv2NRlCJln4+aVeeRniwt6S41mHm9vR8Ch7JQBGVj9eZ
         1J/ixTep0WSc9+D1yiPiW2IhqQfc5sVyRHiKHUvVz3+aZiJkSSF/foFR8jS0Qn2Uo6WH
         DR/a2ZOAqfTZwve+mEBnYDlwyuLCOUXK7phMAvpEGgVvY1FFncbPTa3M06HwKurgmQNM
         NAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bJ8q72vvv8af9UefuPzvZs4y1mrRvEamTAHXnSUV49Q=;
        b=MCLK8YxheTiK2zVkNPaTkHlC2fub2bQcXO7MIwLBDw8yMJr5PqZ0bGdxhC6+OZKtUm
         p+raoHHa/kI02mai8ZttZHZEJTg08ibIHfyb43u3lTSRVCIUOliOPqE/jyUiWrPsgt08
         N/2h/j0hJzWoR/M1O1Fjw2TYAo/0DgRUK6Kg+XfWRGPMhagI6X6MxnTB6EgfjbmVtyfv
         KAU/xh6d9kawvEsOue8278mI/iYdx0Og8A3xvaRB7fsGXsvLpKOOPUXyJrLu6Lru5pVZ
         oCDBQvQ7vHE51HaGqNgXBzDj0waF9R9bfNe0CCHQJx5OsRH6bL3AwkDCb7g+qKrFfO1t
         1PZQ==
X-Gm-Message-State: AOAM530FXW4mT8MsIRwwOL5HsoV0wOp8c2FVnS/Qs0AyE8upwncQvio9
        kbigWpLoyO8OjzWbHNrhqc4=
X-Google-Smtp-Source: ABdhPJwcY4tQJdGjGPn/WCYXvCTwjK9L/2HkvDox8WCMv7E6I9n7k67Fd+ZvqqxO+3/P4geCY3e0ww==
X-Received: by 2002:a63:5c63:: with SMTP id n35mr4417886pgm.311.1629909186634;
        Wed, 25 Aug 2021 09:33:06 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with UTF8SMTPSA id x4sm303253pfu.65.2021.08.25.09.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:33:05 -0700 (PDT)
Message-ID: <c8e13051-4bab-abb1-5193-b06fe74b4df6@gmail.com>
Date:   Wed, 25 Aug 2021 18:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v4 07/12] clk: scmi: Support atomic enable/disable API
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-8-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210824135941.38656-8-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> Support enable/disable clk_ops instead of prepare/unprepare when the
> underlying SCMI transport is configured to support atomic transactions for
> synchronous commands.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
