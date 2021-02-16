Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1FD31CEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhBPR2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhBPR15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:27:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C15C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:27:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o10so134003wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kNDrNk/jNbD3iTgu7QWnPmPLZ3UUFUZrJZtmGZOnk+Y=;
        b=IGx3mQBlASrtyXMImnbMpiRVTgiz67h7cakxZ3SUV0DvvAVKWVOobXYszaDmbV+Uyl
         GAK7/TtUHdtmsSKO8Sv9Aq7ovVirWt5wrkrJhGwrv4MMK3c9u9CfPF/4RVw8ychIjXdz
         GcP9iDvRtsaS3S/jNDY8qLVTselwlId0ywGw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kNDrNk/jNbD3iTgu7QWnPmPLZ3UUFUZrJZtmGZOnk+Y=;
        b=uF/esF80EQ97VY1xJACqu0z5O8X8OpNe/JxxuAjGe5x3Scyz+t/yi1xCRiYpwihD+k
         1hXsuaEThenJgcv2TjykjHVBeRGTNrLAMnFifaTElh1f0CMWMsDE4XLMu0ChLeYirZdI
         61gW7vipC51+Ey9tvCspTI5v9NQTGhOYYhka7MdhQv+00qGZUbTb3VrDPULPo/5zQAIY
         BE/o5o/X3hW3fIMJL/louEFATvRJLi6cQb1hQ9zv2nZmSgRTNm6CzH1viGfZAlqN0zUd
         ipTscbJUwlNDJJzevYKtLwfmZRV+3PNFjSYX2tWr4+pmAFTzWSxFaImqfM+vWi7hoD/2
         a0Zw==
X-Gm-Message-State: AOAM531Wb8MWVKn7q4TzKL8bHKCRZ/HliRQr7fZ7KoP35It0Z7T4vbLg
        AMhMYpHU/bLKH9BZ3iUo2wB//A==
X-Google-Smtp-Source: ABdhPJz8/jWeE6pIeMpj4WxB0eRpdBso7yyuAPPCc0k7vAPFGyRFPeYHR96JXedLxZ/+OYP0ryhuKQ==
X-Received: by 2002:a05:600c:4a22:: with SMTP id c34mr4008516wmp.167.1613496429676;
        Tue, 16 Feb 2021 09:27:09 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id w8sm29181161wrm.21.2021.02.16.09.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 09:27:08 -0800 (PST)
Date:   Tue, 16 Feb 2021 17:27:08 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YCwAbGoVuZJspcx5@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCv9Xb7ePnDy9xRf@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>I wonder if we could find a better name for the configure switch.
>I have troubles to imagine what printk enumeration might mean.
>Well, it might be because I am not a native speaker.
>
>Anyway, the word "enumeration" is used only in the configure option.
>Everything else is "printk_fmt"
>
>What about DEBUG_PRINTK_FORMATS?

Hmm, I don't like DEBUG_PRINTK_FMTS because it's not about debugging, it's 
about enumeration, I guess :-)

The name should reflect that this catalogues the available printks in the 
kernel -- "debugging" seems to imply something different.

I'm ok with a different name like "printk catalogue" or something like that if 
you prefer. Personally I think "printk enumeration" is fairly clear -- it's 
about enumerating the available printks -- but anything that captures that 
spirit is fine.

>printk.c is already too big. Please, implement this feature in a
>separate source file, e.g. kernel/printk/debug_formats.c.

Sure, that's fine.

>> struct printk_fmt_sec {
>> +	struct hlist_node hnode;
>> +	struct module *module;
>
>Please, use "struct module *mod". It is a more common.
>
>> +	struct dentry *file;
>> +	const char **start;
>> +	const char **end;
>> +};
>
>Please, document the meaning of the fields, ideally using the doc
>style or how is the style called:
>
>/**
> * struct printk_fmt_sec -
> * @hnode:	node for the hash table
> * @new_func:	pointer to the patched function code

Roger to both. :-)

>> +
>> +/* The base dir for module formats, typically debugfs/printk/formats/ */
>> +struct dentry *dfs_formats;
>> +
>> +/*
>> + * Stores .printk_fmt section boundaries for vmlinux and all loaded modules.
>> + * Add entries with store_printk_fmt_sec, remove entries with
>> + * remove_printk_fmt_sec.
>> + */
>> +static DEFINE_HASHTABLE(printk_fmts_mod_sections, 8);

>The hash table looks like an overkill. This is slow path. There are
>typically only tens of loaded modules. Even the module loader
>uses plain list for iterating the list of modules.

I don't think it's overkill -- we have prod systems with hundreds. Hell, even 
my laptop has over 150 loaded. If someone needs to walk all of the files in 
debugfs, it seems unreasonable to do an O(n^2) walk when an O(n) one would 
suffice.

Unless you have a practical concern, I think this is a distinct case from the 
module loader with its own unique requirements, so I'd prefer to use the hash 
table.

>> +
>> +/* Protects printk_fmts_mod_sections */
>> +static DEFINE_MUTEX(printk_fmts_mutex);
>
>What is the rule for using "printk_fmts" and "printk_fmt", please?
>I can't find the system here ;-)
>
>Anyway, I would prefer to use "printk_fmt" everywhere.
>Or maybe even "pf_".

pf_ sounds fine. :-)

>> +
>> +static const char *ps_get_module_name(const struct printk_fmt_sec *ps);
>> +static int debugfs_pf_open(struct inode *inode, struct file *file);
>
>There are used many different:
>
>   + shortcuts: fmt, fmts, ps, fmt_sec, dfs
>
>   + styles/ordering: ps_get_module_name() vs.
>		      find_printk_fmt_sec() vs.
>		      printk_fmt_size() vs.
>		      debugfs_pf_open()
>
>It might be bearable because there is not much code. But it would
>still help a lot when we make it more consistent. Many subsystems
>prefer using a feature-specific prefix.
>
>It might be "printk_fmt_" or "pf_" [*] in this case. And we could use
>names like:
>
>	+ struct pf_object [**]
>	+ pf_get_object_name()
>	+ pf_find_object()
>	+ pf_fops,
>	+ pf_open()
>	+ pf_release()
>	+ pf_mutex,
>	+ pf_add_object()
>	+ pf_remove_object()
>	+ pf_module_notify

Oh, I meant to change the name for v4 but neglected to do so. Sounds good, will 
do.
