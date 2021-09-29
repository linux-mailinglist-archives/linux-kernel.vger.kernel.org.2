Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8887541C887
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbhI2Pgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbhI2Pgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:36:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52665C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:34:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i4so12608912lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Hf7pY/JKZgLnfEiK9B7AO8BfkN+o8wWy5PQX3tSxfI=;
        b=ED57SacT6G9Zh2FZj/sQBvo0yWX9FiJ2AHQXdcorOXTBVcZFVhH/UBxjSfoXFlsePR
         9GebQE2KgsGjDqpW9BhzlIiPv/mnDz2uOi6JkQNwT5oroX+H0Nospb/4IflYiomfPK/H
         2jHUlkqBsDsgvr8g+804bkii8ftU7evwT79LDNKcisZtfM1kgmSxoPUxJ1yr4uG3lltg
         Rj7SR76wni+f08sd1c7DTn/YfCh/axcJgRFIcssVkbW0e3JNnMJlo0080eQ77JqeKIMX
         sr5HFMI3PBJnn1oWF1jnZ4ryKHtbzTq9JJTLl7XagopNYqjuUdtF7bJ93ThQHJ1pyZ+R
         0KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Hf7pY/JKZgLnfEiK9B7AO8BfkN+o8wWy5PQX3tSxfI=;
        b=tHliqkI3jK/3l36cEqq0wM62pif3RgUhlu4/fgxDvNaq72nhEgcalU7I49rUpXBAcC
         nmcfFwOuDlaMcDXhJSJHmFIGI36UgP2b724B7bRb4VisFirdtGz+iOaSQoy4MdVipcfn
         9nTv3+qCErsiGXf+egGFH5Ic1QlUdFmTvj+i6p5q1dkVa0ollcWVe1UiQLpO5k3ZOhb6
         OhlcYr5jmT5iehmziO6sxNlkPYDABUJw4evO9mZmGstAs4XvCVY8Jo7QF5u5cOc4N7wj
         guVCaq4CWzlwudr7/vpQNW9nu/VW85e2j5XNxMscuhUb2W8iWjeIo1V2ZZ6VJ/7IXwcG
         L4eA==
X-Gm-Message-State: AOAM533XrU3ytmrJJhc3wgg+j5EKpwQ+OtSdlTTmX45DIXx9uylNb8uj
        S7B8Q7U9Mw8miSNvOtqiVUg=
X-Google-Smtp-Source: ABdhPJzb/8IBk1qVl/MHapOnC7+dTumhtP53xdwWj3NytelUd5jPq1UYo7GgT0PXgiLNYJwTfa0Efw==
X-Received: by 2002:a05:6512:3caa:: with SMTP id h42mr295998lfv.349.1632929692673;
        Wed, 29 Sep 2021 08:34:52 -0700 (PDT)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id i21sm23383lfo.248.2021.09.29.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:34:51 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id DA04D5A001E; Wed, 29 Sep 2021 18:34:50 +0300 (MSK)
Date:   Wed, 29 Sep 2021 18:34:50 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrey Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2] prctl: PR_SET_MM - unify copying of user's auvx
Message-ID: <YVSHmu0Wtin/2pXN@grain>
References: <YFpmdGXmGQ6IetoX@grain>
 <202109292307.smDkJddi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109292307.smDkJddi-lkp@intel.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:20:23PM +0800, kernel test robot wrote:
...
> sparse warnings: (new ones prefixed by >>)
> >> kernel/sys.c:1997:58: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void const [noderef] __user *addr @@     got unsigned long long [usertype] *[addressable] auxv @@
>    kernel/sys.c:1997:58: sparse:     expected void const [noderef] __user *addr
>    kernel/sys.c:1997:58: sparse:     got unsigned long long [usertype] *[addressable] auxv
>    kernel/sys.c:1068:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
>    kernel/sys.c:1068:32: sparse:     expected struct task_struct *p1
>    kernel/sys.c:1068:32: sparse:     got struct task_struct [noderef] __rcu *real_parent
>    kernel/sys.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
>    include/linux/sched/signal.h:710:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    include/linux/sched/signal.h:710:37: sparse:     expected struct spinlock [usertype] *lock
>    include/linux/sched/signal.h:710:37: sparse:     got struct spinlock [noderef] __rcu *
> 
> vim +1997 kernel/sys.c

Thanks for report! I happen to miss Dima's reply in first place as well :(
I'll take a look on this patch. The issie itself is implicit type conversion,
shouldn't be a bug in general but need to address as well. Will do.
