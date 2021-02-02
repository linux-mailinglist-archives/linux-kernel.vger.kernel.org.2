Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA0530BBC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhBBKHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhBBKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:06:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A944C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 02:06:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e12so2983909pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 02:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W0Rg+VakWnsR8Z5NC70sAMo+/kQygK+aQBK/Fe3ACG8=;
        b=qkvLMsfMvLIQE28unsEWCKY7FWdmjdbO0UFk0Ds6gIZqDFSzAfGM2zaLkcw5Mw8YeU
         LrLo2ypdKdVvkLXuD8mKQTkpGC/WhIuJ8eNkOnY+rWYg+B+YwnYh82YNhYrULHhzZkrq
         3p+Yvdg8sf+AkLQSvvNfYK6qddSX0Bv4Q075Bf89FjLhLHXf6Irp4gV9s+PaNidy0sJl
         JbE0bHZLKrBjAMwUBLu5g/mHe2J6aHxzvvHzsGsHCtUL+OW/cWYd1PtKL/qK0hegXvSp
         e9yQkCQc5kVP4fgoZAmT4uaw/NXAaqGQnRJV0JanrbpMePAlfH1L7qfgCrVzncEco/W8
         PR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W0Rg+VakWnsR8Z5NC70sAMo+/kQygK+aQBK/Fe3ACG8=;
        b=EET3EcXxFF7iDqHpVQfSTWd4S5VMoDfCFKEiMxUneUQXrgaJmzaoPp1FxtrId+E/N8
         noohog0uWnljbnEz2TgNkz/YUD/4GlxzOm+KL2EhZ/QoiI4g4KqRhBVZj3jFyeayw3Kc
         8ubCbucDUcjRgcAWBDKpFkDuSgxlmCfIHyYoooHPda2jrTsn5MTbRIqnQLE/5JyNZVhF
         uUVs+OiqmpCxeMzredSZoRKRgmCIAxdsmau3WDufaYetqwVqq4wErRqzmnYy2/j9hcND
         rkHCoNIc0X9OqcKQBbEEMq9LObSK7hJFt6RiKC/5hqcf3+SbSk41TmYHq9fpkwaESfq1
         XNOA==
X-Gm-Message-State: AOAM533pd6WppvtpkcDpL4Ix/0Rza8xQhfk3jkCWwHG4GgsRO5iZkV16
        tR3ROHpsi55T9KznQ5l+eqiM1iExKRQLLw==
X-Google-Smtp-Source: ABdhPJz/aM7KiQdlwNL8er6Qr72c4Unz7ZOeQG3EH3VLJF/HoHER5eOXwJUCF5Iaw/9nidvOp7DqGw==
X-Received: by 2002:a17:90b:33c4:: with SMTP id lk4mr3718742pjb.157.1612260368672;
        Tue, 02 Feb 2021 02:06:08 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id n12sm21328628pff.29.2021.02.02.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 02:06:07 -0800 (PST)
Date:   Tue, 2 Feb 2021 19:06:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 2/3] printk: hard-code CONSOLE_LOGLEVEL_MIN in printk.c
Message-ID: <YBkkDYZz3IgreEmt@jagdpanzerIV.localdomain>
References: <20210202070218.856847-1-masahiroy@kernel.org>
 <20210202070218.856847-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202070218.856847-2-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/02 16:02), Masahiro Yamada wrote:
>  include/linux/printk.h | 1 -
>  kernel/printk/printk.c | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index fd34b3aa2f90..ceaf0486c01c 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -48,7 +48,6 @@ static inline const char *printk_skip_headers(const char *buffer)
>  
>  /* We show everything that is MORE important than this.. */
>  #define CONSOLE_LOGLEVEL_SILENT  0 /* Mum's the word */
> -#define CONSOLE_LOGLEVEL_MIN	 1 /* Minimum loglevel we let people use */
>  #define CONSOLE_LOGLEVEL_DEBUG	10 /* issue debug messages */
>  #define CONSOLE_LOGLEVEL_MOTORMOUTH 15	/* You can't shut this one up */
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 92b93340905c..7b50298d52e3 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -63,7 +63,7 @@
>  int console_printk[4] = {
>  	CONFIG_CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
>  	CONFIG_MESSAGE_LOGLEVEL_DEFAULT,	/* default_message_loglevel */
> -	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
> +	1,					/* minimum_console_loglevel */
>  	CONFIG_CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */

I personally don't think that this improves code readability.

	-ss
