Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C649840D9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbhIPMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239479AbhIPMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631794936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ymv9li1CgJxh/GaLdasD/dWKyAKgiCu4B7/vDC8PJC4=;
        b=UvlmQKgQR032KS+VY8Npuham+DVKqh3mWSR1EMltlZEBE8NLP/9WhElTv509rmUOb8KaZL
        L32HYIf3YEAVCKGGSqvNMjJRwrjBtpvZBzCJjeG7GsQpoozcLlaqEWa8wDK1VILnsSImKj
        +fIRMw36UtnCzohcvnKumOLGoQ/9yYw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-XUsYWJiHMaiRJ8XTSnSElQ-1; Thu, 16 Sep 2021 08:22:14 -0400
X-MC-Unique: XUsYWJiHMaiRJ8XTSnSElQ-1
Received: by mail-yb1-f198.google.com with SMTP id 124-20020a251182000000b005a027223ed9so15917997ybr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 05:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymv9li1CgJxh/GaLdasD/dWKyAKgiCu4B7/vDC8PJC4=;
        b=mFpfkNHLNi5p+LYT6p0CXmllLzj/mdjjT8W05GPRdED27ZO1dX06+DbvUJKW5b3El8
         TqR59bG1vIcUd/zomrLGvmiPksj97LxqpzjDKTZLF62nk4p9kt1NR04VHwMwF8DdUIja
         ehpEI7GXm1lyoNRuJMArsAWaMrp0TrB7tAdMcTXjHi8+WPblPfxB8voi3xbdLfcC75PV
         7kgZumGzM3UBpisvrQV2rvE5N6xzvET7y41/HQug7BXG4vmvkEQKFFoHJNLDsHrDwk4Y
         XxJ0voQoVYhQlz/np8YQZ0LUTSBb5Z4uKs1sZkeFiEINfugwcEDh4UjHhXXswXJTtNhw
         e03Q==
X-Gm-Message-State: AOAM531t8Mz3MCLhqpiekCGVbPXlHzn6Ujr/Rvd0vhPanyFmcrI/ps1f
        X0to74U7+rAP2RCROrNz6T3p+5Neb6OOZxlJFShl1dGF5BdWm+zbC1UYlNe4zyDpiQ6N4k3RkOc
        QX4uRcF+odphkysZ+U/xjotXTDTGRsj+XmQmp97rj
X-Received: by 2002:a25:3ac1:: with SMTP id h184mr6878347yba.237.1631794933781;
        Thu, 16 Sep 2021 05:22:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc6RD5B2bxsTmt0DJCzp+W7Vw4ceUX+846y8Np6i2Sb32yns9SgU2rjyu5g/nA7Alg1QDxICAlXe9X7D3qjqw=
X-Received: by 2002:a25:3ac1:: with SMTP id h184mr6878318yba.237.1631794933438;
 Thu, 16 Sep 2021 05:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <202109162036.zghQuRrY-lkp@intel.com>
