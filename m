Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936DD37FAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhEMP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhEMP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:28:41 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B884C061756;
        Thu, 13 May 2021 08:27:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E4B6D2E7;
        Thu, 13 May 2021 15:27:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E4B6D2E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620919651; bh=k8SMaQe5QJRfP4QfPx7FriwV1OFFuTOejTKjMmLhKTs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UG+tSqEtPnczVmPl4dfkO/uAeKKW+7r/OYiB/3Rmrg7nQhzoC4gw25ktzMJLJC5Jf
         0+YbUHEyOxehKAIl/1oR+b0Ku/SAQMu6zQiIoygu8rkpp0oCtHEOxx4QEhuYT3x8Th
         vQGhHM7aKv1onT8ux5eWNqTTBbGmibAIrm5AnNdmFmBcBdURZmMUpFjjhj9Vk+eJUk
         qmPYueAcUdUOqr/AabmkPrO/DtHgVHFJUysLzWhFdDSlFEEtacSgiMjYsCgUp1GSQO
         IX+hZNgEYbagRRQiBj0A8ahHLWFacTIEssXt43qQUdiGbB0pE31FJoJH7Sa+pKuj1R
         8Wvldf9GpuKGQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wan Jiabing <wanjiabing@vivo.com>, Alex Shi <alexs@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: Re: [PATCH] docs/zh_CN: fix reference file and update translations
In-Reply-To: <20210506081414.14004-1-wanjiabing@vivo.com>
References: <20210506081414.14004-1-wanjiabing@vivo.com>
Date:   Thu, 13 May 2021 09:27:30 -0600
Message-ID: <874kf67ixp.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> writes:

> In commit da514157c4f06 ("docs: make reporting-bugs.rst obsolete"),
> reporting-bugs.rst was deleted and replaced by reporting-issues.rst.
>
> In commit cf6d6fc279360 ("docs: process/howto.rst: make sections on
> bug reporting match practice"), related sections were adjusted.
>
> Fix the reference file and update some translations.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  .../translations/zh_CN/process/howto.rst         | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Applied, thanks.

jon
