Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5E35E03B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbhDMNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346012AbhDMNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:38:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:38:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so1344103pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4KQV/ILjRTEfyafvtEHPuCHBxuKBEtFSnUjDG/AUJY=;
        b=LRl/SL/aIqmiPGiXJhkTeFiqZl5rAFxiuuYnIo0o+91zpyoyM/3pk1WUq/ceE8wHVg
         Va3g4x5JTroA6yrSnk6k/bjlntw/rOpNf5pefyCNQxHhr646Uqm2x37fEnxUrc8ZJJEh
         DNh8ro49tB8qGhIhTlkAgRS9RawM8wpDRcfeAVhSxkN/NydR4gU6bA5+HTsLn/nK02Bf
         JQn9SwpukiFk3KMFuusMu7YxmPUIUU8p9x4Qloz1kof8YUuSuqRMO+ZiCEr4UDcH/EAf
         wa7afwROoSGs55fgqE/xIRyGjypmOp+ErShwWM3ltKGhEQ9zFGCi6RXajkd0yl70UZZB
         FJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4KQV/ILjRTEfyafvtEHPuCHBxuKBEtFSnUjDG/AUJY=;
        b=ZNgn/zIZ4k8XjK8m75ppmHEhvKNUJls0LIcw1W5M9pEH7zHAxESDTDqDM/rFPpE4Ao
         2rcDRTnqbTNUcc1XGMjYe7qQL89Maut/MGxWORze3cZOYFKY+ZWekcYgoUlJ3UGmtb2u
         4FQxHKTa0K74PuC7nlR7tNO7H4h2D7zdXO89W3TLSvKu+ocAyzL2vy0IhC3MeU6UetEN
         mM735Lcook9VaSL96fWNPtDlaDmBhQs7x5K0B6lqLRKaKrx9whdcGhUcl+6AckOfmXhX
         ob8mT1om7l3QI/BL61+ch0XzDzD23BoLsAev4q5x4NZ+cdz8um/zn2cZurpGGbz5IpEb
         6OrQ==
X-Gm-Message-State: AOAM533DfLnOc3mvWJKcBvBin/txaBhD93C9l/luxIrLRHddkPoCVRYd
        A6w5cBFjT0Xc8fcO/1HrPMxBoJ07ariWvhhfXNfeHA==
X-Google-Smtp-Source: ABdhPJy3erD4NrMg9buPu1C82No9WBmEROMMv5BZtjApOeMIRDJDDeVNReF/QbLgMHDfVo0FPcRzzXCv/SRDwqhLhKk=
X-Received: by 2002:a17:90a:6a05:: with SMTP id t5mr115117pjj.20.1618321099705;
 Tue, 13 Apr 2021 06:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210413100747.4921-1-glittao@gmail.com>
In-Reply-To: <20210413100747.4921-1-glittao@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 13 Apr 2021 06:38:08 -0700
Message-ID: <CAFd5g46sOqqjgwHN0Ca55VWUxx+ZzbTfCuh6Axhy4fgwJhQMGw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kunit: make test->lock irq safe
To:     glittao@gmail.com
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marco Elver <elver@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 3:07 AM <glittao@gmail.com> wrote:
>
> From: Vlastimil Babka <vbabka@suse.cz>
>
> The upcoming SLUB kunit test will be calling kunit_find_named_resource() from
> a context with disabled interrupts. That means kunit's test->lock needs to be
> IRQ safe to avoid potential deadlocks and lockdep splats.
>
> This patch therefore changes the test->lock usage to spin_lock_irqsave()
> and spin_unlock_irqrestore().
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
