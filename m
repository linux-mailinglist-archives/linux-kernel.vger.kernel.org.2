Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9864D4594D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbhKVSm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:42:56 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:12316 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhKVSmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:42:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637606381; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=O1L2PBC9UE+igdpkZV5c4OaYh/9FnhP5P3hsf5K7Wb8=;
 b=vZ0OfpQY1VqLqbhRumWt6UmzbnjIWXCmx6I49ORp10xj9WFtp7nca6ZRwmaeOBs6N8+4fusX
 OtYOHvCaFBsN9V5l1Hc7EibZL+JuQTvJMnhXBWFbjSaTm8Xc/NtUBx3CvTYuK42+yPN2WGqk
 LHYxA3WqmOZTiA5RtCPHZRjsaog=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 619be3e66bacc185a5ab6ee8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 18:39:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2A03C4360D; Mon, 22 Nov 2021 18:39:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5380AC4338F;
        Mon, 22 Nov 2021 18:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5380AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: Fix memory leaks in error handling path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1504cd7d842d13ddb8244e18004523128d5c9523.1636615284.git.christophe.jaillet@wanadoo.fr>
References: <1504cd7d842d13ddb8244e18004523128d5c9523.1636615284.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     luciano.coelho@intel.com, davem@davemloft.net, kuba@kernel.org,
        rdunlap@infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163760636938.7371.10106271212043349831.kvalo@codeaurora.org>
Date:   Mon, 22 Nov 2021 18:39:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Should an error occur (invalid TLV len or memory allocation failure), the
> memory already allocated in 'reduce_power_data' should be freed before
> returning, otherwise it is leaking.
> 
> Fixes: 9dad325f9d57 ("iwlwifi: support loading the reduced power table from UEFI")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied to wireless-drivers.git, thanks.

a571bc28326d iwlwifi: Fix memory leaks in error handling path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1504cd7d842d13ddb8244e18004523128d5c9523.1636615284.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

