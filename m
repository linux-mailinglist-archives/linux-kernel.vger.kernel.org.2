Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98D831A5F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBLUWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhBLUWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:22:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72F5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:21:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cl8so265154pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqHGpHlEVtMfxaAYSRUeoJtPJMW39eSW7LQpfFCRpGU=;
        b=l95kKpXY/Ffe7uyRIJyZ57R505HOX3CkoEK3rvVY1WlysL8Q8zw+ZWWZoPwKdnUREA
         FAh9wVuYAuOP3/BnTUKom0DP83wHkGcOkqcqVV1ehLoHnvPgKFQLv05pd++AvOb22Y3/
         pST169LY53VWEECPdVPfgaHYBEu6puzilFe8TzRNQ1zJ1LxIcoaiCfF42WCu3WWtn9f/
         mbbRDnxmlGLJN58dIl0OhQkSEKxNSO9P4l6hXmjgzvobjFcuPPmkE/aJEkKwKdsrsc9b
         FwmxrXMJCUZxGpb4QNixgUieoVzw/WSO2KV76LGFPDMPtQb0WleT1wFkbnFfxR/bhfzS
         65/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqHGpHlEVtMfxaAYSRUeoJtPJMW39eSW7LQpfFCRpGU=;
        b=YqkrpsMewjoB6SFG6ylQj5wK0idoV7Oz6aqpEa/7XelSN7aK3cn3KmaEv3jo5IKC/Y
         Vj4R8zLb1NL+0hTY2VNLvzAvLPMbEQ0QjolehEDGJTu626BW5+SzvFa3GcaMku8fC3SQ
         wPyEb7BAUzciSj0XiOupmKVnRcV46xFmZdIlf7hDmcnhqUtIfeqb3trxrc3G/y1Qt2oV
         sqyJkM+sWky6wkQRS7EcvIaTSoJWG1p3JwtEw4ASO0RUfrwso8WcG8IiFxS6OtGVCqpb
         vmAVcQIhLPZ/2h+9o7UoLPcfRgYpUzdti/9hHQCmqNkzHz/9BNUlI0Eok+lBbAgHewbx
         vBhw==
X-Gm-Message-State: AOAM532nusrnTcKJD/eh4FOdVVN+2Yr6z+jD6axSDP0HFST5bel1/idG
        0pqWQCrrV7ytspQtcsV0SQK+BjapW+WU8kBsprVqmg==
X-Google-Smtp-Source: ABdhPJyBOo+RPuiHr7zk2m0j3+Grll3y+A/FkP89wfB3qaOEU+d4H8phHBAgRXJ/hz9jm1O2ASsrK5j5zv2u00V6aEk=
X-Received: by 2002:a17:903:31d1:b029:de:8361:739b with SMTP id
 v17-20020a17090331d1b02900de8361739bmr4221474ple.85.1613161310340; Fri, 12
 Feb 2021 12:21:50 -0800 (PST)
MIME-Version: 1.0
References: <e7eeb252da408b08f0c81b950a55fb852f92000b.1613155970.git.andreyknvl@google.com>
 <20210212121610.ff05a7bb37f97caef97dc924@linux-foundation.org>
In-Reply-To: <20210212121610.ff05a7bb37f97caef97dc924@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Feb 2021 21:21:39 +0100
Message-ID: <CAAeHK+z5pkZkuNbqbAOSN_j34UhohRPhnu=EW-_PtZ88hdNjpA@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: export HW_TAGS symbols for KUnit tests
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 9:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 12 Feb 2021 21:08:52 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > Currently, building KASAN-KUnit tests as a module fails with:
> >
> > ERROR: modpost: "mte_enable_kernel" [lib/test_kasan.ko] undefined!
> > ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!
> >
> > This change adds KASAN wrappers for mte_enable_kernel() and
> > mte_set_report_once() and only defines and exports them when KASAN-KUnit
> > tests are enabled.
> >
> > The wrappers aren't defined when tests aren't enabled to avoid misuse.
> > The mte_() functions aren't exported directly to avoid having low-level
> > KASAN ifdefs in the arch code.
> >
>
> Please confirm that this is applicable to current Linus mainline?

It's not applicable. KUnit tests for HW_TAGS aren't supported there,
the patches for that are in mm only. So no need to put it into 5.11.

> Today is pretty much the last day for getting material into 5.11, and
> this patch has been churning somewhat.
>
> So I think it would be better to merge this into 5.12-rc1, with a
> cc:stable so it goes into 5.11.1.
>
> For which we'll need a Fixes:, please?
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210212121610.ff05a7bb37f97caef97dc924%40linux-foundation.org.
