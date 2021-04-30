Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF693700DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhD3S7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhD3S7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:59:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:58:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s9so24119567ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HR9HIh5t6ChKf4G2M+/v8UEXBtBcvCoA8Ko3upSQGEE=;
        b=Gthh0M42pJvYCWBy3e13blM8tVYPzsKl3dsjSJfC6WPQE14dl0aGEMfGT9jr9z9r0w
         zsppuIHNQXNvQnegVvGlCd5YB/6sVcBPAQvlzcTZcq9WavaVu35v8QiWsut/Uf2cZiRi
         SROr1sstiMDfAGbtJG7YiUrELWg4w1bLfBT9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HR9HIh5t6ChKf4G2M+/v8UEXBtBcvCoA8Ko3upSQGEE=;
        b=SZH3BgWaEizT8cX6T5tExxLvUUD/o6K0/I8QOqFVBilZ92N2pJnqUdf7sYWR3Uc19v
         nsPZu/BgrfUcAclXuTzuBjmAsmqdLsxjP8vgtgnKDQCL7P27Qpq9FGrnBHXXa0OXtlil
         uCYSlUG4+4qg7mhmurg5z5XJulkH4klWdzvRpKj7NaFx4UbRuCNYKFIiu/VI9SC3wuI2
         1O8P02ns6sDBGwRR33QHjCxiylraTRXcRH916845dCRNaDM29nxAhqQ5UBJ6Op4CHXA9
         9Bkj3DCaZMtBCSj9iNnVFU9QYhbQKFcgKn4aztFMeTZd2mC+IW1ny6AlSuQrgLOkNcy7
         o7JA==
X-Gm-Message-State: AOAM531KyO+pTNeiDUlI4REgZkZLy2b2zZPWGj062RiYIeI57D587+tW
        6EGchMxbA18mf2GRAamnhHO7fWCAwkmYFpMj
X-Google-Smtp-Source: ABdhPJxK5hPaqJHWBxatw0F3sKNHLsDIpiYaGRTheQevuaM6ctcrjWClAP+hADvOjTyqXkHbUFCeTw==
X-Received: by 2002:a05:651c:2c8:: with SMTP id f8mr4898418ljo.409.1619809130432;
        Fri, 30 Apr 2021 11:58:50 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id j14sm343275ljh.0.2021.04.30.11.58.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 11:58:49 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id j10so18466397lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:58:49 -0700 (PDT)
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr4084391lft.487.1619809128928;
 Fri, 30 Apr 2021 11:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de> <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de> <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk> <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
 <26d06c27-4778-bf75-e39a-3b02cd22d0e3@rasmusvillemoes.dk> <CAHk-=whJmDjTLYLeF=Ax31vTOq4PHXKo6JUqm1mQNGZdy-6=3Q@mail.gmail.com>
 <AM6PR08MB43769965CAF732F1DEA4A37AF75E9@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YIt3uKBQnlxHAo/Q@zeniv-ca.linux.org.uk>
In-Reply-To: <YIt3uKBQnlxHAo/Q@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Apr 2021 11:58:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzBbEdpteXfRp6-WPKkZBZ1dtJSir0YqSKb_qi8AghuQ@mail.gmail.com>
Message-ID: <CAHk-=wjzBbEdpteXfRp6-WPKkZBZ1dtJSir0YqSKb_qi8AghuQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Justin He <Justin.He@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 8:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Just what does vfsmount have to do with rename_lock?  And what's the point
> of the entire mess, anyway?

Currently "%pD" doesn't actually show a truly valid pathname.

So we have three cases:

 (a) __d_path and friends get the name right, but are being overly
careful about it, and take mount_lock and rename_lock in prepend_path

 (b) dentry_path() doesn't get the actual path name right (only the
in-filesystem one), and takes rename_lock in __dentry_path

 (c) for the vsnprintf case, dentry_name() is the nice lockless "good
for debugging and printk" that doesn't take any locks at all, and
optimistically gives a valid end result, even if it's perhaps not
*THE* valid end result

Basically, the vsnprintf case does the right thing for dentries, and
the whole "you can use this for debugging messages even when you hold
the rename lock" etc.

So (c) is the "debug messages version of (b)".

But there is no "debug messages version of (a)", which is what would
be good for %pD.

You can see it in how the s390 hmcdriv thing does that

        pr_debug("open file '/dev/%pD' with return code %d\n", fp, rc);

which is really just garbage: the "/dev/" part is just a guess, but
yes, if /dev is devtmpfs - like it usually is - then '%pD' simply
doesn't do the right thing (even if it had '%pD2')

              Linus
