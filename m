Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1C3BBC5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhGELrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhGELr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:47:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A30C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:44:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r9-20020a7bc0890000b02901f347b31d55so11031006wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JP655Kr0pQo2WIEbmEE6zI777FgwwqQfTWCo3Yd5U5Y=;
        b=uVl/FVYJR66p3A+kTDkqnN7VGlSQH2HYny3y9odL82wmHYTn9aH1WGEmu+h0FeYauC
         XwnS6zy3SaCJ5XCHrHqep5UyIi/Wh0uzT5Y+/+hCbwiCW1j0KO1o1ZzggGbPVvM3rbm8
         aRD4zSyImawZGVKdM8xHreAQBpF5mJ+/YA8+ZeyFTjBWC3xx6a9yBGyjOzzgyr5fsrrH
         KcwGX4zga1PXdrqed0GRvruAL7oWpaaGtmB5zPknc2F/r6F/O1YEhNCBP0fbDvePqyA/
         LhEohLJTnAZPxf1ck9Kp+6WvXiQBYaYszNeweTXKjsztlc3qEmqV/tBr19WeIEtJFawi
         4D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JP655Kr0pQo2WIEbmEE6zI777FgwwqQfTWCo3Yd5U5Y=;
        b=RyIed7Wy+wLEZw6OGKjIRTWzWLQK2Kzx/O1mK4TiDyfxno0HW2rL8vv6XMPG/s9BrV
         gx78R15Wb51CI32I9kqGy2S+S/xYLxSL4aCwri/vtGKTm8J3GPjgcpapneBj7SIjzh22
         0x27+MWJkAsYQf22N58QKbmSEkdLTrBeAWwOSSElhJkeoUvQXBrtZ7ws3ThLZBFB/+jq
         cqZqcymDeD9StdkzT4VtltTW5UmGZFunfEnjp9UNUJ2sb84xFNeqsB7bfk7iLloQXIaD
         yQ4e0T/a8KAchxgbPdjc8LRH4bkMIwcDMmdNepgntMpKfCAxZ6EQCRcFTOnHuWIggiCg
         sm8Q==
X-Gm-Message-State: AOAM530RWHZaZE5G4DfTgJpxvY/Pg3yBLb09K4k4PUPkSdkLtqZqJ/Ow
        lQQAPU+Bn7pE0xb6ykBCgPVoYA==
X-Google-Smtp-Source: ABdhPJzljqGqiLe7uyr/rqQf0Ml0k1xid251PBNTF5gFjcEUlXtmY57iuHxc55ce9q/6TbKn4gwJ0Q==
X-Received: by 2002:a1c:25c6:: with SMTP id l189mr15148080wml.49.1625485490745;
        Mon, 05 Jul 2021 04:44:50 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:dddd:647c:7745:e5f7])
        by smtp.gmail.com with ESMTPSA id r16sm15313150wrx.63.2021.07.05.04.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 04:44:50 -0700 (PDT)
Date:   Mon, 5 Jul 2021 13:44:44 +0200
From:   Marco Elver <elver@google.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
Message-ID: <YOLwrMBk6TymR74k@elver.google.com>
References: <20210705103806.2339467-1-elver@google.com>
 <20210705113723.GN3840@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705113723.GN3840@techsingularity.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 12:37PM +0100, Mel Gorman wrote:
> On Mon, Jul 05, 2021 at 12:38:06PM +0200, Marco Elver wrote:
> > This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.
> > 
> > Commit 76cd61739fd1 ("mm/error_inject: Fix allow_error_inject function
> > signatures") explicitly made should_fail_alloc_page() non-static, due to
> > worries of remaining compiler optimizations in the absence of function
> > side-effects while being noinline.
> > 
> > Furthermore, kernel/bpf/verifier.c pushes should_fail_alloc_page onto
> > the btf_non_sleepable_error_inject BTF IDs set, which when enabling
> > CONFIG_DEBUG_INFO_BTF results in an error at the BTFIDS stage:
> > 
> >   FAILED unresolved symbol should_fail_alloc_page
> > 
> > To avoid the W=1 warning, add a function declaration right above the
> > function itself, with a comment it is required in a BTF IDs set.
> > 
> > Fixes: f7173090033c ("mm/page_alloc: make should_fail_alloc_page() static")
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Out of curiousity though, why does block/blk-core.c not require
> something similar for should_fail_bio?

It seems kernel/bpf/verifier.c doesn't refer to it in an BTF IDs set.
Looks like should_fail_alloc_page is special for BPF purposes. I'm not a
BPF maintainer, so hopefully someone can explain why
should_fail_alloc_page is special for BPF.

Thanks,
-- Marco
