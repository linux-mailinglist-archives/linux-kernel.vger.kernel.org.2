Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296B83B0032
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFVJaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:30:44 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E134EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:28:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bm25so22829799qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4DQbfXpC/jltQHrmKqBHkqXNz4Cwyp0eCIHowO6dsE=;
        b=UuHF70wnNI3ul+ZHhqnG6aOsBavnT4oLVZB+yfHB/nEC0ISs1e1rg+GAlcDJncL/Np
         tR9CBRszzXT9NkQpQ7rnJZaFEwYtKPcLqx5uH+0gcWQ5dgg6eF9burvSkSFUTArQNxo9
         bmQhvemRjqXGhPOW80wdSpGuA+BGQdiSOza8AI77rD/GjqmozYM2kQpJOrcxvSy6q95h
         GDEDzMT2Mex2wl6yqQvb1A1r7msSftqBdCkUTW1ONCuoZP14B/FB8qRhQibg9ExwdxjU
         KjymMi9bWIdb7RjBEkVaaWZOHlSYlwwVwYhkImS8j6ebeIIOH0mjrQD/yNbuPDmObCdh
         1sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4DQbfXpC/jltQHrmKqBHkqXNz4Cwyp0eCIHowO6dsE=;
        b=TnkR1SMmCajzB+CVZ2uRv3gRpu/50HYp6fQjWSVVs/R8USh71cnBeAl9PfBcEWKNUz
         ve8D8Y1ogGOuaYK9V3KsehUd42mmVIEYHkQufjV7o+x25YKk1K+Ddxxz9iK19x42niOO
         9miMyGGY0RlZjcH+b8FJrYy+JH4uaDcnMXQJVhI55aMDYi1zqvsKRvU/qP2zJ3GVwMTR
         I2SlZDuRkzefix68yml7Eo/GdHgYtQf/4fRmQrZhuLYDlkGrlv+Cs/z67lxW/iFiV+Zd
         eIgIgJZNagDr62uz/XIUPQR9B8uQkRJNslL3yGydXS0SUcayiwqCTZv0APtWAloMGjN6
         BAWQ==
X-Gm-Message-State: AOAM532cKoEEMRdCmG2eWYtdMArPNr0FxXtdS0tCsXDcSlDwkMc1M+jX
        6KVi2NLCDX6WFx6HZ3Q+dBRsc6VXe4z4s4r8ah9yBQ==
X-Google-Smtp-Source: ABdhPJzpBHPyht+lAjdu5BHc9KbrkBS1r7WeeCuc7EkB1p9/MtfIKFKON+Lj/E/4fUHj/Tk6lQGR93DsQjYoUZHYv/U=
X-Received: by 2002:a37:670a:: with SMTP id b10mr3184065qkc.352.1624354107698;
 Tue, 22 Jun 2021 02:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com> <20210620114756.31304-3-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210620114756.31304-3-Kuan-Ying.Lee@mediatek.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 22 Jun 2021 11:27:51 +0200
Message-ID: <CAG_fn=UTfR9yKrkdRDjxFn=vgR_B7kzytm9WDWT14Gh0PLXyJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/mm/kasan/report_tags.h b/mm/kasan/report_tags.h
> new file mode 100644
> index 000000000000..1cb872177904
> --- /dev/null
> +++ b/mm/kasan/report_tags.h
Why don't you make it a C file instead?

> +const char *kasan_get_bug_type(struct kasan_access_info *info)
If this function has to be in the header, it should be declared as
static inline.
But I don't think it has to be there in the first place.
