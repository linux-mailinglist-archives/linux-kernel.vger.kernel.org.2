Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D2B31CEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhBPRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhBPRTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:19:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:19:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a207so2030158wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JjjMZWwT81OeTqWfJkqjrC+iy3+c6krHrKf6UiyEPcI=;
        b=HPxJHJC2AvGyQfAmNObp8XL9fetZfvzteZJxv/TsoCSTdhc5onhymwDLNy2j1Kcx35
         Q068Kf5nfwKwg5uTq2oVU6wjUg7m1UsHjuOtTnIDQtTQ21MrONFknR0rW4M5czmjoLya
         naXvtdPAlPMvp//j4ClzDj4YeFQrI6Enu/l+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JjjMZWwT81OeTqWfJkqjrC+iy3+c6krHrKf6UiyEPcI=;
        b=bfmDQjZOwKVkKc1fbHn0NQp00nZkf+2kt/FOwbB+vDdaxVhkvYhwtI6alZ7yg84Utj
         M4wZQaF7E5YmJBif8w1aWlGgkv272Nj7ViwDc/fhrem7oJJNM+HOGPgWZ7g1/jllM+m2
         h+a8y08bFsjkAn8KrWWcaEFAy84Ak372ILVikdMTIdgWc6tPwPLhcwBEhijFl8yT2iu6
         w31sIDwDgelug8MVnKIIhN3TWiy5lwD75p7vBYeocIcdpPAZjySi93XYZ12hudqPkjCd
         G2Vf8iHobPzsnTCFP9BX+rrafLu7nVn16C1+W/mC+hwyb9hT326GsAQDrP9yETtPZODf
         /Qig==
X-Gm-Message-State: AOAM533x1cXzEKTCx011/Zw0VxvcRS2J6sT2SeQZzWpHWTYFG+7xGMTB
        mLs6Owcr5bMrcnSVVGoYWoa+Vg==
X-Google-Smtp-Source: ABdhPJx00ZZBnGcr0oKew6pKBR71/VMcTlo5l3wwLXuPexzbFFwcwFAcQUdc2JC6qKYL9UNYUAHxXQ==
X-Received: by 2002:a1c:608b:: with SMTP id u133mr4067358wmb.149.1613495939396;
        Tue, 16 Feb 2021 09:18:59 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id 17sm5849388wmf.32.2021.02.16.09.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 09:18:59 -0800 (PST)
Date:   Tue, 16 Feb 2021 17:18:58 +0000
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
Subject: Re: debugfs: was: Re: [PATCH v4] printk: Userspace format
 enumeration support
Message-ID: <YCv+gpVGHTh9ZMNq@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCvsGzv3qlsWU+UE@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCvsGzv3qlsWU+UE@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>> +static size_t printk_fmt_size(const char *fmt)
>> +{
>> +	size_t sz = strlen(fmt) + 1;
>> +
>> +	/*
>> +	 * Some printk formats don't start with KERN_SOH + level. We will add
>> +	 * it later when rendering the output.
>> +	 */
>> +	if (unlikely(fmt[0] != KERN_SOH_ASCII))
>> +		sz += 2;
>
>This approach is hard to maintain. It might be pretty hard and error
>prone to count the size if we want to provide more information.
>
>There are many files in debugfs with not-well defined size.
>They are opened by seq_open_private(). It allows to add
>a line by line by an iterator.

Hmm, this is optional -- it was just to avoid seq_file having to realloc the 
buffer. I originally used an iterator and I'm happy to go back to it if it 
proves more convenient.

>We should revert the changes when the file could not get crated.
>It does not make sense to keep the structure when the file is not
>there.

See the reply from gregkh on v2, who was quite insistent that we should not 
check debugfs error codes. I'm happy to do either, but I can't please you both 
:-)

>I guess that remove_printk_fmt_sec() would even crash when
>ps->file was set to an error code.

debugfs checks if its input is an error, so it shouldn't, unless that's not 
what you're referring to?

>> +}
>> +
>> +#ifdef CONFIG_MODULES
>> +static void remove_printk_fmt_sec(struct module *mod)
>> +{
>> +	struct printk_fmt_sec *ps = NULL;
>> +
>> +	if (WARN_ON_ONCE(!mod))
>> +		return;
>> +
>> +	mutex_lock(&printk_fmts_mutex);
>> +
>> +	ps = find_printk_fmt_sec(mod);
>> +	if (!ps) {
>> +		mutex_unlock(&printk_fmts_mutex);
>> +		return;
>> +	}
>> +
>> +	hash_del(&ps->hnode);
>> +
>> +	mutex_unlock(&printk_fmts_mutex);
>> +
>> +	debugfs_remove(ps->file);
>
>IMHO, we should remove the file before we remove the way how
>to read it. This should be done in the opposite order
>than in store_printk_fmt_sec().

There is a subtle issue with doing this as-is: debugfs_remove(ps->file) cannot 
be called under printk_fmts_mutex, because we may deadlock due to a pinned 
debugfs refcnt if debugfs_remove() and _show happen at the same time.

Imagine we go into remove_printk_fmt_sec and grab printk_fmts_lock. On another 
CPU, we call _show for the same file, which takes a reference in debugfs, but 
it will stall waiting for printk_fmts_lock. Now we go back into 
remove_printk_fmt_sec and can't make any forward progress, because 
debugfs_remove will stall until all reference holders have finished, and there 
is a deadlock.

That's the reason that debugfs_remove() must be called after we have already 
finished with the mutex and have the printk_fmt_sec, since we need to know that 
it's still valid, and we also need to not be under it at the time of removal.

One way to do what you're asking might be to have a flag in the printk_fmt_sec 
which indicates that we are freeing something, and then take and release the 
lock twice in remove_printk_fmt_sec. Personally, I feel indifferent to either 
the current solution or something like that, but if you have a preference for 
adding a flag or another similar solution, that's fine with me. Just let me 
know. :-)
