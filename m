Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9520B39BE73
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhFDRVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:21:24 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486BC061766;
        Fri,  4 Jun 2021 10:19:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A63D34A6;
        Fri,  4 Jun 2021 17:19:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A63D34A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622827177; bh=ZlKodG2CyaPye6gRNPqLCUaKh7cngmOG3O1y5v31uIk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZZWqnGdVhrdQlE1FnRUM4G6Kxfm/9UAk4/EsRtStnZiXnSeOBOR5K/fvoOBtR+w0g
         r7ZZ6b76FrMlouiKoFaupgpBeQh323Xs+BLKEa/j1ZCOA5obIoKOOl5DAEvwlMb005
         il42RyCH/VEO9/1Rj0Bprt1nzPZ8THv0NGD2cBxJu7kflRjwiS+Lk+ieDtjcqJJira
         YKceF6ApUYxatg7AFvtSytSyck3qzQ7EyxYUr/7ceaQbTmM8rfnM6NXXBeRcTJLOqd
         LD8zjbAMI2WW/OTcKUbaUKfdW4NiMY1nQviWJeeSOhvb5yVwRQZ0u/M1b0Dn6p5f7X
         uZ6ZDcpvWZ4uw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hailong Liu <liuhailongg6@163.com>, Alex Shi <alexs@kernel.org>,
        sterlingteng@gmail.com
Cc:     siyanteng@loongson.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: Re: [PATCH v4] docs/zh_CN: Add zh_CN/admin-guide/lockup-watchdogs.rst
In-Reply-To: <20210603145227.30956-1-liuhailongg6@163.com>
References: <20210603145227.30956-1-liuhailongg6@163.com>
Date:   Fri, 04 Jun 2021 11:19:37 -0600
Message-ID: <87v96tzgwm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hailong Liu <liuhailongg6@163.com> writes:

> From: Hailong Liu <liu.hailong6@zte.com.cn>
>
> Add translation zh_CN/admin-guide/lockup-watchdogs.rst and link it to
> zh_CN/admin-guide/index.rst while clean its todo entry.
>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> ---
>
> changes since v3:
>  - add "Reviewed-by" tag and change log
>
> changes since v2:
>  - fix the "Original:" item and the title of this tranlation
>    which suggested by Yanteng.
>
> changes since v1:
>  - fix the quite a lot of style issues and poor translation issues.
>
> Big thanks to Yanteng for review and suggestions.
> ---
>  .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>  .../zh_CN/admin-guide/lockup-watchdogs.rst    | 66 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/admin-guide/lockup-watchdogs.rst

Applied, thanks.

jon
