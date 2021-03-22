Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90140344AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCVQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCVQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:12:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:12:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y6so20067293eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rLm/oL3RLf373BC6U5HiKi0in0UyPoJg06mhr8jBX0=;
        b=i5z+kS70ciBt6dOaM0rVcxRxlzKibB/h+7qoHYEnTRlw4GegHXbMsDP+xHfGuUB84w
         /eIlbMndd/DUG7UJcJE09rKhnhnuzOaKxMUuAsZp8BJyMrHJTXSOu45GQG66cIWUUS5T
         niGqBQXcY8t+zCAxzjQbiNL4c8gyK5QIB4oCV7bDGzSQXegPUNNPl2AlhvoQrQCkNUIe
         ssQghePVUM+jooceQqebUsvIClRoqJHDrgRC5CSinqr01Zq+c5g5f+KgvZ2ojuBoe9Ty
         SMJ2XwLCnUru4dspmuyXRB1ODDGLUzqyZIqPjiRtpcFnPewPy0j75i4eYDA6Ku6LMncs
         Z0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rLm/oL3RLf373BC6U5HiKi0in0UyPoJg06mhr8jBX0=;
        b=f50IVHYl1qHddv31x/3P59kGCEcK/vr3RGm4bFWOJgkLfkLS0kBavg69LxeBvKtyCm
         IPlIMzBv+Rl8ok8UWAEmr8NnBhPR4n9CTX/zpAXfN0wHy4wnqypwdQGiHu9EtHu1GMyp
         V3HGGb8Rzl0q0ZL2yvocU5ib9MflDrrMMwJyBzuAzlOKRw6n3Yqwo3ld3PVUyvORrCza
         nKuBDz6OxKlTH7xQMB8Sx+PCMlul5lWpl/4FlVT2BFLxgL8YyAT/tsqyLwZmpa4l9067
         SC1S5JIUAsUktsNnEq9tm/ayJDU0vQ224u95I31OzdCKcOzVFIwK1U/7A2oS2NiFsghr
         6qbA==
X-Gm-Message-State: AOAM531jYkfTrKvkFsyuwRHjRiaZ/YWTE/GNt+geQCvlrWBPNGHj+Dz4
        CjgcqYdVD8o5um4LTrCbOJd63f0UCXTU4K+l/PIywQ==
X-Google-Smtp-Source: ABdhPJzaVwsChvZ9VMzl1ZuBju6puAZEPiUq34CGwwdG+nyIfBCqKoTXapJxIYEhHnaAYR6njv6fDLVTc+XhSzEkOoE=
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr328737edw.354.1616429542133;
 Mon, 22 Mar 2021 09:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210322160200.19633-1-david@redhat.com> <20210322160200.19633-4-david@redhat.com>
In-Reply-To: <20210322160200.19633-4-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Mar 2021 09:12:13 -0700
Message-ID: <CAPcyv4hGMoDYCbnFaa2A6JukE+AcOK5qvq2TZVDUomPZYkZjnA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] kernel/resource: remove first_lvl / siblings_only logic
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 9:03 AM David Hildenbrand <david@redhat.com> wrote:
>
> All IORESOURCE_SYSTEM_RAM and IORESOURCE_MEM now properly consider the
> whole resource tree, not just the first level. Let's drop the unused
> first_lvl / siblings_only logic.
>
> All functions properly search the whole tree, so remove documentation
> that indicates that some functions behave differently.

Looks good, and the staging of the potential regressions as standalone
lead-in patches makes sense.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
