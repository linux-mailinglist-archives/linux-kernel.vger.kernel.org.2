Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D23AD2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhFRTfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFRTfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:35:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3944AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:32:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n12so8564810pgs.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9CauSEz6HxLbbaFiGe9BJb3XkCTojZuIQZ6pJCmdamk=;
        b=kbqqelvA5GagoUTjV2Hj39sC5YL1E+IXyGv4rHbi/6Ghd1iWgCjRhK2hrVE31va7Qb
         YW7+RFRVKdSj5OuBhweEINiTaVXZVVMYcQ8nmo/FTm73N3+nKmMu4vME7llEaOUpiZnu
         j2a7oj+qdKwSwzo1Z4vtAzEa1xWu1ThhexzCBP9oaQoJ1x1m0N2Cympz425esovFpqyT
         mj7dqrgOPkVDPAK+6ErUTh40c3PDeNItiQc1OzW6MrOvkON1Z9XfDKrUDqbnN2Kq94iL
         5g4oi2r6iA6+G1KbKqzNTKwU3Y+SR79Blp2TwZORdwBoH0qDEUxwRQTA2IzFht3sYyLb
         x0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9CauSEz6HxLbbaFiGe9BJb3XkCTojZuIQZ6pJCmdamk=;
        b=qX68NvzKK2vOffwlTQKtKW7dtfw/c2eDwnoGxFiwR8bNfqdWEXVwVq9mW8+NB6FUIs
         K9Hz+GcFe58v+YBZ7t72ZmvBQ6XNEo1rVBGPqdCWwam8phWhj/KOw9kyzQh4SgkzfrGE
         WfkPGW41QMTQIQpdpzhnVfGr0Wh0ofIlmH/5pKxQB+CjqrMbInQihnMc1hpckTUfl4th
         sgYw4P5bluew2wYh3N3/8PtaayxoqHq4s7WMhFvO4jqQmp6+2HpCbxdYoFASTg4sHkMP
         8S37g2HFPVIBFrvTZ6eZSjNMTnW8v8BENUa7orWbvEiUH7Li6IoATIsx5s8kGbLOgr3U
         GgDg==
X-Gm-Message-State: AOAM533YF+Dvr4G4HzvrFs1LsU8/Inw2VVIZ4bFzGrX2xTJlA1U+Pocd
        ppny7rUoBJZupBj4pdbcZducuA==
X-Google-Smtp-Source: ABdhPJwSqAPmwRB1YfSPHcy5nlQxpe4LdC2pC/eNINKTTeoYgbqQh899TSAqh9P+Lvu5/6c4oYdgKg==
X-Received: by 2002:a62:5444:0:b029:2e9:c69d:dc64 with SMTP id i65-20020a6254440000b02902e9c69ddc64mr6579262pfb.32.1624044775553;
        Fri, 18 Jun 2021 12:32:55 -0700 (PDT)
Received: from [2620:15c:17:3:3a6:a5d0:1984:a150] ([2620:15c:17:3:3a6:a5d0:1984:a150])
        by smtp.gmail.com with ESMTPSA id r8sm2009077pjr.37.2021.06.18.12.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:32:54 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:32:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     gumingtao <gumingtao1225@gmail.com>, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        gumingtao <gumingtao@xiaomi.com>
Subject: Re: [PATCH] slab: Use %s instead of function name
In-Reply-To: <CAKXUXMxyDaEnWeGNZpCmAFG-5OG0JVrHz0RPk18n_z+ZDKQ-cQ@mail.gmail.com>
Message-ID: <c51952f7-a355-b038-4377-f6673c413d1f@google.com>
References: <1624013943-13935-1-git-send-email-gumingtao@xiaomi.com> <CAKXUXMxyDaEnWeGNZpCmAFG-5OG0JVrHz0RPk18n_z+ZDKQ-cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021, Lukas Bulwahn wrote:

> > It is better to replace the function name with %s.
> >
> > Signed-off-by: gumingtao <gumingtao@xiaomi.com>
> > ---
> >  mm/slab_common.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index a4a5714..36127dc 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -381,8 +381,8 @@ kmem_cache_create_usercopy(const char *name,
> >                         panic("kmem_cache_create: Failed to create slab '%s'. Error %d\n",
> 
> I am just wondering:
> 
> Can you also make that refactoring change for the panic() call as well?
> 
> How about checking the whole file for such patterns and doing that
> change for all occurrences?
> 

Yeah, that would be ideal if gumingtao is willing to do it.  These are 
some instances where the function name actually mismatches.  gumingtao, 
would you be willing to do this?
