Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063BC3F372F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhHTXHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhHTXHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:07:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77067C061575;
        Fri, 20 Aug 2021 16:06:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 320BC304D;
        Fri, 20 Aug 2021 23:06:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 320BC304D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1629500790; bh=P484nEup8mwy7o/GlnCfNrpRd2m85VLTrnFKH46PfH8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sAo3MuqW+YPbPfuXXePJiOyuKqkQwP5YIcfAd9f43Qvc235P/pJqVLQ/i1tD0KpEN
         pe/dr6VXjlNNdB9LMXM0OYtJ7zL3HkGFCNharqObSYD0kiSgYVlyJMd9DCoW7ETf+W
         TZg7dTpEW2NqQp+H14SeAwzHoWihD4sqRRHkXqDgTMHCBpII59ErIahvHkr22VHkjI
         IneY4hqglN8uGxCSgCqknUKPfwtRrVeu+OE05w6UOOVJdsgXMY/Y3isj2RvTbLMHdP
         +OASwNJTn4rqbWzTLB+C1oMoq8vcRpLe08csMTvlyps4AGNtfa4Iy17bzsQIpxc/Vh
         y7p+EEnKA+uJA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chun-Hung Tseng <henrybear327@gmail.com>
Cc:     jmseyas@dit.upm.es, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, henrybear327@gmail.com
Subject: Re: [PATCH v3] Documentation: Update details of The Linux Kernel
 Module Programming Guide
In-Reply-To: <20210820222152.971174-1-henrybear327@gmail.com>
References: <20210820222152.971174-1-henrybear327@gmail.com>
Date:   Fri, 20 Aug 2021 17:06:29 -0600
Message-ID: <87zgtbpvgq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Hung Tseng <henrybear327@gmail.com> writes:

> Recently, the content and examples of the book "The Linux Kernel Module
> Programming Guide" are being actively maintained and added on Github[1].
> Currently, the book is being regularly built into webpage and pdf
> file using Github static page[2].
>
> [1]: https://github.com/sysprog21/lkmpg
> [2]: https://sysprog21.github.io/lkmpg/
>
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> ---
>  Documentation/process/kernel-docs.rst | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 22d9ace5df2a..dd911cf09b55 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -126,15 +126,17 @@ On-line docs
>          describes how to write user-mode utilities for communicating with
>          Card Services.
>  
> -    * Title: **Linux Kernel Module Programming Guide**
> +    * Title: **The Linux Kernel Module Programming Guide**
>  
> -      :Author: Ori Pomerantz.
> -      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
> -      :Date: 2001
> +      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
> +      Jim Huang.
> +      :URL: https://sysprog21.github.io/lkmpg/
> +      :Date: 2021
>        :Keywords: modules, GPL book, /proc, ioctls, system calls,
>          interrupt handlers .
> -      :Description: Very nice 92 pages GPL book on the topic of modules
> -        programming. Lots of examples.
> +      :Description: A very nice GPL book on the topic of modules
> +        programming. Lots of examples. Currently the new version is being
> +        actively maintained at https://github.com/sysprog21/lkmpg.

I have applied this, thanks.

That said, this change introduced a set of build warnings:

    Documentation/process/kernel-docs.rst:132: WARNING: Field list ends without a blank line; unexpected unindent.
    Documentation/process/kernel-docs.rst:136: WARNING: Unexpected indentation.
    Documentation/process/kernel-docs.rst:137: WARNING: Block quote ends without a blank line; unexpected unindent.

To fix that, I had to do this:

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index dd911cf09b55..da9527502ef0 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -129,7 +129,7 @@ On-line docs
     * Title: **The Linux Kernel Module Programming Guide**
 
       :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
-      Jim Huang.
+        Jim Huang.
       :URL: https://sysprog21.github.io/lkmpg/
       :Date: 2021
       :Keywords: modules, GPL book, /proc, ioctls, system calls,

Please, be sure to test the docs build before sending patches.

Thanks,

jon
