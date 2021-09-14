Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF640B9C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhINVQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:16:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:41554 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhINVQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:07 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 880222C1;
        Tue, 14 Sep 2021 21:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 880222C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1631654089; bh=R5IwtEzhX3WHonTFtSdWGEcn69GcfkTVJVNJxTv3yAA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Afi3/nHnBbhboLik8DiHrfJOR/vSaX3p4rCJQM55CzWxvWqjGvt6EODfSaHDQzwKC
         CxwL6+4iMqAnz07RX5+/YWOmiAIuMGTtgDKfZrbyWX7V8R94kCDat6O5FOg0D9vdcY
         yJtBNWQK4JZEEoK/dxuxJ5k8j9NinVO726sbIKM3zuwEZGbO8szUUijqfiG2tW5hho
         Fvv69fSPU0jZre6KYAkpXRSKYqsUXVUxL7CMkKGNfRWsYG2nFfl6Ah5KdEd/NoMP73
         KoPV4BjMQSdAqB/8W4ljE83y5WrGDLeOv6mPctGl6AAVVX8/2bIfc0h6UTeQED33Cj
         jmMHeZIyF/9qg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Junhua Huang <junhuahuangdream@163.com>, alexs@kernel.org,
        bobwxc@email.cn, sterlingteng@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junhua Huang <huang.junhua@zte.com.cn>
Subject: Re: [PATCH v3] docs/zh_CN: Add zh_CN/admin-guide/sysrq.rst
In-Reply-To: <20210825154817.242411-1-junhuahuangdream@163.com>
References: <20210825154817.242411-1-junhuahuangdream@163.com>
Date:   Tue, 14 Sep 2021 15:14:48 -0600
Message-ID: <87a6kedflj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Junhua Huang <junhuahuangdream@163.com> writes:

> From: Junhua Huang <huang.junhua@zte.com.cn>
>
> Add translation zh_CN/admin-guide/sysrq.rst and link it to
> zh_CN/admin-guide/index.rst while clean its todo entry.
>
> Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>
> ---
>
> v3:
> * fix the building warnings and some format issues in presentation.
> * remove the Reviewed-by tag.
>
> v2:
> * modify some translation issues according to review from Yanteng.
> * add the Reviewed-by tag.
> ---
>  .../translations/zh_CN/admin-guide/index.rst  |   2 +-
>  .../translations/zh_CN/admin-guide/sysrq.rst  | 280 ++++++++++++++++++
>  2 files changed, 281 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/admin-guide/sysrq.rst

Applied, thanks.

jon
