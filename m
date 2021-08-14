Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9128C3EBF73
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhHNB6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:58:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47134 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbhHNB6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:58:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628906258; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=C+qezgIh0rDWivT4rvbZT5YmyvAyYRUfpE+phtBAAaw=; b=qGhgmUBTUM1Zelzy2cH2eBX5UwsOGPNaKWkl9Y06iRNTcR/j8lK0W6yqFeGFFpNRN+0E2Mxi
 JHJ/zR92YrDn3bzP7EaE0WNz9fBTLtZbAnTF96YrMg+dq+m+iAWm1mIaPLiG4fgLxmSRZg1o
 T1MGPD7rjj+m/PGy8id86M/zKTU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 611722f9454b7a558f4d6f92 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 14 Aug 2021 01:57:13
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C193C4338A; Sat, 14 Aug 2021 01:57:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AF9DC433F1;
        Sat, 14 Aug 2021 01:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AF9DC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Christoph Hellwig'" <hch@lst.de>,
        <iommu@lists.linux-foundation.org>,
        "'Russell King'" <linux@armlinux.org.uk>
Cc:     "'Dillon Min'" <dillon.minfei@gmail.com>,
        "'Vladimir Murzin'" <vladimir.murzin@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Manning, Sid'" <sidneym@quicinc.com>
References: <20210712061704.4162464-1-hch@lst.de> <20210712061704.4162464-8-hch@lst.de>
In-Reply-To: <20210712061704.4162464-8-hch@lst.de>
Subject: RE: [PATCH 7/7] hexagon: use the generic global coherent pool
Date:   Fri, 13 Aug 2021 20:57:06 -0500
Message-ID: <00a901d790af$b05165c0$10f43140$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGLBLs9KUWyWP2l5ibPYuIecai1XAJ58qmhq/eGB5A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
...
> Switch hexagon to use the generic code for dma_alloc_coherent from
> a global pre-filled pool.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Brian Cain <bcain@codeaurora.org>

