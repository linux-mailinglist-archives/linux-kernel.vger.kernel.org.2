Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEB1326730
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBZTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZTEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:04:53 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:04:12 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k2so8919026ili.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZ8qA7aQ5rpYT0V2sctlkBYPSd8hoeYCGiKdEoaJ6vM=;
        b=oKvpOm5iarSQ50kIWkk9J3uYkaBdk2Rh6A5rsIzmPgynnXLl+CctGSG7eLJi6eUv06
         RU7c8ld/yPnB7UH0ZSYOJIZ6w927LNIdI0xiV2eL3JknVbocjzaIowpPj9pIruNA0v0H
         3Ivbv3STxsu14ZiPWD/EDorKRzfpdwAp26qDC57jCIicOoEcD+g+gCt5VTRhaD0cBEl1
         MgA4f+ZtuQEpWPjhA4AV8jTQt2d6kQkolaMMHMeUVMMSeOQ0/MNSAov3prYsm7ptrpAE
         UxO1bgHjdrKWimHZzLxf61lJRo1sdv9CjNSjx8qaXSNRW0WZQ9mbsMGBxBpUmRU+Vy7M
         W6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZ8qA7aQ5rpYT0V2sctlkBYPSd8hoeYCGiKdEoaJ6vM=;
        b=CQgfVQQXcHa7yDZXGL4t9NVB5YTaKNYmE19C9I3NcKm9r5VyBUs/10KCteLpBckhdA
         vAsOmcRCgUKDJPMYuuKjYTkyUiGy+bH8iPGQq+zT2kisUqrVZTNkfnlDQA1uaU3xLHIK
         b3WkMkz4fdSjHpTJqKLhekXPjWDqa8pYSUkSlneoB/QaF/XELqWiqYQF0RXpYY4EiatU
         Quz1lJj0GPTxXL59ggUHyHd5ZDGZdzW6ZOvw4+v6tQJM7ob6ORvpc4G4FqMK48xBcMY5
         aJxh/9xVEYtXrzLs8cGvz2aq1SQnp1AWkhwu7ZeHBgb9OBe1fYqajuQlq4Ibaih6FtFB
         cciA==
X-Gm-Message-State: AOAM53269ZDoA4Eo0Fxo5oxAzcyVzboYRSYYTALg5nUEKog1O3gAYdfK
        ee+D9tlTtuvFNurlfLTeC2xPWg==
X-Google-Smtp-Source: ABdhPJwnYu4zRP+tcyj4kccpaJX9VLj4BYvACrkR0IoFavyjLN8Ii1ceBJLPRpp3LrdbwgvzRZIK9w==
X-Received: by 2002:a05:6e02:d4a:: with SMTP id h10mr3653155ilj.107.1614366251849;
        Fri, 26 Feb 2021 11:04:11 -0800 (PST)
Received: from google.com ([2620:15c:183:200:bd06:d32d:458e:cd3a])
        by smtp.gmail.com with ESMTPSA id o12sm5813972iop.42.2021.02.26.11.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:04:11 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:04:07 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        willy@infradead.org, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 0/3] trim the uses of compound_head()
Message-ID: <YDlGJ4eRPCNWESkj@google.com>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
 <bd876842-b1e6-66fd-da1a-b181cede101a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd876842-b1e6-66fd-da1a-b181cede101a@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:52:03AM +0100, Vlastimil Babka wrote:
> On 2/26/21 10:17 AM, Yu Zhao wrote:
> > Patch series "mm: lru related cleanups" starting at commit 42895ea73bcd
> > ("mm/vmscan.c: use add_page_to_lru_list()") bloated vmlinux by 1777
> > bytes, according to:
> >   https://lore.kernel.org/linux-mm/85b3e8f2-5982-3329-c20d-cf062b8da71e@suse.cz/
> 
> Huh, I thought Andrew didn't want to send it for 5.12:
> https://lore.kernel.org/linux-mm/20210223145011.0181eed96ab0091a493b51f6@linux-foundation.org/
> 
> > It turned out many places inline Page{Active,Unevictable} which in
> > turn include compound_head().
> > 
> > From the v1:
> >   Removing compound_head() entirely from Page{Active,Unevictable} may
> >   not be the best option (for the moment) because there may be other
> >   cases that need compound_head().
> > 
> > In addition to picking a couple pieces of low-hanging fruit, this v2
> > removes compound_head() completely from Page{Active,Unevictable}.
> > 
> > bloat-o-meter result before and after the series:
> >   add/remove: 0/0 grow/shrink: 6/92 up/down: 697/-7656 (-6959)
> 
> Good that you found a way to more than undo the bloat then. But we need to be
> careful so bugs are not introduced due to pressure to not have bloated 5.12.

I was very conservative and only picked a few pieces of low-hanging
fruit. The pressure is good -- if you hadn't noticed it and Andrew
hadn't been emphatic about it, it'd have been left for another time
and to another person, and so on.
