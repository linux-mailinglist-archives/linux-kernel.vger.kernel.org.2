Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7952B3D4FDD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 22:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhGYTsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 15:48:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:41872 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhGYTsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 15:48:15 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A2F7A2E5;
        Sun, 25 Jul 2021 20:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A2F7A2E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627244924; bh=zCOoUL2oZzQjAqQS9h7m+KprfsKRNBVSx8rMhiJuo9A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SMNyO7R6xpYwhabouHocTAZ/U4mUsX8rX1q3L/HqMOTWo2jS0odfIzSanNTo6b3fT
         p6AIvEW001pCSX2gugSDUdx6FESpXM6rW6jZVkKFdA5VwjC3AFVuhT+nNm4H/PQXqh
         Hftaky7UB64ChJEFucoykcE+S0RdKOB+U8wM5PunsccWqeWYdlCAeHHkYBIYJmgqRZ
         36wYQPDAONOxLVWIYvOb4eDb8x9Nk+4D6MZ8mQregYu1+dH5miiPcpsfCZrflv9lOY
         797tUz502hglyUl0DbImyXgobl5ZYissCwFrGUHNxH+yWSGD2cHI92MXGl+kYKGjj8
         oWdw6Oqw7lMVw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>, alexs@kernel.org
Cc:     bobwxc@email.cn, sterlingteng@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: reformat zh_CN/dev-tools/testing-overview
In-Reply-To: <20210724130611.4231-1-src.res@email.cn>
References: <20210723060328.16581-1-src.res@email.cn>
 <20210724130611.4231-1-src.res@email.cn>
Date:   Sun, 25 Jul 2021 14:28:44 -0600
Message-ID: <87wnpeuohv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res@email.cn> writes:

> Reorganise several long lines in order to satisfy the kernel coding
> style.
>
> Signed-off-by: Hu Haowen <src.res@email.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../zh_CN/dev-tools/testing-overview.rst          | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Applied, thanks.

jon
