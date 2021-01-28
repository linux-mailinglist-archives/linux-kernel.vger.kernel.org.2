Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA052306FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhA1Hgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:36:31 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:31138 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhA1HeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:34:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611819238; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=9W6Vf1R++yjjF3FxF3cPAfaLSdNa8uzt5rRAyBg4yjw=;
 b=oQ9yAHQyoM8u+dAVxX9COsGEpAhJrBMIFUTPZX7NxAcWwNhPEio5zbs3OhKjcas2txZBENl5
 59jX+ESlvt9moJz4gquttJIMEb284FcohhmKdOmFjWxO7buzEgYeJmXCgTC7vOFqjsyWjitH
 rnyje/PotrWiPR5qDlt3WhFSdC4=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 601268c1beacd1a252aa8e8f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Jan 2021 07:33:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35C1BC433ED; Thu, 28 Jan 2021 07:33:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE25CC433C6;
        Thu, 28 Jan 2021 07:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE25CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: Add separate entry for LED triggers to fix module
 builds
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201227143034.1134829-1-krzk@kernel.org>
References: <20201227143034.1134829-1-krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210128073321.35C1BC433ED@smtp.codeaurora.org>
Date:   Thu, 28 Jan 2021 07:33:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> wrote:

> After commit 72cdab808714 ("ath9k: Do not select MAC80211_LEDS by
> default") a configuration like:
>  - MAC80211_LEDS=y
>  - LEDS_CLASS=m
>  - NEW_LEDS=y
>  - ATH9K=y
> leads to a build failure:
> 
>     /usr/bin/ld: drivers/net/wireless/ath/ath9k/gpio.o: in function `ath_deinit_leds':
>     drivers/net/wireless/ath/ath9k/gpio.c:69: undefined reference to `led_classdev_unregister'
>     /usr/bin/ld: drivers/net/wireless/ath/ath9k/gpio.o: in function `led_classdev_register':
>     include/linux/leds.h:190: undefined reference to `led_classdev_register_ext'
> 
> To be able to use LED triggers, the LEDS_CLASS can only be a module
> if ath9k driver is a module as well.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 72cdab808714 ("ath9k: Do not select MAC80211_LEDS by default")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I took Arnd's patch instead:

https://patchwork.kernel.org/project/linux-wireless/patch/20210125113654.2408057-1-arnd@kernel.org/

But I think we really need the cleanup Arnd proposes during the discussion so
that we have consistent LED handling in wireless drivers. Patches very welcome.

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201227143034.1134829-1-krzk@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

