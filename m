Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B9C3C60D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbhGLQzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:55:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:42842 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhGLQzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:55:03 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3C6B02ED;
        Mon, 12 Jul 2021 16:52:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C6B02ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626108735; bh=Ht0oyzdlSiXVIXNy6859nQqTmXf4s3iJH3pkY4b8KJA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VB6s9kMqtzwaBWywvSSxp/NhuT7GjnJUm3jJIMlod5oQpThVi//qYMVQWFfJmMseZ
         3tBeIlaonKYx/Ll038+TDk+pMAQSB7zTor81u5VmhmCi7lm2aSnNPVXf2tscP4kkkB
         Q8xLp1MnmdNwddJ7l9DxhmE5GKK/1c77Wx9/ZAr4lPEqlFFBe83A/27S23ScV1QDUy
         OPhqruA0TdZ+aDcd3uLqFFS73qryy6M/xs47rf5/DkLhZcCg7Q3WrB64UGoFWPjwfN
         zVOWuDFKOMj8H4PJGWawZuqFjrCH1MVgNemsoj38yTRMLZ6jUsWJ+eB2LTRgNOSUom
         WOZ4QXG3WPR3g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
In-Reply-To: <20210620052841.GA22083@bobwxc.top>
References: <20210617070051.32794-1-src.res@email.cn>
 <20210620052841.GA22083@bobwxc.top>
Date:   Mon, 12 Jul 2021 10:52:14 -0600
Message-ID: <878s2bqxtt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Wu X.C." <bobwxc@email.cn> writes:

> From: Hu Haowen <src.res@email.cn>
>
> Create new translations for dev-tools/testing-overview.rst and link it
> to dev-tools/index.rst with TODOList modifications.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>
> Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
> ---
> Jon, sorry for previous inconvience.
> v6: fix link tag
>     rebase to newest docs-next
>
>  .../translations/zh_CN/dev-tools/index.rst    |   5 +
>  .../zh_CN/dev-tools/testing-overview.rst      | 108 ++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/testing-overview.rst

Applied, thanks.

jon
