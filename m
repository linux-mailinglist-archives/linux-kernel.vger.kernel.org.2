Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C613ABD1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhFQTut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFQTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:50:47 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09EC061574;
        Thu, 17 Jun 2021 12:48:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BED119A9;
        Thu, 17 Jun 2021 19:48:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BED119A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623959319; bh=ZInPe7rb2hVV4jWX2+NphKYQLL17I62Jt5XXMTdyq8M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D4QfKxr0uIXqFTu7jVHeIouq+1rtDp9T9pgLow4m7TvU5ldNVROZ7d3Yo4MY95FYk
         vzQWAO/vThVYmFTpUxzHd9gufYRvf9ilQxn6MPKv4RLKuJyg4BUDZrj5YwPYUGB7zx
         AswQ1zC+jdQLNrGDLRFsUdWFGNBANVPt7g9hk7ZDgjF9S3faw8bjIEzI1qHIiBTgzb
         Zd1YEEA3wWchx2icn2XcIHX95vDSlBNrtMN2S7brj2FHQYlY/ITvNhrPEagGndCHEx
         4frrylG4bK15qTKphKplc19HHYOWrGTu6g33KhjB0bgJpBsHoWahvoGKH5I3RQgcKJ
         6CcGo9DmiP3cQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>, bobwxc@email.cn,
        siyanteng@loongson.cn
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
In-Reply-To: <20210617070051.32794-1-src.res@email.cn>
References: <20210617070051.32794-1-src.res@email.cn>
Date:   Thu, 17 Jun 2021 13:48:39 -0600
Message-ID: <87czsktgq0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res@email.cn> writes:

> Create new translations for dev-tools/testing-overview.rst and link it
> to dev-tools/index.rst with TODOList modifications.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>
> Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../translations/zh_CN/dev-tools/index.rst    |   5 +
>  .../zh_CN/dev-tools/testing-overview.rst      | 110 ++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst

This patch doesn't apply to current docs-next.  I can fix that, but then
it also adds this build warning:

  /stuff/k/git/kernel/Documentation/translations/zh_CN/dev-tools/testing-overview.rst:78: WARNING: unknown document: kcov

Please, build-test your patches before sending them to me...

Thanks,

jon
