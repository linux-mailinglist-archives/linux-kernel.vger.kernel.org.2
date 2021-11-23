Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DCD459A02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhKWCTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhKWCTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:19:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719FCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:15:58 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q12so16864026pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fV4UWOphcTooaNp5TkT3NkmYW3NIpDrHpLwpN/UYQHg=;
        b=QFDiGrv8cTyw63MGwGl4fA9wE8Cyswd3UXUFqFlJZtP7oJULqsyXrjMtY9cGR74blT
         0UaHFrinZ40fV1OmwhGSnr8eHesDuHjpsn0LZxgeltwVgrP+ST5a+kH/vmIHFi0fEayW
         VFk/Z5zv1BV1W2aU0PpiVRHFZX+ociEs2mkG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fV4UWOphcTooaNp5TkT3NkmYW3NIpDrHpLwpN/UYQHg=;
        b=5ybDJ3lRw0OmLUwBExHQS6k4GRwrxpzmbDdIGNW8GDfvcEcU7xJDgtcURMXqeAYt2s
         +WpnQES2zmzL6ea2Wxd5jURRzJkMpf+ejqGoAA0awoxFG5KMRNoS3dlodXtHzI3Ww/WD
         AGP69+5Xy0pmoyYK+LxQmQ1FjhbrSvd3hXxn358om6MVMtW/2BUK6JMbo1mNsCNM/WKr
         GJAjmhIPT5RzKg9QRYLC3y365ekOkQbqbKci4ImOb+GhVCW83oJhKwUPEyLiGYLfQ6At
         +HGpJEe2fSycR1ny8HzuResgsi/tZ36xbNRNKCswWYkY8yBoj+bpIq9AmfFIQIocdUhd
         JGUg==
X-Gm-Message-State: AOAM531ld+VyUeqz5/4u2Cu4tPKCwAVcPjt9WNdZAMN6GpL/aPJdc5Tg
        589rrgdBTl2k+M1QQAwSmG3pNw==
X-Google-Smtp-Source: ABdhPJzwTCDHKKBf9eElChNAUrsZb/6f+spW7nPmZqqx7aLJkXCx2q9e/FXdpgIERl5NIQx5QjsItw==
X-Received: by 2002:a63:5945:: with SMTP id j5mr1195978pgm.311.1637633757926;
        Mon, 22 Nov 2021 18:15:57 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:6c1d:310c:ef60:f3c6])
        by smtp.gmail.com with ESMTPSA id nh21sm8621346pjb.30.2021.11.22.18.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 18:15:57 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:15:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] printk/console: Rename has_preferred_console to
 need_default_console
Message-ID: <YZxO2I7D8uFQWKTF@google.com>
References: <20211122132649.12737-1-pmladek@suse.com>
 <20211122132649.12737-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122132649.12737-3-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/11/22 14:26), Petr Mladek wrote:
> The logic around the variable @has_preferred_console made my head
> spin many times. Part of the problem is the ambiguous name.
> 
> There is the variable @preferred_console. It points to the last
> non-braille console in @console_cmdline array. This array contains
> consoles preferred via the command line, device tree, or SPCR.
> 
> Then there is the variable @has_preferred_console. It is set to
> "true" when @preferred_console is enabled or when a console with
> tty binding gets enabled by default.
> 
> It might get reset back by the magic condition:
> 
> 	if (!has_preferred_console || bcon || !console_drivers)
> 		has_preferred_console = preferred_console >= 0;
> 
> It is a puzzle. Dumb explanation is that it gets re-evaluated
> when:
> 
> 	+ it was not set before (see above when it gets set)
> 	+ there is still an early console enabled (bcon)
> 	+ there is no console enabled (!console_drivers)
> 
> This is still a puzzle.
> 
> It gets more clear when we see where the value is checked. The only
> meaning of the variable is to decide whether we should try to enable
> the new console by default.

A nit: by "new console" you probably mean preferred_console. It sort
of suggests that try_enable_new_console() was not such a bad name,
may be, since we still refer to such consoles as "new" not "preferred".


> Rename the variable according to the single situation where
> the value is checked.
> 
> The rename requires an inverted logic. Otherwise, it is a simple
> search & replace. It does not change the functionality.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
