Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C272B31314E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhBHLsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:48:25 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:57963 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233196AbhBHL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:27:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612783617; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5QCI63NH6Wa4pD81iDZmUJs/qJLaqHjMmad3Bk2CwNE=;
 b=BciarByGzYNUvvf6ZXERpuE/Bb1noPo3hEPWAQ/gFTUhl+eB1z7pBo0inqOMnEOOXdb9k91b
 cgRKUsfqLowcH7VobIa1UXwumyLb01ABqATWRMDSn63J/pt2Jzs8m0JvmJnwVYFYjOmxMVhG
 XFHIgBy20Lq7m/EwMYT3chX01YU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60211fe1f112b7872c458817 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 11:26:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5CA59C433CA; Mon,  8 Feb 2021 11:26:25 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 740CFC43464;
        Mon,  8 Feb 2021 11:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 740CFC43464
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: Use true and false for bool variable
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210208112625.5CA59C433CA@smtp.codeaurora.org>
Date:   Mon,  8 Feb 2021 11:26:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Fix the following coccicheck warnings:
> 
> ./include/linux/ssb/ssb_driver_gige.h:89:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_one_dma_at_once' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:79:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_have_roboswitch' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:182:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_must_flush_posted_writes' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:178:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_one_dma_at_once' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:174:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_have_roboswitch' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:170:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_is_rgmii' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:162:8-9: WARNING: return of 0/1 in
> function 'pdev_is_ssb_gige_core' with return type bool.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Acked-by: Michael Büsch <m@bues.ch>

Patch applied to wireless-drivers-next.git, thanks.

4331667fa14e ssb: Use true and false for bool variable

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

