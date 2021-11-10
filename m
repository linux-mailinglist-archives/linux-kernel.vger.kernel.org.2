Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA3E44C317
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhKJOmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhKJOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:42:01 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CDC061764;
        Wed, 10 Nov 2021 06:39:13 -0800 (PST)
Received: from localhost (unknown [151.44.43.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB5545ECC;
        Wed, 10 Nov 2021 14:39:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AB5545ECC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1636555152; bh=bhz6uOAGwgBI+FNK0TNABGLPC5xHyy5joqyJG3fY4CY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X5cGVqBPvZ24t4VTjC8EjU2+llJvu9LbXb0CJzZ1rg3LqyxMwagaa46P0CfHgCA3a
         b25jBHCPXonsm/fyUoC6YtKtDKvbpBTkd4pawbYeck2mBBMFgyJGBWktPF4AVVmm5b
         mZ3x/ijRBjJXpdCpeSYcRuEAKXpE7gp5gb9E2+Yu5k7j0cGz4nxLgSAfA07HZ25y1B
         hTtXavVWN2ff1e3Ub/tTaARZuCAqPZ4jDmrD48qR7csorFZgQik0iWXZCVZ8vunLyH
         8F2oPv/1UvCEx+d1tHJ4cw6/PBQRhpgkeB/H70CT/kjtWb0tYqGNhuJe3eIw9AvZso
         r9KQ7/fhP343g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 14/15] Documentation: add document for pte_ref
In-Reply-To: <20211110105428.32458-15-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110105428.32458-15-zhengqi.arch@bytedance.com>
Date:   Wed, 10 Nov 2021 07:39:08 -0700
Message-ID: <875yt0krcj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qi Zheng <zhengqi.arch@bytedance.com> writes:

> This commit adds document for pte_ref under `Documentation/vm/`.

Thanks for documenting this work!

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  Documentation/vm/pte_ref.rst | 212 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
>  create mode 100644 Documentation/vm/pte_ref.rst

When you add a new RST file, you also need to add it to the associated
index.rst file or it won't be included in the docs build.  Instead,
you'll get the "not included in any toctree" warning that you surely saw
when you tested the docs build with this file :)

> diff --git a/Documentation/vm/pte_ref.rst b/Documentation/vm/pte_ref.rst
> new file mode 100644
> index 000000000000..c5323a263464
> --- /dev/null
> +++ b/Documentation/vm/pte_ref.rst
> @@ -0,0 +1,212 @@
> +.. _pte_ref:

Do you need this label anywhere?  If not, I'd leave it out.

Thanks,

jon
