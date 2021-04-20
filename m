Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA50A364F87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 02:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhDTAdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 20:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhDTAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 20:33:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0DEC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 17:33:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d21so22813816edv.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 17:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pz/zpqrNsXBLRBdAANHO3s6ykIZgjKdFVra10NB441U=;
        b=GWIugcBbcAEFKrQ7DDpWfxxRc3DQvHV5d/FzDpNeto/wqSVixA7QawBw2XoAQRgG3g
         vWVZPSG8itZARpLSizOZgsuHdTeLOK1QzPIzF+ThWtfcpeyK9QSyGkP7H9rCatjG96MY
         2lXHJufdm4v+ezEQ3fr1BoXCbvSajStrFMVkqw+40YkhkBDLJ9FJJld2MG40iFjwogQ+
         2y18utHnsKAnGM9foiaIiY6ANkq0mk2cyfruHK6/A++jE+MY6vRoq9bkob9/MxOgTqJb
         mBLSSRkQ0PtDYSoW4pLZmjzF1l/zGfLc6i24RWD1RUQxYfbw4KzdQHWa2U4grsPnf4KF
         q2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pz/zpqrNsXBLRBdAANHO3s6ykIZgjKdFVra10NB441U=;
        b=biZ+WA8PvMupK+K0B64V0AZ6qQvxokqtal0iwc51mMhD5/GYMkKyCJ3abHzfaajuZ2
         5Y9hmqWHT+1qnZH+hKbbZ87ZTpAElF1ERKjp2n7cTs4ac1UJmztD/23zVVKRrk8tFz+l
         psuzNH3WIZ54UrO0uPIxRDSV2olbhVgEMJaHWbJJRy9GC6tJGXc4OpFfsV+nsHOiaWUR
         Sal0h0CoWfh2jMur/lVrlXGVuG6g/0CaMOd3yz6kydCqEhcec9dRP6VrcG1CSukPz81r
         mxkYQmlceaFDN/aNSSXA+prfexthu25cm+f7Hggqfs8vLrWQxdeD41g/kUrvis9Tmc71
         J8zw==
X-Gm-Message-State: AOAM531kfN6w36QgeSif74I1OhiNf33NsiSg1qFbg/9iUIYM8rVdVcUL
        J4GERMaXI/PyHuDspRYT4eXxpdjkadyhjANkXnUgMQ==
X-Google-Smtp-Source: ABdhPJyJxDW+nX58cu0dv51Y5mvuJVcqennaSe9Wn9IA4DG203YPUfU/I8YqJLRMN94aW2jdMp0mvm7HVwx4XH4XmmA=
X-Received: by 2002:a05:6402:35c8:: with SMTP id z8mr4181007edc.210.1618878799838;
 Mon, 19 Apr 2021 17:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210420002821.2749748-1-jane.chu@oracle.com>
In-Reply-To: <20210420002821.2749748-1-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Apr 2021 17:33:10 -0700
Message-ID: <CAPcyv4j-JANFd_b0x8fPd3=OsfGk+SDmdSZhMVyrQowex5r6KQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memory-failure: unecessary amount of unmapping
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 5:28 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> It appears that unmap_mapping_range() actually takes a 'size' as its
> third argument rather than a location,

Indeed.

> the current calling fashion
> causes unecessary amount of unmapping to occur.

s/unecessary/unnecessary/

>
> Fixes: 6100e34b2526e ("mm, memory_failure: Teach memory_failure() about dev_pagemap pages")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Other than changelog fixup, looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f7ed9559d494..85ad98c00fd9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1368,7 +1368,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>                  * communicated in siginfo, see kill_proc()
>                  */
>                 start = (page->index << PAGE_SHIFT) & ~(size - 1);
> -               unmap_mapping_range(page->mapping, start, start + size, 0);
> +               unmap_mapping_range(page->mapping, start, size, 0);
>         }
>         kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
>         rc = 0;
> --
> 2.18.4
>
