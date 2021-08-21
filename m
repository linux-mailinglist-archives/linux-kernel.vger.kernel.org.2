Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817C43F3BAC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhHUR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:27:13 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21348 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhHUR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:27:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629566789; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6WsGx9ae68Ps20lCTKcLH+Mv3aDl+4r3zhiufzd6GVI=;
 b=buW50jxbi6YY0MnplGhBbrWdJQe4cU/U8uH4bdDF2AsKRylClCHdNpkOd06VBjtXAHVIok2k
 yEqySCxcUgDzmd64mAwgjtofyKkjpUpEQbVdnxGZi5WnRF2ZvjXZYRjNGBrFw/o9CUoiy3c7
 cQoE7gge6qaocF/Uku8cltGTw/k=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61213739a2d1fbf62b2a4ede (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 17:26:17
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06659C43616; Sat, 21 Aug 2021 17:26:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E4C6C4338F;
        Sat, 21 Aug 2021 17:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5E4C6C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] rsi: fix occasional initialisation failure with BT
 coex
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1628245403-2517-2-git-send-email-martin.fuzzey@flowbird.group>
References: <1628245403-2517-2-git-send-email-martin.fuzzey@flowbird.group>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821172617.06659C43616@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 17:26:17 +0000 (UTC)
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

Failed to apply, please rebase on top of wireless-drivers-next.

error: sha1 information is lacking or useless (drivers/net/wireless/rsi/rsi_91x_mgmt.c).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: rsi: fix occasional initialisation failure with BT coex
Patch failed at 0001 rsi: fix occasional initialisation failure with BT coex

3 patches set to Changes Requested.

12423167 [1/3] rsi: fix occasional initialisation failure with BT coex
12423171 [2/3] rsi: fix key enabled check causing unwanted encryption for vap_id > 0
12423173 [3/3] rsi: fix rate mask set leading to P2P failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1628245403-2517-2-git-send-email-martin.fuzzey@flowbird.group/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

