Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42673633E4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 07:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhDRF41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 01:56:27 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:46439 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbhDRF40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 01:56:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618725359; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=igdUaRyaxUqTqUu8GzWWjHaq3ftiOYE2xM21Khaf0B4=;
 b=E7cAyjBx57WuKLbaLb45EgVNrYNagp2vZ/2voLzuIIm3XUqlTPfnVq16mu7B/zq9QrX2jUnX
 WDnPaju2axkhjJRQ6cmHwiWbuVi1fo1mVkVN7gmT/JlB+wi4vzMGfiKX0wPvmmwLqeWt6xHv
 J1vdt4s1Jn4xBB7Spnj8ZqXfTpA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 607bc9eca817abd39abd4746 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 18 Apr 2021 05:55:56
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD55EC4338A; Sun, 18 Apr 2021 05:55:55 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 39899C433F1;
        Sun, 18 Apr 2021 05:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39899C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ti: wlcore: fix error return code of
 wl1271_cmd_build_ps_poll()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210307082906.20950-1-baijiaju1990@gmail.com>
References: <20210307082906.20950-1-baijiaju1990@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, lee.jones@linaro.org,
        colin.king@canonical.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210418055555.AD55EC4338A@smtp.codeaurora.org>
Date:   Sun, 18 Apr 2021 05:55:55 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> When ieee80211_pspoll_get() returns NULL to skb, no error return code of
> wl1271_cmd_build_ps_poll() is assigned.
> To fix this bug, ret is assigned with -ENOMEM in this case.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Someone needs to review this.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210307082906.20950-1-baijiaju1990@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

