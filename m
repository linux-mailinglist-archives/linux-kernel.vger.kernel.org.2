Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E342ADA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhJLULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhJLULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:11:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE94C061570;
        Tue, 12 Oct 2021 13:09:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EBFA7867;
        Tue, 12 Oct 2021 20:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EBFA7867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634069356; bh=zxIqeYDiMyPPDwY3JGMtAhMaTDV44x2D+hOurfXa1sk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e1HqYa43JiBAiw8JnNonutF/hvyDK2r/lr0romX6CuVuCPkhHtmPDihnjQwhJFHJm
         CnQn72kHvTN72RNoLQCUwKGk/IARriNkQ0d7YLL2apzciF0GLD6Z+TzVfNuKU8rFEb
         0JpW3YkY02dq4w24dH1w7HsPyF4zbwMl+4i8socpxXy2sapfJET1BtQ2qbqn9sOVfM
         VK7mweXTwbIawz7J/EPoZEAbDHhRe2GcH55Vuy4x3doycTKkAjfRMSpnCH5UtTTAF/
         yP0QWIVUldB+GmeuaitLrKSeZ+wwjOFy+3ceLYsi5nM220TKZeuRfLOIvjRol1zpl8
         +AcAx71gB1nLA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: pdfdocs: Adjust \headheight for fancyhdr
In-Reply-To: <c5a5577e-5de8-9cd4-9253-956ccc748417@gmail.com>
References: <c5a5577e-5de8-9cd4-9253-956ccc748417@gmail.com>
Date:   Tue, 12 Oct 2021 14:09:15 -0600
Message-ID: <87wnmit384.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Fancyhdr prior to v4.0 outputs a message per document as follows:
>
>     Package Fancyhdr Warning: \headheight is too small (12.0pt):
>     Make it at least 13.59999pt.
>     We now make it that large for the rest of the document.
>     This may cause the page layout to be inconsistent, however.
>
> Fancyhdr v4.0 complains (once a page!) as follows:
>
>     Package fancyhdr Warning: \headheight is too small (12.0pt):
>     (fancyhdr)    Make it at least 13.59999pt, for example:
>     (fancyhdr)    \setlength{\headheight}{13.59999pt}.
>     (fancyhdr)    You might also make \topmargin smaller to compensate:
>
>     (fancyhdr)    \addtolength{\topmargin}{-1.59999pt}.
>
> Related item in fancyhdr v4.0 announcement on 2021-01-04 [1]:
>
>     Backward incompatible changes:
>       - Eliminate adjustments of \headheight or \footskip, when the
>         header or footer is too high.
>
> [1]: https://www.ctan.org/ctan-ann/id/mailman.2685.1609863692.2532.ctan-ann@ctan.org
>
> Silence the warnings by adding a couple of \addtolength commands in
> the preamble.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> Hi,
>
> This update doesn't have much visual effects in the final PDFs
> (adjustment of only 1.6pt), but getting rid of harmless warnings
> would help spot potential important ones.
>
> Tested against Sphinx versions 2.4.4 and 4.2.0, with Tex Live
> versions 2017/debian (Ubuntu 18.04), 2019/debian (Ubuntu 20.04),
> and vanilla 2021 (as of 2021-10-08).
>
>         Thanks, Akira
> --
>  Documentation/conf.py | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

jon
