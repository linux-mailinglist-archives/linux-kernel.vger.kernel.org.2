Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7453613B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhDOUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhDOUvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:51:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002CAC061574;
        Thu, 15 Apr 2021 13:51:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2B8FF304D;
        Thu, 15 Apr 2021 20:51:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2B8FF304D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618519887; bh=WJNXxMnf3o1Krg6cX9lLd+A+GnhL4P/2Sm5O0ykWVPw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F0xisW+Z+Ynny20XPvz29JX94RXpol5SPT4IM0u6kY5QflG6MfnCXu3wfbiq4+di3
         0eVUvHGmXzbQ3ONDAwLdiYbSboMVJtCBQXwibj0UXIoGnZvBwf97LeHX1llqcdpF75
         mbh3Em5/R2e+u5r41lldBhWUrvFx0+K8NZkZphSsiUdmGgtRN14g99PmNo3dhGeHg0
         UGjA45712FZtsOVFGVyTrY7uqw1e6JE84emhpaYwyh1CtXq5seOOiue8TRvCvwG2fZ
         Qu6JEflu/YdvkMSYNUp6iyeyK1djEa7kMJdhnVI2DMgZm1fMCSi2g/v4sPoo3HHbUo
         ap3Qut/obKbqg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wu XiangCheng <bobwxc@email.cn>, Alex Shi <alexs@kernel.org>,
        Bernard Zhao <bernard@vivo.com>
Cc:     YanTeng Si <sterlingteng@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v6] docs/zh_CN: add translations in zh_CN/dev-tools/gcov
In-Reply-To: <20210415054304.GA26689@bobwxc.top>
References: <20210414082316.15160-1-bernard@vivo.com>
 <20210415054304.GA26689@bobwxc.top>
Date:   Thu, 15 Apr 2021 14:51:26 -0600
Message-ID: <87a6pzi84x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu XiangCheng <bobwxc@email.cn> writes:

> From: Bernard Zhao <bernard@vivo.com>
>
> Add new zh translations
> * zh_CN/dev-tools/gcov.rst
> * zh_CN/dev-tools/index.rst
> and link them to zh_CN/index.rst
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
> ---
> base: linux-next
> commit 269dd42f4776 ("docs/zh_CN: add riscv to zh_CN index")
>
> Changes since V5:
> * modified some words under Fangrui Song's advices
> * rewrite beginning paragragh since Bernard and Fangrui's advice
>
> Changes since V4:
> * modified some words under Alex Shi's advices
>
> Changes since V3:
> * update to newest linux-next
> * fix ``
> * fix tags
> * fix list indent
>
> Changes since V2:
> * fix some inaccurate translation
>
> Changes since V1:
> * add index.rst in dev-tools and link to to zh_CN/index.rst
> * fix some inaccurate translation
>
> Thanks!
>
>  .../translations/zh_CN/dev-tools/gcov.rst     | 265 ++++++++++++++++++
>  .../translations/zh_CN/dev-tools/index.rst    |  35 +++
>  Documentation/translations/zh_CN/index.rst    |   1 +
>  3 files changed, 301 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/gcov.rst
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/index.rst

Applied, thanks.

jon
