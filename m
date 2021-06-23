Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB5F3B1CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFWOmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 10:42:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21230 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhFWOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:42:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624459187; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=82D/RvnvXIWarUQl34Y8kax/sq7KtyWDivoFVNNrcc0=; b=rjP9aY/21c5AnM0fSC29JcyhRd/mmxRqoFiELFzFFLiXgSC8MsTEFcOS/NsI2M1Id8HNYV87
 PkUpmL79Nm1s4foA8/6zG6czVeAkLNMYitfEJxmNPpbMVE5nqwg+YcJvExFb0EgkqqE1ajbM
 D6KVTMu6kMiVAfLvroSA6q8Ta4M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60d3479d01dd9a9431f8b1af (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 14:39:25
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B948C43460; Wed, 23 Jun 2021 14:39:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 45043C433F1;
        Wed, 23 Jun 2021 14:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45043C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Christoph Hellwig'" <hch@lst.de>,
        "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Sid Manning'" <sidneym@codeaurora.org>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210623141854.GA32155@lst.de>
In-Reply-To: <20210623141854.GA32155@lst.de>
Subject: RE: how can we test the hexagon port in mainline
Date:   Wed, 23 Jun 2021 09:39:21 -0500
Message-ID: <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJHxj6Ga6VuoE3mNrk9EKW2w3HC7qpA7bUg
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
...
> 
> Hi all,
> 
> the oldest supported gcc version in mainline is gcc 4.9.  But the only
> hexagon crosscompiler I can find is the one Arnds website points to here:
> 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> which is a non-upstream gcc 4.6.1 port.  How are we supposed to even
> build test hexagon code?

We have provided a clang-12-based toolchain here:

https://codelinaro.jfrog.io/artifactory/codelinaro-qemu/2021-05-12/clang+llv
m-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

Could we update https://mirrors.edge.kernel.org/pub/tools/crosstool/ to
point here?

-Brian

