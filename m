Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43613EA6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhHLO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhHLO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:57:52 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645FC061756;
        Thu, 12 Aug 2021 07:57:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 301DC44A;
        Thu, 12 Aug 2021 14:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 301DC44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1628780247; bh=csI+g0I7i+/PQ+uJiZXzwrLTH3TTq4CmgYgZRCtgHEw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kUZty8t2remczjo/K2FjOD4OBqbm+zzi/u8zz+Rzuig67nL9PSpUYNf6j7IC238W8
         uURZ+5nnJ5uDwArYO8NCDbKYVdts6LMuYbCMvzfmxpGURLq9gQ4XPIL7JBZpHbnIW/
         lDJIbSIEGFsuyvhZfOtegItIexEFbXSc3A9mrF71bVNx6OkhZB1R+7cwrnPQ6K2y+b
         NY8EGQacIpwGI+MP+q2SBEcFfN8PYJUf0m9B0WafIG4pecbNajVNuTNpR+9BwYb8gs
         sVL4RzxvXawoRIWvL3pBvWyKXG6Djpp9uALxvd2gbXhRHkSoFZYyvgtPHzScSEpv28
         VCykKFk9X09iA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     cgel.zte@gmail.com, alexs@kernel.org, siyanteng@loongson.cn,
        sterlingteng@gmail.com
Cc:     yang.yang29@zte.com.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] docs/zh_CN: Add zh_CN/accounting/psi.rst
In-Reply-To: <20210731084502.571451-1-yang.yang29@zte.com.cn>
References: <20210731084502.571451-1-yang.yang29@zte.com.cn>
Date:   Thu, 12 Aug 2021 08:57:26 -0600
Message-ID: <87wnoqzp61.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:

> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Add translation zh_CN/accounting/psi.rst and zh_CN/accounting/index.rst.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> v5: link accounting/index to top-level Chinese index.rst
> v4: delete wrong Reviewed-by
> v3: add reviewers
> v2: correct wrong format and add translations for code annotations
> ---
>  .../translations/zh_CN/accounting/index.rst   |  25 +++
>  .../translations/zh_CN/accounting/psi.rst     | 155 ++++++++++++++++++
>  Documentation/translations/zh_CN/index.rst    |   2 +-
>  3 files changed, 181 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/accounting/index.rst
>  create mode 100644 Documentation/translations/zh_CN/accounting/psi.rst

Applied, thanks.

jon
