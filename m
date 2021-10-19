Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03416434067
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJSVXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:23:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12EC06161C;
        Tue, 19 Oct 2021 14:21:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7134D738;
        Tue, 19 Oct 2021 21:21:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7134D738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634678465; bh=ji7v3dUTgSj5LMhc6Ojf0I7as0hF4hA8KlhK6GQkbLo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UG4/lw7bGE/Imt5VVml9JCMFMu2zJwoVi2B+US7A2KRVnw/pTZ5rmh1TPaFMwiVkp
         FCzJfL7tBCLKfPpTeofQicg/n6siQb0HwuaeTL95h4L7ltU7M1xM2QcKQz3qTiyhuT
         SbjvjW5Hbkjy0klFlL2hdMipcAtkiKbJhSeC6EWup5niL8P7C4mXMjvpkFlXA/Clcf
         Xn420Hpe/hf8quEQSAtbNLuBkhh4rQNv8+eGhjFulNxMI6NBiYRXmvWROvs2Y0fkVO
         t7mHM64EKkIyzlR5UI3JaA06Xixoa6yhtI/UE7CagZo5GftPxj49DnhEmoB5wwwLLo
         3vnmP7mH/usLA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/23] docs: translations: zh_CN: memory-hotplug.rst:
 fix a typo
In-Reply-To: <b22b772c23f531708a9bc025d56c0312a53bd6c9.1634630486.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <b22b772c23f531708a9bc025d56c0312a53bd6c9.1634630486.git.mchehab+huawei@kernel.org>
Date:   Tue, 19 Oct 2021 15:21:04 -0600
Message-ID: <878ryosocf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> memory_hotplug.rst -> memory-hotplug.rst

Why do I feel we've been switching this around forever...?

> Fixes: 620127548a69 ("docs/zh_CN: add core api memory_hotplug translation=
")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>
> To mailbombing on a large number of people, only mailing lists were C/C o=
n the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git=
.mchehab+huawei@kernel.org/
>
>  Documentation/translations/zh_CN/core-api/memory-hotplug.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/core-api/memory-hotplug.rst=
 b/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
> index 9a204eb196f2..9b2841fb9a5f 100644
> --- a/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
> +++ b/Documentation/translations/zh_CN/core-api/memory-hotplug.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-zh_CN.rst
>=20=20
> -:Original: Documentation/core-api/memory_hotplug.rst
> +:Original: Documentation/core-api/memory-hotplug.rst
>=20=20
>  :=E7=BF=BB=E8=AF=91:

Applied, thanks.

jon
