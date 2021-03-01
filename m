Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4643329E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444598AbhCBCnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 21:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbhCAUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:00:15 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C1C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 11:59:04 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z13so19137913iox.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QP0lfpyl4j3iabI8oLYVZHEGp/CCtjlP1LZcsB8l3xs=;
        b=Tawe4UwJvceLRDwdA9DCQtkns6tyom6mHo1CkksI3vxWKthOSXJHOZheMcnBX7wyxh
         MwGBSIfN6fhtnqhCXaBKKw3z9wboBJwaF/SNyLGUEyDd5Nzf4DlTAZ2qeVOgTtEP5AKY
         xuv3SoKD553fL0R3sWZkmN3DWkh4XTm5dxzfDmvP5zipDtOhYs/iNmVCb9Q2t8ZQYJN6
         5XErONSn8/XG7fdSrDZHC67XWQusyW+17OVw2CXb1o6ulDHCT/anSByPKoSUt6j8iqTu
         cif3fmsEinYzos+u9ujtwIg3lMggdTSa17j4klc8aqztF6Y5ExQx6GZGODJktBHs2Qe0
         Nalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QP0lfpyl4j3iabI8oLYVZHEGp/CCtjlP1LZcsB8l3xs=;
        b=RdGOx0VNi17urDlXFfnhP2gp6MnZQlTh/opw0QStwAt96w6DkXgefkPSqlTmmu05Zd
         u79RPPZBB9C/faxpXUjV++5OCtDoT5RpHHy0yi3ehXrivA//IFFUZLBF6A4ymgEohczZ
         OTtie7zOZqy6BRDgxt4hwbj/CXtzGFUA/zF6z+AFXRNmLQSi4E5a5ef4jpQ0Bbqe2IKZ
         TLzGFcb4Pq4F6TfGL373zobKVy1ssz7FTgIwC3UyRSHzooFwHORHQAgJAKdgO+T7jOlz
         wVuRKnunaAzCj1vWAyZaebW4gK76gFejNCCWQ0oL/r6eeQued42CSw+Z8I7/8r114Iqp
         3XvA==
X-Gm-Message-State: AOAM533aoAt9ZJXc+jIMZPu7+TuH82r56Wu0JqipYFMHIWSaEsHf4xtU
        2tU4J4ndqLJHjGr9kizRF4hWjg==
X-Google-Smtp-Source: ABdhPJyOVQgRghJvvC/kWUutrk7mLxzGCyEOp4HgXW8D81m6u5kNVFTrWT9v29xnD/H+nIyKuP5sEQ==
X-Received: by 2002:a02:93e9:: with SMTP id z96mr17707053jah.73.1614628743734;
        Mon, 01 Mar 2021 11:59:03 -0800 (PST)
Received: from google.com ([2620:15c:183:200:c02f:2525:d61c:5fca])
        by smtp.gmail.com with ESMTPSA id q4sm10469668iob.52.2021.03.01.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 11:59:03 -0800 (PST)
Date:   Mon, 1 Mar 2021 12:58:58 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        alex.shi@linux.alibaba.com, vbabka@suse.cz, guro@fb.com,
        hannes@cmpxchg.org, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v2 3/3] mm: use PF_ONLY_HEAD for PG_active and
 PG_unevictable
Message-ID: <YD1HgmERg3/LuApe@google.com>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
 <20210226091718.2927291-4-yuzhao@google.com>
 <20210226121314.GB2723601@casper.infradead.org>
 <20210301115007.mgw5vthgjoibnjf4@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301115007.mgw5vthgjoibnjf4@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 02:50:07PM +0300, Kirill A. Shutemov wrote:
> On Fri, Feb 26, 2021 at 12:13:14PM +0000, Matthew Wilcox wrote:
> > On Fri, Feb 26, 2021 at 02:17:18AM -0700, Yu Zhao wrote:
> > > All places but one test, set or clear PG_active and PG_unevictable on
> > > small or head pages. Use compound_head() explicitly for that singleton
> > > so the rest can rid of redundant compound_head().
> > 
> > How do you know it's only one place?  I really wish you'd work with me
> > on folios.  They make the compiler prove that it's not a tail page.
> 
> +1 to this.
> 
> The problem with compound_head() is systemic and ad-hoc solution to few
> page flags will only complicate the picture.

Well, I call it an incremental improvement, and how exactly does it
complicate the picture?

I see your point: you prefer a complete replacement. But my point is
not about the preference; it's about presenting an option: I'm not
saying we have to go with this series; I'm saying if you don't want
to wait, here is something quick but not perfect.
