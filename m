Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558C938B80E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbhETUG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhETUGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:06:55 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:05:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 02215301;
        Thu, 20 May 2021 20:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 02215301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621541133; bh=ObSg9otZA8Wu7CMnLBYLmAJcg5O0RSEPsSKyKg7twhM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IJxP8tMOOflQZFe8afnJCqiVRIfEdZPm1xe1+Ul6SY4C1pcokX/B+2DHjwV0I6yaG
         rWWQRtgUyzS6U6NL0djXvs3nkom3js53LPxYm3kKB9aLeUKljJmeg6z1d4gALfAFWO
         goZQpUb5o54hSGIkwR2ZS+1zpm9z600EPPRHW01t4E1sQLa0Uk3HXvM9mbuN/sBjG3
         D79Mu/b9VIIzw2x9CkADk3IOM/ARI7BZZBM9Y1pC8FMkaU1U8+c1O6i8LMmQeMqdTU
         kus4Dj2MWLb863AREYICxtq/MrBpJQ7HkwFBNxVNjpJ5hgDYOXd5cHITDOXkTV/ZZ6
         8Kztr0OLarXdA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Koderer <marc@koderer.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v4 0/2] Fix typos in samples/kprobes/kprobe_example.c
In-Reply-To: <1621218083-23519-1-git-send-email-yangtiezhu@loongson.cn>
References: <1621218083-23519-1-git-send-email-yangtiezhu@loongson.cn>
Date:   Thu, 20 May 2021 14:05:32 -0600
Message-ID: <87sg2hnpbn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiezhu Yang <yangtiezhu@loongson.cn> writes:

> Split the v3 patch [1] into two patches suggested by Masami Hiramatsu.
>
> [1] https://lore.kernel.org/patchwork/patch/1429021/
>
> Tiezhu Yang (2):
>   samples/kprobes: Fix typo in handler_fault()
>   samples/kprobes: Fix typo in handler_post()
>
>  samples/kprobes/kprobe_example.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

I've applied the set, with one tweak.  The first patch included this
line:

  Fixes: 804defea1c02 ("Kprobes: move kprobe examples to samples/")

But that patch, as its title suggests, simply moved the code to a
different place; it didn't introduce that particular mistake.  So I took
the Fixes tag out.

Thanks,

jon
