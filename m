Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD4397CC1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhFAWzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhFAWzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:55:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF61DC061574;
        Tue,  1 Jun 2021 15:53:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A6086E2;
        Tue,  1 Jun 2021 22:53:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A6086E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622588018; bh=PTa73ReiH99pYqrE1NUMVlZagcYAcqSVKLM15m3VVHo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hbUmMXM6OdMXBpPnxLFx6bfsCLW0Y+OTwFzkhFHLgUIHW/m6QgjMaCAbGpenq5Bkr
         T1KM0VQy/Hmh8b06JGlfs3dqFVWJR/2/oOwPvARNPSsUmZGEblzTulh7VtgyjYLvnw
         K3j1n7lF74dHsYM/Y04MLb8etNLFDUaWdn8mZTv/5uGRBVzt4jGs9k1pg/nqzSEGTv
         nHmTDVFnpbhaAf81TiOs1yw8HpsB3OqGEXTh3i0zG8i1YAxJTYIfYVV6AqkhwV+KFJ
         L2O76w6R8klTxQnzfSozZxRBSkhKz2gqZT3Iswmu1r8ctcW2c8MQ4/xQ0wyB5u2xw4
         Fy9nVWRAWDP5A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Haocheng Xie <xiehaocheng.cn@gmail.com>, rostedt@goodmis.org,
        mingo@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haocheng Xie <xiehaocheng.cn@gmail.com>
Subject: Re: [PATCH] docs: Fix typos in Documentation/trace/ftrace.rst
In-Reply-To: <20210531083905.25763-1-xiehaocheng.cn@gmail.com>
References: <20210531083905.25763-1-xiehaocheng.cn@gmail.com>
Date:   Tue, 01 Jun 2021 16:53:37 -0600
Message-ID: <87a6o98adq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haocheng Xie <xiehaocheng.cn@gmail.com> writes:

> Fix the usage of "a/the" and improve the readability.
>
> Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
> ---
>  Documentation/trace/ftrace.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 62c98e9..11cc1c2 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -354,8 +354,8 @@ of ftrace. Here is a list of some of the key files:
>  	is being directly called by the function. If the count is greater
>  	than 1 it most likely will be ftrace_ops_list_func().
>  
> -	If the callback of the function jumps to a trampoline that is
> -	specific to a the callback and not the standard trampoline,
> +	If the callback of a function jumps to a trampoline which is
> +	specific to the callback and which is not the standard trampoline,

The "that" in the first line was actually correct and best left
unchanged.  I've applied the patch, but took the liberty of putting
"that" back.

Thanks,

jon
