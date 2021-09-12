Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79704407EF1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhILRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhILRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 13:30:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077BC061574;
        Sun, 12 Sep 2021 10:28:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A031B2CB;
        Sun, 12 Sep 2021 17:28:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A031B2CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1631467728; bh=Z93cyMUcOAaNaWs7wlKg4p0OMtDBsNw9FZrykDTTdeo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Laoic5faTcOU5xhvqSxr9jWZaRGqesd4HDpgIQNQpoOrfWSxMHFATIVrsqMls72V/
         lCuxxCP8uxA2+Mmd3aeksEe0svctduUMWjdjajvHi9pBnrBL05QdIed1f9yWHsWHnD
         76ECF4isWDCiubQEesrB0ThyNUQfvtPl3fFdEVfqcbwR7QYu4ACeeJJAWUOwP+1MSY
         VKIVi9PLCATN8st1x1jPzXZPTF6Ty9ifbo2P7B1xGCCLmUzvDdzup7l7XPHZyj+IoC
         ZBi54GE40YMYw3lKSMrmN1Z/3oaQJ36LKyj9+Ok5nYTrPn67LUAzyZIv4M5WtRp3zb
         gwJj2xXB/RbuA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Leo Yu-Chi Liang <ycliang@andestech.com>, src.res@email.cn,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     ycliang@cs.nctu.edu.tw, ycliang@andestech.com
Subject: Re: [PATCH 1/1] docs/zh_TW: Add translation for
 riscv/boot-image-header
In-Reply-To: <20210912155049.129774-1-ycliang@andestech.com>
References: <20210912155049.129774-1-ycliang@andestech.com>
Date:   Sun, 12 Sep 2021 11:28:47 -0600
Message-ID: <87v935n1o0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leo Yu-Chi Liang <ycliang@andestech.com> writes:

> From: Leo Yu-Chi Liang <ycliang@cs.nctu.edu.tw>
>
> Add Traditional Chinese for Documentation/riscv/boot-image-header.rst
>
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  .../zh_TW/riscv/boot-image-header.rst         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/translations/zh_TW/riscv/boot-image-header.rst
>
> diff --git a/Documentation/translations/zh_TW/riscv/boot-image-header.rst b/Documentation/translations/zh_TW/riscv/boot-image-header.rst
> new file mode 100644
> index 000000000000..86519d3c4f3b
> --- /dev/null
> +++ b/Documentation/translations/zh_TW/riscv/boot-image-header.rst

When you add new RST files you *always* have to add them to the
index.rst file to include them in the docs build.  Please always test
the docs build and be sure your changes work before sending them.

Thanks,

jon
