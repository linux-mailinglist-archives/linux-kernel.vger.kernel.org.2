Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0F38BFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhEUGpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhEUGpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:45:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9DAC061245
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:42:37 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 22so13819555pfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hl/qohgB2l3RB64t8f38Kc+WBgXz2CrEXkw4MtzNOz0=;
        b=hFlidlnBXquOFTvAU6cPyjWsXFebuppc7HfVBMYLmz4i/bFYW7fwXpNC8qzwP+IYjW
         eEQbXPAPZNG81f0zk9U10WQZ5EuigjxQCbxAdYGFmZ05wgTKm/KAFR+dn4plRitI0k1a
         UWImRtgIfBxQ81tUKr820gFKKYHJ5aFGGxPik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hl/qohgB2l3RB64t8f38Kc+WBgXz2CrEXkw4MtzNOz0=;
        b=R2H/AgO3SV5TDpnXJl93lqDeOtqtz9abooYrdYzHOAtgsTCx6kR3CrPHMJjvgwwHBE
         ad9TwDgJ5pFDxqmJmJsS7M1GgVV4WDcCfigTNtNVDvIsjBPlYQFGuD4xqLWx8s5s/hcL
         drlaQvcmF05Tps1G03tbQxv011m5w+Z0kl1pNxWqFLfLT11O7ZkKxIAIN2yG6mWMzXNv
         f6vQQczWvt/7y8egW0Y9saopvwd2oadqHhcHi5SBGOBXcst2/7m5DZBKDH+HR7vpVIYw
         s2VxZHMv0QzjJ98KqY/bCZczRhjzIPQ+Bzc42ss9X9qFsjetJOLgWsBT1CkPbZyEiEAa
         o7Wg==
X-Gm-Message-State: AOAM530NJ8F44gzX6zZ8wckqphu9CYbjInDEYWmP5pbsRGVdxQDkQud8
        48T3aDMHKmN/3PtRb9vH9WYgGw==
X-Google-Smtp-Source: ABdhPJzhaHY99PwQpKfDa1wNRy8NEmYunelNDqsOlYBX4rgShiWjjNeJ08Jmd6doyIuodpzFUWLu0g==
X-Received: by 2002:aa7:88d6:0:b029:2e3:b74b:2a5b with SMTP id k22-20020aa788d60000b02902e3b74b2a5bmr5563724pff.4.1621579356878;
        Thu, 20 May 2021 23:42:36 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id a20sm3582207pfc.186.2021.05.20.23.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:42:36 -0700 (PDT)
Date:   Fri, 21 May 2021 15:42:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <YKdWV2lznaxUKBM5@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
 <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
 <YKX/H0EwRRLM+cAa@google.com>
 <20210520145318.GJ4441@paulmck-ThinkPad-P17-Gen-1>
 <YKbhg30Q6YlerCoz@google.com>
 <20210521001443.GR4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521001443.GR4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/20 17:14), Paul E. McKenney wrote:
> > On a side note.
> > 
> > I wish we didn't have to put kvm_check_and_clear_guest_paused() all
> > over the place.
> > 
> > We do load jiffies at the start of check_cpu_stall(). So, in theory,
> > we can just use that captured jiffies (which can become obsolete but
> > so will grace period timestamps) value and never read current system
> > jiffies because they can jump way forward. IOW
> > 
> > 	jn = j + 3 * rcu_jiffies_till_stall_check() + 3;
> > 
> > instead of
> > 
> > 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
> > 
> > Then we probably can remove kvm_check_and_clear_guest_paused().
> > 
> > But that "don't load current jiffies" is rather fragile.
> > 
> > kvm_check_and_clear_guest_paused() is not pretty, but at least it's
> > explicit.
> 
> If this works for you, I am very much in favor!

Oh, no. Sorry for the noise. This is racy and won't work.
