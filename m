Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36C535E80C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhDMVJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhDMVJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:09:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E83C061574;
        Tue, 13 Apr 2021 14:09:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 866AA2CD;
        Tue, 13 Apr 2021 21:09:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 866AA2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618348156; bh=C5mWz6BVRciRIMBbxYq3d3EZLsQzuCGe1XXoW3xDybU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aqxtGB0AzDpZvkfVvgnCdfsVvXwUvcSWem6GZBYWXbQ7NSHibTpk8wgPYKlq8ZI2f
         SfYdhCEKQeae1ws3t6mPn+kzqYkpMyITcZPDuWt7XJSCQNs4KU7mfX51PvM2FbF0XP
         /8fuopSLoZ7zdlCqh8q8IEQksMHYyOOpz3DN8l3oeOTTIvMrpeCMOUZrN1oX1tiLIO
         tJdJBGVnujBfuXbLFzGHWYQgCMURBtisUcSBjXlmQ30PTa7XZm3aUvaTKh1tWxdPdg
         6sL4rEXuMe7pfVtd9B4lWklXZUTuR7KjAWR4LuST4hD1dkVJJPYzq4g2Ejbl0qtk2f
         n4hbgUkSwvj8g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: align Italian documentation
In-Reply-To: <20210409224104.30471-1-federico.vaga@vaga.pv.it>
References: <20210409224104.30471-1-federico.vaga@vaga.pv.it>
Date:   Tue, 13 Apr 2021 15:09:16 -0600
Message-ID: <878s5lsxhf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Translation for the following patches
>
> commit 7dfbea4c468c ("scripts: remove namespace.pl")
> commit 1a63f9cce7b7 ("docs: Remove make headers_check from checklist")
> commit 1e013ff7cb54 ("docs: Document cross-referencing using relative path")
> commit 0be1511f516e ("Documentation: doc-guide: fixes to sphinx.rst")
> commit 911358401284 ("kernel-doc: Fix example in Nested structs/unions")
> commit 875f82cb374b ("Documentation/submitting-patches: Extend commit message layout description")
> commit 78f101a1b258 ("Documentation/submitting-patches: Add blurb about backtraces in commit messages")
> commit f0ea149eee6b ("docs: submitting-patches: Emphasise the requirement to Cc: stable when using Fixes: tag")
> commit 05a5f51ca566 ("Documentation: Replace lkml.org links with lore")
> commit 9bf19b78a203 ("Documentation/submitting-patches: Document the SoB chain")
> commit b7592e5b82db ("docs: Remove the Microsoft rhetoric")
> commit 26606ce072d4 ("coding-style.rst: Avoid comma statements")
> commit dd58e649742a ("docs: Make syscalls' helpers naming consistent")
> commit 460cd17e9f7d ("net: switch to the kernel.org patchwork instance")
> commit 163ba35ff371 ("doc: use KCFLAGS instead of EXTRA_CFLAGS to pass flags from command line")
> commit 0ef597c3ac49 ("docs: remove mention of ENABLE_MUST_CHECK")
> commit f8408264c77a ("drivers: Remove CONFIG_OPROFILE support")
> commit 0653c358d2dc ("scsi: Drop gdth driver")
> commit f8ae7bbec726 ("net: x25_asy: Delete the x25_asy driver")
> commit cf6d6fc27936 ("docs: process/howto.rst: make sections on bug reporting match practice")
> commit da514157c4f0 ("docs: make reporting-bugs.rst obsolete")
> commit 4f8af077a02e ("docs: Fix reST markup when linking to sections")
> commit 3a4928cf5e3c ("Documentation: kernel-hacking: change 'current()' to 'current'")
> commit c170f2eb9648 ("docs: Document cross-referencing between documentation pages")
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Applied, thanks.

jon
