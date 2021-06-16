Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070273A9E42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhFPO4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhFPOz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:55:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D5CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:53:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4A4201D78;
        Wed, 16 Jun 2021 14:53:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4A4201D78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623855232; bh=41okDU2C5ZvjNSnuwv35T/ZXCbIVwVaMm0c2rVcS94U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nrKkPYHmG7/s/oaouDPDpNCML6Bfixit7TBDVYWz7CvbB+f8LHITzPCizHSJ0M660
         2iYHlj0+YAT0Q0pdIa0CsTVr+wEGabQ+Lz3wJQ1HCN5nVIzUzh0Fz8Bpd9A/btUz6i
         hmE/+4MqGcu0CSv6B95mOZS/rfmIOMyuzbOLybzB2x4WJqZHzQgfqs4vqvEWZ/Vu1G
         vjK06NDQzV9ZkTB465tqVmlpIYh/a0nXNoslX2bCwrViYxuwHotGP9cQKY4auu04gd
         hJFRzEI3Ai9mXDzdjCGT3xL7DP7WHSXWVqunIKQKL73nbxw+2G/ED8GmAd5UUStYbH
         QH0q4+FanyBgg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v2 1/3] scripts: add spelling_sanitizer.sh script
In-Reply-To: <20210616122507.896-2-thunder.leizhen@huawei.com>
References: <20210616122507.896-1-thunder.leizhen@huawei.com>
 <20210616122507.896-2-thunder.leizhen@huawei.com>
Date:   Wed, 16 Jun 2021 08:53:51 -0600
Message-ID: <87bl85yi68.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhen Lei <thunder.leizhen@huawei.com> writes:

> The file scripts/spelling.txt recorded a large number of spelling
> "mistake||correction" pairs. These entries are currently maintained in
> order, but the results are not strict. In addition, when someone wants to
> add some new pairs, he either sort them manually or write a script, which
> is clearly a waste of labor. So add this script. For all spelling
> "mistake||correction" pairs, sort based on "correction", then on "mistake",
> and remove duplicates. Sorting based on "mistake" first is not chosen
> because it is uncontrollable.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  scripts/spelling_sanitizer.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100755 scripts/spelling_sanitizer.sh
>
> diff --git a/scripts/spelling_sanitizer.sh b/scripts/spelling_sanitizer.sh
> new file mode 100755
> index 000000000000..603bb7e0e66b
> --- /dev/null
> +++ b/scripts/spelling_sanitizer.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh -efu
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# To get the traditional sort order that uses native byte values

So I am of the naive opinion that everything we drop into scripts/
should start with a comment saying why it exists and how to use it.
Otherwise how are people going to benefit from it?

Thanks,

jon
