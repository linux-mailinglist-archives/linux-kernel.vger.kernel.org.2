Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F6A445575
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKDOmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDOmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:42:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DADC961244
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636036778;
        bh=ai31fzAbWj8pRoJ/nZTLZdrdlF+TK/pOzNP3mcZ4RTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RFkeXZlcGamv5Vouh/DNZEIfWGdikJbn8FzthkiGorj38Q/sYSkBwH/YxVUFwyzG0
         N403HxVcAIYijcNd/7tde2Cu1+0rl1wsvsmEHWWgfvbcS/gJL0MoVJYpBDNxK5H2dr
         PgdQSwYSIV8z9q+IICwKIm0hraqkaLWPa0ExAQRF93QYSgDhTHcZ2nzk9pV7y6+NKs
         AblsJGVgndF2xMY4JBIz/QCuKwn8zxSAOEfxj4NVSb31TLSHvvktiuNxhlgoNx/z1q
         m986JpGCXD/++Vm+OSg5xFxQKXgZeOyajTlIu8uoUDkbM/xEz9CPdkUS18akrWPQoK
         9poFEAtOYfPmw==
Received: by mail-wm1-f42.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so4438477wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 07:39:38 -0700 (PDT)
X-Gm-Message-State: AOAM531FW4HFN/Sk7gTx1dRe0odL65g6pSsFxrRCfOIzEkUYJSCfw8pu
        w+rVIGS2ajNQiugWccSLX7e8RKQNaWAGL8OIVE0=
X-Google-Smtp-Source: ABdhPJyVqn+aJE8IHgch7AdIuqESKhXTx5L0KXCRWKzrMD9FeGcqtI0O3CVdwxGSSN1H/T8sxxoFdNTY3m6sp/KZdy0=
X-Received: by 2002:a05:600c:2107:: with SMTP id u7mr3532339wml.82.1636036777247;
 Thu, 04 Nov 2021 07:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211104133549.1150058-1-arnd@kernel.org> <YYPmrAGIBgMq2zQE@casper.infradead.org>
In-Reply-To: <YYPmrAGIBgMq2zQE@casper.infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 4 Nov 2021 15:39:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a38r0PwHJUVhtV379+YZgkRpr+gfaRJK_V+ddHu4vEuDg@mail.gmail.com>
Message-ID: <CAK8P3a38r0PwHJUVhtV379+YZgkRpr+gfaRJK_V+ddHu4vEuDg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmap: avoid -Wsequence-point warning
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Chen Wandun <chenwandun@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 2:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Nov 04, 2021 at 02:35:40PM +0100, Arnd Bergmann wrote:
> >
> > This only appeared in one randconfig build so far, and I don't know
> > what caused it, but moving the index increment out of the expression
> > at least addresses the warning.
>
> Would that randconfig include CONFIG_ARM64_PA_BITS_52?
>
> #define __phys_to_pte_val(phys) (((phys) | ((phys) >> 36)) & PTE_ADDR_MASK)
>
> because that's going to double-increment idx.  Or single increment.
> Or whatever else the compiler feels like doing.

Ok, got it. I've got a new patch turning that into an inline function now,
which seems like a more reliable fix. I still don't see why the warning only
showed up now, as both the caller and the definition of __phys_to_pte_val()
are not that new, and I've been testing with gcc-11 for a while now.

       Arnd
