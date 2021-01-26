Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C411B3054BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhA0HeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317488AbhA0AEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:04:05 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D57C061353
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:28:47 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n7so177097oic.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6elxq1WfF4E41ZiBczRrJyQmMODP+O0N7PSHZ9Kx/14=;
        b=AuzqKJ94rmZ3lCpEcfqI5NsAgVFHvpLo6cHeoOZKK/GpHi6W5cv3GwWc6hUhWxBxnv
         WHCl6R8Q+Os3QUsUOQJA50Q5YtBvL1jUO3gD3ZEWyZgsrxvaGn+kW9I4nKieg397ml3d
         38Rq/CmX7T4sjBr5YoOrSFTHZEnnDn5QzNJrGeI1A36VRJdy6lcI77reKvNjyjPus1gB
         N0JBff//11xHi07IYuRyWz0OP8qcIhCF6prjSNziTmSLOUE/X5F3dJUx8vzqefTR/XAx
         o99ujyveMc11O005JQmFa28uLzKVvlSaHYrv3F0IcWmlmfrdavEpVFEZg6qyynYxcezE
         31Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6elxq1WfF4E41ZiBczRrJyQmMODP+O0N7PSHZ9Kx/14=;
        b=uWsK7aqMyDVBuV7tXAe2zMAV9EBgo6d0i3J5hZC5sXNNhePyCW+vxB7FKx95c/Ek0b
         +xnFpCj7PN5CiLTIIXegZGUcIHl+ASQAVsKqguTZsujopQ7J30/j77lUJ1njNxsgt6x0
         MbVR6EwGYFIqAwPKb1+PLWzF4Hrv730PhCUVvC/Cv1bzYN62l2xwcZuOn207qwYaZemf
         1R60zNgP1U1n6yvuNVt/C0r3NvyTIjG+Y3MR2qMInrEkjD9WWL503BxvwVRuqSoZfwm/
         eff3/Xr/ArS9Z+Jb94q/OFzUPKlliTPoCn4Ed2xcYMMOPVbN+fgAbfh2OyxmWPq1gQs5
         p3/A==
X-Gm-Message-State: AOAM531XvM58UOeAQo9eYRRILFqx1Zsxuz8LYe/2Du68xVBCQrpxN7Hx
        cAf+TkR851FN0+5YDd0hL5a00lSfGoS/oA==
X-Google-Smtp-Source: ABdhPJxd9Vg4/FGYqUZdNOcBAq3TbLrlQNMDdaP1cglRedmblvFJcX4xEsB02WyUooPtAkZkHh0j1A==
X-Received: by 2002:aca:ecc8:: with SMTP id k191mr1341900oih.179.1611703725081;
        Tue, 26 Jan 2021 15:28:45 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g13sm26718otl.60.2021.01.26.15.28.43
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2021 15:28:44 -0800 (PST)
Date:   Tue, 26 Jan 2021 15:28:22 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Will Deacon <will@kernel.org>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 0/8] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
In-Reply-To: <20210126230851.GE30941@willie-the-truck>
Message-ID: <alpine.LSU.2.11.2101261522260.2650@eggly.anvils>
References: <20210120173612.20913-1-will@kernel.org> <20210126230851.GE30941@willie-the-truck>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021, Will Deacon wrote:
> On Wed, Jan 20, 2021 at 05:36:04PM +0000, Will Deacon wrote:
> > Hi all,
> > 
> > This is version four of the patches I previously posted here:
> > 
> >   v1: https://lore.kernel.org/r/20201209163950.8494-1-will@kernel.org
> >   v2: https://lore.kernel.org/r/20210108171517.5290-1-will@kernel.org
> >   v3: https://lore.kernel.org/r/20210114175934.13070-1-will@kernel.org
> > 
> > The patches allow architectures to opt-in at runtime for faultaround
> > mappings to be created as 'old' instead of 'young'. Although there have
> > been previous attempts at this, they failed either because the decision
> > was deferred to userspace [1] or because it was done unconditionally and
> > shown to regress benchmarks for particular architectures [2].
> > 
> > The big change since v3 is that the immutable fields of 'struct vm_fault'
> > now live in a 'const' anonymous struct. Although Clang will silently
> > accept modifications to these fields [3], GCC emits an error. The
> > resulting diffstat is _considerably_ more manageable with this approach.
> 
> The only changes I have pending against this series are cosmetic (commit
> logs). Can I go ahead and queue this in the arm64 tree so that it can sit
> in linux-next for a bit? (positive or negative feedback appreciated!).

That would be fine by me: I ran v3 on rc3, then the nicer smaller v4
on rc4, and saw no problems when running either of them (x86_64 only).

Hugh
