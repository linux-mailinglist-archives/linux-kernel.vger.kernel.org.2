Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C789412B27
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244698AbhIUCJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhIUBxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:53:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15A9C035489
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:30:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y28so72545114lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F04phcRQSPUfY7ZkC6X/DRscrySixKvQV8Zj2GiRtvM=;
        b=C7gc4AzPAKAay4aiwe2Peik4mHpQuwTIEtFvC3AJfU1kJWQtPOpHiQH+hcsqMYD9ZG
         uT+bzPh9384fxb4Ov2BYgcC3she9ny1rmd4su0zK64zXI4AqFwRbCUnnAkuDr6nq+GAq
         vC78VMXmBENpN4acXFfAgaGfSlTDblODT0de8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F04phcRQSPUfY7ZkC6X/DRscrySixKvQV8Zj2GiRtvM=;
        b=giWmVSkVzQsXfGw8daEEySbL9T1MeMsWydGZ/KCVLYFDpDcU2axllEPbsNdNE602P+
         lr8uVCYT+1bAOgwn7rormtwuYGUPsdQRiDa+EsNcKX3Ou8O+4yB1GxIAAJgCyYCsvPH9
         nC1pEfqLI9QCPKmB8ve3ta7zfYWtG0H6/2ds+gyBlgo/PDKN8PjgPUcTnCLq5A0//2Vz
         FnmA1lVIpnUFkD6Yj2h6kHw7g5naMwcTjZim+Sz33WrOZSOsaUz1NA3adcB/kUojl4iM
         p9lzgcw9KEpWxCP6476wDsF92qGvNR/Vjn1qzOE965bv318sl8CkDlJih/HDa0jUMaWl
         QPMQ==
X-Gm-Message-State: AOAM531MroQdJQK+p7MESKQtoylNGIR3ZfaYHHicoP9I+0kCfi/pGoPy
        9sgjICPcgcWZksgbpuQgGo73J/3Du0MzBjgdqOQ=
X-Google-Smtp-Source: ABdhPJxCn30+/TjEZ9mz+KgJH5lvzCbcABW3ZM8LM0dGrcxoM7q0iB9GmVjE2DofC3/oDtatgYjPXA==
X-Received: by 2002:a2e:4b0a:: with SMTP id y10mr23242380lja.110.1632180611523;
        Mon, 20 Sep 2021 16:30:11 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v77sm1374592lfa.93.2021.09.20.16.30.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 16:30:09 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id i25so74866303lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:30:08 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr20462696lfc.402.1632180608608;
 Mon, 20 Sep 2021 16:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210907212347.1977686-1-minchan@kernel.org>
In-Reply-To: <20210907212347.1977686-1-minchan@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 16:29:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2_yEuAC5=9VWefK+0JD9pAKf8qL-vpSmS7MtLA8SZEA@mail.gmail.com>
Message-ID: <CAHk-=wh2_yEuAC5=9VWefK+0JD9pAKf8qL-vpSmS7MtLA8SZEA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: fs: invalidate bh_lrus for only cold path
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        Oliver Sang <oliver.sang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Chris Goldsworthy <cgoldswo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 2:24 PM Minchan Kim <minchan@kernel.org> wrote:
>
> kernel test robot reported the regression of fio.write_iops[1]
> with [2].
>
> Since lru_add_drain is called frequently, invalidate bh_lrus
> there could increase bh_lrus cache miss ratio, which needs
> more IO in the end.
>
> This patch moves the bh_lrus invalidation from the hot path(
> e.g., zap_page_range, pagevec_release) to cold path(i.e.,
> lru_add_drain_all, lru_cache_disable).

Was this confirmed to fix the regression?

I only see the "tested with 5.14" that the regression was still there

   https://lore.kernel.org/lkml/034fc860-d0d0-0c61-09d2-3c41c4f020c6@intel.com/

I don't see a confirmation that this patch fixed it.

It looks likely, but if you have the confirmation somewhere, it would
help to link that too.

Or did I miss it?

           Linus
