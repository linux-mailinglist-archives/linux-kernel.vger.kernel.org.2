Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB9A38D2DA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 03:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhEVB4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 21:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhEVB4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 21:56:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5155461183;
        Sat, 22 May 2021 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621648529;
        bh=WgxXh3i+R5l1py7AC87CtNwXFl8oTVhGgJMkGlMvBfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d/9doEtCdRV/rmta7FPXlOizuCBJt4zAPC/7B4HrDf5uru4K47pUW066byoCaxFuc
         DnmEA0VcS1LhukVXVrfnCor6yGzq8NYN9NOlcHd7xjxgm4oRqK/a/58Aqt7P5yo9BI
         TiViAJUu0j8lg2tJU/uC1z/b7JZwcDQunEpoJ/9ZSHHQ+xHr6ZrpuhO7UDKAvfz1in
         QgryaGeG8L7L0Yq1V66PuH4rPHQjwJ0mm5QTsxbJWPWHB1nzXy0ExQ96b7GlyxKR3c
         fONO76yRHsUvYo3XggnZdxxxQqwIz/AU9RF3spHGbM27vlU4flL27pZrQJZUgzWmW5
         9zVPs/rOXWeEQ==
Date:   Sat, 22 May 2021 10:55:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Devin Moore <devinmoore@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 0/4] bootconfig: Add mixed subkeys and value under
 the same key
Message-Id: <20210522105526.1c9719e50173ef3d3cee240b@kernel.org>
In-Reply-To: <CAOELnJyuaUSiHi84AF34_myBVOQ9BtyRNMpAh95bgPK0nvy9=A@mail.gmail.com>
References: <162157886618.78209.11141970623539574861.stgit@devnote2>
        <CAOELnJyuaUSiHi84AF34_myBVOQ9BtyRNMpAh95bgPK0nvy9=A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 15:06:22 -0700
Devin Moore <devinmoore@google.com> wrote:

> On Thu, May 20, 2021 at 11:34 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > Here is the 2nd version of the series which updates bootconfig to
> > support mixed subkeys and a value under the same key.
> > Since the kernel cmdline accepts options like
> > "aaa.bbb=val1 aaa.bbb.ccc=val2", it is better that the bootconfig
> > also support it.
> >
> > In this version, I fixed [1/4] to show /proc/bootconfig correctly
> > and update the description.
> >
> > Changes in v2
> >  [1/4]:
> >       - Fix /proc/bootconfig accroding to Devin's report (Thanks!)
> >       - Update patch description to explain why, not what.
> >       - Use xbc_node_is_array() instead of checking field directly.
> >  [4/4]:
> >       - Update an exmaple code.
> >
> >
> > This series depends on the below bugfix.
> >
> >  https://lore.kernel.org/lkml/162087519356.442660.11385099982318160180.stgit@devnote2/
> >
> > With this series, sub-keys and a value can co-exist under a parent key.
> > For example, following config is allowed.
> >
> >  foo = value1
> >  foo.bar = value2
> >
> > Note, since there is no syntax to put a raw value directly under a
> > structured key, you have to define it outside of the brace. For example,
> >
> >  foo {
> >      bar = value1
> >      bar {
> >          baz = value2
> >          qux = value3
> >      }
> >  }
> >
> > Also, the order of the value node under a key is fixed. If there
> > are a value and subkeys, the value is always the first child node
> > of the key. Thus if user specifies subkeys first, e.g.
> >
> >  foo.bar = value1
> >  foo = value2
> >
> > In the program (and /proc/bootconfig), it will be shown as below
> >
> >  foo = value2
> >  foo.bar = value1
> >
> >
> > Thank you,
> >
> > ---
> >
> > Masami Hiramatsu (4):
> >       bootconfig: Change array value to use child node
> >       bootconfig: Support mixing a value and subkeys under a key
> >       tools/bootconfig: Support mixed value and subkey test cases
> >       docs: bootconfig: Update for mixing value and subkeys
> >
> >
> >  Documentation/admin-guide/bootconfig.rst           |   30 +++++++-
> >  fs/proc/bootconfig.c                               |    2 -
> >  include/linux/bootconfig.h                         |   38 +++++++++-
> >  lib/bootconfig.c                                   |   76 +++++++++++++++-----
> >  tools/bootconfig/main.c                            |   47 ++++++++++--
> >  tools/bootconfig/samples/bad-mixed-kv1.bconf       |    3 -
> >  tools/bootconfig/samples/bad-mixed-kv2.bconf       |    3 -
> >  tools/bootconfig/samples/bad-override.bconf        |    3 -
> >  tools/bootconfig/samples/bad-override2.bconf       |    3 -
> >  tools/bootconfig/samples/good-mixed-append.bconf   |    4 +
> >  tools/bootconfig/samples/good-mixed-kv1.bconf      |    3 +
> >  tools/bootconfig/samples/good-mixed-kv2.bconf      |    3 +
> >  tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 ++
> >  tools/bootconfig/samples/good-mixed-override.bconf |    4 +
> >  14 files changed, 178 insertions(+), 47 deletions(-)
> >  delete mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
> >  delete mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf
> >  delete mode 100644 tools/bootconfig/samples/bad-override.bconf
> >  delete mode 100644 tools/bootconfig/samples/bad-override2.bconf
> >  create mode 100644 tools/bootconfig/samples/good-mixed-append.bconf
> >  create mode 100644 tools/bootconfig/samples/good-mixed-kv1.bconf
> >  create mode 100644 tools/bootconfig/samples/good-mixed-kv2.bconf
> >  create mode 100644 tools/bootconfig/samples/good-mixed-kv3.bconf
> >  create mode 100644 tools/bootconfig/samples/good-mixed-override.bconf
> >
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> Thanks a lot!
> I tested this on an Android virtual device(Cuttlefish) with a variety of
> parameters that included array values. I checked the output in /proc/bootconfig
> before and after the changes.
> I added a new parameter that failed before these changes and it worked great!
> Added 'androidboot.hardware=cutf_cvm ' which worked with
> 'androidboot.hardware.gralloc = "minigbm"' that was already present.
> So,
> 
> Tested-by: Devin Moore <devinmoore@google.com>

Thanks Devin for testing it!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
