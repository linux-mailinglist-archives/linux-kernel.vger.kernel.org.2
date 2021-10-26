Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05D43AAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 05:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhJZDfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 23:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234614AbhJZDfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 23:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635219203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D67ZIzn9g0pIFj2txRRtbWc4Y3A64INhBFms+OCCnE8=;
        b=MVCn9ocH2nKZv22ofVh/HPJ+509qTYfuNyh9SooSVyJ1tkWcm4fMSAQGbCa3yrC03R2gbA
        ZlgWGK9VgxDEy+G93df00tXnFjOldd+r+izH5Y3wMKx42mbm7ziHW2Uotg/5RF9OOX9cXb
        oVCIpW56OgBshFRr1iI5ruveTGM0qkI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-_cf1AUOjMJysMDYSapTmWw-1; Mon, 25 Oct 2021 23:33:21 -0400
X-MC-Unique: _cf1AUOjMJysMDYSapTmWw-1
Received: by mail-qk1-f197.google.com with SMTP id u18-20020a05620a085200b0045fd532b0d2so10486734qku.15
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 20:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D67ZIzn9g0pIFj2txRRtbWc4Y3A64INhBFms+OCCnE8=;
        b=6cSZV9Us0sN6TTqVa1PWR1FGEIniDq+ly0DkLkJA1mwonCOl94e+6Ee86SZIX9QsOT
         bM4RVv9b7EUJTdZr7bZSeyZOCK5Kea5er9GQHo/Axa4NWmIXHEKgCPQ7JPKDsgqtkE68
         3xG6DfBfoFL4av35C9w9YrTf6mmvDqxAk/eW6uC44NAZcQQP14ifw0O37qj5HYGtbrGw
         RLPzhzajFAE1fGuIovzlwh3Zy8jIa1sF6UMQGgeS1c9mXP6iyIoLjinYBm3nTCl2Afwg
         JnyAj+OhOhdJo2/r5ML/WA00rcV4M04egME9Fp+KZfozT1Gb8etZHmH0uGych6hnPV0y
         Diaw==
X-Gm-Message-State: AOAM530sbqYNe9kZK1I62ON+qQYNVQ3hGaK8bgi+a7+rlUMGD+QsOpTm
        D+QAqpE0RJM3VIzKuMq2REhwIlyRb/zB1fvcwN5ocnJpiNb/HWidxEBt+fb+6OksDZmFNTrow5+
        qi/1AIEhuHNbzL86IBDJ29Dgu
X-Received: by 2002:a05:6214:2aa9:: with SMTP id js9mr16075918qvb.10.1635219201133;
        Mon, 25 Oct 2021 20:33:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRUxpIHjuEfuUS28zMqCMxOJ2vZxSq4eyYRqz3n+4eB9WBhyACgDDsLROryJZiA48xi8c0hw==
X-Received: by 2002:a05:6214:2aa9:: with SMTP id js9mr16075912qvb.10.1635219200935;
        Mon, 25 Oct 2021 20:33:20 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c19sm9442269qkj.132.2021.10.25.20.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 20:33:20 -0700 (PDT)
Date:   Mon, 25 Oct 2021 20:33:17 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rob Landley <rob@landley.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
Message-ID: <20211026033317.lye4ckhdv7ycr37v@treble>
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
 <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
 <20211024192742.uo62mbqb6hmhafjs@treble>
 <66ed460c-ac48-2b5a-e8e4-07613cf69ab0@landley.net>
 <YXZzIUqdWW9wwlpr@hirez.programming.kicks-ass.net>
 <20211025144656.fqqneysf72wwxp3m@treble>
 <YXbFpfJwXJXABDup@hirez.programming.kicks-ass.net>
 <20211025185945.ywcvhqypzoaxohyc@treble>
 <YXcM/a8TUJYPcaGI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXcM/a8TUJYPcaGI@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:01:01PM +0200, Peter Zijlstra wrote:
> Also, unrelated, were you going to do that .fixup cleanup for x86_64 or
> should I try and squeeze it in?

If you have time in the next week or so, go ahead.  I'm planning to
(mostly) disappear for a week starting on Wednesday.

-- 
Josh

