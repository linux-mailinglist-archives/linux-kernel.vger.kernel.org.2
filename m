Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D184358B92
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhDHRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhDHRlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:41:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7EEC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:41:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8C2A752B9;
        Thu,  8 Apr 2021 17:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8C2A752B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617903699; bh=+UZJeapSw6RbnfzFuHAaOLfr2SkD2daYHCQEMl3vFTQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iOGSTk8x0e40stKHIy9yWOjRboH+cW/Y473ASTl+jM0zSU/AlpG93NunRk+vsF0Rj
         PomY0fptUU2mW7OgRkaLoUJ58eb0DKYo+ybJ38MRTcP5eGyJF56MvbwrsP64JOX9TU
         ZrMY3WCsZZ/L7pfLLon2tl9gemONlIVaVSjtVC5vIY34BMgX/4pJqMM37N60G7csIE
         G7WkUds9ZL7WbRmG/os6x3zhnNUWL8EbrkFYRdppQMOc3JuvVADIXAcZux7JahxiIt
         +sbJUZsgrc8KOKZwMcWTiROJJgfdAoMzeEN6k4fFwE0Bm0kdu89qAZ9KHvA0bxBhUQ
         KUYgqOvj0t0+Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: Re: [PATCH] tools: Fix a typo in kernel-chktaint
In-Reply-To: <20210402070514.336376-1-standby24x7@gmail.com>
References: <20210402070514.336376-1-standby24x7@gmail.com>
Date:   Thu, 08 Apr 2021 11:41:39 -0600
Message-ID: <871rbkznak.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masanari Iida <standby24x7@gmail.com> writes:

> This patch fixes a spelling typo in kernel-chktaint
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  tools/debugging/kernel-chktaint | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 607b2b280945..719f18b1edf0 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -25,7 +25,7 @@ if [ "$1"x != "x" ]; then
>  	elif  [ $1 -ge 0 ] 2>/dev/null ; then
>  		taint=$1
>  	else
> -		echo "Error: Parameter '$1' not a positive interger. Aborting." >&2
> +		echo "Error: Parameter '$1' not a positive integer. Aborting." >&2
>  		exit 1

Applied, thanks.

jon
