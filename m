Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED9E315BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhBJAzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhBIWMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:12:16 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0848C08EC2C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:59:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z6so23813210wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRXcm3EvYqUoiGNTjYj2+xSX/85AuZX9z+0FoyOz2Nw=;
        b=pKHu/F3C4N4x3TqrsbYFHTYXiIuEnPcineTNaDiyBYvYaqiLN6PWDu1xOU/BFQ9Ja2
         EqYhNxnxZKuLJHrUkuDASDT67v2qK0PYtarTkfUEZuHH8yL0rOdNBc9hR9Q5b5uS0bdS
         S3qUZQj8ih8ZsvwWGQMTypdsJg6GEQbPOYNN5fb1GGRqzWH3ZTrb6YcmzBCtpb6zMfUW
         blT0AgY98xgRLj4QUZgBrdhgq6ndzDvt8I+1HiIFA0WgQZoQpQfrixCtyRS0O13SYSPL
         29HynDaj1BcIk95mLY6YZnhJqmzDVZLVWz/sfEhlsooaVxBqzQTrEkCVhSP379DIKE0x
         374A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRXcm3EvYqUoiGNTjYj2+xSX/85AuZX9z+0FoyOz2Nw=;
        b=PwFDN1whz25vZKxMOfY+6z3n/N25j/rHaUqhhtilTbkQ2pJTep5aV6vtpg+ZpDSPAY
         rWgzeGFGF3TYnc072R9SMlai0h5UP2IYAcB2Sb8q4ZzNkrwAMI1CZby5s3SMGrdeWp61
         A/H0r+t50zDjDYfbOYNxq654N3va1aSM72o7y7UDjOlf+E2cgKcXGg+xyLYWD6dBJwG4
         vpgV2GKduA2h0z6HY3hhXKP9uQiJCS+0quRMBBnVMN4lRPZHMgJhhX+nUif1HPK07S9k
         GGNPgTBMibMPMNEU471FTeh0wrauAxmEuerLXROCdlT7uODe7IkfABbjrqcBtcFsStmf
         OzdQ==
X-Gm-Message-State: AOAM531nt00EtJfSL17ebZCGFYj3uWn8gz1sFzASnX892k0J7sWZTYSf
        FjANnPZ08eSjcrZuSoGn/IVc4g==
X-Google-Smtp-Source: ABdhPJzpy//cZm+LUaliLjKG7xToQBX9HiV1AyoPCXHsDhi3GpJCcUfMzZU+bj05fTivhbQ410a/lw==
X-Received: by 2002:adf:f1c5:: with SMTP id z5mr146578wro.391.1612907987526;
        Tue, 09 Feb 2021 13:59:47 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:51c9:b9a4:3e29:2cd0])
        by smtp.gmail.com with ESMTPSA id r12sm39574767wrp.13.2021.02.09.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:59:46 -0800 (PST)
Date:   Tue, 9 Feb 2021 22:59:40 +0100
From:   Marco Elver <elver@google.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com, glider@google.com, andreyknvl@google.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <YCMFzCz8ootub9pH@elver.google.com>
References: <20210202213633.755469-1-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202213633.755469-1-timur@kernel.org>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 03:36PM -0600, Timur Tabi wrote:
> If the make-printk-non-secret command-line parameter is set, then
> printk("%p") will print addresses as unhashed.  This is useful for
> debugging purposes.
> 
> A large warning message is displayed if this option is enabled,
> because unhashed addresses, while useful for debugging, exposes
> kernel addresses which can be a security risk.
> 
> Signed-off-by: Timur Tabi <timur@kernel.org>
> ---
>  lib/vsprintf.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..b9f87084afb0 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2090,6 +2090,30 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +/* Disable pointer hashing if requested */
> +static bool debug_never_hash_pointers __ro_after_init;

Would it be reasonable to make this non-static? Or somehow make it
possible to get this flag from other subsystems?

There are other places in the kernel that dump sensitive data such as
registers. We'd like to be able to use 'debug_never_hash_pointers' to
decide if our debugging tools can dump registers etc. What we really
need is info if the kernel is in debug mode and we can dump all kinds of
sensitive info; debug_never_hash_pointers is would be a good enough
proxy for that.

Thanks,
-- Marco
