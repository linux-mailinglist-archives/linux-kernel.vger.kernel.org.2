Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286EC33ABCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCOGuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCOGt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:49:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F316C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 23:49:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o11so32301156iob.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RXgUmifVTRc4KqwJ1QL+c7x30HxQbXm8rlBa7DWXLDs=;
        b=mFfGAOHLQ6z6AzIPc5xQAP07QTvg/ukTxuMDCaDFXDsvjg+Af5zW/7P+O8PmMkckf6
         Qm83HV/Suz4U6XcHZti3eTpv9hVGtxygGUki4PLJrRbCVztiAEcsfz/GVk6sVOnzAQ4E
         ER+kVt0InidQr7o4D8U9szlRWXKuKXpRrJPKwOdc7Sa/XjkGzANFht0IRlPdV/kFQOVC
         cg4s5huqyDpLc4Gu9e/+OYbMakhQjxEuUKPVQrFnSo7hjzlnNMf+UW3SGaACx9pOYPd/
         PG8/UgTb/mvkEIPKabbS7moKC9OqhduF6iL153L8D/e4a9Rp2msOHpJzAmt9ONtscejh
         4+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RXgUmifVTRc4KqwJ1QL+c7x30HxQbXm8rlBa7DWXLDs=;
        b=mY0vh/snJoEC6Xl5T3gSP9cuU8FKCeuvlSAmd/ggBXLIubDCnv2fTh+AyKK5pEwOx4
         CLZIy3A+MdkaU3VtlPRZo13rTOE7bHFoEFHeo2qAz9zcVSvfb+DsoUwwxnmfnM2j1mTx
         Z+Ju5210asxW4Ls5PMho8EGqxtP631DL52c2q5BbkJsXUfuPoEY59ULByyMvgNr0MIMn
         /uRjjs0/TKyc2+DHu2Ulbb55Swgj1B2X1ogmCYsuGCYa6RKe+HCv/be5ncqPFo8GlCmH
         RdpBNnL4kyodT2LMjIYtW0EKQuBgziZvQzrCgkTcVNZRuUyhJgp80wyIWr0BWr4+/BFS
         Qunw==
X-Gm-Message-State: AOAM533V0bWAR5gJE/2eyQ43wRvKfJdNZ6W0ae+jLfjVLo3TKhKqf1bu
        Y7J7HP5w3q6MBwDZx65KYRNp3g==
X-Google-Smtp-Source: ABdhPJxkfg7ky75GDgyu6R4kS51RbN2SojXSpPor2VbAGBdjj/Ar8NdNuFjIA/xp7lUi/DhIoAoJ9g==
X-Received: by 2002:a05:6638:388e:: with SMTP id b14mr8493434jav.62.1615790996165;
        Sun, 14 Mar 2021 23:49:56 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:4d84:eb70:5c32:32b8])
        by smtp.gmail.com with ESMTPSA id b9sm6906580iof.54.2021.03.14.23.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 23:49:55 -0700 (PDT)
Date:   Mon, 15 Mar 2021 00:49:51 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, page-reclaim@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
Message-ID: <YE8Dj4uSPDE6HYM1@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <20210315011350.3648-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315011350.3648-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:13:50AM +0800, Hillf Danton wrote:
> On Sat, 13 Mar 2021 00:57:33 -0700 Yu Zhao wrote:
> > TLDR
> > ====
> > The current page reclaim is too expensive in terms of CPU usage and
> > often making poor choices about what to evict. We would like to offer
> > a performant, versatile and straightforward augment.
> 
> It makes my day, Monday of thick smog in one of the far east big
> cities, to read the fresh work, something like 0b0695f2b34a that removed
> heuristics as much as possible, of a coming Mr. Kswapd. 

Hi Hillf!

Sorry to hear about the smog, we don't have smog, only a few feet of
snow...

I shared the latest version of the cover letter here, if you are a fan
of Google Docs:
https://docs.google.com/document/d/1UxcpPAFNk1KpTJDKDXWekj_n6ebpQ-cwbXZlYoebTVM

And speaking of heuristics, yeah, I totally understand. We've had more
than fair share of problems with get_scan_count() and
inactive_is_low(). And we are still carrying a workaround (admittedly
a terrible one) we posted more that a decade ago, on some of our old
kernel versions:
https://lore.kernel.org/linux-mm/20101028191523.GA14972@google.com/

And people who run the Chrome browser but don't have this patch (non-
Chrome OS) had problems!
https://lore.kernel.org/linux-mm/54C77086.7090505@suse.cz/

With generation numbers, the equivalent to inactive_is_low() is

  max_seq - min(min_seq[!swappiness], min_seq[1]) + 1 > MIN_NR_GENS

in get_nr_to_scan(); and the equivalent to get_scan_count() is

  *file = !swappiness || min_seq[0] > min_seq[1] ||
	  (min_seq[0] == min_seq[1] &&
	   max(lruvec->evictable.isolated[0], 1UL) * (200 - swappiness) >
	   max(lruvec->evictable.isolated[1], 1UL) * (swappiness - 1));

in isolate_lru_gen_pages(), both in the 10th patch.

They work amazingly well for us, and hopefully for you too :)
