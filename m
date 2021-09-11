Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0482407A77
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 23:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhIKVOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 17:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhIKVOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 17:14:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E065C061757
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 14:13:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 5so3364191plo.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aQYoFqAi5ik4tbMfLghNKTAjNiIYA7qEoxNw70ugRnk=;
        b=fQqtTvjfW6Uk6TP6THx9qVsF+7pvLtOCmKdZdoZ1Tt27SsxgZeLvTzyrSDB9EnO8qY
         LeBAFN/3DRw9NR3vK7IcHpY4SZRmh1C9OwRKKneRmG1wIii+fWP1Jnw5a7ty0GyLmIzD
         0DTvX+pyLazs8O7KNbw8Nf9rSQ7ytTxaUeT8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aQYoFqAi5ik4tbMfLghNKTAjNiIYA7qEoxNw70ugRnk=;
        b=6B2BiJQ1olphhoyPeSdZIyyByDhn6tibGYVKsKY1PjN2aEPKSVzEm5LhgLRdLjc/yr
         BvHdRklSpTtf0EkhqO9T5LnTCQzfAiiCoprmsLHxVWCUdjTanQSqCzCbUv9TSYKMg8xt
         rd0uSd6wOCVqpxVbAs2UyiG4M49VLyGgaymGyWFB8Ptp+Ut2yhEixvU+ckpT/a+h5B4p
         kf/gIIBeAlWsk+lD2/Du6SYni+zB8pS9dKhkHk0y2RvatFxg49kOf3H7YibW7rCwBrGY
         h+NdKlAp8LbFEo4Vezakhk+eO8eC9WBGEjNaZ0raI+z9YdVMIeU5NiCJffO4oQKiE7X0
         nWJA==
X-Gm-Message-State: AOAM532DWVI5cjLz39RNeqlqzydtiDObiunDG60pqNWoOKz6wCgR3u24
        5/qQJkIXZJ9Rid/K29VXRD0zgQ==
X-Google-Smtp-Source: ABdhPJw0i4ZOH3FiIvR3nlDfzLLv0nF5OYs1OW8BjpJQXrkxYMcmvo8MqIVe1Lg7l2HBwwdP7jxKFg==
X-Received: by 2002:a17:90a:428f:: with SMTP id p15mr4765498pjg.75.1631394800769;
        Sat, 11 Sep 2021 14:13:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a21sm2489063pjo.14.2021.09.11.14.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 14:13:20 -0700 (PDT)
Date:   Sat, 11 Sep 2021 14:13:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/1] x86: change default to
 spec_store_bypass_disable=prctl spectre_v2_user=prctl
Message-ID: <202109111411.C3D58A18EC@keescook>
References: <87eel8lnbe.fsf@nanos.tec.linutronix.de>
 <20201104235054.5678-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104235054.5678-1-aarcange@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 06:50:54PM -0500, Andrea Arcangeli wrote:
> Switch the kernel default of SSBD and STIBP to the ones with
> CONFIG_SECCOMP=n (i.e. spec_store_bypass_disable=prctl
> spectre_v2_user=prctl) even if CONFIG_SECCOMP=y.

Hello x86 maintainers!

I'd really like to get this landed, so I'll take this via the
seccomp-tree unless someone else speaks up. This keeps falling off
the edge of my TODO list. :)

-Kees

-- 
Kees Cook
