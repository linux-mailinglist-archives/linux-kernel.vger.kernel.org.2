Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E033F3BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhHURup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:50:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:49261 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhHURun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:50:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629568204; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=oOw0hNMvmiwGmM8lKJQwgKVAwHL3E72T449gwZIaonY=;
 b=b4+YuObDK5KhZt7HQieOxiS6nqnf2v7qpol7OKDyanDhMczmCukUE7wwDFtFWspClrwMEXvM
 /pGBprUgUJz0+yKitwOoIB6HrglE9OSmGbmi2c5zuFJ83kmD7tYy0PJeaU9lBT3jbzamfOMh
 fDZ81c3ZnEG0szCKgwIDCD1PGq4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61213cae89fbdf3ffe97e18f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 17:49:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 257BBC43617; Sat, 21 Aug 2021 17:49:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A804C4338F;
        Sat, 21 Aug 2021 17:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3A804C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: drop redundant null-pointer check in
 mwifiex_dnld_cmd_to_fw()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210804020305.29812-1-islituo@gmail.com>
References: <20210804020305.29812-1-islituo@gmail.com>
To:     Tuo Li <islituo@gmail.com>
Cc:     amitkarwar@gmail.com, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        Tuo Li <islituo@gmail.com>, TOTE Robot <oslab@tsinghua.edu.cn>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210821174934.257BBC43617@smtp.codeaurora.org>
Date:   Sat, 21 Aug 2021 17:49:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tuo Li <islituo@gmail.com> wrote:

> There is no case in which the variable cmd_node->cmd_skb has no ->data,
> and thus the variable host_cmd is guaranteed to be not NULL. Therefore,
> the null-pointer check is redundant and can be dropped.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> Tested-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

118934041c5f mwifiex: drop redundant null-pointer check in mwifiex_dnld_cmd_to_fw()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210804020305.29812-1-islituo@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

