Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB193247A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 00:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhBXXvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 18:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhBXXv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 18:51:27 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9589C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 15:50:46 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id i8so3974189iog.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 15:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HHAMxwO0RN5Il90ir5Bo3fGze6LKQGtEHSeat0z2uIo=;
        b=cRo4toHeGxpVexHF/YAEG+uIWzAyWs1pK2mIlg962ut4/vVoLntcPQZC6JdtFf92zU
         oxIx+Ht1M/6QSNgA2r3AX1dDXz8MpQQz/PmYwze5GeydKZIi7V7NcH+ogPC1DCtzQ/0S
         +WXL8pZzow/0r5Z7THeNawXu1DpSqsGgzl/RhKoerkFM0/cTbArlm6qP5eq4Zw3Vfsoh
         7txgTpuf0ogRJxJhRzuGsdiJlgs3qqkQInLSgRC7YlemI7P9CzSHS6tMMYaH882XuLuF
         yDxXOnuWZeD62+EvMooff1tpbv6gy4lfZFFmUhRZ2rp2l8CsZUg1LiuFH352Jb2x0Ch6
         VwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHAMxwO0RN5Il90ir5Bo3fGze6LKQGtEHSeat0z2uIo=;
        b=Fr7e+7/2RjCx7e6/OWAiXTz5bnBEPFkySAFl7sjbfvhnTQupCugea/W0SUzDVwMQ6q
         R33UnFcFeR2SxDlOwhzIZ/CbJahxPaT01BTns1FtM98bWz8rQRYalwrNYP2UhPdZePhe
         MNSnRc5012pa07ot9oUfJEF4wuG71aoTTkhh9IjWoULyR7K2XrKW4liobiGjASRqaBwf
         Vu+/45HSSz/JcOI9CO8sOG0nWYmgd5VfVYh9R1k+WU1cxPMRlsX1ooZNe8zmxTF1EPKP
         hKWnvNeFnBcnB5rTh6rtjDBx/I0YZ4Ds4iWUto8UBUHpfHnvEHVTTSwEl1jEeUV3W9F0
         UBaw==
X-Gm-Message-State: AOAM533fMBGh4279X065wlDB+9i4fXdxHwzmg3c1jBjkRLq2TOdDuxPw
        Tf58Uvh0QtALG3tNXQVpigyF8g==
X-Google-Smtp-Source: ABdhPJy6X/K39lgbmIovoZg4d8Uzw4vQJBZK8Vdk65weda6qzcWjI3+wRrtBRKSBq3o7hAr0ZAy/rg==
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr310855iot.186.1614210646231;
        Wed, 24 Feb 2021 15:50:46 -0800 (PST)
Received: from google.com ([2620:15c:183:200:c037:ba21:bf5e:4d1f])
        by smtp.gmail.com with ESMTPSA id o8sm2248030ilu.55.2021.02.24.15.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 15:50:45 -0800 (PST)
Date:   Wed, 24 Feb 2021 16:50:39 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-ID: <YDbmT87E106uS1Xa@google.com>
References: <20210122220600.906146-11-yuzhao@google.com>
 <20210224084807.2179942-1-yuzhao@google.com>
 <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
 <20210224215639.GT2858050@casper.infradead.org>
 <YDbUaJ0j2YisyyuK@google.com>
 <20210224224846.GU2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224224846.GU2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 10:48:46PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 24, 2021 at 03:34:16PM -0700, Yu Zhao wrote:
> > > If only somebody were working on a patch series to get rid of
> > > all those calls to compound_head()!  Some reviews on
> > > https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
> > > would be nice.
> > 
> > I'm on board with the idea and have done some research in this
> > direction. We've found that the ideal *anon* page size for Chrome OS
> > is not 4KB or 2MB, but 32KB. I hope we could leverage the folio to
> > support flexible anon page size to reduce the number of page faults
> > (vs 4KB) or internal fragmentation (vs 2MB).
> > 
> > That being said, it seems to me this is a long term plan and right
> > now we need something smaller. So if you don't mind, I'll just go
> > ahead and remove compound_head() from Page{LRU,Active,Unevictable,
> > SwapBacked} first?
> 
> It's really not a big change I'm suggesting here.  You need
> https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
> https://lore.kernel.org/linux-mm/20210128070404.1922318-5-willy@infradead.org/
> https://lore.kernel.org/linux-mm/20210128070404.1922318-8-willy@infradead.org/
> and then the patch I sent above to create folio_lru().
> 
> Then any changes you want to make to use folios more broadly will
> incrementally move us towards your goal of 32kB anon pages.

Well, these patches introduce a new concept which I'm on board with.
Assume everybody else is too, it still seems to me it's an overkill
to employee folio to just get rid of unnecessary compound_head()
in page_lru() -- this is not a criticism but a compliment.

Let me work out something *conceptually* smaller first, and if you
think folio is absolutely more suitable even for this specific issue,
I'll go review and test the four patches you listed. Sounds good?
