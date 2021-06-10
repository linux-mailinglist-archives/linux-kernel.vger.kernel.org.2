Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FB3A2E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFJOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhFJOuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED0216128A;
        Thu, 10 Jun 2021 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623336492;
        bh=wQQTd1CqqkLhXd1KZGw/Nxb7g/KLKDgHa/hM2KdbUzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UY1OxWifY/XVi4JYcS5BifZL31aMbYnvmlchw9VSWxtJQRH1k70LUUpJtseMYYSHi
         /wtBkQ+bGABN6g/48+8fpi2lsarFZhyX8k+OdMKg5tFDDETJDYxTrLgnfgnd90Lf/8
         p1Sxh79Xc/Ml2IQ5fiMpWd1+K8uTGCdCBlWGSB+/O4iK2zBmsx7RibXIPRvx890MIA
         TRdhus1eVxphErJBn5I5gtbY/7naaf6NFo6mIJinurbEsbUyySZZ/VEJ/gVhbjFF5T
         EmtNkd+NmxPdLJK40gH5/YINmTrhhwcX9X0xTUFLbMqaqpckstEwk+Z/XtIBB7nqI/
         y11oVvpNL4Tdw==
Date:   Thu, 10 Jun 2021 23:48:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Devin Moore <devinmoore@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/6] bootconfig: Add mixed subkeys and value under
 the same key
Message-Id: <20210610234809.9d1e92cb3f04842e14c3d011@kernel.org>
In-Reply-To: <CAOELnJzW4boH=WadqW31hbWLhmZgNLD9+EiN0GJGBe1RCMxFaw@mail.gmail.com>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
        <CAOELnJzW4boH=WadqW31hbWLhmZgNLD9+EiN0GJGBe1RCMxFaw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 16:02:27 -0700
Devin Moore <devinmoore@google.com> wrote:

> On Wed, Jun 2, 2021 at 1:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > Here is the 4th version of the series which updates bootconfig to
> > support mixed subkeys and a value under the same key.
> > The 3rd version is completely wrong. I missed to picked up the older
> > (v1) patches to v3. So please ignore v3.
> >
> > Since the kernel cmdline accepts options like
> > "aaa.bbb=val1 aaa.bbb.ccc=val2", it is better that the bootconfig
> > also support it.
> >
> > Here is the previous series (v2):
> >   https://lore.kernel.org/lkml/162157886618.78209.11141970623539574861.stgit@devnote2/
> >
> > In this version, I rebased on top of the latest linus tree and
> > add the build error fix [1/6](*) and a cleanup patch [6/6].
> >
> > (*) https://lore.kernel.org/lkml/162087519356.442660.11385099982318160180.stgit@devnote2/
> >
> > Changes in v4
> >  [1/6]:
> >      - Added from separated thread. This is a fundamental fix.
> >  [6/6]:
> >      - New cleanup patch.
> >
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
> > Masami Hiramatsu (6):
> >       tools/bootconfig: Fix a build error accroding to undefined fallthrough
> >       bootconfig: Change array value to use child node
> >       bootconfig: Support mixing a value and subkeys under a key
> >       tools/bootconfig: Support mixed value and subkey test cases
> >       docs: bootconfig: Update for mixing value and subkeys
> >       bootconfig: Share the checksum function with tools
> >
> >
> >  Documentation/admin-guide/bootconfig.rst           |   30 +++++++-
> >  fs/proc/bootconfig.c                               |    2 -
> >  include/linux/bootconfig.h                         |   58 ++++++++++++++-
> >  init/main.c                                        |   12 ---
> >  lib/bootconfig.c                                   |   76 +++++++++++++++-----
> >  tools/bootconfig/include/linux/bootconfig.h        |    4 +
> >  tools/bootconfig/main.c                            |   62 +++++++++++-----
> >  tools/bootconfig/samples/bad-mixed-kv1.bconf       |    3 -
> >  tools/bootconfig/samples/bad-mixed-kv2.bconf       |    3 -
> >  tools/bootconfig/samples/bad-override.bconf        |    3 -
> >  tools/bootconfig/samples/bad-override2.bconf       |    3 -
> >  tools/bootconfig/samples/good-mixed-append.bconf   |    4 +
> >  tools/bootconfig/samples/good-mixed-kv1.bconf      |    3 +
> >  tools/bootconfig/samples/good-mixed-kv2.bconf      |    3 +
> >  tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 ++
> >  tools/bootconfig/samples/good-mixed-override.bconf |    4 +
> >  16 files changed, 205 insertions(+), 71 deletions(-)
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
> 
> Thanks for the updated patches.
> I tested the v4 changes on an Android virtual device(Cuttlefish) with
> a variety of
> parameters that included array values. I checked the output in /proc/bootconfig
> before and after the changes.
> I added a new parameter that failed before these changes and it worked great!
> Added 'androidboot.hardware=cutf_cvm ' which worked with
> 'androidboot.hardware.gralloc = "minigbm"' that was already present.
> 
> These changes really help Android simplify some boot configuration
> processes. We will be using it ASAP.


Thanks Devin.

Hi Steve, can you also pick this series? (except [1/6], which you've already merged)

Thank you,

> 
> So,
> 
> Tested-by: Devin Moore <devinmoore@google.com>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
