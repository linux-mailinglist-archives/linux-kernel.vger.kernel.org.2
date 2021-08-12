Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7C3EA7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbhHLPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhHLPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:44:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3135C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:44:15 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h11so11095623oie.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpfP7I/jc2+BB4WhfHjvO/EMXto5OQE4zX/MsZU99j8=;
        b=vRiM7MY6AWLe90EmHAb55UK+uL56sONCIdxRRFJRtQlGwoPsmFFdPVadl1/Ihi4dbH
         2c0xWiepnA2c9RSULOzgy61aGi076jjNO/cC9RxqXz9zyXVsxcFI3xF6xsUxdYi5qF9Q
         hPJK9IgHTG5gLTYElWri/bym+MsYMrylFs4pVWcUGg/ptdidJalbxIfmqvnbCR/J4wN+
         3/VdVRqSBpWDC1OERKgzjxjgD9g0Pw2qOEKEtKf7+1P33l/c2Z6Dk8k4tUx6wrSCYYJx
         I3OpGKMIhtUR6LPyIAXfp/5XomW1Pe24lXSdJAMsPG6t9xtau2mdxzH3LTvtL0FSsHhi
         7vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpfP7I/jc2+BB4WhfHjvO/EMXto5OQE4zX/MsZU99j8=;
        b=JuSB6xEMOLbRhyThuHT9EFDo7mUXcOcoKyNocBQoVItEuxQAv7uWINw2yGS+AVyaXb
         gWBmyVsAaloDl/6Qv34Vg8pOEe8xEOQOwLiDIwVanvYz2gT+B5QJ85w7LW35XvWl1jf+
         aQCUHkqO/pPdoPGGk8HvXTFeAlKVYvhcFusjy/lc57QWLJ8wCB9e7e6oQ9oMA31Yhu1e
         6eVdrGzj75wQ9HYHiyvRhf9aKIX9g+60eDLAp0mH/xdOf6c4XkZwme/3g6zZ33wzdUCH
         L1Vm4/o542FnqIkjc9Sk6mCcsLRm25FeGLqtHGdHutbCbyekwrRUH7CQsF5USyVKjKa9
         MeSA==
X-Gm-Message-State: AOAM533cIUNguipT7q12BNl9Rs4BtN5zN5eOSSFYJklTSHTHXjI6sq/X
        CTDSRUvJVhncc+YhYHERCspTgAiuJaZSmM/x2N+dEg==
X-Google-Smtp-Source: ABdhPJyrW0HY4kHb23UkoThnrJRaIFzVTyyeOpzcToB6SU4lQTOjMLOkjCt2hBV/5uuXCoFEQrIn3GlXakyZ3r5X9Wo=
X-Received: by 2002:aca:eb8a:: with SMTP id j132mr3817727oih.121.1628783054859;
 Thu, 12 Aug 2021 08:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628779805.git.andreyknvl@gmail.com> <CA+fCnZfjsfiAsfnOxJhMaP0i7LaDgsVSkrw_Ut66_E_wQ3hE_g@mail.gmail.com>
In-Reply-To: <CA+fCnZfjsfiAsfnOxJhMaP0i7LaDgsVSkrw_Ut66_E_wQ3hE_g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 12 Aug 2021 17:44:03 +0200
Message-ID: <CANpmjNN-0C8Q4q_Hx988RPSVeb0_54C=cRxfch3H+V3Pb5wWsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] kasan: test: avoid crashing the kernel with HW_TAGS
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 at 17:06, Andrey Konovalov <andreyknvl@gmail.com> wrote:
> On Thu, Aug 12, 2021 at 4:53 PM <andrey.konovalov@linux.dev> wrote:
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > KASAN tests do out-of-bounds and use-after-free accesses. Running the
> > tests works fine for the GENERIC mode, as it uses qurantine and redzones.
> > But the HW_TAGS mode uses neither, and running the tests might crash
> > the kernel.
> >
> > Rework the tests to avoid corrupting kernel memory.
> >
> > Changes v1->v2:
> > - Touch both good and bad memory in memset tests as suggested by Marco.
>
> Ah, I forgot to include your reviews/acks, Marco.
>
> Perhaps you can give one for the whole series now.

Reviewed-by: Marco Elver <elver@google.com>

Looks good, thank you!
