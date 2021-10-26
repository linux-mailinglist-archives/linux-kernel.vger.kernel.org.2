Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F843BDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbhJZXYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJZXYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:24:31 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBFC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:22:07 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id h4so1523445uaw.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J18QttHAkFDS7yxz+1rjMOa4CC6r6s8T6z90wWDtKnM=;
        b=UUgvFrR+HKKFK8Xbmv5tdHLBTz2c3Jxe83/yQSjGWL6ZMTBERVPLz7HGzOIDZXMIiL
         oU8t/tK18coPzNBChNmQzno0N8loKXyMzVuRFnKRhwgM9QFIyGXbDmlDLaeTeh8J4nGL
         8WDCBTmwIV66qqkK86dTyaPoQ3AVkvOzdsjsHvtMZUSWtDm0S13xq+amg2QnNYZm5iOE
         PRa4JObjkF5GrYCEDpzhtOZ0CRS2e9Lb73wscC2FvigHJvezGsaypJTHUOf0tmFb1P1K
         AW2uVYzq302wtU2mpagTftZpxA3IbcUul8PUgDWiNDkymaNMll/Dc7acJm7mdb9JYP0b
         V+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J18QttHAkFDS7yxz+1rjMOa4CC6r6s8T6z90wWDtKnM=;
        b=U2gTyvpe4jU/y+kcF2vtUfK8qQFGLnapWY6LhGk/T1/sea4LBKMnjYqi2GouV/Hs60
         RtUUer3Kp5Xd9YpLs37bUUs7EYh6boHcjr+ZZnbfjxd7EA0yXluxulNF2E80XxIGPUAc
         +GORXm5ENBzZWVA++RVgBDd6gXhRBub5jSior9+G+/VUVToFzeFi23lDJC5xYjnD7lgh
         3tJQIrc0y4GZlQGlyXhgmcz7OvLExe82sEun0wVGLcI/69ZStFMZiVfIClstLv5H480L
         DX+jiwlT4Npf//1tNK24ENnNYOZTsHZeTa3ZUdCo+llerR+X5zhten9uydZe4PM4hdo7
         HLgg==
X-Gm-Message-State: AOAM530wgF0KVviVGK5xrEtLZiTAtGcgLio1MxTiMGtxm2DBmuJ9neJi
        jD60axRE6Ga8W7WrFL4FEcEB/202hK15ZQrayOsgEeQ1e8deUg==
X-Google-Smtp-Source: ABdhPJx4lFsGHDL8KFwKlcXqK7O+w6Mif7FDdqlZ4s4k6X+hEkLS2rBkYwW9nhpkzDj/TM6EYqIvqhMo6ezpRoK8x5g=
X-Received: by 2002:a05:6102:11f0:: with SMTP id e16mr17418235vsg.21.1635290526524;
 Tue, 26 Oct 2021 16:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211012232522.714898-1-posk@google.com> <20211012232522.714898-3-posk@google.com>
In-Reply-To: <20211012232522.714898-3-posk@google.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 26 Oct 2021 16:21:55 -0700
Message-ID: <CAFTs51V8c3vuw-hFHWuxJDnvr2t-tNs8SC7syFOVvVSm8JdKKQ@mail.gmail.com>
Subject: Re: [PATCH v0.7 2/5] mm, x86/uaccess: add userspace atomic helpers
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 4:25 PM Peter Oskolkov <posk@posk.io> wrote:

[...]

> +static inline int __try_xchg_user_32(u32 *oval, u32 __user *uaddr, u32 newval)
> +{
> +       u32 oldval = 0;
> +       int ret = 0;
> +
> +       asm volatile("\n"
> +               "1:\txchgl %0, %2\n"
> +               "2:\n"
> +               "\t.section .fixup, \"ax\"\n"
> +               "3:\tmov     %3, %0\n"

I believe the line above should be "mov %3, %1", not "mov %3, %0".
I'll fix this in the next patchset mailing.

> +               "\tjmp     2b\n"
> +               "\t.previous\n"
> +               _ASM_EXTABLE_UA(1b, 3b)
> +               : "=r" (oldval), "=r" (ret), "+m" (*uaddr)
> +               : "i" (-EFAULT), "0" (newval), "1" (0)
> +       );
> +
> +       if (ret)
> +               return ret;
> +
> +       *oval = oldval;
> +       return 0;
> +}
> +
> +static inline int __try_xchg_user_64(u64 *oval, u64 __user *uaddr, u64 newval)
> +{> +> +
> +       u64 oldval = 0;
> +       int ret = 0;
> +
> +       asm volatile("\n"
> +               "1:\txchgq %0, %2\n"
> +               "2:\n"
> +               "\t.section .fixup, \"ax\"\n"
> +               "3:\tmov     %3, %0\n"

Same here.

[...]
