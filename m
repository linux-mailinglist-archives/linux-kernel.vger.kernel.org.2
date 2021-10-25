Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFD43A501
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhJYUwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhJYUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:52:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A3CC061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:49:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t184so12101148pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J/0aP2Daq6xhKNhA39WstqFWhNYtSs2hRE8Jp5q5DoY=;
        b=dtxXQ7Ub3zdGl3b04fy6YEx0aHHMrBMBkkt23P6YsZTh3WfRJYLcyNVs5iDmgrZ3Z7
         fVY8qw4w5yZt/rKdwA6I+WKzsMPib9tyPV1GmQQqJogTX0JO5cCf1ERELG+oPL5pgTCd
         9hFngNVhMxmz8TWjGYgLOY6R5ycNlXcKnwIQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J/0aP2Daq6xhKNhA39WstqFWhNYtSs2hRE8Jp5q5DoY=;
        b=LM3OzCd7AobUuD5PaGSg3rkBS7Cwb9doWsmwTDolUN7DgeLhVITEN7qm6PDx6x/THL
         YjziMyXqwywjdHzs/5e0JVNv8o5jQo1tiuriz3snoEnUXnHqomXz9MOfYwcIAbYz69Wn
         iU/dwx0C/5NEtYCm+eIMb2istkbUpMfHH506ph8jVQ0nw08sMRMf35sBO5Q+Fu48DiHC
         90kOL2vOB/443CiRevH+a5CKoVR+hvUg1S7WbMg7eOXrBiiP0wn4dmRf3uDwMCh4H2Hu
         KQq698OfRJ3ya2UVV0l7k6yGhBcbCOXsrFrpFA5WM6c3kTgTIsAeLLRzvjclHeHHPOes
         u19A==
X-Gm-Message-State: AOAM533KDItjpVUWTp11ViOu/1N86acAgmVgF8OpX2ackXOqZkK6Fk65
        7S9dd/l9Xxc5fvcsto/MSXVmCw==
X-Google-Smtp-Source: ABdhPJw+BIDmVf9GdkUCQfH3wD8OFMdfl2X2bWyiJEa54xASQ0xV+phFxbdJxrC/m9dry6U1wvnXqw==
X-Received: by 2002:a63:9245:: with SMTP id s5mr15651942pgn.4.1635194998482;
        Mon, 25 Oct 2021 13:49:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ng5sm19584034pjb.51.2021.10.25.13.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:49:58 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:49:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Avoid shadowing previous locals
Message-ID: <202110251346.1E6F4CB6@keescook>
References: <20211025183728.181399-1-quic_qiancai@quicinc.com>
 <202110251232.652ACB6@keescook>
 <cd68c514-544d-c29f-d435-78e31f6a173c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd68c514-544d-c29f-d435-78e31f6a173c@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:15:28PM -0400, Qian Cai wrote:
> 
> 
> On 10/25/21 3:34 PM, Kees Cook wrote:
> > On Mon, Oct 25, 2021 at 02:37:28PM -0400, Qian Cai wrote:
> >> __compiletime_strlen macro expansion will shadow p_size and p_len local
> >> variables. Just rename those in __compiletime_strlen.
> > 
> > They don't escape their local context, though, right? i.e. I don't see a
> > problem with the existing macro. Did you encounter a specific issue that
> > this patch fixes?
> 
> Yes, this is pretty minor. There are also some extra compiling warnings (W=2)
> from it.
> 
> ./include/linux/fortify-string.h: In function 'strnlen':
> 
> ./include/linux/fortify-string.h:17:9: warning: declaration of 'p_size' shadows a previous local [-Wshadow]
> 
>    17 |  size_t p_size = __builtin_object_size(p, 1); \
> 
>       |         ^~~~~~
> 
> ./include/linux/fortify-string.h:77:17: note: in expansion of macro '__compiletime_strlen'
>    77 |  size_t p_len = __compiletime_strlen(p);
> 
>       |                 ^~~~~~~~~~~~~~~~~~~~
> 
> ./include/linux/fortify-string.h:76:9: note: shadowed declaration is here
> 
>    76 |  size_t p_size = __builtin_object_size(p, 1);
> 
>       |         ^~~~~~

Gotcha. Yeah, we have -Wshadow=local tracked here:
https://github.com/KSPP/linux/issues/152

The changes needed to fix __wait_event() are extensive, though. But yes,
there's no good reason for this macro to make things worse for W=2. ;)

I'd like to keep the existing names, so many just prefixing them with
"__" and send a v2?

Thanks!

-- 
Kees Cook
