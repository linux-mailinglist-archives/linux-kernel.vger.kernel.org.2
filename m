Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E875841A438
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhI1A3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhI1A3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:29:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8605C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:28:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q23so17387632pfs.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 17:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+O2oP5PBbznVkw0kl68S5JiNk8ZSLPfew9HvyuC3qQ=;
        b=V2LwPj5OjmEykE/J8mpGwB3g6M8zqXcDWBz8WFdrLoO8byKAaHYH3fMOwLkhxiXRJG
         RO3dF8L90Gf6EBILqHOO+rCFlKMfa0cgUI0yzZ3QU/JaCZ9Atlf3b74N/mugYxy1x5nc
         u8X368N0dlzYThZhclBdU9RVZ2XHzNC+yjVS6GnjJngBcFhKuzkItoCt7CaTqi2+RPvX
         T0UmPsdQzo6Lk6D2aOslQjBcNEtfKlGf1e6y7W6CxlBM2ioyJStlkCnWCqH/ObOAkI3E
         DkocQVeJ95OAdSrnOqEKaKTuoxHy1FVBiXb1KYndV6mScg8YyhiSi0KZ6uk9OHBtucr+
         t9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+O2oP5PBbznVkw0kl68S5JiNk8ZSLPfew9HvyuC3qQ=;
        b=m37FanbLGqSWg4q47kll3U4QZOCD9ihVVfrLnwqdYpyq8Vn1FfujkwtpbXiBiD9oq8
         5B4ZTHadTPmlOgG3jO5LhvYPemy5YmxA68+9SuipJEJ9mQk5Ac1tK1R7U7hapbPqu8Zj
         LhMoilmU6D07WYSTWmVYbvrx/YKXGMZxQZ9XV9Jov4XDdDGL7laOHGqM7mXsJ2rmIwDq
         wnOuCA4X684rAH7lvaGR/5rv/2XtgVT1Q3/foRGCNtwUotEZ8gpsw8QVVEBPdMwE11bX
         aMQ+aL+NOw+CLfcbKSLc+PiWL7cLeiApbAjIJR+Gua41lG6CU5sTJU4AqrURGak6zaP+
         /6Ww==
X-Gm-Message-State: AOAM532Qywbn3bM8M+VOl+W7Mbw6i0VR54yGLPhvKEDKAK2xo4HiHThY
        RZbtKWtWk/EeIQaYnpEm0JsR+O9cIIRU/EodQnA=
X-Google-Smtp-Source: ABdhPJxSCcDudnZ/+5WIuzEmPKPUoKlC6lTU3Z+rEE6Rm37qyw+RQ8l7Bf18BVazv/iZ8xQ108XU36x/dOmuDRAjb2o=
X-Received: by 2002:a05:6a00:78d:b0:447:3496:a301 with SMTP id
 g13-20020a056a00078d00b004473496a301mr2795810pfu.68.1632788893309; Mon, 27
 Sep 2021 17:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <e2b142ad4a44535d5aa81b0c00c5f05f312f9097.1632738876.git.christophe.leroy@csgroup.eu>
 <87mtnx1rhr.fsf@mpe.ellerman.id.au>
In-Reply-To: <87mtnx1rhr.fsf@mpe.ellerman.id.au>
From:   cp <carlojpisani@gmail.com>
Date:   Tue, 28 Sep 2021 02:28:02 +0200
Message-ID: <CA+QBN9Bci34_t5wKqEMck29MGM6fti=hMQ0w2zt9AEaCS0f7yg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: Map 32Mbytes of memory at startup
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess we're not expecting systems with less than 32MB, so making it
> unconditional is OK?

hi
it's not 32MB of total physical ram, but rather using 32MB of the
total physical ram to correctly boot a kernel bigger than 8MB.

The problem is complex:
- u-boot loads things at 0x0200.0000 (in my case)
- then cuboot copies the kernel to 0x0090.0000, and appends the flat
device tree to the end of kernel
- then cuboot copies again the kernel to 0x0000.0000, and invokes head.S

at this point head.S needs to initialize the virtual memory, and needs
to have 32MB mapped in order to correctly gets the flat device tree

if the kernel is smaller than 8MB, then cuboot copies it to
0x0080.0000, and head.S only need to have 16MB mapped in order to gets
the flat device tree

Cheers
