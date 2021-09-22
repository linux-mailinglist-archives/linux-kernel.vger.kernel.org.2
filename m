Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4375E4153CF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhIVXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhIVXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:19:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:18:26 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 2so4515691qtw.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=AMmc2S9EwrQHTB819xMq3/OnJbyotUeYMqzS5bfmA5w=;
        b=RyJALmgNRSWoqvMs9gV5fDXpRptPIFyZbRI3cNPRX5QO4NQhyHjrnsUVYHO73CFMsH
         ZSi5qRIoAJHxg+56mwwThpwRuzgo8IFptaJ212yqWkJyM6Sx4KihlyB+O7tFJbGsiwc1
         5ItAnp1rHaG6p/tBAfqdIfEvqcFekqeaPPbGz0FwgF+6tw5LB0NiOMPEe+cgbz0TLvRC
         PzgLkZtXmR5KxfV/fObEyCOhjOGXBPi8du4i+4Ebj4xy1+2/050llqA6lJ9VhAytn1nk
         OM8G+/MwCAm6QuTKNxfKBsxLzRFpAZBUr+050Vn9nCUIyrd0j8N5pFsaDR74mMTtXTQE
         E0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=AMmc2S9EwrQHTB819xMq3/OnJbyotUeYMqzS5bfmA5w=;
        b=AbzsrwAFsSoNowUCw9VRTzUxZA3UVfch6X0o7OCX3XcAHHuzpvDxRSiLC5fEmxqFHu
         AkAAys47z0HNMgUMF5EKgzfmXSjuybX1NKOEulNvMtaEFxJwz/MJCAg58CcE77KVy0Kl
         LeAgf+dXRknFwulTQJxDW2HN4i81K4+32RWwDhWOVH6Rkze+cGK2gPFpr/tOxH35+Gar
         xyGwIdIu5J5FC4cg7/7h6C4w/0k5DKF36udquMO+9lAr3p2kjZt5/eA3yCT8Ka8WkyaK
         9RGB2PQlrhj1YJDI3isGxVUXr1BuB09a8Wy9yew7iYArmDsx6L5WgwY8ccAgZKaxviw3
         rVgA==
X-Gm-Message-State: AOAM532CUkp4L1KGlW+Qr97ZgytRkcimCKjYuyDeUQIceXBaifhgXQiA
        4Tcfw1oONAmeImf9+haRPMiHTw==
X-Google-Smtp-Source: ABdhPJzMrxos1y2f6+UtwI3iVasX7ubloEvN0kUUt5KvFEvCfhuOzzR6wW2XkMfQ+ariaREXFhtZlw==
X-Received: by 2002:ac8:720f:: with SMTP id a15mr2011057qtp.84.1632352705855;
        Wed, 22 Sep 2021 16:18:25 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y23sm2969068qkj.128.2021.09.22.16.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 16:18:24 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:18:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     Axel Rasmussen <axelrasmussen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
In-Reply-To: <YUueOUfoamxOvEyO@t490s>
Message-ID: <24224366-293a-879-95db-f69abcb0cb70@google.com>
References: <20210922175156.130228-1-peterx@redhat.com> <CAJHvVch3g_UY-akMdu0O9413iCb1H83DLhR1Am8WnfUyV=s1=g@mail.gmail.com> <YUueOUfoamxOvEyO@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021, Peter Xu wrote:
> 
> Not installing pmd means uffd-minor can still trap any further faults just like
> before, afaiu.
> 
> There's a very trivial detail that the pmd missing case will have a very slight
> code path change when the next page fault happens: in __handle_mm_fault() we'll
> first try to go into create_huge_pmd() once, however since shmem didn't provide
> huge_fault(), we'll go the VM_FAULT_FALLBACK path, and things will go like
> before when faulting on a small pte.  The next UFFDIO_CONTINUE will allocate
> that missing pmd again, however it'll install a 4K page only.

I think you're mistaken there.

I can't tell you much about ->huge_fault(), something introduced for
DAX I believe; but shmem has managed pmd mappings without it, since
before ->huge_fault() was ever added.

Look for the call to do_set_pmd() in finish_fault(): I think you'll
find that is the way shmem's huge pmds get in.

Earlier in the thread you suggested "shmem_getpage() only returns
small pages": but it can very well return PageTransCompound pages,
head or tail, which arrive at this do_set_pmd().

Hugh
