Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6432678F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZTu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:50:27 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10559C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:49:47 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e2so9041363ilu.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=43Qu7rQobpoCb4pqwKbZdlIAWt2FrSZkSPCwmQLfeds=;
        b=JkyFluRpI7IzCKigoybqtH/jF03s8co1GHwfUDjED8MbWcWqopzRJaw/iLFyQonBiv
         m96bjExzqRUJOX6UC4UHdkPfrBG/vXcxOu6i/TrdSzgrZFZ4O7mJtdYTAOPvwNfffN3z
         Advgv3ZdPFRos4gOu04K9M+0AjfNwe58lk/roxaT07ihiPmEzw0di3kz9Diz4bFX3pXT
         UhQfNwPVom/9HcMkFD5HTqpUIgJ0+XZJf4X+hEKBrrmwDIrqa2cuBv0olZce7xa75rky
         aHc79A8Qm2SyvcAFRMniCFKwzPHnktGM1/NLVNzOxpdb6cOmIjAxY5esFfqbxY8LHbph
         JViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=43Qu7rQobpoCb4pqwKbZdlIAWt2FrSZkSPCwmQLfeds=;
        b=KXELX9d0Ta6vgxBFqC0X2RHFD8GPnN28YcLXsp8uPkxjEJi/pZC8Actie3e6XBhk3M
         eGCvgOR/35nz1VLvfPgZ+dSiOcawpRPLMBBGCQI+TgktsLwAA3Jxjv3utyUrfgcL9+2+
         JuntI0UYtfZcnBB+ejmLZPXr+ru3kiRdH0LAIUkMKNe3yea4Sq9wfQFSBnVaybQH7GuP
         BD5MYMJSI5Hlul2YKIunvFRlpzRvjVyYxKDH63vGGv/Gd8vuMdf3w03S9HNwszcytFBg
         OLs1UnrBc3lCS1G4xetXV/qtBCvcAMpndYwW118lyNbPUPkjMSZb5dXk0NWhFzyu67H0
         1ZzA==
X-Gm-Message-State: AOAM531JBnEG4qUAhtL/Nl7rG+8Jn9vtqam+RTc19LlV9m3Jj/m5eBRE
        mwnTigJU9fWpJf/n6zD6Zpmf/w==
X-Google-Smtp-Source: ABdhPJzjnQCgG3yL6cjbdr7w+h5H6KBFQzWcXNyrd+79rpGVvoTVFEr4u3m65/jwPVu6rfUXZo2ytA==
X-Received: by 2002:a05:6e02:f47:: with SMTP id y7mr3826768ilj.87.1614368986310;
        Fri, 26 Feb 2021 11:49:46 -0800 (PST)
Received: from google.com ([2620:15c:183:200:bd06:d32d:458e:cd3a])
        by smtp.gmail.com with ESMTPSA id w1sm4829876ilv.52.2021.02.26.11.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:49:45 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:49:41 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v2 3/3] mm: use PF_ONLY_HEAD for PG_active and
 PG_unevictable
Message-ID: <YDlQ1VLtGsTbwp4z@google.com>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
 <20210226091718.2927291-4-yuzhao@google.com>
 <20210226121314.GB2723601@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226121314.GB2723601@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:13:14PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 26, 2021 at 02:17:18AM -0700, Yu Zhao wrote:
> > All places but one test, set or clear PG_active and PG_unevictable on
> > small or head pages. Use compound_head() explicitly for that singleton
> > so the rest can rid of redundant compound_head().
> 
> How do you know it's only one place?  I really wish you'd work with me
> on folios.  They make the compiler prove that it's not a tail page.

I hasn't been following the effort closely, so I'm rereading the very
first discussion "Are THPs the right model for the pagecache?" and
then I need to rewatch the recorded Zoom meeting. As I said I'm on
board with the idea, but I can't create a roadmap based on my current
rough understanding, unless you prefer me to just randomly throw some
reviewed-bys at your patches in the next few days. (Our long-term plan
for folios is to support arbitrary anon page sizes because anon memory
is more than 90% of total user memory on Android, Chrome OS and in our
data centers.)

That said, if you have something ready to test, we could do it for you
in our runtime environments immediately.
