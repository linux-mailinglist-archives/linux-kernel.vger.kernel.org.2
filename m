Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C45363F10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhDSJoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhDSJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:44:52 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC9AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:44:21 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id c84-20020a4a4f570000b02901e9af00ac1bso1392244oob.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4SsjBBBWAk9PglcpWZrcZB88JEvecexvFUi0GD5O9o=;
        b=Fnpl5H0etWSmKyfe2GsN2TRAI0qkylTHELE4LbYuKhWUKxlgbRGl90BJWvQjsnKB9t
         mqZ0xwCiCM/AibNY+58YgNmT+qEUb+m1c5yewpfpqUgjfjFt1fTU0C3R/5+29DXsmwqc
         TFLptvpbNkHFundGMJ79T9oLlGHKqcPMlRbcn6YeDWRNrFAgT4aTLWbNnGQKUIC/hIkU
         VSXQGBjkzXnmlnH3ysi6cYg1bur/hiPeIne1gG4frKdGqF6M9D14VlmFFn4oBdHiBwmh
         yiqeXIiIaYT8AITTAgrbXL4tFVEnT8cxMqj3fXUTjq0DMO89rfwKvoh6+k4V0iJLYdTe
         7+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4SsjBBBWAk9PglcpWZrcZB88JEvecexvFUi0GD5O9o=;
        b=WcLl9BH7XqIZ35OokCuldEUo6k5VxM1JOxOxZ1CA42WiA27eErx50PjGocsuRtbGhz
         m0QQK5oG2BBUwGk09nAmrnTVCddFSVFPwyyMJj6Ltvreei4pcIbmULjreyK7n/PIDC1g
         AYgbFv3ziSTKZN2TM21eFVOQmHA6W6Px9QoibGzgRbGWdAW0D7+Oq+wptmFxa/swrP9E
         s/qq4Ag0iXAFJW0ypkzi8oGB+vn0VCnRoDLa+xON+Hl1jl9boTtmaPfiF3ozHuWLVsf3
         LEtJy07m+FskHhuKH5Tkq/DWw0y7stHHMdScORAxjBCrI9I4Ug4Rw0R/fz9mvqAokygs
         v03w==
X-Gm-Message-State: AOAM530ar2YlcQpcgXSUB44DsclxneLqMh6vofMwLmSKCX8wWy3dBNPq
        4LpRiB07s6B60As39LoXUi7mrpwAqy8qgs7RNNeeQg==
X-Google-Smtp-Source: ABdhPJx8V+fYrfsN3nTvs02sCEhF15TCAcIp6fVMcPZIvT+JjyJGqWTZfvLiVmqBDOCw+wunTkoXSQRfjng2FBECoR4=
X-Received: by 2002:a4a:d29c:: with SMTP id h28mr12940962oos.14.1618825460590;
 Mon, 19 Apr 2021 02:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210419085027.761150-1-elver@google.com> <20210419085027.761150-2-elver@google.com>
 <20210419094044.311-1-hdanton@sina.com>
In-Reply-To: <20210419094044.311-1-hdanton@sina.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 19 Apr 2021 11:44:09 +0200
Message-ID: <CANpmjNMR-DPj=0mQMevyEQ7k3RJh0eq_nkt9M6kLvwC-abr_SQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kfence: await for allocation using wait_event
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 at 11:41, Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 19 Apr 2021 10:50:25 Marco Elver wrote:
> > +
> > +     WRITE_ONCE(kfence_timer_waiting, true);
> > +     smp_mb(); /* See comment in __kfence_alloc(). */
>
> This is not needed given task state change in wait_event().

Yes it is. We want to avoid the unconditional irq_work in
__kfence_alloc(). When the system is under load doing frequent
allocations, at least in my tests this avoids the irq_work almost
always. Without the irq_work you'd be correct of course.

> > +     wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate), HZ);
> > +     smp_store_release(&kfence_timer_waiting, false); /* Order after wait_event(). */
> > +
