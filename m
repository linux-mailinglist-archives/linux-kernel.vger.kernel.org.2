Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC73A7189
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFNVtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:49:45 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:40538 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhFNVto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:49:44 -0400
Received: by mail-pg1-f176.google.com with SMTP id m2so3053251pgk.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=11qshP+zA6nV1VlKwOngkmrT97wBNjMb27p4nx9dPeQ=;
        b=LUq145VKrQEwE9rgjOGzpPz5r0oSlIPHk/zQwJklsmP/reLr2QhQxs4SzJknhYFcOG
         QTjaJq3N6SKt3n80XeAs0CwuOkqO4TC378gRzRviXjYGeymf9bYuq0R/ohCGLMe6y766
         fzykrtMGa4x7NDcNTbP8sn9RCya+ITsJtGozg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=11qshP+zA6nV1VlKwOngkmrT97wBNjMb27p4nx9dPeQ=;
        b=sBNUSA2Kzr6K7ZA/pcJCxbZhL8xj2G9uJLIHiNxBy+e05D8h3fgatVqrvuYpExYem9
         I8+kr8FmRD5LcnWfxvN21iVKLx+oQGHJdRm8Eqdb323qsufEEz6op40FbBdLRCwoal1t
         FqsXBqwBgK6sMVJXkb2e0SlsG9dM7CD8flEXuzk7W5ZVt2KZq5DPx8un9XkbcI8xWqUO
         I0S22rbyGiz9fCEMnYkPk/PY8FoFJsBsfMNvJSAACdT0chwCHMXS4PNa/CIVRPXCN17o
         QSG05RPDc4MUvHv1SpHspf5Qq8BBDkAMlappscrz7zv9YMtlx88uDN6I2Hqa9URy4AK4
         MhEw==
X-Gm-Message-State: AOAM531pPA4/V13YlZnqEq7IQd46Y2rqH2YyZ1qXhcw0OL0n363gkEx4
        Sb5jDoL1GxHklwSo91O0N2jR7w==
X-Google-Smtp-Source: ABdhPJzKUWUtsQki9KiY6Yxrv339fbByTu4VTpxk9IVUZhA/8Q0tVs97sv/b2UkmGkORRB8NFg1eiQ==
X-Received: by 2002:a63:e0e:: with SMTP id d14mr18768633pgl.426.1623707184226;
        Mon, 14 Jun 2021 14:46:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gd3sm380097pjb.39.2021.06.14.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:46:23 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:46:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>, axboe@kernel.dk,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Use the normal block device I/O path
Message-ID: <202106141436.294D1B2@keescook>
References: <20210614200421.2702002-1-keescook@chromium.org>
 <YMe3eoodEyT+r1oI@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMe3eoodEyT+r1oI@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 08:09:30PM +0000, Al Viro wrote:
> On Mon, Jun 14, 2021 at 01:04:21PM -0700, Kees Cook wrote:
>   
> >  static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
> >  		loff_t pos)
> >  {
> 
> >  	/* Console/Ftrace backend may handle buffer until flush dirty zones */
> >  	if (in_interrupt() || irqs_disabled())
> >  		return -EBUSY;
> 
> > +	return kernel_write(psblk_file, buf, bytes, &pos);
> 
> In which locking environments could that be called?  The checks above
> look like that thing could be called from just about any context;
> could that happen when the caller is holding a page locked?

The contexts are determined by both each of the pstore "front ends":


PSTORE_FLAGS_DMESG:
static struct kmsg_dumper pstore_dumper = {
        .dump = pstore_dump,
...
kmsg_dump_register(&pstore_dumper);


PSTORE_FLAGS_CONSOLE:
static struct console pstore_console = {
        .write  = pstore_console_write,
...
register_console(&pstore_console);


PSTORE_FLAGS_FTRACE:
static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
        .func   = pstore_ftrace_call,
...
register_ftrace_function(&pstore_ftrace_ops);


PSTORE_FLAGS_PMSG:
static const struct file_operations pmsg_fops = {
...
        .write          = write_pmsg,
...
pmsg_major = register_chrdev(0, PMSG_NAME, &pmsg_fops);


and each of the pstore "back ends". (ram, EFI vars, block, etc.)


> IOW, what are those checks really trying to do?

Traditionally, the most restrictive case is kmsg_dump, but that's the
whole point here of the "best effort" mode: if we can't safely make the
call and no panic handler has been registered, we must skip the call.

e.g. the RAM pstore backend has all its buffers preallocated, and it'll
just write directly into them. The handling here has gotten progressive
weirder, as more back ends landed -- i.e. EFI var writing added some
limits to the kind of locking pstore could do, etc.


It may turn out that the checks above aren't needed. I haven't tried it
without, but I suspect it's for the kmsg_dump case.

-Kees

-- 
Kees Cook
