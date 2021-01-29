Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57328308D69
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhA2T2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhA2T15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:27:57 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48FCC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:27:16 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id ew18so5004876qvb.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W2ghzd/CLjNAIxuHclEmxfn8E0lo4q/ihR7kL0nL0Qo=;
        b=dx4px5JIWtlW+hXmDMfsh0lbw2eBI/HqPO96aQv/XbR7nIF2lDFu+76hEaEoSF8kEq
         VBfB9ud9n6WozMQMD7kajGwHWGWTiLfmBSAfGs73f3Dj+32DfTUxwO5PEz/2rr/LShhB
         g6J2ynSIT9QelMj4qT7P/Qt3ghjyircEwYkY0GnSrWVPmKAaBR50atAEjtECMw2Htut+
         EIPV5t1U/O5B5n8amw+LRIQiXOqFaca051F7+F/Pg643XJt3FDDMPH6TLAbc85n2Zgfx
         g6ox9l9OkZxhi49dsVUWgIqpVM9PhWTbksGCVNqFLzxj2XpuzPC25S+cZwkv5rCuomIT
         UwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W2ghzd/CLjNAIxuHclEmxfn8E0lo4q/ihR7kL0nL0Qo=;
        b=MSd+BPFO8D0qnMQOwtmHQ/mqM4D6DCofZkC73Hj8cmcovhNavTZKliWah6CkBenVDE
         3fo5Z7q6w2QXPeE9CHynv4digUL+JkEYxlf6m4S1kzlkwzUOA8wzQ8b4aPbml6bd+gZS
         eaFJC/X0NkwP6smi7mPAxeVydK7P3C0l7duPHHR1Ph8C59/oEwttRzazlMOp2vtoD6vY
         pI2Llcfwr9wdLilD/DvjHXhXv1yfR85nL39lbvvrS22c5fJ/sjTbgQir7PdspMdRIqdO
         r+qDlRw7WlH7NklV+2t0NUFw385qxRt5CgOgbww+MhsOruH4SLtnRv8pnuItunoZZMyB
         9LrQ==
X-Gm-Message-State: AOAM531UgomvoSt/OC7GeINVrg1d900gz+ghGgE/mRerIgw5ODG4Jayn
        GTCUKj1r8TUBS9+odp6GwC/Ecg==
X-Google-Smtp-Source: ABdhPJy1FKErBXTLTJSPKr6EhyRWTnTFZJmnrgy0+6EE386XpEm0z8xqzmrUpr/E7WVv1dEVmDQbnQ==
X-Received: by 2002:a0c:f481:: with SMTP id i1mr5384974qvm.50.1611948435943;
        Fri, 29 Jan 2021 11:27:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:f735])
        by smtp.gmail.com with ESMTPSA id s129sm2687878qkh.37.2021.01.29.11.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 11:27:15 -0800 (PST)
Date:   Fri, 29 Jan 2021 14:27:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Saravanan D <saravanand@fb.com>
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, songliubraving@fb.com, tj@kernel.org
Subject: Re: [PATCH V6] x86/mm: Tracking linear mapping split events
Message-ID: <YBRhkSIuNvkrZo5o@cmpxchg.org>
References: <20210128212048.oopcyfdf4j2lc663@devvm1945.atn0.facebook.com>
 <20210128233430.1460964-1-saravanand@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128233430.1460964-1-saravanand@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 03:34:30PM -0800, Saravanan D wrote:
> To help with debugging the sluggishness caused by TLB miss/reload,
> we introduce monotonic hugepage [direct mapped] split event counts since
> system state: SYSTEM_RUNNING to be displayed as part of
> /proc/vmstat in x86 servers
> 
> The lifetime split event information will be displayed at the bottom of
> /proc/vmstat
> ....
> swap_ra 0
> swap_ra_hit 0
> direct_map_level2_splits 94
> direct_map_level3_splits 4
> nr_unstable 0
> ....
> 
> One of the many lasting sources of direct hugepage splits is kernel
> tracing (kprobes, tracepoints).
> 
> Note that the kernel's code segment [512 MB] points to the same
> physical addresses that have been already mapped in the kernel's
> direct mapping range.
> 
> Source : Documentation/x86/x86_64/mm.rst
> 
> When we enable kernel tracing, the kernel has to modify
> attributes/permissions
> of the text segment hugepages that are direct mapped causing them to
> split.
> 
> Kernel's direct mapped hugepages do not coalesce back after split and
> remain in place for the remainder of the lifetime.
> 
> An instance of direct page splits when we turn on
> dynamic kernel tracing
> ....
> cat /proc/vmstat | grep -i direct_map_level
> direct_map_level2_splits 784
> direct_map_level3_splits 12
> bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @ [pid, comm] =
> count(); }'
> cat /proc/vmstat | grep -i
> direct_map_level
> direct_map_level2_splits 789
> direct_map_level3_splits 12
> ....
> 
> Signed-off-by: Saravanan D <saravanand@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
