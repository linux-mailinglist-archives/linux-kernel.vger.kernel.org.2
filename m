Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7977330CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhCHLvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhCHLvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:51:01 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1155C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 03:51:01 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id h22so8869485otr.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 03:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbNCPfQ/roqFMvfDVCK/GyRFnn05PPWL4s16p+iljKg=;
        b=PS5NN6DUCqMOBqLWOEzdWpTZ1Sa2R2WYZiakOxUSdiElm9ZJ51RzEwsj0Ri+e5mWB5
         Z9QPG1HJ1heIOFlZ8fKe9ous/pi9AthiInarCnWhq3jNCckqZxQhdVl3RfMwTSZlY5lG
         g8EujUVi0mv784njAV974o/XliCTbz2kP0WzBue966M2Ph26LxCmuaMTMeX3Wyr7Shi2
         3U0Lf60BVYrWwo++9+QTKa1uy/lybK/U62qYhPklSlO1fuZLz0oDmm9PsP05qLSWsxSc
         hkwEY+R8vWqQb9uTTIx4pv3ne9D6w/9PJlq67hJ7MRdIxNszM1NQI7n0F6pLsTyo+FZ1
         lUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbNCPfQ/roqFMvfDVCK/GyRFnn05PPWL4s16p+iljKg=;
        b=n1xyV87o1pZgMm7Ws8lrGnO3qF6fkOZrv5UkjP/VF3EW6lpwAvDHzTVZ8TcrMs14xW
         H2s/sffoKGr4317p5LBzhp6eEqU6dsRzPouzTDKuIGp8LBd1hfCTgAmIPnvshOcnGTnq
         DFcRbfDPcPnW3OgU3FbTAlyS1erxBQ8htZJAfADVdtSYAp+JzrRaaCjDuA8h/yMH/bm+
         5h3ouu54VBPrly2QYXgLBJdGzMYNf397dxy6toaRoP8ZH8VX/Sr9cSbPmyk2skZj0Y5w
         tmdOaoFgbv7UqdQHLkoadbyTK+Jl2Am2sWDXhhEVye6sjOECQ91yjG3D2T8DWg2zBpyL
         aYJA==
X-Gm-Message-State: AOAM530ApEMCtzre+F4r/WU5Ds3ddAy9xsjexExLdEGOvOe0vRXODNXg
        sh0cfBENqsBI2xtxCEcSRbJya7HEA7CtfYXZGIU9mQ==
X-Google-Smtp-Source: ABdhPJxLE3Qt3UCz8nFg87Y8EMVRDCfGsHytH1+xHqDhtFTMg/s/NlcmgHBCSeyLFs9ITxbykj8dOdiW0wmu2C2pqEU=
X-Received: by 2002:a9d:644a:: with SMTP id m10mr19849951otl.233.1615204260958;
 Mon, 08 Mar 2021 03:51:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614989433.git.andreyknvl@google.com> <a7f1d687b0550182c7f5b4a47c277a61425af65f.1614989433.git.andreyknvl@google.com>
 <YEYMDn/9zQI8g+3o@elver.google.com>
In-Reply-To: <YEYMDn/9zQI8g+3o@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 8 Mar 2021 12:50:49 +0100
Message-ID: <CANpmjNM+CoExcw=19VOtXT5KMnSboTUCska1tmR_WZVMeE49sQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] kasan, mm: integrate page_alloc init with HW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2021 at 12:35, Marco Elver <elver@google.com> wrote:
[...]
> Could we instead add a static inline helper to <linux/kasan.h>, e.g.
> kasan_supports_init() or so?

Hmm, KASAN certainly "supports" memory initialization always. So maybe
"kasan_has_accelerated_init()" is more accurate?  I leave it to you to
decide what the best option is.

Thanks,
-- Marco
