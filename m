Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1882412E47
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 07:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhIUFpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 01:45:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25582 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIUFpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 01:45:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632203018; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=k6pSttvVgNFdyEDniUfPWVDBvflAMZr1Ha2ifSo3044=;
 b=KHYEkPOr1B47YOxg/xegshaZm2asyq1h6ASdJUKUNwsYGEkaPhrsrume8EpLrmrKGKDgjZS2
 xVx/x1O92z54eFstz2usX9JXYvmUjTgxb3ysmwhjJM2OdmuNPrw+JOCRWHZKcWYSlfUinYFZ
 qsB7+hQxBRQMMHArdciqeEz5I7c=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 614970f7507800c880a93ab3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 05:43:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 087CEC4360D; Tue, 21 Sep 2021 05:43:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72E1DC4338F;
        Tue, 21 Sep 2021 05:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 72E1DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] rsi: fix occasional initialisation failure with BT
 coex
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1630337206-12410-2-git-send-email-martin.fuzzey@flowbird.group>
References: <1630337206-12410-2-git-send-email-martin.fuzzey@flowbird.group>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210921054319.087CEC4360D@smtp.codeaurora.org>
Date:   Tue, 21 Sep 2021 05:43:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Fuzzey <martin.fuzzey@flowbird.group> wrote:

> When BT coexistence is enabled (eg oper mode 13, which is the default)
> the initialisation on startup sometimes silently fails.
> 
> In a normal initialisation we see
> 	usb 1-1.3: Product: Wireless USB Network Module
> 	usb 1-1.3: Manufacturer: Redpine Signals, Inc.
> 	usb 1-1.3: SerialNumber: 000000000001
> 	rsi_91x: rsi_probe: Initialized os intf ops
> 	rsi_91x: rsi_load_9116_firmware: Loading chunk 0
> 	rsi_91x: rsi_load_9116_firmware: Loading chunk 1
> 	rsi_91x: rsi_load_9116_firmware: Loading chunk 2
> 	rsi_91x: Max Stations Allowed = 1
> 
> But sometimes the last log is missing and the wlan net device is
> not created.
> 
> Running a userspace loop that resets the hardware via a GPIO shows the
> problem occurring ~5/100 resets.
> 
> The problem does not occur in oper mode 1 (wifi only).
> 
> Adding logs shows that the initialisation state machine requests a MAC
> reset via rsi_send_reset_mac() but the firmware does not reply, leading
> to the initialisation sequence being incomplete.
> 
> Fix this by delaying attaching the BT adapter until the wifi
> initialisation has completed.
> 
> With this applied I have done > 300 reset loops with no errors.
> 
> Fixes: 716b840c7641 ("rsi: handle BT traffic in driver")
> Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
> CC: stable@vger.kernel.org

3 patches applied to wireless-drivers-next.git, thanks.

9b14ed6e11b7 rsi: fix occasional initialisation failure with BT coex
99ac60188212 rsi: fix key enabled check causing unwanted encryption for vap_id > 0
b515d097053a rsi: fix rate mask set leading to P2P failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1630337206-12410-2-git-send-email-martin.fuzzey@flowbird.group/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

