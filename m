Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDF64599FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhKWCNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhKWCNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:13:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA862C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:10:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id o14so15710834plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGXxGJzsa1casn0ONZd2/LBD5Y8XYuu5N3+HBaK0e7k=;
        b=cxHw9Jh+E7IXyJnZoQVuOiUWoWbbfQKosLG6yMeHcoOtu9iTR+L2PG0EQUX2ahfYbK
         vPYb/4lkIk+K50oH41WKkh0OVEAlW4ExnuHXLoo9Dj0k8GD63bmiPTh3i8ij4hmh6O//
         MvyJi+w9S1bnAL/8+qzwJf8SQyRVaEs1giL3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGXxGJzsa1casn0ONZd2/LBD5Y8XYuu5N3+HBaK0e7k=;
        b=objKAag6c2zCAKFdyNu6Si8/StFN/Njd5yD3IHRPYmIMPIeWqyNZ/FNs17SsRgnzsx
         iKX3F7RwcMQKLEmYl/T9M9WZhGVpT5gzXBZ3BO7yn6g4cb88Ov/8R1fRDLPtk4mQSL5w
         4oiYFrXkJ2AA76rTD8dfjJm3tN75vXTU4VF7F4dVzHq1GyWlFAsWz0wopxw2kwhgJt68
         K1g6bwu+hcTHwgSadSYFyn9QYT4F/oiKmojlYrccuYSPVQ8wvop7ZXcTYtB5tUTa5jI5
         iFcTQdCYqDz/BIhKLLua65+vTfPqsWwzn8BhGV6P0nz3u8Q4covIdCjLkocZH4+t3dmJ
         EaXg==
X-Gm-Message-State: AOAM532lMAXfPii7J91pKSARRwdLzXLZW7c+5GMFIXyR3hZtbaDnlT46
        e/YQ5V+kvSIsOYjUA+PayTNlEw==
X-Google-Smtp-Source: ABdhPJxDPgUeHT3ZEQVB0cTV4v8TeGfvYub1zY9sXeBOqQ7RqFO67viU7X/wGEheRz2svKzSyLZC1A==
X-Received: by 2002:a17:90b:4ad0:: with SMTP id mh16mr1984400pjb.176.1637633423400;
        Mon, 22 Nov 2021 18:10:23 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:6c1d:310c:ef60:f3c6])
        by smtp.gmail.com with ESMTPSA id pj12sm21118464pjb.51.2021.11.22.18.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 18:10:22 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:10:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] printk/console: Split out code that enables default
 console
Message-ID: <YZxNiiK3PRZnsfPG@google.com>
References: <20211122132649.12737-1-pmladek@suse.com>
 <20211122132649.12737-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122132649.12737-2-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/11/22 14:26), Petr Mladek wrote:
> Put the code enabling a console by default into a separate function
> called try_enable_default_console().
> 
> Rename try_enable_new_console() to try_enable_preferred_console() to
> make the purpose of the different variants more clear.
> 
> It is a code refactoring without any functional change.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[..]
> -static int try_enable_new_console(struct console *newcon, bool user_specified)
> +static int try_enable_preferred_console(struct console *newcon,
> +					bool user_specified)
>  {
>  	struct console_cmdline *c;
>  	int i, err;
> @@ -2909,6 +2910,23 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
>  	return -ENOENT;
>  }
>  
> +/* Try to enable the console unconditionally */
> +static void try_enable_default_console(struct console *newcon)
> +{
> +	if (newcon->index < 0)
> +		newcon->index = 0;
> +
> +	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
> +		return;
> +
> +	newcon->flags |= CON_ENABLED;
> +
> +	if (newcon->device) {
> +		newcon->flags |= CON_CONSDEV;
> +		has_preferred_console = true;
> +	}
> +}

try_enable_default_console() also sets preferred_console, as well as
try_enable_preferred_console().
