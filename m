Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB1398370
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhFBHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhFBHr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:47:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D8F36138C;
        Wed,  2 Jun 2021 07:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622619945;
        bh=kiadr+m0Z5QzYQDZ8Pa+EnIE3zp/yuwM9r566Be9JEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ue/HThttHFhDriwh9I9zs+MyH8O3iOuZPLP5ehlIcbDzKVJ07rGoNdVi/y8g1uPOR
         qKh2TZ4DLowfW34b5LGFebVKGUrrytGSUeUJQE9cwefmmDCNCscFvh8aTg93mQiw+1
         0B5I/xsjnc0pn35cL1gkELh6CNHuSUZOp3X0epy6lptuQ2/ZQHEqqcAvXAAsi4lIFB
         1sulBgB0M76l96UEBK15ANPQ8mLuCK7hUxXr7J82kfpLzJEd6LX4U94KveOHrydseO
         UK/ZubUeRpZQf332t8IvC+C9GNq1cRxrueYTH0uQ7l+fnNAkbSNEf8UDZz9ug0NZtN
         2USkkH6UYoZoQ==
Date:   Wed, 2 Jun 2021 16:45:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: Re: [PATCH v3 0/6] bootconfig: Add mixed subkeys and value under
 the same key
Message-Id: <20210602164542.c08e17d67467fa94df7b9ea3@kernel.org>
In-Reply-To: <162261506232.255316.12147562546699211199.stgit@devnote2>
References: <162261506232.255316.12147562546699211199.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I missed to use the old series. Let me update it.

On Wed,  2 Jun 2021 15:24:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd version of the series which updates bootconfig to
> support mixed subkeys and a value under the same key.
> 
> Since the kernel cmdline accepts options like 
> "aaa.bbb=val1 aaa.bbb.ccc=val2", it is better that the bootconfig
> also support it.
> 
> Here is the previous series:
>   https://lore.kernel.org/lkml/162157886618.78209.11141970623539574861.stgit@devnote2/
> 
> In this version, I rebased on top of the latest linus tree and
> add the build error fix [1/6](*) and a cleanup patch [6/6].
> 
> (*) https://lore.kernel.org/lkml/162087519356.442660.11385099982318160180.stgit@devnote2/
> 
> Changes in v3
>  [1/6]:
>      - Added from separated thread. This is a fundamental fix.
>  [6/6]:
>      - New cleanup patch.
> 
> 
> With this series, sub-keys and a value can co-exist under a parent key.
> For example, following config is allowed.
> 
>  foo = value1
>  foo.bar = value2
> 
> Note, since there is no syntax to put a raw value directly under a
> structured key, you have to define it outside of the brace. For example,
> 
>  foo {
>      bar = value1
>      bar {
>          baz = value2
>          qux = value3
>      }
>  }
> 
> Also, the order of the value node under a key is fixed. If there
> are a value and subkeys, the value is always the first child node
> of the key. Thus if user specifies subkeys first, e.g.
> 
>  foo.bar = value1
>  foo = value2
> 
> In the program (and /proc/bootconfig), it will be shown as below
> 
>  foo = value2
>  foo.bar = value1
> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (6):
>       tools/bootconfig: Fix a build error accroding to undefined fallthrough
>       bootconfig: Change array value to use child node
>       bootconfig: Support mixing a value and subkeys under a key
>       tools/bootconfig: Support mixed value and subkey test cases
>       docs: bootconfig: Update for mixing value and subkeys
>       bootconfig: Share the checksum function with tools
> 
> 
>  tools/bootconfig/include/linux/bootconfig.h        |    4 +
>  tools/bootconfig/main.c                            |   62 +++++++++++++-------
>  tools/bootconfig/samples/bad-mixed-kv1.bconf       |    3 -
>  tools/bootconfig/samples/bad-mixed-kv2.bconf       |    3 -
>  tools/bootconfig/samples/bad-override.bconf        |    3 -
>  tools/bootconfig/samples/bad-override2.bconf       |    3 -
>  tools/bootconfig/samples/good-mixed-append.bconf   |    4 +
>  tools/bootconfig/samples/good-mixed-kv1.bconf      |    3 +
>  tools/bootconfig/samples/good-mixed-kv2.bconf      |    3 +
>  tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 ++
>  tools/bootconfig/samples/good-mixed-override.bconf |    4 +
>  11 files changed, 64 insertions(+), 34 deletions(-)
>  delete mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
>  delete mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf
>  delete mode 100644 tools/bootconfig/samples/bad-override.bconf
>  delete mode 100644 tools/bootconfig/samples/bad-override2.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-append.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-kv1.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-kv2.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-kv3.bconf
>  create mode 100644 tools/bootconfig/samples/good-mixed-override.bconf
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
