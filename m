Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C51342315
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCSRRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhCSRRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:17:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B84C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:17:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bx7so11637309edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NmOSs5tEu47Laoh1qxa+rl3JlDXehYKJh6XfrCU+SRM=;
        b=OU2XM07/P0SFEX8dpG4FteiSW0vErpq78CdkpTISEI3TrhMSkCQcs2ABH6+r8ZkqkH
         NZloQc4xFVaGBSYiMCFUkfobMcc+GMn30T3hfWLv4FEEUqpHWaVZGE2AeuluiUkET39b
         t6WHSkoXxOlo5HJXOQr6qp1ePUp2KERBezcJio2ikhSdUIWgm8C5MKFx/ra+RI/IC7DF
         s5yi/XZu5xM02hzzAy+lhL6rcfPl+U9Be+soziyfLPm1VE4HneXtj6foLwOOKTpLQPh7
         lR7E1oBw+EKZuyWHKTfP3QW4b+cBxthHGrWJhPGxZIOn53SAltZYkjEk6wfy7KiUprKC
         25fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NmOSs5tEu47Laoh1qxa+rl3JlDXehYKJh6XfrCU+SRM=;
        b=afSvHspKnRTwkaA7A3pMRXmss8Lcwx+pVoFgulT4tkYW3XBO2f39KhQSv0ClIn0dj5
         +CF5rC4XoOUt6g/piW1CZ4+S1jzlMoywEyTaSE6YffzTSCIzvJZnB8pOTLPlfPWBrhIZ
         B41NmViYtiEb60lNpDFYhZcEU8tO08LO31r0YA55RpJDDRX+QiTOAu25bLt5Z0T55j8v
         FFkI5kWOS5QgygWQNWfUs8Ka6Zt79okbTVag2sgB50mHJ7e2hQ4MIRhrSMoSkGXfhqCj
         tHR8yPq+zVNL3Pacy8d+MSroj8asBCa419K1rYiupv2AVcePW0puFjwwECEYiWJsaswd
         k+CA==
X-Gm-Message-State: AOAM531gbAzKJrjr+N0aBuN4hc+Bstbxy+dGVmZR8JIf0be2LmGLKeMy
        LraRkDbGFeSlYIxA9pOiE7fH67/MJpyRvxai
X-Google-Smtp-Source: ABdhPJzOFq4v0Lwd4dwxfKOLdM+czU7z6OYUykk7hRaTQS/S4dNiOJFeqlritMVFyedzsDiN0+tPmg==
X-Received: by 2002:a05:6402:1283:: with SMTP id w3mr10777157edv.340.1616174234323;
        Fri, 19 Mar 2021 10:17:14 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r25sm3914743edv.78.2021.03.19.10.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:17:13 -0700 (PDT)
Date:   Fri, 19 Mar 2021 17:17:12 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Refactor kdb_defcmd implementation
Message-ID: <20210319171712.vlkgnmp7cbnayxdn@maple.lan>
References: <20210309121747.859823-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309121747.859823-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 05:47:47PM +0530, Sumit Garg wrote:
> Switch to use kdbtab_t instead of separate struct defcmd_set since
> now we have kdb_register_table() to register pre-allocated kdb commands.

This needs rewriting. I've been struggling for some time to figure out
what it actually means means and how it related to the patch. I'm
starting to conclude that this might not be my fault!


> Also, switch to use a linked list for sub-commands instead of dynamic
> array which makes traversing the sub-commands list simpler.

We can't call these things sub-commands! These days a sub-commands
implies something like `git subcommand` and kdb doesn't have anything
like that.


> +struct kdb_subcmd {
> +	char    *scmd_name;		/* Sub-command name */
> +	struct  list_head list_node;	/* Sub-command node */
> +};
> +
>  /* The KDB shell command table */
>  typedef struct _kdbtab {
>  	char    *cmd_name;		/* Command name */
> @@ -175,6 +181,7 @@ typedef struct _kdbtab {
>  	kdb_cmdflags_t cmd_flags;	/* Command behaviour flags */
>  	struct list_head list_node;	/* Command list */
>  	bool    is_dynamic;		/* Command table allocation type */
> +	struct list_head kdb_scmds_head; /* Sub-commands list */
>  } kdbtab_t;

Perhaps this should be more like:

struct defcmd_set {
	kdbtab_t cmd;
	struct list_head commands;
	
};

This still gets registers using kdb_register_table() but it keeps the
macro code all in once place:

kdb_register_table(&macro->cmd, 1);

I think that is what I *meant* to suggest ;-) . It also avoids having to
talk about sub-commands! BTW I'm open to giving defcmd_set a better name
(kdb_macro?) but I don't see why we want to give all commands a macro
list.


Daniel.
