Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4590843F3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhJ2AQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhJ2AQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 20:16:42 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:14:15 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y80so19629054ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 17:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0H+hcz5mIoLgucYJuuIQzKuvcx/oSxpsxSEye8deWqI=;
        b=PndcFJbVAdtS1AqoPJIf9X7FJ1nfi3+nOGlGHvxK0OobEUuuu+fjPp0K00BASkq96U
         Ki8zmY8N5/ZrucFmzHGz6hb4/PA0vqeswec7fcTjKbRkBDVk2odz5k0LHISdx/gxFtBr
         dEuBcc/kz9yuMGoJ1/E2n9zlN/Jh5JH0Qq7Pw3eBVO1Sxpz3OFChmyRiRM+w+ruXxNR5
         pOBNwRPrDKQ09fC+NZTBieeYJkL0DhDsQu1YvS9iFqlZx9oocw9lSy3zn+8oeXkZPziq
         rY0Y2S9+astQ5SO+CUeAn/0HXVn2gGGRW7RDAhhhKyzvJBlaHIlLBxhbZVGbWyLdYHYX
         WuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0H+hcz5mIoLgucYJuuIQzKuvcx/oSxpsxSEye8deWqI=;
        b=C4Gv2wLr8QrUW8OugEEt+xZhAjEVtflzOPzOjljBk5xc2xKPnST+5MJvhZ1EbxGQ4d
         kF+Qeyt8Vu2anRKx3f2DrbhN+MWVN27O141WUOhn7vFKjfQys2F6s6B9CsN/Dz+xKemk
         G3qzvfNdsPjPMQK5JDG0LIaaP67P+lsllRNcCOTsk64c6y1K5QL2cK56s7tnTcgQrwIi
         kSdhQGQPccMzv6DzHSX2yMjiPwYJhoKujpuhkVglzTlLqTA9u+lpSjX+81JphzrcVWpe
         O2sapNHWIn7L98/43oB4qDa3xQfxZkYi5KQO4NpO9Ok6H/fUtjTsqy6Va0i0WBh4nLpK
         FbaQ==
X-Gm-Message-State: AOAM531AA8gHocA9r+HDWN7JLwuvs+P3JLbJIROAbaPHOBHV5FbMqs+c
        gt1D4jlKQKWiVu1UuqrsRkto0FRbw2B/UOxEXvOpmQ==
X-Google-Smtp-Source: ABdhPJyVr9GGlBvM3ABP3VuzD+WvD5mPysWBbO2rM1Qq/WH2UgidBV+oieFKiStalrjoQD0ajCurgFcnZ7qUw1ksS2k=
X-Received: by 2002:a25:6b4d:: with SMTP id o13mr7224133ybm.291.1635466454061;
 Thu, 28 Oct 2021 17:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211007143556.574911-1-eric.dumazet@gmail.com> <YWWD8NCCJi3kZKvq@hirez.programming.kicks-ass.net>
In-Reply-To: <YWWD8NCCJi3kZKvq@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 28 Oct 2021 17:14:02 -0700
Message-ID: <CANn89iLdxNeZR_67ZOTX+K7GbOw44kZXU=ebpODySDs6x5BZNw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/apic: reduce cache line misses in __x2apic_send_IPI_mask()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 5:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 07, 2021 at 07:35:56AM -0700, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > Using per-cpu storage for @x86_cpu_to_logical_apicid
> > is not optimal.
> >
> > Broadcast IPI will need at least one cache line
> > per cpu to access this field.
> >
> > __x2apic_send_IPI_mask() is using standard bitmask operators.
> >
> > By converting x86_cpu_to_logical_apicid to an array,
> > we divide by 16x number of needed cache lines, because
> > we find 16 values per cache line. CPU prefetcher can
> > kick nicely.
> >
> > Also move @cluster_masks to READ_MOSTLY section to avoid false sharing.
> >
> > Tested on a dual socket host with 256 cpus,
> > cost for a full broadcast is now 11 usec instead of 33 usec.
> >
> > v2: use a dynamically allocated array, as suggested by Peter.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Has this patch been merged x86 maintainers tree yet ?

Thanks for reviewing !