In-Reply-To: <202109162036.zghQuRrY-lkp@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Sep 2021 14:22:01 +0200
Message-ID: <CAFqZXNuv-d4WFvaVVa1WqzkrP6Wepu6QEKcUH=VejnP2OZz66A@mail.gmail.com>
Subject: Re: [selinuxproject-selinux:stable-5.15 1/1] include/linux/rcupdate.h:395:2:
 warning: passing argument 1 of 'security_locked_down' discards 'const'
 qualifier from pointer target type
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 2:08 PM kernel test robot <lkp@intel.com> wrote:
> tree:   https://github.com/SELinuxProject/selinux-kernel stable-5.15
> head:   c491f0a471580712a4254adece400c3ebb3d8e44
> commit: c491f0a471580712a4254adece400c3ebb3d8e44 [1/1] lockdown,selinux: fix wrong subject in some SELinux lockdown checks
> config: um-x86_64_defconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/SELinuxProject/selinux-kernel/commit/c491f0a471580712a4254adece400c3ebb3d8e44
>         git remote add selinuxproject-selinux https://github.com/SELinuxProject/selinux-kernel
>         git fetch --no-tags selinuxproject-selinux stable-5.15
>         git checkout c491f0a471580712a4254adece400c3ebb3d8e44
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um SUBARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/rbtree.h:24,
>                     from include/linux/mm_types.h:10,
>                     from include/linux/mmzone.h:21,
>                     from include/linux/gfp.h:6,
>                     from include/linux/mm.h:10,
>                     from drivers/char/mem.c:12:
>    drivers/char/mem.c: In function 'open_port':
> >> include/linux/rcupdate.h:395:2: warning: passing argument 1 of 'security_locked_down' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      395 | ({ \
>          | ~^~~
>      396 |  RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
>          |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      397 |  rcu_check_sparse(p, space); \
>          |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      398 |  ((typeof(*p) __force __kernel *)(p)); \
>          |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      399 | })
>          | ~~
>    include/linux/rcupdate.h:587:2: note: in expansion of macro '__rcu_dereference_protected'
>      587 |  __rcu_dereference_protected((p), (c), __rcu)
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/cred.h:299:2: note: in expansion of macro 'rcu_dereference_protected'
>      299 |  rcu_dereference_protected(current->cred, 1)
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/char/mem.c:620:28: note: in expansion of macro 'current_cred'
>      620 |  rc = security_locked_down(current_cred(), LOCKDOWN_DEV_MEM);
>          |                            ^~~~~~~~~~~~
>    In file included from include/linux/fs_context.h:14,
>                     from include/linux/fs_parser.h:11,
>                     from include/linux/shmem_fs.h:11,
>                     from drivers/char/mem.c:25:
>    include/linux/security.h:1347:53: note: expected 'struct cred *' but argument is of type 'const struct cred *'
>     1347 | static inline int security_locked_down(struct cred *cred, enum lockdown_reason what)
>          |                                        ~~~~~~~~~~~~~^~~~

Ah, I forgot to add the const qualifier to the function definition in
the CONFIG_SECURITY=n branch... Paul, will you amend the commit or
should I send an updated patch?

>
>
> vim +395 include/linux/rcupdate.h
>
> 76c8eaafe4f061 Paul E. McKenney        2021-04-21  379
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  380  #define __rcu_access_pointer(p, space) \
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  381  ({ \
> 7d0ae8086b8283 Paul E. McKenney        2015-03-03  382          typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
> 423a86a610cad1 Joel Fernandes (Google  2018-12-12  383)         rcu_check_sparse(p, space); \
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  384          ((typeof(*p) __force __kernel *)(_________p1)); \
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  385  })
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  386  #define __rcu_dereference_check(p, c, space) \
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  387  ({ \
> ac59853c06993a Pranith Kumar           2014-11-13  388          /* Dependency order vs. p above. */ \
> 506458efaf153c Will Deacon             2017-10-24  389          typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
> f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  390          RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
> 423a86a610cad1 Joel Fernandes (Google  2018-12-12  391)         rcu_check_sparse(p, space); \
> ac59853c06993a Pranith Kumar           2014-11-13  392          ((typeof(*p) __force __kernel *)(________p1)); \
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  393  })
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  394  #define __rcu_dereference_protected(p, c, space) \
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28 @395  ({ \
> f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  396          RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
> 423a86a610cad1 Joel Fernandes (Google  2018-12-12  397)         rcu_check_sparse(p, space); \
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  398          ((typeof(*p) __force __kernel *)(p)); \
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  399  })
> 995f1405610bd8 Paul E. McKenney        2016-07-01  400  #define rcu_dereference_raw(p) \
> 995f1405610bd8 Paul E. McKenney        2016-07-01  401  ({ \
> 995f1405610bd8 Paul E. McKenney        2016-07-01  402          /* Dependency order vs. p above. */ \
> 506458efaf153c Will Deacon             2017-10-24  403          typeof(p) ________p1 = READ_ONCE(p); \
> 995f1405610bd8 Paul E. McKenney        2016-07-01  404          ((typeof(*p) __force __kernel *)(________p1)); \
> 995f1405610bd8 Paul E. McKenney        2016-07-01  405  })
> ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  406
>
> :::::: The code at line 395 was first introduced by commit
> :::::: ca5ecddfa8fcbd948c95530e7e817cee9fb43a3d rcu: define __rcu address space modifier for sparse
>
> :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

