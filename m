Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADD33C7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhCOUVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhCOUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:21:00 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6EC06174A;
        Mon, 15 Mar 2021 13:21:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6BE402E5;
        Mon, 15 Mar 2021 20:21:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6BE402E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615839660; bh=YM7+iJCyaR3Kgy/2lXgIddw6Qs0Wtx4bSayd637mJO0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CArspoU1TfpeCbM/TLgUyaXcM5/7V9YUFG5m8M6D0FBtY3srALSyxdeO49R0bByTp
         l9uVOj1k/BU5F+sfnPj7Y1Dc64qDlwse5f0UfX855gqAWBUpgh6WGYNmd+t1nEHhoU
         9sg8dQihEgYgE8DaeaO7kIh+P1dUgaXi3Oy5Y0y2pmzEyYEjgZ20uIP2NR8HBjI/V4
         bMUTCVAPjUVCh9khmkhuLn3rnV7FJECInK5Nk3rvrPCjhbMA3yV8eToBrxhVhI+vwj
         kIkgd0GWkSrh8pKE3WlHx90VOLD11LJeZSR/aG/0mDj10bDsyJyWVvOzcntBKYPMbZ
         dnb51CZPzW3NQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1, RFC] docs: reporting-issues.rst: tone down 'test
 vanilla mainline' a little
In-Reply-To: <20210310072858.231776-1-linux@leemhuis.info>
References: <20210310072858.231776-1-linux@leemhuis.info>
Date:   Mon, 15 Mar 2021 14:20:59 -0600
Message-ID: <874khc1844.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Tell users that reporting bugs with vendor kernels which are only
> slightly patched can be okay in some situations, but point out there's a
> risk in doing so.
>
> Adjust some related sections to make them compatible and a bit clearer.
> At the same time make them less daunting: we want users to report bugs,
> even if they can't test vanilla mainline kernel.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Randy Dunlap <rdunlap@infradead.org>
>
> ---
> With this I try to get rid of the last remaining parts that have a
> 'this needs discussion' box that's in the text. I hope I've found a
> middle ground that everybody can live with.

For the most part it seems OK to me.

I *really* worry, though, that this file is getting so big that few
people will work their way through it.  Anything that could be done to
make it more concise going forward would be more than welcome.

One other thing down below...

> v1, RFC
> * this version
> ---
>  .../admin-guide/reporting-issues.rst          | 273 ++++++++++--------
>  1 file changed, 149 insertions(+), 124 deletions(-)
>
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 18b1280f7abf..a475e014f9ca 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -94,10 +94,11 @@ early if an issue that looks like a Linux kernel problem is actually caused by
>  something else. These steps thus help to ensure the time you invest in this
>  process won't feel wasted in the end:
>  
> - * Stop reading this document and report the problem to your vendor instead,
> -   unless you are running the latest mainline kernel already or are willing to
> -   install it. This kernel must not be modified or enhanced in any way, and
> -   thus be considered 'vanilla'.
> + * Are you facing an issue with a Linux kernel a hardware or software vendor
> +   provided? Then in almost all cases you are better off to stop reading this
> +   document and reporting the issue to your vendor instead, unless you are
> +   willing to install the latest Linux version yourself. Be aware the latter
> +   will often be needed anyway to hunt down and fix issues.
>  
>   * See if the issue you are dealing with qualifies as regression, security
>     issue, or a really severe problem: those are 'issues of high priority' that
> @@ -134,12 +135,14 @@ process won't feel wasted in the end:
>  
>  After these preparations you'll now enter the main part:
>  
> - * Install the latest Linux mainline kernel: that's where all issues get
> -   fixed first, because it's the version line the kernel developers mainly
> -   care about. Testing and reporting with the latest Linux stable kernel can
> -   be an acceptable alternative in some situations, for example during the
> -   merge window; but during that period you might want to suspend your efforts
> -   till its end anyway.
> + * Unless you are already running the latest 'mainline' Linux kernel, better
> +   go and install it for the reporting process. Testing and reporting with
> +   the latest 'stable' Linux can be an acceptable alternative in some
> +   situations; during the merge window that actually might be even the best
> +   approach, but in that development phase it can be an even better idea to
> +   suspend your efforts for a few days anyway. Whatever version you choose,
> +   ideally use a 'vanilla' built. Ignoring these advices will dramatically
> +   increase the risk you report will be rejected or ignored.

s/built/build/

Also, I would stop quoting terms like "mainline", "stable" and "vanilla"
throughout.  It makes the reading experience a bit stranger without
(IMO) adding anything.

Thanks,

jon
