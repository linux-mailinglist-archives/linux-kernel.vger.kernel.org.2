Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE333B8ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhF3XJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhF3XJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:09:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E45AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 16:06:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g24so2927769pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RuO4JUZ+FX7giReeuhXb2PopY/hRsvujLpGRixSjArU=;
        b=TONRcXHxn5CIhUD92++R45hGlhM6XWfsZ2e7kI9CufKonbQD+LigLT1FSb/YawlY9+
         /PZdIIJvuBIew6OSwzEswA//AWNa4n/SnGMegbDON6KlsWVX2Hl0T6zyTn3M0EYh0vFu
         wJLpmvNZnVmEUeMEk9SdPeJSrajHet8eAbo8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RuO4JUZ+FX7giReeuhXb2PopY/hRsvujLpGRixSjArU=;
        b=XOURdLlSWQIZ8vzrFCtV+l6CYLY0vuFEEnnWiRNIyNhRkOazaklcbb6L65uv35gFJq
         OOCTqhSNkuQLQpt62H/tiu88JuyBiGSBitinEiqoEFqfjhSKXhz91HsN9SfdSwS1Ctvz
         271mdT2mBRxABxJt6T0TSrFJnPlVv4xHK1qnwshIVUvfXVSpU4J4+/OeUBn1aJ1EAsGd
         ldtXMIM6mEibXByrxWB58YCS/JlXAw8dUAnens68uXGtL8kxUyTHgQmebkx88mvNaGi8
         pLWzGbJ9DnY8mac9jV8uQNNK0Suus44N86sKBoE27S7yxYHg1iOuBhfCd9tm6c4mDg6G
         hWmw==
X-Gm-Message-State: AOAM530rdEBavSVWbbKJ70z26ci+92GyxA7+TB64wTAMFr39189S3aXK
        ONXcKRxMKnSuZMChrr52eGZp6Q==
X-Google-Smtp-Source: ABdhPJzXWAume3jqDZOat+M85hkUOSkfZfyzmUQzN1cAibRyEKMv4X5Q9IPaNHkQ0bijfz9Bd9k9bw==
X-Received: by 2002:a17:90b:230a:: with SMTP id mt10mr6482633pjb.236.1625094417844;
        Wed, 30 Jun 2021 16:06:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6sm24343279pgh.34.2021.06.30.16.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 16:06:57 -0700 (PDT)
Date:   Wed, 30 Jun 2021 16:06:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-api@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp.2:  Clarify that bad system calls kill the thread
Message-ID: <202106301606.E710FF81EC@keescook>
References: <87r1gkp9i7.fsf@disp2133>
 <202106292156.9458CF22@keescook>
 <87k0mbp0yc.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0mbp0yc.fsf_-_@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 03:11:23PM -0500, Eric W. Biederman wrote:
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  man2/seccomp.2 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/seccomp.2 b/man2/seccomp.2
> index a3421871f0f4..bde54c3e3e99 100644
> --- a/man2/seccomp.2
> +++ b/man2/seccomp.2
> @@ -69,9 +69,10 @@ The only system calls that the calling thread is permitted to make are
>  .BR exit_group (2)),
>  and
>  .BR sigreturn (2).
> -Other system calls result in the delivery of a
> +Other system calls result in the termination of the calling thread,
> +or termination of the entire process with the
>  .BR SIGKILL
> -signal.
> +signal when there is only one thread.
>  Strict secure computing mode is useful for number-crunching
>  applications that may need to execute untrusted byte code, perhaps
>  obtained by reading from a pipe or socket.

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
