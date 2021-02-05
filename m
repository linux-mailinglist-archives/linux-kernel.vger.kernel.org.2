Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0D310FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhBEQrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbhBEQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:45:13 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DEEC061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:26:55 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o16so5137477pgg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PTifcKN8spL3ClpqXcFGHeUFpoZ67atZiPMBU3wuDs=;
        b=HS3+D2H5qhhSXm5Mhv9pAeIQrIxIDrLLhrbubqDRQEHMzcshMMVXCtDGapcRO+w0Mh
         Ry8wZrTRSu5DzM6JkcjQdB4e+rwquqcyHdk4BllNxbt4vd8dhxxn1Gu3pKXPPcBOYGMW
         19euoavfkMowdIXaQ6HyNSFWSTVzj4YuS1o84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PTifcKN8spL3ClpqXcFGHeUFpoZ67atZiPMBU3wuDs=;
        b=o19FsY+rzQI6EvQcEBBdmZfVxxw6E09oI+xhWAEGdr/hKgCgz1KwCAEBtdDYeZwAGG
         NgQajba8nMCEQuk4JXGCi/QS+nzJvKuUighpnvGHYIthl0Ainy34Rw/iY2sucH0MEV2U
         ZY5phpvVtw+z28rPaiJfn7U6MnEuxm60bEnln9h7pk01DjrLBIQCJoDAon/wL+v7tnvN
         ws5UqimDUrEGr0pFuHlZyL05JR0kP1Fc5eCFeogZUIakgJx+iKQNgaJ09PqAbrMc/OXJ
         skiBppc6JXmEOJ7aRTFl8MzIlfVTKKm16BiYXmiIw+Zy6T4gGbfNB2z6/tuJvJbYmeRc
         4Y5Q==
X-Gm-Message-State: AOAM530BrKHCG80yJRWcdn5X2RaMQJVxI1QqGHP+ZrLTtEllGgAuCThm
        gas4B94HVPr7eU2wFNEvkI8iAA==
X-Google-Smtp-Source: ABdhPJyovoQ5m59St1KtJeobhPYp42OO5wY6rGeSKoIt1K/gK6R9dUzhVZK3/QwGz1Hw+E4zxyllEA==
X-Received: by 2002:a63:1c08:: with SMTP id c8mr5528896pgc.228.1612549614604;
        Fri, 05 Feb 2021 10:26:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm3441246pfd.130.2021.02.05.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:26:53 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:26:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 24/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
Message-ID: <202102051026.B250352D4@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-25-yu-cheng.yu@intel.com>
 <202102041235.BA6C4982F@keescook>
 <6d7dd90f-dc03-06ce-57a2-57e4c2f803f3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d7dd90f-dc03-06ce-57a2-57e4c2f803f3@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 03:41:59PM -0800, Yu, Yu-cheng wrote:
> On 2/4/2021 12:35 PM, Kees Cook wrote:
> > On Wed, Feb 03, 2021 at 02:55:46PM -0800, Yu-cheng Yu wrote:
> > > arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
> > >      Get CET feature status.
> > > 
> > >      The parameter 'args' is a pointer to a user buffer.  The kernel returns
> > >      the following information:
> > > 
> > >      *args = shadow stack/IBT status
> > >      *(args + 1) = shadow stack base address
> > >      *(args + 2) = shadow stack size
> > 
> > What happens if this needs to grow in the future? Should the first u64
> > contain the array size?
> > 
> > Otherwise, looks sensible.
> > 
> > -Kees
> > 
> 
> The first item is a bitmap, and there are two possible bits.  Should there
> be a need, we can then do things about it.  My thought at the moment is, we
> may not meet the situation.  Can we keep this for now?

Ah, good point. Yes, since that's a bitmap it ends up describing what
follows. This is fine as-is. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
