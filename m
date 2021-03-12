Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BC338478
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhCLDq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhCLDqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:46:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61BE064F94
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615520815;
        bh=4R+bUiUQrhAbhcNq5F9PTRR6LOdoOwhc+tn0NqBlX+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WfGhsPrMk6twy/JXIkr08yNMjm7RjFp9o1vVqy0yOSkHKKMeRBj9abUiPv1TZ5Gk7
         9tp57mMqkQ2hVyCijXDS+pAvFGxS2uvnjYo868eucIczegZPeytOUQ4qStxT9R85xK
         /tvJ8DQ+ihzD7qGUcAknyy+cMKscnGRzBRQtfgsUpV0orgSuMUiHEJ8qOMh/KXjXt9
         HsINldf2PpL1Cg/bj6ECAcSvRrLujK5FtX35WG+rs2d/uG29W5xjSxltuNS7GQlR4I
         EGDWoHtnCHhPSnmq7XpFCvh71HhhWf38r0lB5ZlGDyXh6iIQX97LsmiYqbTrLyUdt1
         apUw5wgbDyoYw==
Received: by mail-qk1-f180.google.com with SMTP id x10so23038358qkm.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 19:46:55 -0800 (PST)
X-Gm-Message-State: AOAM533Wjej+bLG6uNvASDCt5R792HQ7MCgFNB0Zrs2gIKoQvhZKdSfP
        S1ClsuL1rp3/HLe2kDn0AH0emB8AeD1q5IocnyQ=
X-Google-Smtp-Source: ABdhPJwA2sqL31w8M4oJJ0ibkLv0U9JXpG/49rf229DGuMNa5NXksK8IS0NNxE/htGQm8fGSLb9+l2gKtcfA/vXogew=
X-Received: by 2002:ae9:f81a:: with SMTP id x26mr10406100qkh.497.1615520814578;
 Thu, 11 Mar 2021 19:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20210305194206.3165917-1-elver@google.com> <20210305194206.3165917-2-elver@google.com>
 <YEX5fyB16dF6N4Iu@alley> <CANpmjNPTXPWZyPTqYZKdnvcbHP+ZOa0ce0Md5EE6GViQMyeTOw@mail.gmail.com>
In-Reply-To: <CANpmjNPTXPWZyPTqYZKdnvcbHP+ZOa0ce0Md5EE6GViQMyeTOw@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Date:   Thu, 11 Mar 2021 21:46:16 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUS6DJAtF2M7Rs28yzSOjRheLodL_F50wsrEFN_0upDPQ@mail.gmail.com>
Message-ID: <CAOZdJXUS6DJAtF2M7Rs28yzSOjRheLodL_F50wsrEFN_0upDPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers warning
To:     Marco Elver <elver@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 4:51 AM Marco Elver <elver@google.com> wrote:
> If we do __initconst change we need to manually remove the duplicate
> lines because we're asking the compiler to create a large array (and
> there's no more auto-dedup). If we do not remove the duplicate lines,
> the __initconst-only approach would create a larger image and result
> in subtly increased memory consumption during init. The additional
> code together with manual dedup should offset that. (I can split this
> patch as Andy suggests, but first need confirmation what people
> actually want.)
>
> I have no idea what the right trade-off is, and appeal to Geert to
> suggest what would be acceptable to him.

Maybe we can have only the message itself wrapped in an #ifdef CONFIG_
of some kind.  For example:

+#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
       pr_warn("**********************************************************\n");
       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
       pr_warn("**                                                      **\n");
       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
...
+#endif

       return 0;
}

In other words, if space is really constrained, then don't include the
message.  Or maybe just include part of the message.
