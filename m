Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB339BE77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFDRWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:22:07 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D229C061766;
        Fri,  4 Jun 2021 10:20:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 440D74A6;
        Fri,  4 Jun 2021 17:20:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 440D74A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622827220; bh=x0gZ/+V+J/EpZw6CTyYmGuRUO4eDuSK+FswFXgyN9e0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nTTJ26HkdMTj+/8yEOjRKxUCVOwSiq+xGz4Y8NTDL3TVggfSVCPgj8Rf7ypCWxlFI
         JoLqs8D2I98JascDuPpDCMenjmqiYYZc9tcHmuWuByM6PK+PjtXOnscqX4gbn4fGjX
         7YhHidGyubb7aRymhLGDHuV4yVlktutMPFGfD1We92VSRsdpfQ3enMkfOYn4Q4XzZt
         BQ1I57UqWdOQghTJcb4+KA8L3CKMvW/LSjoeiGMuJVbp94fbA4BMYl/D/rzj5Hiech
         Hrz/zcxr+sMYRqiQ+lP244+5r7cSGoLlXzu8odlm+QXLZz1o9hOGCivECBClvEy6b2
         /zdnCMY328ugA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wan Jiabing <wanjiabing@vivo.com>, Alex Shi <alexs@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Fangrui Song <maskray@google.com>,
        Bernard Zhao <bernard@vivo.com>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com
Cc:     kael_w@yeah.net
Subject: Re: [PATCH] [v5] docs/zh_CN: add translations in zh_CN/dev-tools/kasan
In-Reply-To: <20210603141127.101689-1-wanjiabing@vivo.com>
References: <20210603141127.101689-1-wanjiabing@vivo.com>
Date:   Fri, 04 Jun 2021 11:20:19 -0600
Message-ID: <87r1hhzgvg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> writes:

> Add new zh translations
> * zh_CN/dev-tools/kasan.rst
> and link it to zh_CN/dev-tools/index.rst
>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
> Changelog:
> v5:
> - Fix some aligns below titles.
> v4:
> - Fix a space missing.
> v3:
> - Fix aligns and inaccurate translation.
> v2:
> - Delete spaces surround with English words.
> ---
>  .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>  .../translations/zh_CN/dev-tools/kasan.rst    | 417 ++++++++++++++++++
>  2 files changed, 418 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/kasan.rst

Applied, thanks.

jon
