Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D638E0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhEXF0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhEXF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:26:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A170C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:25:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso9725447pjx.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GhZ+fbzH+vfIhOx6yI5V3is0jZ3e02lSOnCZzlDb+g4=;
        b=fbAx/NH4RUPFkIpEiiALRpMEV4dXrXjH0jUcIqjYQulVnnBaxlWyOul180cWdJEqf7
         XUnRRkCgBjuZun86gHMa5HxSc8yYjmXlUA8RfeK02BH8vVwhpFN+bP/xT60cKqaiL1Qi
         /5xrlbJJT7tMS6AXDDyQLwfkOxR/hJxBboUi1G8Y0Nph/Xg4ChT2gE9bgMl1gRhJDKMf
         eRfGhtYovz8+hboaIjYUpGEIqZSBUpoR0wf8CeTwqfKWT08ymCrrmI23CF7gWSA9/VHx
         NVvCMiPcl6NIgOBEFsQ48kpRU7SRerotERn7UsXXUruYNyrEozT+SKBNCikLz0H1diWt
         Xeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GhZ+fbzH+vfIhOx6yI5V3is0jZ3e02lSOnCZzlDb+g4=;
        b=Z2CaSp4A0041gGWJcoHDTV5UOk1MaOKAl/xcuJzSjqD8m/DdH7PabSgWbMcHP9ciM9
         hIkwQ28xxge8/Dbj0Ko4qiAvAOA4yWufhPw+v724xZ9bJX+rsTtZJ3oOTNeEr0MMItSt
         h+NtGWlE/JI669D5yoj1X1SINWcpSO57t2JiFb9tB1z387HLgPTHkYRWIO67HCodR8tr
         IunBKu7Bm/TXSCLPdLdIQLbW6OtIVHuIioLn6XsKA39NoO45dc8V0f7AeoZd4WkyGDWm
         /Ode0r+S6EDBhbwa+WG2BCSyKCzGsLdN+W03mgxPMCpePdc6/RJDkt4ntDfG+OASndAj
         6sQg==
X-Gm-Message-State: AOAM532WLt13Kf54k5XZK7Ih35UEb8nYpC+ZwScFRAlUq2rTko3w2AUh
        Xfi/f+akKKtw5QcKjho1XtAMgA==
X-Google-Smtp-Source: ABdhPJwt+Z1hnYtuL116Rr5ZOJDI00RwZinNVXk+hgNJUHq/r9oyErIv/9dKNzrDcbZcnprhY/n+uA==
X-Received: by 2002:a17:90b:3615:: with SMTP id ml21mr23502748pjb.194.1621833912763;
        Sun, 23 May 2021 22:25:12 -0700 (PDT)
Received: from [2620:15c:17:3:9016:8a6d:7de4:aa23] ([2620:15c:17:3:9016:8a6d:7de4:aa23])
        by smtp.gmail.com with ESMTPSA id l5sm3897193pff.20.2021.05.23.22.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 22:25:12 -0700 (PDT)
Date:   Sun, 23 May 2021 22:25:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [mm/slub]  ad36bafb3b:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
In-Reply-To: <20210518170700.0ffdcaeb55cf64607120d5be@linux-foundation.org>
Message-ID: <7b54b481-a7b-f06e-aef2-ed529af3aaf5@google.com>
References: <20210516144152.GA25903@xsang-OptiPlex-9020> <20210518170700.0ffdcaeb55cf64607120d5be@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021, Andrew Morton wrote:

> On Sun, 16 May 2021 22:41:52 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: ad36bafb3bcdfdb98ae3516285bbb3ecd51d1597 ("mm/slub: use stackdepot to save stack trace in objects")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> 
> I expect
> https://lkml.kernel.org/r/20210516195150.26740-1-vbabka@suse.cz will
> fix this?
> 

Yes, that should do it.
