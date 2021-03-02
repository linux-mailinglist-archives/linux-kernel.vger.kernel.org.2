Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299B932AD4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384252AbhCBVfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350300AbhCBSnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:43:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730ADC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:43:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so2609325pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qaYU5ZzeE5zbqFCyLzv3wI18v5WxmwBBNA3YgsmpLlI=;
        b=A4cMHEy/WPGNNldlmPvdCyL8qJBDPbBr4PqhrT29EGjlHnQPdNJoxViUDQYSEUlyNI
         4LODiReAE/+oRoAqmQiwxdRUXb50K8HTQraT7ADeca8U6+fSa8iixrPCz2bHmlu6jLfT
         itjBQGSySkANugOeStoNnEJmRSO9wTNF99x7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qaYU5ZzeE5zbqFCyLzv3wI18v5WxmwBBNA3YgsmpLlI=;
        b=iQpbYNWGLemEYA52zq6JY9CJdKe3ItHWE9ozs3uzp+Go7OFVeTmjPgvO1z6cnfXYKX
         Oc3wrh0HGJLGg1WxziQXZvUzmWR7tm77gxLqHJPFrGGQAs2wrDEVs/D0eaQQSclq0R5t
         V13NiwZhtgE7zUHQ9g97ur1PohAsA4EJ8tDxl//2dhah7tqrT/sQOf7uyYzJFJ7z5Qrk
         1RWucdSY+CGWw3I9zSWspZJ68vgKrTcrA8PM4VA7OKwNM14P/KLYDKyt6C04+pR8GDMo
         CNzKfLG3h6rjnOx1thp1rypJ82qpub3hqyx/YgKt+ygTLgPQVh5GuBy6PryltqflirCD
         wuiQ==
X-Gm-Message-State: AOAM530OaNifw2qhiHuJVBU9tWEz9qKXYBAsEamo7IiH1dtjM5Yg8+Bq
        0OateEOQFdh0Qqq+sZa7Ba/59Q==
X-Google-Smtp-Source: ABdhPJw9bvtXVLykthKPXQgOFU9KJFF+Xd6wYvOLOi4V32IeSZRg53OPDLXt09vUxXzmq80DTsJluw==
X-Received: by 2002:a17:902:f688:b029:e4:bde1:1730 with SMTP id l8-20020a170902f688b02900e4bde11730mr4815345plg.41.1614710580860;
        Tue, 02 Mar 2021 10:43:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a136sm21760323pfa.66.2021.03.02.10.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 10:43:00 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:42:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH AUTOSEL 5.11 31/52] x86, build: use objtool mcount
Message-ID: <202103021042.CBF1600@keescook>
References: <20210302115534.61800-1-sashal@kernel.org>
 <20210302115534.61800-31-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302115534.61800-31-sashal@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 06:55:12AM -0500, Sasha Levin wrote:
> From: Sami Tolvanen <samitolvanen@google.com>
> 
> [ Upstream commit 6dafca97803309c3cb5148d449bfa711e41ddef2 ]
> 
> Select HAVE_OBJTOOL_MCOUNT if STACK_VALIDATION is selected to use
> objtool to generate __mcount_loc sections for dynamic ftrace with
> Clang and gcc <5 (later versions of gcc use -mrecord-mcount).
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This one doesn't make sense without all the other objtool changes for
it. Please drop this from autosel.

-Kees

> ---
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 21f851179ff0..300a9b5296fe 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -168,6 +168,7 @@ config X86
>  	select HAVE_CONTEXT_TRACKING		if X86_64
>  	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
>  	select HAVE_C_RECORDMCOUNT
> +	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
> -- 
> 2.30.1
> 

-- 
Kees Cook
