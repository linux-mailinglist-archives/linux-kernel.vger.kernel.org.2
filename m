Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF4365D61
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhDTQbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhDTQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:31:38 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D669C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:31:05 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id o17so8457460vko.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyeBpP93r/ZScXTlbohZqR/MhbvH5Rc92gL8R/yslVY=;
        b=CgbVw/oINtzTTI1+A0YC6JPWahqbSC2IdZ9dEmpk7H1hsd38Q1gr9Pd3Q9rN7Z9D5g
         yCqwpqVnXCBGiqGtUChUW4HbEtfwSpTK8ROdJXcsh0qB9OodRCUEAJJDVkhjPlQOKn2D
         vUHQwDt2559vKDjgYkFeTx0+zRl+rTmxlMWUAqBIPuQPAycPmTip1SqtJXMiCa7l74ow
         w+/KqQoaYJ5rWqWM4jXAJ5VvS7KibmpMIxKV6ywT5AjDflR9R+8S6eM+2z5uedxa64Gm
         vgB+wchJDtBhwLdxpEfKqk1qKzp9TOwy7pmzCuUwsIF52bGr+HKvWjtSdIoPhNjKf70E
         SIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyeBpP93r/ZScXTlbohZqR/MhbvH5Rc92gL8R/yslVY=;
        b=VnNfjrH/qzIA49zuvPzBXml1kCCfwotnjwzp1iAjrEAel04A4Gskwdo9VUXs6VYOcU
         /Pxt5JfGl4L2uOpAn8nI3qDjrZ9WIeA6gLAp4ZhWeV3J8ecZcgPPWPWsGkj6x+RIIayW
         yiZzAEbRM5Ybb88Yw1hE+Uwdy76682vtdBH/PtanwCMkGUN0ykn5s7G2+ifPAgk98KFn
         GxdMddFQSxDNRcFPH0CDs8Yg78fdlmzfJa7Ts9jCIf1O2JhdrNZm6rXCIyOT9kMWVy6E
         GOWUrmQbYirAqnoALQ9DS/jQ/ute3+FyE4D7SVu2Rqy8dU3GbeUUpMWDDNypULcS4CUH
         vjvw==
X-Gm-Message-State: AOAM530nRmUcJsExWY91OYb+/uaGW5gM9ob8VVB6iOpEPzn4fg262k+e
        7PZnYOPCQXizBZ4iUDlc9EnNOKDnAi6JyNFYUpVJJA==
X-Google-Smtp-Source: ABdhPJx6jG67VpNY3OyeKZKHSCMUZbY8X2DVAXHrorLVCyhF0BXZcmUT2UykHJjG9gynWS5xc8oj2nlUOHHQ8Nnsb6w=
X-Received: by 2002:a1f:3105:: with SMTP id x5mr9160343vkx.8.1618936263724;
 Tue, 20 Apr 2021 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcxDJ5gH9XvZ1bMsRqqU8bTpGLsz75+pWMnj52b-nMZHKhdtQ@mail.gmail.com>
 <20210420154730.GA577592@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210420154730.GA577592@agluck-desk2.amr.corp.intel.com>
From:   Jue Wang <juew@google.com>
Date:   Tue, 20 Apr 2021 09:30:52 -0700
Message-ID: <CAPcxDJ6bPH4TSO44RpPSU2EqjmBaWOf88JMfYKdiFYe755Dzug@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 8:48 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Mon, Apr 19, 2021 at 07:03:01PM -0700, Jue Wang wrote:
> > On Tue, 13 Apr 2021 07:43:20 +0900, Naoya Horiguchi wrote:
> >
> > > This patch suggests to do page table walk to find the error virtual
> > > address.  If we find multiple virtual addresses in walking, we now can't
> > > determine which one is correct, so we fall back to sending SIGBUS in
> > > kill_me_maybe() without error info as we do now.  This corner case needs
> > > to be solved in the future.
> >
> > Instead of walking the page tables, I wonder what about the following idea:
> >
> > When failing to get vaddr, memory_failure just ensures the mapping is removed
> > and an hwpoisoned swap pte is put in place; or the original page is flagged with
> > PG_HWPOISONED and kept in the radix tree (e.g., for SHMEM THP).
>
> To remove the mapping, you need to know the virtual address :-)
I meant in this case (racing to access the same poisoned pages), the
page mapping should have been removed by and the hwpoison swap pte
installed by the winner thread?

Other racing threads can rely on the subsequent #PFs to get the
correct SIGBUS with accurate vaddr semantics? Or is the goal to "give
back correct SIGBUS with accurate vaddr on _the first MCE on ANY
threads_"? I wonder if that goal is absolutely necessary and can be
relaxed a little to take into account subsequent #PFs.
>
> Well, I did try a patch that removed *all* user mappings (switched CR3 to
> swapper_pgdir) and returned to user. Then have the resulting page fault
> report the address. But that didn't work very well.
Curious what didn't work well in this case? :-)

>
>
>
>
> > NOTE: no SIGBUS is sent to user space.
> >
> > Then do_machine_check just returns to user space to resume execution, the
> > re-execution will result in a #PF and should land to the exact page fault
> > handling code that generates a SIGBUS with the precise vaddr info:
>
> That's how SRAO (and other races) are supposed to work.
Hmm, I wonder why it doesn't apply to this race.
>
> -Tony
