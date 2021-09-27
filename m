Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044AB419523
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhI0NfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhI0NfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:35:15 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33332C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:33:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l8so21767914edw.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HcnQqbopaKTbfNCFEcMRHjZ29Aha5URcI+niusbKs7Q=;
        b=bIL2RJd81JX5T4t+0lu9GBa3k8wPjjj9YkUb8wAwqlBOyAvYoPNPdv5+6in4BmWHJm
         dMjLYDSR1cs2cBsaGIQNVqr38EnEezzssfFp/Ca1+wkVNHgCIpSlVUGHBFEpIn7+Gh5p
         cvWoa1brBiqwgjE+JFKnt5UUUZ4j7icUGxVW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HcnQqbopaKTbfNCFEcMRHjZ29Aha5URcI+niusbKs7Q=;
        b=frTib1Iw3Z56qhrNcfcCsJek+EQ6ma33RmYqmAUW9lFpu6RTYcP/9MbZXtI9413cen
         rrfrN/EIvrCj1COSeQBA/si6oPcM/QYbVj6bqvx90efXFMzXg8UiisCAzfHFmj/gT6EB
         9j5FmpY5gTc0nWVWEGytbEbnCOCmLfo7Ls31s0tlFIVphv6uAYUDX+baAqMXPs+3nUZU
         PW73MFQgFra/vRJSEn7mQDoro7clh5el99KoX6ewTNmSwEryB/+Mi/9hcTX9eSXmRGdN
         1YRBDw0A2utia0nkwvu+oB78/cYvzGClz8PbPlOs3QsNRmhODzWSK0eHz/MET2TzooKc
         qC/Q==
X-Gm-Message-State: AOAM531qvaIQuva9qW5sM8EGA93LHO7oHOpBLuS7jmt672ro7A8Bb0PE
        n/XRe5U/aHzeolLZFK2fVGgvEg==
X-Google-Smtp-Source: ABdhPJwshnnixcq6LlC2JYZ6yd0RvDjsW82x3TAkBK5g8O8M1H2ZODmrEHaKM1w1kl6XuCZz9IWnGQ==
X-Received: by 2002:a50:9d02:: with SMTP id v2mr23415268ede.105.1632749615754;
        Mon, 27 Sep 2021 06:33:35 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6664])
        by smtp.gmail.com with ESMTPSA id ca4sm8717419ejb.1.2021.09.27.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 06:33:35 -0700 (PDT)
Date:   Mon, 27 Sep 2021 14:33:34 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] printk: avoid -Wsometimes-uninitialized warning
Message-ID: <YVHILl7E5RI3ohyX@chrisdown.name>
References: <20210927125007.1581919-1-arnd@kernel.org>
 <YVHE1qclD6ZyjvvD@chrisdown.name>
 <CAK8P3a3_0njnrTokeXmOuZ1vA00Nk9pqbxsOZw+6QcCL-Ng=xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_0njnrTokeXmOuZ1vA00Nk9pqbxsOZw+6QcCL-Ng=xg@mail.gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:
>On Mon, Sep 27, 2021 at 3:20 PM Chris Down <chris@chrisdown.name> wrote:
>>
>> Hi Arnd,
>>
>> Arnd Bergmann writes:
>> >From: Arnd Bergmann <arnd@arndb.de>
>> >
>> >clang notices that the pi_get_entry() function would use
>> >uninitialized data if it was called with a non-NULL module
>> >pointer on a kernel that does not support modules:
>>
>> On a !CONFIG_MODULES kernel, we _never_ pass a non-NULL module pointer. This
>> isn't just convention: we don't even have `struct module` fully fleshed out, so
>> it technically cannot be so.
>
>Yes, I understand that part, hence the "if it was called" rather then
>"when it is called".

But there's no "if", it's simply not possible.

>> >kernel/printk/index.c:32:6: error: variable 'nr_entries' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>> >        if (!mod) {
>> >            ^~~~
>> >kernel/printk/index.c:38:13: note: uninitialized use occurs here
>> >        if (pos >= nr_entries)
>> >                   ^~~~~~~~~~
>> >kernel/printk/index.c:32:2: note: remove the 'if' if its condition is always true
>> >        if (!mod) {
>> >
>> >Rework the condition to make it clear to the compiler that we are always
>> >in the second case. Unfortunately the #ifdef is still required as the
>> >definition of 'struct module' is hidden when modules are disabled.
>>
>> Having IS_ENABLED and then an #ifdef seems to hurt code readability to me.
>>
>> >Fixes: 337015573718 ("printk: Userspace format indexing support")
>>
>> Does this really fix anything, or just clang's ignorance? If the latter, clang
>> needs to be smarter here: as far as I can see there are no occasions where
>> there's even any opportunity for a non-NULL pointer to come in on a
>> !CONFIG_MODULES kernel, since `struct module` isn't even complete.
>
>I don't see how you would expect clang to understand that part. It does
>not do cross-function analysis for the purpose of diagnostic output, and
>even if it did, then this caller
>
>static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
>{
>        const struct module *mod = s->file->f_inode->i_private;
>        struct pi_entry *entry = pi_get_entry(mod, *pos);
>...
>}
>
>has no indication that "s->file->f_inode->i_private" is guaranteed to
>be a NULL pointer.

Sure, but it seems unnecessary to me to gum up the code because of clang's 
inability to understand that.
