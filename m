Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ABD434065
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhJSVWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:22:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:53266 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhJSVWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:22:31 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C1B16738;
        Tue, 19 Oct 2021 21:20:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C1B16738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634678417; bh=uCOBbNiaiyeylhFrdeMmrjnNJPh0+d3HJX3usuZODvY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=k1+l+vQnb64ri2FnU9maBhIrfajGdijzTpP+szLEo0ZtukI3+W6nYuJSMkXyRiY2C
         rN56VToCcelcqqPj4i/seWbglFnSywun/yPspEkXIuVdAMihJMAOamSj7xuG34UbjB
         mjBWwpGfkM5AyCCOv8W3EuOONnQF8hhy1TFochb/jL3cd2tDCgFKOSU9H87/2+5w+9
         0Qp+tmFQGfqyH9fJ5NmM+ksfXx5bKCihZryAsmyXX9SpKW45z1YxBznLGW5b0pElzs
         A9NP9NN+MOgZVKz3fCx8Nd5jJCY4Liik2pVXpgSAk2JAJCQq+bAJgBQGP/siDWPWFf
         M1bVQ16HjUGgw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/23] docs: translations: zn_CN: irq-affinity.rst:
 add a missing extension
In-Reply-To: <22eadbe9fc99fffbd440714f2e4423a5519392a3.1634630486.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <22eadbe9fc99fffbd440714f2e4423a5519392a3.1634630486.git.mchehab+huawei@kernel.org>
Date:   Tue, 19 Oct 2021 15:20:17 -0600
Message-ID: <87czo0sodq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Without .rst extension, ./scripts/documentation-file-ref-check will produce
> a warning, and auto-generating cross-references by automarkup.py may not
> work.
>
> Fixes: 8137a49e1567 ("docs/zh_CN: Modify the translator tag and fix the wrong word")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
>
>  Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst b/Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst
> index 7addd5f27a88..36b085226d0b 100644
> --- a/Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst
> +++ b/Documentation/translations/zh_CN/core-api/irq/irq-affinity.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../../disclaimer-zh_CN.rst
>  
> -:Original: Documentation/core-api/irq/irq-affinity
> +:Original: Documentation/core-api/irq/irq-affinity.rst

Applied, thanks.

jon
