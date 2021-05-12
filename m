Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEB937BED3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhELNvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:51:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:50:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m37so18242775pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j7HPp7SPJ5ixrof+8xWJIVyjAJUc8DcOO4WKRHuF6MA=;
        b=sgFrgz1Fvinqj3coczr7/9S/4ocBWk25qLmzjxOTC8F/COEco9upxjWoA8xjd7POiX
         gTdJV3qU4TBPLrGN3zZReoel0sSZyUeWXdFN8/O5DKcfUsExkomoNATnQnz4hKmV7dIA
         OY7Bhniy7i348gw1aIEY4Do0rrZy6Xd+XFZPBIHi3RYjXiQPRaI+V8Hal7yfy6gZPJde
         xs8661yXyBDD4GziGHvBnMQnVotfTF0uAYUZQX0o0+qYCZkb7N+csXbI/ATnYTPeZIHB
         fzMj1WRLcmz2PWGWWiXyBaE3TjTbX/SPAZsGtML6ky+3GxAChybYeqH7/OoiPfySCSrr
         jLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j7HPp7SPJ5ixrof+8xWJIVyjAJUc8DcOO4WKRHuF6MA=;
        b=bGN+zLaJBxF/r3bn0wXssr6zyPMyjRXmNw04nYvipEi81I13EovFLMYK+6QPV95FtB
         GHfSi5khM0Kt7Q/oGiNIg5+Vn2+XWOV0WS0FZLkksFd00SsdUqzHUqb1Op85nZI9iwLR
         ETlZLY0HmQRunPTL4ce1RFMd7YfZqocmToEyIhMisUYodJ2HcKWGOOfWT1L/AKZvpf62
         DHPGWEwVvl+tKHZ6mIu8pDwhvbOITPlzUsIZj3p+aSD5m+TFdkBP0j4p1ErkBZ2SCeMv
         vpwFyMo6BDNFzTxwjaLYca37P33vyrVkSMnNg7YBtmwJCjKXUCJC6vuCi4ZvwUBMm9xh
         iGsg==
X-Gm-Message-State: AOAM530qR1XAHduC7KDZE6woa3co+9Dy50o9vjwUtMiPuFtA9BZYabhM
        2ccTxhzZUEgm/FFoi4mbkMy4o5T831Q=
X-Google-Smtp-Source: ABdhPJzgg8+XoUwQIyqn1Ed7ie1GHsvTDKIQGHGOiy0+jgLaP43rAsYWzyoS9wLQa5yGo3ZljJcFmw==
X-Received: by 2002:a63:79c3:: with SMTP id u186mr32840037pgc.203.1620827427999;
        Wed, 12 May 2021 06:50:27 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id l6sm51758pgc.68.2021.05.12.06.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:50:27 -0700 (PDT)
Subject: Re: [PATCH -next] reset: brcmstb: Add missing MODULE_DEVICE_TABLE
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Zou Wei <zou_wei@huawei.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1620789283-15048-1-git-send-email-zou_wei@huawei.com>
 <d88dd8b76c3fe831f411b4e16ea15a6a8aa225dd.camel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c7d6ba29-7f05-050c-405a-5cab24047a69@gmail.com>
Date:   Wed, 12 May 2021 06:50:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d88dd8b76c3fe831f411b4e16ea15a6a8aa225dd.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2021 11:06 PM, Philipp Zabel wrote:
> On Wed, 2021-05-12 at 11:14 +0800, Zou Wei wrote:
>> This patch adds missing MODULE_DEVICE_TABLE definition which generates
>> correct modalias for automatic loading of this driver when it is built
>> as an external module.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> 
> Thank you, applied to reset/next with
> 
> Fixes: 77750bc089e4 ("reset: Add Broadcom STB SW_INIT reset controller driver")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

And thanks for adding the Fixes: tag as well.
-- 
Florian
