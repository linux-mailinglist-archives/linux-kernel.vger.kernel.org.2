Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DFA3A8052
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFONiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:38:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12095 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhFONiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:38:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623764174; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=oCyt5HP1cG0mwjB/oFPGtagilcICyOfoCjGxAwOTsPg=;
 b=AFfvdpzTPfUojbH2cM/d6oSUVr3AzTKx1Y/kvVk6+wy6KwUJpAd9qWv7Nyc7oxwRm2PA5wxn
 7XLLT16W3ke25x0QMGi7jUhCjdQTB7ejptq23Fr6aa/iyQgmmBhVz6PHcokBDh1x1s8qSzRK
 c6YTRRq8+PKDiYcjsPo0ra+ofzk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60c8acc3e27c0cc77f1e9b6a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:36:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98B79C43460; Tue, 15 Jun 2021 13:36:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1A3BC43217;
        Tue, 15 Jun 2021 13:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1A3BC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wl1251: Fix possible buffer overflow in
 wl1251_cmd_scan
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210428115508.25624-1-leegib@gmail.com>
References: <20210428115508.25624-1-leegib@gmail.com>
To:     Lee Gibson <leegib@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Gibson <leegib@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615133602.98B79C43460@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:36:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Gibson <leegib@gmail.com> wrote:

> Function wl1251_cmd_scan calls memcpy without checking the length.
> Harden by checking the length is within the maximum allowed size.
> 
> Signed-off-by: Lee Gibson <leegib@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

d10a87a3535c wl1251: Fix possible buffer overflow in wl1251_cmd_scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210428115508.25624-1-leegib@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

