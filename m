Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC67831916F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhBKRrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhBKRH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:07:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5F0C061788;
        Thu, 11 Feb 2021 09:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=6WEYQQb0H1BdtLvpRHOyUD9ECxFdkNdhBC5U4O1Uj+w=; b=q/OrS2NZDj1wxWUThBwO3Etocq
        /K3l52ZG+S5qOHsivKptiNrCujvRiupPXHyq1YUBXdXd22PRnY2XXkmQi1UY93wihy03yjy7mRBZ0
        MA6QoDj1ceeJ5g8FUoSA3reBvzSoSwGfPGNc9X1aprNYn/Elcabo1I/yzJBNOXvnUhu86630h2q6h
        qvMp4R33i1HJksidEe7ScaLwIQt1dNDXGHE3mvj/HtH+FN3l7va38qYJujPccZohi1Imd9ck0esAE
        F+Es+wBaPjt6py6+U34ZTqDEM6OS89z+CNTq7XTbKtbUXp4O7gFdwakfUrcSFga/tL8iDjzUJxCql
        OMpqZu1w==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAFQs-0001uw-MB; Thu, 11 Feb 2021 17:07:11 +0000
Subject: Re: [PATCH] docs: reporting-issues.rst: explain how to decode stack
 traces
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joerg Roedel <joro@8bytes.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Damian Tometzki <linux@tometzki.de>
References: <20210210054823.242262-1-linux@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bd9a3e43-d52f-d947-04bc-28d4cc524cb4@infradead.org>
Date:   Thu, 11 Feb 2021 09:07:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210210054823.242262-1-linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

Just a couple of small nits (or one that is repeated):

On 2/9/21 9:48 PM, Thorsten Leemhuis wrote:
> Replace placeholder text about decoding stack traces with a section that
> properly describes what a typical user should do these days. To make
> it works for them, add a paragraph in an earlier section to ensure
> people build their kernels with everything that's needed to decode stack
> traces later.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 77 +++++++++++++------
>  1 file changed, 55 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 07879d01fe68..b9c07d8e3141 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -154,8 +154,8 @@ After these preparations you'll now enter the main part:
>     that hear about it for the first time. And if you learned something in this
>     process, consider searching again for existing reports about the issue.
>  
> - * If the failure includes a stack dump, like an Oops does, consider decoding
> -   it to find the offending line of code.
> + * If your failure involves a 'panic', 'oops', or 'warning', consider decoding
> +   the kernel log to find the line of code that trigger the error.

                                                   triggered

>  
>   * If your problem is a regression, try to narrow down when the issue was
>     introduced as much as possible.
> @@ -869,6 +869,15 @@ pick up the configuration of your current kernel and then tries to adjust it
>  somewhat for your system. That does not make the resulting kernel any better,
>  but quicker to compile.
>  
>  
>  Check 'taint' flag
>  ------------------
> @@ -923,31 +932,55 @@ instead you can join.
>  Decode failure messages
>  -----------------------
>  
> -.. note::
> +    *If your failure involves a 'panic', 'oops', or 'warning', consider
> +    decoding the kernel log to find the line of code that trigger the error.*

                                                             triggered


or it could be "code that triggers"... (just not "trigger").


-- 
~Randy

