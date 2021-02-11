Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53131913F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhBKRjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhBKQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:42:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88127C0613D6;
        Thu, 11 Feb 2021 08:41:36 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2B0AD5F42;
        Thu, 11 Feb 2021 16:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2B0AD5F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1613061696; bh=mMRZwq7oGoLQd1eLwL/qnQCjuvsA/TsEBd4aS2W2p5Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=il7A0sENfUtxXRxwUvbbDH2M9kG6XMioYJH0yt8YaU64UIkNw2/brA4Vn9tpmHllc
         QZFuRbbcKCfcqYFs2mbxpUgZc1bAnHcLfMEaPk6ug++zUgDdOzGj8rtChadKKp7L7w
         KihKUJmmqDPc6ni3356AqO+gpe+nEsardQXCD1nVDJ7UO8fcNOiSdktq3x1+XnarDZ
         NQE7eVy4a7LkWuoGrfK+YTBCVjpHuviYe0srDXLiVyhj0wHt31A/7OVrw3V5TIsG8A
         2oNjhghKZ8SvJyh3b55fGQo/kCRkcorBZOHSrJaPUW0WWxFnHNOyPE4112fhVH6V5M
         rFR2yuTrZp8MA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation/admin-guide: kernel-parameters: Update
 nohlt section
In-Reply-To: <20210209172349.2249596-1-f.fainelli@gmail.com>
References: <20210209172349.2249596-1-f.fainelli@gmail.com>
Date:   Thu, 11 Feb 2021 09:41:35 -0700
Message-ID: <871rdmr1z4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> Update the documentation regarding "nohlt" and indicate that it is not
> only for bugs, but can be useful to disable the architecture specific
> sleep instructions. ARM, ARM64, SuperH and Microblaze all use
> CONFIG_GENERIC_IDLE_POLL_SETUP which takes care of honoring the
> "hlt"/"nohlt" parameters.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
>
> - used ';' after requires CONFIG_GENERIC_IDLE_POLL_SETUP (Randy)
>
>  Documentation/admin-guide/kernel-parameters.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied, thanks.

jon
