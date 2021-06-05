Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A942A39CBBF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 01:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFEXsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 19:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFEXsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 19:48:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE81C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 16:46:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so8088412pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 16:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CjTJyoA1J6ESNieCl6xhVrMKsJqhC9RI8AQfmh5v9iM=;
        b=ILxj5VVXkn9v4pD5XIY1TF/VrOVrhbkSgXwliSnbBxeiRI5roH/5THqM08UQeKVWrt
         kUZ2Cx14ukHLmV5EelQblTClUjGSkJ9h2IXeDgj8bc/9wuRFfpprkAsxzMwbVnJaRSie
         Cz/VwK/+3/VAYRn78FwuwqjhZwcU8uGESc0cG7KX5vyFH5wpanJv9N9dJV0Zk8bBcctM
         h4MVBbQf9vkJw+f0GDs0IzawBdXBn1VjT5ZvKplPoQ24szk8Ks1VwoBjSTd8N30Iqnjf
         T8dlMj5OAxY96kimye0p+8HGA4YOsaHiSO5k85KdM7ZQKY3Ec5zz6zjyarWdHR6c2vcB
         jSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CjTJyoA1J6ESNieCl6xhVrMKsJqhC9RI8AQfmh5v9iM=;
        b=lR2TSuuTIXYCiTVpRybjwZsB9krAPqsGIiV8PcJEgyE++9NZBfBnqpd5fglJVUQGXg
         WZYADxgGdV/8lObZW9eSb9dl2Dw9sQ4cV+VuAN8oeUrTolxfhmm9MVUBBfQ7rkVp9UnD
         nU683BOXc6SnKknQm9C9Nf1biGxU+SnqFeKsRfOAiNhJ43P8MDS6D/GtXDUbIlN3Pq7O
         1A0o36VzF1JELApIqiKB2AbdotC5xJG3PVWO5JzpcsTI1g/Anoqif5q7d8GPa3854DPK
         MzVXjWnRh4yZh+9mt3cBxW2TlFNTSuNxqVPiJe12ZL4E8ta+6TW8G6gprN/j0zx+0OhR
         DFPA==
X-Gm-Message-State: AOAM533R/j29XrcjF8F/WtXmCN6L9uIeb95skNG1TQEqXN9WSrVosNwA
        G6eXbDJte+nYBufjdfExPG2KTQ==
X-Google-Smtp-Source: ABdhPJzCGnmVpWWaC+YnLujNzbH8WreadEQeK9zkRTrwVJIj7E9X2M1kl6XQkKMJh/Kf8zRxdrPawQ==
X-Received: by 2002:a17:902:8c91:b029:ef:aa9a:af35 with SMTP id t17-20020a1709028c91b02900efaa9aaf35mr11021866plo.24.1622936758729;
        Sat, 05 Jun 2021 16:45:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3047:e4fd:1f31:6f88])
        by smtp.gmail.com with ESMTPSA id o14sm4594723pfu.89.2021.06.05.16.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 16:45:57 -0700 (PDT)
Date:   Sat, 5 Jun 2021 16:45:51 -0700
From:   Fangrui Song <maskray@google.com>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH v3 1/1] pgo: Fix allocate_node() v2
Message-ID: <20210605234551.k25j232kvsuzodxd@google.com>
References: <20210604165819.7947-1-jarmo.tiitto@gmail.com>
 <202106041104.929FFB3@keescook>
 <2268220.EOMg9uvDZY@hyperiorarchmachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2268220.EOMg9uvDZY@hyperiorarchmachine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-05, Jarmo Tiitto wrote:
>> Kees Cook wrote perjantaina 4. kesäkuuta 2021 21.06.37 EEST:
>> >
>> > I grep -R'd where the memory_contains() can be found and it is only
>> > found in #include <asm-generic/sections.h>
>>
>> That's true, but the way to use "asm-generic" is to include the
>> top-level "asm" file, so that architectures can override things as
>> needed.
>>
>Thanks, I didn't know that.
>
>> > I cross my fingers and await if this is my first accepted patch. :-)
>>
>> I tweaked it a bit and applied it (see the separate email).
>>
>> Thank you!
>>
>> -Kees
>>
>> --
>> Kees Cook
>>
>
>Whoa!
>Thanks, I'm glad it worked out. :-)
>
>Btw. I have almost forgotten that I once wrote code
>(that I didn't send) for the GCC gcov subsystem that also enabled
>-fprofile-generate/use for the kernel.
>However the Clang PGO looks much more approachable and
>easier to hack on since the profile data format is simpler.
>
>So starting to work on this felt just natural to me. :-)
>
>-Jarmo

Right, __llvm_prf_vnodes reserves space for static allocation.
There is no relocation referencing __llvm_prf_vnodes so there is
no straightforward way using the space for the kernel.

In userspace shared objects, the scheme works by linking
libclang_rt.profile-*.a into every shared object.  The
__start___llvm_prf_vnodes/__stop___llvm_prf_vnodes symbols are
delieberately hidden in compiler-rt InstrProfilingPlatformLinux.c.

The GCC gcov format is definitely simpler than the LLVM format:)
