Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79132BE21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbhCCRGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhCCMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:36:18 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2F5C061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:27:41 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b130so12070457qkc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQJvPyDlOt5fHAYYg5Wntf4f/iXvZZKqmxZl2pA3ycA=;
        b=I7GRODcAo0XnsoKg75ws5i8n9NObImxtE9WMRcW4ElZn2EzPhTCl2vmOJfV9yscLxi
         0D6s2lMGpwE2rSLse4rszEwt25wzIIwnamMw5rdQFec2liCyFRBb95102aiUBEk5/bGh
         tkvdipXt9/wuEsBIiEasoh29/FkdW706DNGGvXGC0p/ZxDtN4yfpDCMw5fVRvKB4Hg0r
         VkY7aCIZEPsr1CZH5u776xKW9/lAA+j5iOlYfi7Bfb333B9lE1wU0Kr5F4QRx9sprfps
         X2DfUH7lfh3/k2Deh4bNrNFnk6a8aCWoZ6Zxv6SusSb0QUSW/rSWcTedbEEAohEs0Aev
         MGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQJvPyDlOt5fHAYYg5Wntf4f/iXvZZKqmxZl2pA3ycA=;
        b=BaVVnT4OuzSOK4TDUFHJA/2GlqDYd2LlC+WDGpc4QS/+12yWW3dIiK52sWMzzardjU
         rThrPjJrZ055SXVEVTAOmQftm3LE/az/FRjjfX5lmpPJnVGQNZV9rquTPMIQ6UMEC7KV
         WnsnlO0eCVjUUHxvqvtm1njeUQKcgzkl/IZ4en1ZmOtMyO1fs6yZb86rY+5/tObsOmAQ
         lcJPfkh8gcZDGqgPM3dR2v3vxGNEIQ1D9YFVWoVBE/9ghjZ95RhOONMXKp2kVb0rG79S
         KyG7eE6dd2Zffp1q6vf7bJ9AWgiwmg6ESgrUafIZYQPB/+9L3NjuN9iKCyNMKENgySMJ
         le3Q==
X-Gm-Message-State: AOAM531iq7EBm4h15+rCsu5gNt/dKPWmBHLBg77gJ74cccc8gi2yBSar
        x5Nr6VcGEfJoXuIENiNDwwLtPQoyqm4crpvdPmFcnw==
X-Google-Smtp-Source: ABdhPJwgJX+j8CgCGgffgNk0gxz/y7Fxb8hOEIUL8C7EI70yzkFg6bMlbjRKQH40ys5foy7RCInU1cVcExy6kKl955A=
X-Received: by 2002:a37:630a:: with SMTP id x10mr20824060qkb.326.1614774459988;
 Wed, 03 Mar 2021 04:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20210303121157.3430807-1-elver@google.com>
In-Reply-To: <20210303121157.3430807-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Mar 2021 13:27:28 +0100
Message-ID: <CAG_fn=W-jmnMWO24ZKdkR13K0h_0vfR=ceCVSrYOCCmDsHUxkQ@mail.gmail.com>
Subject: Re: [PATCH mm] kfence: fix printk format for ptrdiff_t
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 1:12 PM Marco Elver <elver@google.com> wrote:
>
> Use %td for ptrdiff_t.
>
> Link: https://lkml.kernel.org/r/3abbe4c9-16ad-c168-a90f-087978ccd8f7@csgroup.eu
> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
