Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCC3C619B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhGLRPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhGLRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:15:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A628C0613DD;
        Mon, 12 Jul 2021 10:12:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4DC8136E;
        Mon, 12 Jul 2021 17:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4DC8136E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626109934; bh=GENBQY4du2/5sQ8IaBN99MefXBtrjByovb0MtqXhn+U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aMDfeutSvyJyAWfWy7nPBz3qkR3ic5xYhCvaJOed04aNtVuaxt7fr6LIQ7LKNraRw
         S2C5haz/4eiz3weYcTBnu8PaWuRM4QtVMMbTxZmAe0HF0UtpyaOiS/ErHWa41Y8Dte
         YtaKRtdkdccdr/1cdAzDUwiWJHfZny/ZT+2WjYjolp4oGz9v181T8xrF5ezEB+WNqf
         wPF/NcQ0qMSOXbo+WjRCEUBUNDVH1aQ4v6ZJlLgVuSwznbwp/hPV/GbOUSnW2uUv/1
         rVnMRdzfkES0pLgRSvdxasxbPhtgBnLOsgkTQucraB+brLF/ZXYkcWmWxjhCYZMxkl
         wqzcjoy3MfPxw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Jialun <hujialun@comp.nus.edu.sg>,
        =?utf-8?B?5byg5LmQ?= Zhang Le <r0bertz@gentoo.org>,
        Alex Shi <alexs@kernel.org>
Cc:     Hu Jialun <hujialun@comp.nus.edu.sg>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: Remove the Microsoft rhetoric
In-Reply-To: <20210703164834.460447-1-hujialun@comp.nus.edu.sg>
References: <20210703164834.460447-1-hujialun@comp.nus.edu.sg>
Date:   Mon, 12 Jul 2021 11:12:13 -0600
Message-ID: <87mtqrpic2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Jialun <hujialun@comp.nus.edu.sg> writes:

> Update Chinese translation on par with original English coding-style.rst
> Related commit b7592e5b82db19b72a34b471f3296ad3f651c8b9
>
> Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
> ---
> This is more of a crude first attempt to begin getting accustomed to
> mailing list conventions of open-source communities.
> While efforts have been made to conform to the patch submission
> conventions, there is still inevitably certain omissions.
> Any corrections and suggestions would be greatly appreciated! :)
>
>  Documentation/translations/zh_CN/process/coding-style.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

jon
