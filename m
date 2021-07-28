Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5313D3D91BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhG1PU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:20:58 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:51858 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbhG1PU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:20:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627485654; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=NMBA6eMZ2++sBypZUxc6pdznV/MW5syE3FBstf0UH5I=; b=BFqPU2m2R0GQVlIJZVI6K/7QZNxnNuJSIP8x1G7QoFadzO8IG3HeieOaPr4HZUP5QWSLUOAM
 c8MF6WfPimB92MWX3OgXsnsRoRwnV66oB2LtYDPChx4wZV+W2fkcLQMR6H2Q5Aoa4loZrWqh
 VLO9L/sstCmL2+t9yk5EFdDeyr4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 610175c7e81205dd0aa482b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Jul 2021 15:20:39
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28087C4323A; Wed, 28 Jul 2021 15:20:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CDC3C433D3;
        Wed, 28 Jul 2021 15:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CDC3C433D3
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
References: <20210712061704.4162464-1-hch@lst.de>
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
Subject: RE: add support for the global coherent pool to the dma core
Date:   Wed, 28 Jul 2021 10:20:34 -0500
Message-ID: <03d501d783c4$1d3f10e0$57bd32a0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGLBLs9KUWyWP2l5ibPYuIecai1XKvxfn8g
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, July 12, 2021 1:17 AM
> To: iommu@lists.linux-foundation.org; Russell King
<linux@armlinux.org.uk>;
> Brian Cain <bcain@codeaurora.org>
> Cc: Dillon Min <dillon.minfei@gmail.com>; Vladimir Murzin
> <vladimir.murzin@arm.com>; linux-arm-kernel@lists.infradead.org; linux-
> hexagon@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: add support for the global coherent pool to the dma core
> 
> Hi all,
> 
> this series adds support for using the global coherent (aka uncached)
> pool to the generic dma-direct code and then switches arm-nommu and
> hexagon over to it, together with a bunch of cleanups.

Christoph,

Thanks for sending this -- I will take a look and give some feedback soon.

> Diffstat:
>  arch/arm/Kconfig                |    5 -
>  arch/arm/mm/dma-mapping-nommu.c |  173
+--------------------------------------
> -
>  arch/hexagon/Kconfig            |    1
>  arch/hexagon/kernel/dma.c       |   57 ++-----------
>  include/linux/dma-map-ops.h     |   18 ++--
>  kernel/dma/Kconfig              |    4
>  kernel/dma/coherent.c           |  159
+++++++++++++++++-------------------
>  kernel/dma/direct.c             |   15 +++
>  8 files changed, 124 insertions(+), 308 deletions(-)

