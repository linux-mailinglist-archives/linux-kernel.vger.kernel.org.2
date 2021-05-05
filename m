Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36C374818
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhEESjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhEESji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:39:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90876C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 11:38:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1357794pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=POQGQj7ALoCPENTaHpI2WeLM1iSFaDi818aVBMGOLqw=;
        b=Db7y3p0IEKbFRtxFUuYHcc68qZZR873peN9d0aGG9tlw2rZmwTOGIz/dx5FTZ5Lphi
         6fuBUvVN2bTS1kqRzIhmnlmKpakG8unMK8hTv9EYWQRvwhYHW7AFphwdkFb7ZpM7neay
         rktKL9ozidaqOd0M8nj1aEFODm3v9hbv8k6+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POQGQj7ALoCPENTaHpI2WeLM1iSFaDi818aVBMGOLqw=;
        b=ovu5BemO0UMK4ZD4ciZk9nkVXU3pcZJpIitIw0EITzX7sSJelc+3GIYZydbMWpuGej
         i6rdV0rGkpwpeki6SRPLsKgQxZlnhPJbPYzoaUuV2xtpimk4WfJ8Ds8MfydvluC8Gpgx
         +f7e2+3XHuH/yyP+u1Qr2iB89EoVU0hg9EHi6SJM0Ml9/n0gvNr4Sa/wkmObNdMOJGhX
         UGwQcxQ4GX6vypoPFRSyYnAoybSGtf6e15RgpSAvQVq2IYPKH5IIc02idRW8oneTXhs1
         TaKVtobTfkVqE71O+zMBF8/imOqVwi29huP5KrjQwR8kI3r6nvR4DdIawhXgc/Th1U+J
         81nw==
X-Gm-Message-State: AOAM533qG7Zv/LPGbc2nZ8s2UC231KKOJyER3cVuB0ure7gb8QGUxUqJ
        kJjYvIP8j5zdv4ESo13Z6qcAcg==
X-Google-Smtp-Source: ABdhPJxiN86yOamEdzSsvtrqNATfjczZniozKJJExXyIhzlZO4VwUnelTWDRAcgOFOWnS4+Z9USU8g==
X-Received: by 2002:a17:90a:302:: with SMTP id 2mr13376430pje.34.1620239921095;
        Wed, 05 May 2021 11:38:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x26sm15882079pfm.134.2021.05.05.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 11:38:40 -0700 (PDT)
Date:   Wed, 5 May 2021 11:38:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, dave.hansen@intel.com,
        luto@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] PKS write protected page tables
Message-ID: <202105051132.7958C3B@keescook>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
 <202105042253.ECBBF6B6@keescook>
 <YJJZSdVoP6yBbIjN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJJZSdVoP6yBbIjN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 10:37:29AM +0200, Peter Zijlstra wrote:
> On Tue, May 04, 2021 at 11:25:31PM -0700, Kees Cook wrote:
> 
> > It looks like PKS-protected page tables would be much like the
> > RO-protected text pages in the sense that there is already code in
> > the kernel to do things to make it writable, change text, and set it
> > read-only again (alternatives, ftrace, etc).
> 
> We don't actually modify text by changing the mapping at all. We modify
> through a writable (but not executable) temporary alias on the page (on
> x86).
> 
> Once a mapping is RX it will *never* be writable again (until we tear it
> all down).

Yes, quite true. I was trying to answer the concern about "is it okay
that there is a routine in the kernel that can write to page tables
(via temporary disabling of PKS)?" by saying "yes, this is fine -- we
already have similar routines in the kernel that bypass memory
protections, and that's okay because the defense is primarily about
blocking flaws that allow attacker-controlled writes to be used to
leverage greater control over kernel state, of which the page tables are
pretty central. :)

-- 
Kees Cook
