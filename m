Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C006335AA8A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 05:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhDJDk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 23:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDJDk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 23:40:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EBFC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 20:40:40 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id c3so266067ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 20:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJJZ2SPgf+Gg+NYfKZ7t6DNqvmzuFuYSeEReOWLgPfA=;
        b=BKAWM2Wq2kpGksARs2bHCTxp3Zo8XV+EcIFoarnHAjAlX4h5kj1kjWsBXNDYoch9Fj
         L64ZaDbcJCUDMRRcSnSo44YgzuckQhaiS9KGTK+o3ZSexmKdF72ebMxl7Mx9LyZBVVHH
         M65eSNwXSPDCQUmKrtODV/ZuBWSXWTt5TljZC/YpVppr08XGlzFlDuRhSLup+p9CYJ8h
         kkWvIq5szwCZzP39vMmRm7uNyU8+EzRnhSWmDySB/Fm0AXNioX3s+mwOq/iuLsPEmzjG
         X7/mBDGyUXwHk1hm0+yVqB3ojfBR9pvh+MPOVyYH0xlnYT+LdLIQ9M2nd4r0r+of3Rpp
         0J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJJZ2SPgf+Gg+NYfKZ7t6DNqvmzuFuYSeEReOWLgPfA=;
        b=D/Bi+4EY8pmFJ7F/gW0rXI2qkKX4JzeaFsxgE8xs3htOHe05jWFwHF0kaY1l4XjdLC
         pza2w5cVhIrC5hh1rYR0BbswEyvfkKFYx0yDLBHe5jy7qOuuL8Nn4GUTzBaO5kxJTpE+
         Tc2mnF/hdV4vcyD0yjIjFKSI64eKK0A4Fljq9O13BlbTnjGwYJ23jDhBpd2VSY1mIllo
         3ozmEEitwUSOjO/YvThbfG3Tx22wQQUzXP/5BMIHbA5VUMEpKo1pVdt8jC6gSxMFFA6s
         OTEY53dGrQvIe34mi5r7hjuNyHQ2jEByIdg+JDDQtxvGAOL/V2/eFHZ2vN0RqdhItXoH
         KWiQ==
X-Gm-Message-State: AOAM5321nXQJ+sddD56TT2WLRAcFX2LFKfbWiFIEtgEzPL5iE20T7z+I
        0vMbH0LqzNMMVn1fbXAZl4DDXeW7QkNWwXN+Pgp2GBehT/U=
X-Google-Smtp-Source: ABdhPJwrG+z8SCwzBOUbw0Azmt8803Ic7tqE9t65SstM2b8uTKsXHmPMJs5misDzbZXAYft80Pipo8gVq/ESutKlkRg=
X-Received: by 2002:a05:6e02:11a9:: with SMTP id 9mr3756287ilj.288.1618026040249;
 Fri, 09 Apr 2021 20:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183227.99A473BE@viggo.jf.intel.com>
In-Reply-To: <20210401183227.99A473BE@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 9 Apr 2021 20:40:29 -0700
Message-ID: <CAAPL-u-tJDpjW0DvYNUajM7tOCPBs95ijzGO3330cKbfqpf9Cw@mail.gmail.com>
Subject: Re: [PATCH 06/10] mm/vmscan: add page demotion counter
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 11:35 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Yang Shi <yang.shi@linux.alibaba.com>
>
> Account the number of demoted pages into reclaim_state->nr_demoted.
>
> Add pgdemote_kswapd and pgdemote_direct VM counters showed in
> /proc/vmstat.
>
> [ daveh:
>    - __count_vm_events() a bit, and made them look at the THP
>      size directly rather than getting data from migrate_pages()
> ]
>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>

These counters can be more useful if they are per-node.

Reviewed-by: Wei Xu <weixugc@google.com>
