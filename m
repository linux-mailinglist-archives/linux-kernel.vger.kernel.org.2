Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32604364EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 01:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhDSXgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 19:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhDSXgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:36:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B38C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:36:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c3so5469881pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+AXERFClYZYQUr1IqN7bGc0QBx+E2BeAvwA2SBiAo5U=;
        b=YmK13dmW5qtJCyvdmMQvQkEeNCJafx0yaLZuG+qt1h0kHyE16ZlbvlaKIXMdJuos0q
         oXaLUgrsIoOMW/QfJSmDcXcR6EX6TN/9FfVu/z3XvPw31FD3n4vWRmqF1KhC3Fyl4bE9
         eEG4MsQbmbgtdohUERLAUr/uXceQgL/DsllmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+AXERFClYZYQUr1IqN7bGc0QBx+E2BeAvwA2SBiAo5U=;
        b=RGMihg0aNeolYL+Dc4Kyy4HhPp+321SsNSWgwKNICYrncV6QtsOV3ax2Gn+BgCT8pT
         qEMAR88a2Vwr5EG0GsuC1t2EGdw/Grj/DsYXlR0m+ttX07/6FoLcSVNyuaP7O9bAp3KP
         p+sfcEhRYe5bkQ6Rz0OaY9j5DCQrODGLTQj52onP+4HM3mJzzgcz2vfN1bFeEEeyVaPj
         rrsy9iD20zjXfDreoXhCzx1FzyW+0KC3kCKrZ6kXeCgYrqEg11iLUQyZNbuBa77gP3ac
         hRMqhBQHR9rKUYCISCGI4y8yp8x1d1qquB1OLnKl50W6UBw/wHgNU01wmpLtRUAGv1wa
         Kp2Q==
X-Gm-Message-State: AOAM530uMS+BbklmMirkU4UCXpD77A4xBoS9J/fZL3fcgpABHWyUTvuc
        zuRZIxLC81S5vHHzgUjHuFHowauV48NbUg==
X-Google-Smtp-Source: ABdhPJzERC0jwguaNsJ+wSeg55qiPue3mqoTqTb9eYfqXtUH3uNdF0tKTOJIlM21AuWzWAGco92F6A==
X-Received: by 2002:a62:ce42:0:b029:261:ab24:f65f with SMTP id y63-20020a62ce420000b0290261ab24f65fmr4572278pfg.18.1618875374515;
        Mon, 19 Apr 2021 16:36:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm14586976pfh.217.2021.04.19.16.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 16:36:13 -0700 (PDT)
Date:   Mon, 19 Apr 2021 16:36:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 4/7] mm: Introduce verify_page_range()
Message-ID: <202104191630.F00A6AAF@keescook>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.769864829@infradead.org>
 <202104121302.57D7EF8@keescook>
 <YHVADhpkETMQGD5X@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHVADhpkETMQGD5X@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 08:54:06AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 12, 2021 at 01:05:09PM -0700, Kees Cook wrote:
> > On Mon, Apr 12, 2021 at 10:00:16AM +0200, Peter Zijlstra wrote:
> > > +struct vpr_data {
> > > +	int (*fn)(pte_t pte, unsigned long addr, void *data);
> > > +	void *data;
> > > +};
> > 
> > Eeerg. This is likely to become an attack target itself. Stored function
> > pointer with stored (3rd) argument.
> 
> You got some further reading on that? How exactly are those exploited?

Sure, see "Executing code" in
https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html

I killed the entire primitive (for timer_list)
https://outflux.net/blog/archives/2018/02/05/security-things-in-linux-v4-15/#v4.15-timer_list
but that was a lot of work, so I'm trying to avoid seeing more things
like it appear. :) (And I'm trying to get rid of similar APIs, like
tasklet.)

This new code is unlikely to ever be used as widely as timer_list,
but I just cringe when I see the code pattern. I'll understand if there
isn't a solution that doesn't require major refactoring, but I can
dream. :)

-- 
Kees Cook
