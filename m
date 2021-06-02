Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF95939902A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFBQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhFBQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:40:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CAC061574;
        Wed,  2 Jun 2021 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=91h4N1sKM1YP4rXZHIR8cJXk05tTexl20hslj5nsFkk=; b=KkrS31d03jzgZslNhyqet2ZIeD
        BunS44chkiy++7cp3zaasTg3MzK+r+mnEFcREioMtJOHMEyCZqCRe8ivvts4qLL9egr51MCjJ2+sj
        ethEpAsEZTNfDXXte6WgPWJAk4zGC1xTFuyWE9E3sMa3DcbfIH9SBRVRoPhoALlQbXPfUjzBC1I/R
        XjyRNTE07M6Bxs3jJBsa88mA3j0CGy9bfl/FWlgyd4ywb1OxRrkatPlzyUlzw3VjNAybwdLwlxnUP
        bImVrFbFI94NYQXib3S4MItst5XnkkI70rh5QEbi1b1uDeIwL5VZ59w3krA2MtI0lsDaVM2mvxON9
        DsOimA/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loTsv-002w1H-1c; Wed, 02 Jun 2021 16:38:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBE8B30019C;
        Wed,  2 Jun 2021 18:38:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B067520223DAB; Wed,  2 Jun 2021 18:38:29 +0200 (CEST)
Date:   Wed, 2 Jun 2021 18:38:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Lepton Wu <ytht.net@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] docs: accounting: update delay-accounting.rst
 reference
Message-ID: <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 05:43:13PM +0200, Mauro Carvalho Chehab wrote:
> When :doc: is used, the .rst should be removed. Also, the patches
> are relative to the current directory.
> 
> So, the right reference should be:
> 
> 	:doc:`/accounting/delay-accounting`
> 
> Fixes: fcb501704554 ("delayacct: Document task_delayacct sysctl")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index b2057173fe07..7f36cba3204b 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1097,7 +1097,7 @@ task_delayacct
>  ===============
>  
>  Enables/disables task delay accounting (see
> -:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
> +:doc:`/accounting/delay-accounting`). Enabling this feature incurs

This breaks any chance of using 'goto file' like features in text
editors :/ Can we please not do crap like this.
