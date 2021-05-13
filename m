Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1F37FA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhEMPYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhEMPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:24:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18A8C061574;
        Thu, 13 May 2021 08:23:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 91724153;
        Thu, 13 May 2021 15:23:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 91724153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620919402; bh=nCLDeCCv39g0a3SBIn30K6a6wMHFoEfUP22lU3VdG0E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZQcDFVMtPryOuy1uWN+52z4pCdeqPQnkV0nns8YJUifoBCi2aS4lKYUFUCNQvNq1F
         UMPrnVJ5NUyGSEIA3/ALJLwlV6fR7mqSTAUg7Jl0PqcxqnC3CIijOTbPhUpQVtgBQk
         EK77GjZjmtM/8oZ62RLOfn2CgPCV7BZX2P4FNzKvoNcn2iGn9aiEnGbmN95ynECjh+
         33LVthL5y9iWwdJtPjvV0/FkCxgLK4euOAjBQtCn6No1d08N58AkYACZMnlydmS5G2
         ygXCKy4OS8gAia0BHecOu4VpIMpOHhPmGZwL6CbRE5rfdLsMhNFc8wJph1fvMbrMNc
         bKoU+ueknyd1Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: update description for
 kernel.hotplug sysctl
In-Reply-To: <20210420120638.1104016-1-linux@rasmusvillemoes.dk>
References: <20210420120638.1104016-1-linux@rasmusvillemoes.dk>
Date:   Thu, 13 May 2021 09:23:21 -0600
Message-ID: <87cztu7j4m.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:

> It's been a few releases since this defaulted to /sbin/hotplug. Update
> the text, and include pointers to the two CONFIG_UEVENT_HELPER{,_PATH}
> config knobs whose help text could provide more info, but also hint
> that the user probably doesn't need to care at all.
>
> Fixes: 7934779a69f1 ("Driver-Core: disable /sbin/hotplug by default")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 1d56a6b73a4e..c24f57f2c782 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -333,7 +333,12 @@ hotplug
>  =======
>  
>  Path for the hotplug policy agent.
> -Default value is "``/sbin/hotplug``".
> +Default value is ``CONFIG_UEVENT_HELPER_PATH``, which in turn defaults
> +to the empty string.
> +
> +This file only exists when ``CONFIG_UEVENT_HELPER`` is enabled. Most
> +modern systems rely exclusively on the netlink-based uevent source and
> +don't need this.

Applied, thanks.

jon
