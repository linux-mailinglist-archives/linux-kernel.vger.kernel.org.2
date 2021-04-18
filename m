Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA28036341A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 08:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhDRGf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 02:35:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44858 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhDRGfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 02:35:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618727727; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=7p/hcsE0piwa8MU9XQk6YnVr8yYhp1/bkJY9iJlzboY=;
 b=IKcFV4WcRHMp2pSUpNSv7K6aD79fW9HDTklO2mWgnwkFgjvQPxZPsNC/m+bv0XFJeEU228ue
 1WBapLovkGTAZcLe8fbusYOEHHnh7ou8aBUa8KSaCN8RzlVmc0QOZ8Db4Lh2PxPGH0WjFi+8
 WhPAsaiLC7IlbPIurmYIXgYDoYI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 607bd32ea817abd39ad4d699 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 18 Apr 2021 06:35:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CE763C4338A; Sun, 18 Apr 2021 06:35:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B2F3C433D3;
        Sun, 18 Apr 2021 06:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B2F3C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: mwl8k: Fix a double Free in mwl8k_probe_hw
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210402182627.4256-1-lyl2019@mail.ustc.edu.cn>
References: <20210402182627.4256-1-lyl2019@mail.ustc.edu.cn>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     buytenh@wantstofly.org, davem@davemloft.net, kuba@kernel.org,
        gustavoars@kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210418063525.CE763C4338A@smtp.codeaurora.org>
Date:   Sun, 18 Apr 2021 06:35:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lv Yunlong <lyl2019@mail.ustc.edu.cn> wrote:

> In mwl8k_probe_hw, hw->priv->txq is freed at the first time by
> dma_free_coherent() in the call chain:
> if(!priv->ap_fw)->mwl8k_init_txqs(hw)->mwl8k_txq_init(hw, i).
> 
> Then in err_free_queues of mwl8k_probe_hw, hw->priv->txq is freed
> at the second time by mwl8k_txq_deinit(hw, i)->dma_free_coherent().
> 
> My patch set txq->txd to NULL after the first free to avoid the
> double free.
> 
> Fixes: a66098daacee2 ("mwl8k: Marvell TOPDOG wireless driver")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>

Patch applied to wireless-drivers-next.git, thanks.

a8e083ee8e2a mwl8k: Fix a double Free in mwl8k_probe_hw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210402182627.4256-1-lyl2019@mail.ustc.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

