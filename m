Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC03A81AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFOOEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:04:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29155 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbhFOOEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:04:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623765749; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=8/f/DvtNejt87+u8IhG8UM7+m+gixlDyoZukRJXkyHQ=;
 b=DUDgpqnljS4pXUe6BVpCE7YuaPi2Haw7hSW8ZZkMY/QPTyhCHbXEW4YmngbvbiegXhiU5/bv
 Z+rnf33m7KHJnrhT19NjWUv+aDM5eD3vi5V8smq4eFXw6GokcUwcaVWT5oVexxjs8nBbhHEs
 zJc1V2Ey2UXl1Bq3+yQxpwnpQYE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60c8b2c9e27c0cc77f45b6df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 14:01:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E897C433D3; Tue, 15 Jun 2021 14:01:45 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9544DC433D3;
        Tue, 15 Jun 2021 14:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9544DC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] net: ath: ath5k: Fix wrong function name in
 comments
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210517050141.61488-2-shenyang39@huawei.com>
References: <20210517050141.61488-2-shenyang39@huawei.com>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Nick Kossifidis" <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615140145.1E897C433D3@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 14:01:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shen <shenyang39@huawei.com> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/wireless/ath/ath5k/pcu.c:865: warning: expecting prototype for at5k_hw_stop_rx_pcu(). Prototype was for ath5k_hw_stop_rx_pcu() instead
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Nick Kossifidis <mickflemm@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

3b0c7b2415e5 ath5k: Fix wrong function name in comments
2d1f8673ad6c ath: Fix wrong function name in comments
9d1bb2289b42 wil6210: Fix wrong function name in comments

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210517050141.61488-2-shenyang39@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

