Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90293F3209
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhHTRL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhHTRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:11:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D5C061575;
        Fri, 20 Aug 2021 10:10:48 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 29A6D5ED5;
        Fri, 20 Aug 2021 17:10:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 29A6D5ED5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1629479447; bh=rZCez0/eKtXqruR3YYLSS/hJHgzgGV3jQ8YZ6fvQviE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SoPc3VFOn+Qe6PKabZc4FGef5QDQ/OsrszvBdDo+pKvmUCNBmK1yJPDPxlNfnAU4y
         XsSZ+MUaxyirJUr8MGqNSBddaduiHTF1+JFO/0afYZIvAjeNw6WBTJVGezrswgiegn
         tQV4nnivJTf8t0Xyd2BsTd3NizvIoJ6TAAopffzp9vfajF8zi9hQMXx2rgQZLZBLLA
         IwgFN1YzpdxiwAaCjyXxqiWYEc4ADizz4tarTufoxuZKa9PUcBIgg6HjrDoBXX8Yfw
         3jCLyt8bYEYoihEKEkJba3cO8OLWaoTaoz0VGVx2BFARscBV5dyarHtY+zIwMSKa84
         055uwGqj9Bxpg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 1/2] Documentation/process/applying-patches: Activate
 linux-next man hyperlink
In-Reply-To: <20210812095030.4704-1-sj38.park@gmail.com>
References: <20210812095030.4704-1-sj38.park@gmail.com>
Date:   Fri, 20 Aug 2021 11:10:46 -0600
Message-ID: <87k0kgrqi1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj38.park@gmail.com> writes:

> From: SeongJae Park <sjpark@amazon.de>
>
> There is a url for linux-next in the 'applying-patches.rst', but it's
> surrounded by backquotes.  So the url doesn't have a hyperlink in the
> built document.  To let readers easily move to the page, this commit
> puts the url outside of the backquotes so that a hyperlink to the url
> can be automatically made.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/process/applying-patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
> index 2e7017bef4b8..c2121c1e55d7 100644
> --- a/Documentation/process/applying-patches.rst
> +++ b/Documentation/process/applying-patches.rst
> @@ -389,7 +389,7 @@ The -mm patches are experimental patches released by Andrew Morton.
>  
>  In the past, -mm tree were used to also test subsystem patches, but this
>  function is now done via the
> -`linux-next <https://www.kernel.org/doc/man-pages/linux-next.html>`
> +`linux-next` (https://www.kernel.org/doc/man-pages/linux-next.html)
>  tree. The Subsystem maintainers push their patches first to linux-next,
>  and, during the merge window, sends them directly to Linus.

Applied, thanks.

jon
