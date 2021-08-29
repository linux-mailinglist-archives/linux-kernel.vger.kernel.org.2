Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3543FAB27
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhH2LqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 07:46:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46696 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235143AbhH2LqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:46:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630237527; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=irGqUUIYdBveN6/7OVMy9T8jCS+s1qL+o56/wbFqR2s=;
 b=mKAOZxBgrORbrtLKytPb0jkJlIJ/pj3YGZKWfE1hBhGxiOgclkrQFWxiXPZYL7YjI27kMVoM
 acy56V2hieKlbkxw2ivWP0NuHdsgsG/HLoEgSEtQflISPHC/o0Mk996N8iygfQsdiN+jE78N
 smc99C9nN5oczoJlWRLILhZAAZI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 612b7350825e13c54a35bc0c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 29 Aug 2021 11:45:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 46822C4360D; Sun, 29 Aug 2021 11:45:19 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6054C43460;
        Sun, 29 Aug 2021 11:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A6054C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] bcma: Fix memory leak for internally-handled cores
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210727025232.663-2-yuzenghui@huawei.com>
References: <20210727025232.663-2-yuzenghui@huawei.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zajec5@gmail.com>, <hauke@hauke-m.de>, <linville@tuxdriver.com>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210829114519.46822C4360D@smtp.codeaurora.org>
Date:   Sun, 29 Aug 2021 11:45:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zenghui Yu <yuzenghui@huawei.com> wrote:

> kmemleak reported that dev_name() of internally-handled cores were leaked
> on driver unbinding. Let's use device_initialize() to take refcounts for
> them and put_device() to properly free the related stuff.
> 
> While looking at it, there's another potential issue for those which should
> be *registered* into driver core. If device_register() failed, we put
> device once and freed bcma_device structures. In bcma_unregister_cores(),
> they're treated as unregistered and we hit both UAF and double-free. That
> smells not good and has also been fixed now.
> 
> Fixes: ab54bc8460b5 ("bcma: fill core details for every device")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

2 patches applied to wireless-drivers-next.git, thanks.

b63aed3ff195 bcma: Fix memory leak for internally-handled cores
9fc8048c56f3 bcma: Drop the unused parameter of bcma_scan_read32()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210727025232.663-2-yuzenghui@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

