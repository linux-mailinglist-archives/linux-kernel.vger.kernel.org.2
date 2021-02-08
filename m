Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281453128B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 02:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBHBOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 20:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHBOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 20:14:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E8C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 17:13:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bl23so22053197ejb.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 17:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oEt0BgOZ2KHHMgo3SreNAxooDa7aDR95XrdYI5RtTx0=;
        b=ZboMpA+9nk4VmQ/ALBSckUzSFEND1UoZGDySZQVW8nyfNHbXPC7bj5Lgux2ryelTpe
         512Pv3SPXhtyiceD4FTx3NJGZiYTAuaK1IcHFfOE0AWn01tQkdDXthNdS6d6gpcQQ6EO
         PgdgEuHYBpgwlhqAd2Nbrb4MARICeqjw+pj6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oEt0BgOZ2KHHMgo3SreNAxooDa7aDR95XrdYI5RtTx0=;
        b=awYIogpbcD3udHzbX6f55C4VQybaQqZTvaB0TWZFRTh8zW0Ky1ES2FgJzIXeMc4KJv
         PPFqInbrV+9P+p1kGKoAd1bxJ1c8hwx6SLmbH3b7SFgnU89wqTuuFyNBsL3AA8cjDIoa
         7AhSQe1Afx6toBdop7zmLI3hhUk/SXTR8lioqZn6NBDtG9usgR4hzwGBZuN5ZI3yqS2s
         Xdie2PS53n6v+aNDqp+2ek1++4j27IpHHxtSWKNLFWMAVLZlS1op8fxM0DmQWvFJJDng
         l64nEikrZeeRa8hFbHGPr4t/T3KFSwVA0TAmBVxXs4KOgyQTmjqIpKS+iqDxAjmwhbUo
         6nng==
X-Gm-Message-State: AOAM530dquCjOpf2X6vXA/4RBgHYZco7xE2ouuAj3dSxQs5XpaSUz+PS
        u7303aUFICYG1uD6kdTcdPgfVw9MEYducA==
X-Google-Smtp-Source: ABdhPJxxwh+h9wjgtZYW4Z6cg/Rww9g+pcmmWejbpaQvqHWvqbRhZ9w+fpYrrRClXwEyaQJrjBrutQ==
X-Received: by 2002:a17:906:7cb:: with SMTP id m11mr15100322ejc.332.1612746837745;
        Sun, 07 Feb 2021 17:13:57 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id z22sm8254087edb.88.2021.02.07.17.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 17:13:57 -0800 (PST)
Date:   Mon, 8 Feb 2021 01:13:56 +0000
From:   Chris Down <chris@chrisdown.name>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <YCCQVDSl4eN7x6Yb@chrisdown.name>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
 <202102080635.uqNxyQZp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202102080635.uqNxyQZp-lkp@intel.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot writes:
>All errors (new ones prefixed by >>):
>
>   /usr/bin/ld: arch/um/drivers/xterm.o: in function `xterm_open':
>>> xterm.c:(.text+0x16b): undefined reference to `printk'
>>> /usr/bin/ld: xterm.c:(.text+0x1a8): undefined reference to `printk'
>   /usr/bin/ld: xterm.c:(.text+0x1f4): undefined reference to `printk'
>   /usr/bin/ld: xterm.c:(.text+0x25e): undefined reference to `printk'
>   /usr/bin/ld: xterm.c:(.text+0x2b5): undefined reference to `printk'
>   /usr/bin/ld: arch/um/drivers/xterm.o:xterm.c:(.text+0x31c): more undefined references to `printk' follow
>   collect2: error: ld returned 1 exit status

Ah yes, since it just uses it as extern. I'll fix it for v2.
