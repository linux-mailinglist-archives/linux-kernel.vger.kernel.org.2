Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5D45D28C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346999AbhKYBuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350221AbhKYBsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:48:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ABCC07E5C2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 16:53:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u11so3256119plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 16:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=scJBclGIopOVvG3HSUpsjPmCQQn013b/K/39DlZv3x4=;
        b=ScoHsauE0NTyr0yybyYp1l2UwStVFF1tAnpH5fnJhEkea+UGTrOHxRtGfqirT8Ya8D
         DTvx2TtIeKGlEd+BtCbgLDOR5BE3veGp/R6TmMw9pvs9iLNFY+xcNyuAO2pKzwxFuMWB
         wGVRboyX8VzPtGkMASZqTCV9dWUSfx3bIBxRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=scJBclGIopOVvG3HSUpsjPmCQQn013b/K/39DlZv3x4=;
        b=gw3fcv3i6mVIms0ZzxVQfRJxOethfMPt1Ku0QA0Vl41Yf6fCzGRZ3CWuWt689cJqnP
         qltMH5Oevx0PmZffkLWGW/ou4Rrx7GpqQmPlSk2do2/0OUXhvBNLUh9BjdxNm+jBFovr
         Bfh/rQ9om3216A/+60nVdUIsF8hag07G6qXnEM8WgSRw/j5HFNPzfuvtc//ksNOHqTeA
         xu94gXhxk0E7M9CdqopN+1voUSGAfWkxTITikhZr9Id68ViHZDv+mVbOyffuj6Ztg0ou
         XCDPFuKRG1XJbDHGQ9zg7GF6dupHI7s0x4mnqk7q4FTthoQk9GzX+/qcyknSVgKCiD3A
         8/OQ==
X-Gm-Message-State: AOAM532NmhgtqgxXusIQ7v7wmYCCVvza/qOU7Nlb9cmouWTj00ohLZbs
        umvLnWOI0s5wslEv3UNCIj30Sg==
X-Google-Smtp-Source: ABdhPJzyHEzyR7ArhBFbwqnc3bmS+Tf811bPK8hZDgLgPfudi/aPrXj1HmSLYypSmW5O1lH6o4JzwQ==
X-Received: by 2002:a17:903:2344:b0:142:25b4:76c1 with SMTP id c4-20020a170903234400b0014225b476c1mr25324384plh.43.1637801634938;
        Wed, 24 Nov 2021 16:53:54 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:5469:38f8:3785:7433])
        by smtp.gmail.com with ESMTPSA id ml24sm768144pjb.16.2021.11.24.16.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 16:53:54 -0800 (PST)
Date:   Thu, 25 Nov 2021 09:53:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] printk: More consistent loglevel for continuous lines
Message-ID: <YZ7enboRQprct49o@google.com>
References: <20211124154838.5415-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124154838.5415-1-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/11/24 16:48), Petr Mladek wrote:
> 
> Anyway, it looks a bit non-practical to update all existing pr_cont()
> callers:
> 
> 	$> git grep "pr_cont" | wc -l
> 	2054

Another question is how many pr_cont()-s are getting compiled with
the "average" production kernel config. A number of pr_cont() is in
debugging code - lockdep, kasan, etc. - which is not compiled for prod.

[..]

> +static void printk_write_loglevel_ctx(int loglevel)
> +{
> +	u8 *loglevel_var = printk_loglevel_ctx_var();
> +
> +	if (!loglevel_var)
> +		return;
> +
> +	/*
> +	 * Remember only the really used loglevels that can be stored
> +	 * within 3 bytes in struct printk_info.
> +	 */
> +	if (WARN_ON_ONCE(loglevel != LOG_LEVEL(loglevel)))
> +		return;
> +
> +	*loglevel_var = loglevel;
> +}
> +
> +static u8 printk_read_loglevel_ctx(void)
> +{
> +	u8 *loglevel_var = printk_loglevel_ctx_var();
> +
> +	if (!loglevel_var)
> +		return LOGLEVEL_DEFAULT;
> +
> +	return *loglevel_var;
> +}
> +
>  /**
>   * printk_parse_prefix - Parse level and control flags.
>   *
> @@ -2066,6 +2122,21 @@ u16 printk_parse_prefix(const char *text, int *level,
>  	return prefix_len;
>  }
>  
> +static int printk_sanitize_loglevel(int loglevel, enum printk_info_flags flags)
> +{
> +	/* For continuous lines, fallback to the previously used loglevel. */
> +	if (flags & LOG_CONT && loglevel == LOGLEVEL_DEFAULT)
> +		loglevel = printk_read_loglevel_ctx();
> +
> +	if (loglevel == LOGLEVEL_DEFAULT)
> +		loglevel = default_message_loglevel;
> +
> +	/* Remember the really used loglevel for this context. */
> +	printk_write_loglevel_ctx(loglevel);
> +
> +	return loglevel;
> +}

Let's assume something like this

	foo()
	{
		char *s;

		pr_cont("Blah ");
		s = arch_foo();
		pr_cont("%s \n", s);
	}

Suppose that arch_foo() errs and pr_warn()-s. Are we going to use WARN
level for trailing pr_cont()?

	pr_cont("Blah ") -> printk_write_loglevel_ctx(default)
	pr_warn() -> printk_write_loglevel_ctx(warn)
	pr_cont("%s \n"") <- printk_read_loglevel_ctx(warn)



p.s. I'm still reading amazingly detailed commit messages from your console
registration patch set.
