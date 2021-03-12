Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6356033999B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhCLWZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbhCLWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:25:04 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10426C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:24:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s7so12580304plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUp9bdMACAhipmgQpADFkYf0b9xiq1zIbv0Svm5SjIQ=;
        b=tRMYCue0cTuNDzRc5gjlgI5lRzpZB2q1NKrfaqQKEk1Avx+uKY28ypXV1raS171Zd0
         BbGLBRWlCmBxwaZRPqlhKELFuYcKTVWbtvD7hRR+rNT+73/mOnaoh2MJIPdOrvUtMhzg
         Bp+ejJWqrlkiqs+mJ9D3OK3YTg5v5Lt0TTK8Bi5gwhfb9ME97bdoZY0lT7PDbsvWMr0F
         HJLtbr1keykFIiJsfSGzIE3ofli9unD+UVclb1pLwPA2CJsyhrP8o4IaybUU7iG5vdk6
         Fb9c2IlRw/tFNV4Brk7NX1e4prCk+rOhmkMHGbIVA1Voul+BrgAGr6t7eBXkgKPHCcZL
         tLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fUp9bdMACAhipmgQpADFkYf0b9xiq1zIbv0Svm5SjIQ=;
        b=Iz+22hWPYIhiQ5LhjTgrA9tMhiqTLktG/ORxEeHJNtOtcgYSywgCx+CxoArCXIlC57
         GTJRlZkj6Fquvg86rygnVBeoFbPuVbzwReUoFglFyliJdRWbefznD/SHFsopvi5abl1o
         zkllzMO272ia/paghgVq8BnEFRd931xNesbw5j6RtabGaaOgmKCJOgEDyGuGPv/37/WV
         vbg49mk+NvlG9YEkj7wL3lrfYQC7kStVeNiXUhUpaxxfE59d7CZ2PMVPDv7+cDQxxIiL
         SNiHL5n5oqPiCQB8IG+tTBmuvup+JvRMgSYWuB8cGFbgvVmWU0lI8ce1Qg1oUITC08PS
         6ODQ==
X-Gm-Message-State: AOAM530kKqhC4RViz3e+RzTp96eIHsgRTMvbiYM9YBS503byvdsTlyU0
        MCKL8mT0LHBit5Z8pws5182hXw==
X-Google-Smtp-Source: ABdhPJxJOa74NY7q2LHFWvncgeiaxoct+Yp2XSoE/g2xdALRNjZkyofpC+nmTr0q1WcvtdkV8S6AdA==
X-Received: by 2002:a17:902:e74f:b029:e5:fedb:92b9 with SMTP id p15-20020a170902e74fb02900e5fedb92b9mr601002plf.67.1615587892224;
        Fri, 12 Mar 2021 14:24:52 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:bca6:9fa5:8695:2f0d])
        by smtp.gmail.com with ESMTPSA id s27sm5966766pgk.77.2021.03.12.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 14:24:51 -0800 (PST)
Date:   Fri, 12 Mar 2021 14:24:47 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] gcov: fix clang-11+ support
Message-ID: <20210312222447.rwnvmlp4i5jfmwyy@google.com>
References: <20210312192139.2503087-1-ndesaulniers@google.com>
 <20210312202537.z77v4qnvptbrug2f@google.com>
 <CAKwvOd=8WM9KVoPxy7x9kQR5cEz1M+hJ4Pbz8kU+5ipMSzSJ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOd=8WM9KVoPxy7x9kQR5cEz1M+hJ4Pbz8kU+5ipMSzSJ+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-12, Nick Desaulniers wrote:
>On Fri, Mar 12, 2021 at 12:25 PM 'Fangrui Song' via Clang Built Linux
><clang-built-linux@googlegroups.com> wrote:
>>
>> function_name can be unconditionally deleted. It is not used by llvm-cov
>> gcov.  You'll need to delete a few assignments to gcov_info_free but you
>> can then unify the gcov_fn_info_dup and gcov_info_free implementations.
>>
>> LG. On big-endian systems, clang < 11 emitted .gcno/.gcda files do not
>> work with llvm-cov gcov < 11.  To fix it and make .gcno/.gcda work with
>> gcc gcov I chose to break compatibility (and make all the breaking
>> changes like deleting some CC1 options) in a short window. At that time
>> I was not aware that there is the kernel implementation. Later on I was
>> CCed on a few https://github.com/ClangBuiltLinux/linux/ gcov issues but
>> I forgot to mention the interface change.
>
>These are all good suggestions. Since in v2 I'll drop support for
>clang < 11, I will skip additional patches to disable GCOV when using
>older clang for BE, and the function_name cleanup.

Only llvm_gcda_start_file & llvm_gcda_emit_function need version
dispatch. In that case (since there will just be two #if in the file) we don't even need

   depends on CC_IS_GCC || CLANG_VERSION >= 110000

>> Now in clang 11 onward, clang --coverage defaults to the gcov 4.8
>> compatible format. You can specify the CC1 option (internal option,
>> subject to change) -coverage-version to make it compatible with other
>> versions' gcov.
>>
>> -Xclang -coverage-version='407*' => 4.7
>> -Xclang -coverage-version='704*' => 7.4
>> -Xclang -coverage-version='B02*' => 10.2 (('B'-'A')*10 = 10)
>
>How come LLVM doesn't default to 10.2 format, if it can optionally
>produce it?  We might be able to reuse more code in the kernel between
>the two impelementations, though I expect the symbols the runtime is
>expected to provide will still differ. Seeing the `B` in `B02*` is
>also curious.
>
>Thanks for the review, will include your tag in v2.

4.8 has the widest range of compiler support. gcov 4.8~7.* use the same format.

clang instrumentation does not support the column field (useless in my opinion) introduced in gcov 9, so it just writes zeros.
