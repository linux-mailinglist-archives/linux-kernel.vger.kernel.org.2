Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1834395FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhJYMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:20:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31596 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233135AbhJYMT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:19:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635164254; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=fWKxaBJfbZu62J4f9mK3WB8slIxGA4Es1JIHrQ2zcEE=; b=loNChsDnMpeIP7YGJFtw4Ai5nsAaSy0wvpGLi6Fms+o9NrSildSb3xZE6Ec8f5kgz5AnF4Zg
 X1HeG7veC1tKRKz57IOAc+eUbMJcY6IgzDt4K3TpTnvnfvikt1Si6C53/Jk/tYjJOikU2ewq
 CX8Yb/DlWM4YFMaAUKsaARpbDxc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6176a052c75c436a3052b920 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Oct 2021 12:17:22
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA3BDC4338F; Mon, 25 Oct 2021 12:17:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3BEBC4338F;
        Mon, 25 Oct 2021 12:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D3BEBC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Srinivasan Raju <srini.raju@purelifi.com>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Mostafa Afgani <mostafa.afgani@purelifi.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list\:NETWORKING DRIVERS \(WIRELESS\)" 
        <linux-wireless@vger.kernel.org>,
        "open list\:NETWORKING DRIVERS" <netdev@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v20 2/2] wireless: Initial driver submission for pureLiFi STA devices
References: <20200928102008.32568-1-srini.raju@purelifi.com>
        <20211018100143.7565-1-srini.raju@purelifi.com>
        <20211018100143.7565-3-srini.raju@purelifi.com>
        <20211025095927.cssdlblcdprdwfsy@kari-VirtualBox>
        <CWLP265MB321780AB502EF147F6AAF197E0839@CWLP265MB3217.GBRP265.PROD.OUTLOOK.COM>
Date:   Mon, 25 Oct 2021 15:17:15 +0300
In-Reply-To: <CWLP265MB321780AB502EF147F6AAF197E0839@CWLP265MB3217.GBRP265.PROD.OUTLOOK.COM>
        (Srinivasan Raju's message of "Mon, 25 Oct 2021 11:23:58 +0000")
Message-ID: <87mtmxcn90.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivasan Raju <srini.raju@purelifi.com> writes:

>> Thease are just what I found myself.
>
> Thanks ! I will check and fix.

Please don't use HTML, our lists drop those.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
