Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119E943C332
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhJ0Gsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:48:55 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:40893 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhJ0Gsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:48:52 -0400
Received: by mail-ua1-f54.google.com with SMTP id e2so2983680uax.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3OYuluJJxgLVvFCzRNdVWcBJVm4Oc75q+PDZtzI47A=;
        b=KXLGZ25iho11SUvbNIttyGZzTRHnctmmaL94g8J5AQt3DI4MolqsaOfcFPIq5lhE1u
         Tqb7uCQNgEyYAxV2m1+T01mzLF+w5Wgc8QNYJYVUMsfmrxlqQIR8X2/eku63jXxb33+k
         dTGi77lLijRT8PuD5S12ivOL+kOfevswdJnP7U/hGobol3JQiiX+DRUEKaFs5ecW2yqu
         4cd5y9F77XWggoNAPQQLU2F1Ct2amncZ8sJXMaePXU80hGEEu5i3oqqMcFk0JhT3jsan
         gYVgKg0L5Pr+lFkasRtGSSgi/Z+nMv6lK/HpNu8vhqz0IbQCswbUU9gTNP6MZqayb2NQ
         wfXQ==
X-Gm-Message-State: AOAM5325jWEurqNKZnHL5KbHquBmX39kF6uQW0x75LlNwcwYqjwJ9pFN
        DSGmVbqAMpBOyns6jMbO/wdH5yL4J5/O5Q==
X-Google-Smtp-Source: ABdhPJymJYlzYgynBxyflK6CY9iioAYjTQ4oIp8GbPomc5LD7LMf30ia5jCRzmZs5y1o12YYrOhw7A==
X-Received: by 2002:a05:6102:a8d:: with SMTP id n13mr29081341vsg.17.1635317186472;
        Tue, 26 Oct 2021 23:46:26 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id y19sm10891812vsi.17.2021.10.26.23.46.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 23:46:25 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id e10so3040474uab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:46:25 -0700 (PDT)
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr29056379vsl.9.1635317185074;
 Tue, 26 Oct 2021 23:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com> <20211026173822.502506-7-pasha.tatashin@soleen.com>
In-Reply-To: <20211026173822.502506-7-pasha.tatashin@soleen.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Oct 2021 08:46:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWWKY=R8=RGfHosSq_YcvsB1Ub8VURJ=uwHCJidAJN5EA@mail.gmail.com>
Message-ID: <CAMuHMdWWKY=R8=RGfHosSq_YcvsB1Ub8VURJ=uwHCJidAJN5EA@mail.gmail.com>
Subject: Re: [RFC 6/8] mm: rename init_page_count() -> page_ref_init()
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 7:38 PM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> Now, that set_page_count() is not called from outside anymore and about
> to be removed, init_page_count() is the only function that is going to
> be used to unconditionally set _refcount, however it is restricted to set
> it only to 1.
>
> Make init_page_count() aligned with the other page_ref_*
> functions by renaming it.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

>  arch/m68k/mm/motorola.c  |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
