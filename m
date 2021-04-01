Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C04351196
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhDAJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbhDAJLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:11:33 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A31C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:11:32 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 7so1509981qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRTdyxga9+xU4X0UPyyuU5rgsxj5AmXn/YlJB5Gr9oY=;
        b=azUvCNBEk+Vp9j9fOzPBnjxC7FnM+PGkEetPt6yd44+wPhdZQ2+UdyKvKEIN45RZNi
         312/ZLW1/fgPV/wdxVMsGQirm7XYBJBS2M1ayfpeY03oHHrCti4z3QoSlXkzf+NTnEap
         CuBfmdk42G7yE5qrMY+tlCKOwO8bPJlCmSbz5GHYQ9ghtbvC6Kq2BZgqYRKJxOEIqHQo
         g+/27HKD0btCSCU8a8DRDPNXo1xLSNiAzTg97pjBp6wfUCMVuPbbyYt+J9ssIm1/DTW3
         3VfhVUPGtKRU4TNDRaMYEh1ZwyTaDeCxoyCAV32cfpmVGnFjVMDqf2qPcuH7i6Zd0WzT
         hODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRTdyxga9+xU4X0UPyyuU5rgsxj5AmXn/YlJB5Gr9oY=;
        b=hM197LBvNWJNAYzPTu4tME9RTQ/M86o7NVmZiV/gtv11tpnIAH3nG51jpj5u2ZHkUd
         BwSxh1NgVx4zZci442lBl83tACMSmYSabQ5//Vg+3yj0zgg524fbLAomAAY5Mh1c0+9k
         lttXE9q+BtIJkuDhZxz/2KaDgxPM0roZvd2AxCojWwpdBZiM0JJcLpE+ySuwjsHXX6Y4
         Tkv00BmhZA6yJjSXzZOvYuV7T7mZ7eT6g9V+2zo8qoVlI/bBrzLto4sdyP8V86k9VR13
         ZDE85BBiPay+7zDmrxZb857+7mXlNHVudKIquwyp2mZxTVoJFZDA1ORm/Qbsozs65iY/
         /CNg==
X-Gm-Message-State: AOAM533tssoVky8/0NuOv8aGCpoXyWp+21xpkWi8Fx/0r+/8idX6E8gj
        wVByAPafIE2aii8TTgGZMLwbZBWmH/QxocwY/samPw==
X-Google-Smtp-Source: ABdhPJy8zlwIqmVaYaWfClf8qJUi5eyyttjWs31QuLBj+/cDB+I+iVlBqUDHmZUWEmooNRAobcmZtip6ltJxIp2+OLc=
X-Received: by 2002:a05:620a:2013:: with SMTP id c19mr7238842qka.403.1617268291223;
 Thu, 01 Apr 2021 02:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210330065737.652669-1-elver@google.com>
In-Reply-To: <20210330065737.652669-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 1 Apr 2021 11:11:19 +0200
Message-ID: <CAG_fn=W7WZBCSozOuMWzr52Ri_htrmkTOkcF5nvMs9icH=StoA@mail.gmail.com>
Subject: Re: [PATCH mm] kfence, x86: fix preemptible warning on KPTI-enabled systems
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tomi Sarvela <tomi.p.sarvela@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 8:57 AM Marco Elver <elver@google.com> wrote:
>
> On systems with KPTI enabled, we can currently observe the following warning:
>
>   BUG: using smp_processor_id() in preemptible
>   caller is invalidate_user_asid+0x13/0x50
>   CPU: 6 PID: 1075 Comm: dmesg Not tainted 5.12.0-rc4-gda4a2b1a5479-kfence_1+ #1
>   Hardware name: Hewlett-Packard HP Pro 3500 Series/2ABF, BIOS 8.11 10/24/2012
>   Call Trace:
>    dump_stack+0x7f/0xad
>    check_preemption_disabled+0xc8/0xd0
>    invalidate_user_asid+0x13/0x50
>    flush_tlb_one_kernel+0x5/0x20
>    kfence_protect+0x56/0x80
>    ...
>
> While it normally makes sense to require preemption to be off, so that
> the expected CPU's TLB is flushed and not another, in our case it really
> is best-effort (see comments in kfence_protect_page()).
>
> Avoid the warning by disabling preemption around flush_tlb_one_kernel().
>
> Link: https://lore.kernel.org/lkml/YGIDBAboELGgMgXy@elver.google.com/
> Reported-by: Tomi Sarvela <tomi.p.sarvela@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
