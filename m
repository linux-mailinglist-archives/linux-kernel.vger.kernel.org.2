Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2060934AD56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCZR24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhCZR2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:28:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3B8C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:28:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k10so9638634ejg.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+JfJ+IVghbbF73AG5/h/ydSFAqFzFdokpF/W0pgnvU=;
        b=DEyQzkgjA8rbI3yPSNDKqVvKOp6l+aPvzG3TsEIH3Y7HtRIeABFnYJke+ss/1be+r7
         39GAI8s6L1jFDJ07yzUc9g5Bs42j7D3zvq9v0+wpVNmUetnwBqonscXjaXB9wvj9+vO7
         ssEy1XQ7JngdvrpeSLC4mkdJRWy88qydn9LhM8Nj93sSYTx6fUbdj5JNJAti2jZ7kzqc
         A13G4iISheGpeitlrqXbeai6Pe74T3x0Il4V+ywGrKT089fiB45UZn3MSJmtel9+RmGP
         +YcPh0R0HDxIInafjZ+P+mTN/B9maasp+gKWn0c88RO3NABG36iXIPiBp1J+Y44unDyO
         RHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+JfJ+IVghbbF73AG5/h/ydSFAqFzFdokpF/W0pgnvU=;
        b=nAuGf4P3QY3pe7aSBBz/mIZastaJj1Po0BRrXbszcb1CkAO/WmvD2H9wyHXehxhAnY
         q7FGsHV6OsK4o3taYro8los+R1P6xA6mkwsV4oy+SxyiIy5QfbTVZfw32wvWYOcTXO+L
         MtgVEIs9ykBnrCrvcuD+HkkMnMPdiIKCQ6+AHgdJnX5aNocZowiqu01UY5svEOvMrhln
         F862hlFEXVKc+gWSUIErknQOVmzZUAESRRJ2Tbcjt6N7qYleLQ7XTE7+MExkaFr+OTIc
         75mEnAUQO0iXUvlgr4WH42TTVXVHikxs8gqErQc4K3bQQLbRGPZ55NB8NzjuvLfFgpiD
         TLwQ==
X-Gm-Message-State: AOAM5338jSfscOqxWwH5Wx7itRzo4R9OeKbIJFJDdoT1qmsvussH0RfM
        xH0VzAgS75KOk8w1w8n0erNVyfma/QoQqpnWzFyibA==
X-Google-Smtp-Source: ABdhPJyfQ//N1TPVO+n/uFqNMXuuRBQcF3/RrleipCOlrsqGKEcAq4Xt8+nrPl4lcK5h3Mbrmse2kFJI3pAxcIftlf8=
X-Received: by 2002:a17:906:3159:: with SMTP id e25mr16617617eje.303.1616779710741;
 Fri, 26 Mar 2021 10:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210324230759.2213957-1-minchan@kernel.org>
In-Reply-To: <20210324230759.2213957-1-minchan@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 26 Mar 2021 18:28:19 +0100
Message-ID: <CADYN=9LZF4zWuV8VA1y3tcoKWzwK3zCJPFL6yDNuvMzGvEVarQ@mail.gmail.com>
Subject: Re: [PATCH v8] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, jhubbard@nvidia.com,
        Matthew Wilcox <willy@infradead.org>, digetx@gmail.com,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 at 00:09, Minchan Kim <minchan@kernel.org> wrote:
>
> Since CMA is getting used more widely, it's more important to
> keep monitoring CMA statistics for system health since it's
> directly related to user experience.
>
> This patch introduces sysfs statistics for CMA, in order to provide
> some basic monitoring of the CMA allocator.
>
>  * the number of CMA page successful allocations
>  * the number of CMA page allocation failures
>
> These two values allow the user to calcuate the allocation
> failure rate for each CMA area.
>
> e.g.)
>   /sys/kernel/mm/cma/WIFI/alloc_pages_[success|fail]
>   /sys/kernel/mm/cma/SENSOR/alloc_pages_[success|fail]
>   /sys/kernel/mm/cma/BLUETOOTH/alloc_pages_[success|fail]
>
> The cma_stat was intentionally allocated by dynamic allocation
> to harmonize with kobject lifetime management.
> https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Link: https://lore.kernel.org/linux-mm/20210316100433.17665-1-colin.king@canonical.com/
> Addresses-Coverity: ("Dereference after null check")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Tested-by: Anders Roxell <anders.roxell@linaro.org>
