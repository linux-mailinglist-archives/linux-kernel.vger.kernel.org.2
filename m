Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB13F38E7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 07:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhHUFto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 01:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhHUFth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 01:49:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C84BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 22:48:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so8688056pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NWXh61nIoxEnUM9HmpK2vkre7I4Nt4vNqnfH4nx8Gv0=;
        b=YmZkRmn9/vVLBlFObf9NnGXVGhH8V3iQtAILZsfzE3JMzuOLEczWRP6sjuVNl38G7s
         oEL5nu8XVyzSR3Tt9kF41vB00eMPt2jG7/xDp0wnCOAXLvoBPxm3AUXVkiF+6Y3A69LF
         Pr/il4wuNgDTrV3ZoGR6RLTPNqJzVFd4XR3Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWXh61nIoxEnUM9HmpK2vkre7I4Nt4vNqnfH4nx8Gv0=;
        b=K+VmFC+D4NKOPu49y9GJC3uzniWnCFnc2ZjLZAExn5bSSGuo6GtQImq4UfGDJsBJHz
         U9kA9tBZGoMX8rtmlo9/Tq0eiOsgkbIVJRi+7QQcYYvuLqltpGJHa3ZKlAi3Qa743ZWF
         W+6H6442fezrk0sWtOOWkoIEd7XpOH2XEaTa4wz40ozy0LuJSMO7L/dAkhUBgZ9ryzC6
         go5DdaPEko9rw9ioAGXGg+sdRvyh+XB1un1kG02r07R+KT7DIXj6XhKgna2dRcQmlOm2
         ENXRB0DeXgG2SqOUqCBhBthqMtRHTHiQ864vabZFNbV5OvlGZYX3tkdTScW5bBPzW3ds
         DLyg==
X-Gm-Message-State: AOAM530x42abKmWzr7yCsfWgDdGBbYDv+vAyYFeLd9bCnmDIRDEWrMoy
        a3F/CWWM/3nPiAOsghXTsqUCww==
X-Google-Smtp-Source: ABdhPJzLEWbzpC4HsQYdgNaLHNpSsaZSsNQfLQVyDp5uC59uEnUnO1jM7nkLa7XS75beJmuid15DTw==
X-Received: by 2002:a17:90a:bd18:: with SMTP id y24mr8500824pjr.83.1629524938555;
        Fri, 20 Aug 2021 22:48:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p17sm13227181pjg.54.2021.08.20.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 22:48:57 -0700 (PDT)
Date:   Fri, 20 Aug 2021 22:48:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: linux-next: Tree for Aug 20 (Wno-alloc-size-larger-than)
Message-ID: <202108202248.921E8C66@keescook>
References: <20210820192615.23e2e617@canb.auug.org.au>
 <2706a406-9f72-7df1-03f6-f8e852897eb2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2706a406-9f72-7df1-03f6-f8e852897eb2@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 02:54:05PM -0700, Randy Dunlap wrote:
> On 8/20/21 2:26 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20210819:
> > 
> 
> Both linux-next and mmotm have many of these warnings when using
> gcc (SUSE Linux) 7.5.0:
> 
> cc1: warning: unrecognized command line option '-Wno-alloc-size-larger-than'

Ew. Thanks for letting me know. I thought I'd verified this existed in
gcc going back to 4.9, but it looks like I did something wrong in that
test.

I think this should fix it:

diff --git a/Makefile b/Makefile
index b0fafc41b686..e33ffa05899e 100644
--- a/Makefile
+++ b/Makefile
@@ -1097,7 +1097,7 @@ endif
 ifdef CONFIG_CC_IS_GCC
 # The allocators already balk at large sizes, so silence the compiler
 # warnings for bounds checks involving those possible values.
-KBUILD_CFLAGS += -Wno-alloc-size-larger-than
+KBUILD_CFLAGS += $(call cc-option, -Wno-alloc-size-larger-than)
 endif
 
 # disable invalid "can't wrap" optimizations for signed / pointers

-- 
Kees Cook
