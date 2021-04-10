Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA58635AAA7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 06:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhDJEKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 00:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhDJEKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 00:10:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEEEC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 21:10:33 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d12so3852701iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKAvJDJpixiodyXdGAtmOzYV+aUqoGHeW4SHKi5+c6A=;
        b=ChU5bwjDor51WkS1j2wI24x9YETvq4RsPXESxZ2Aw896qAzrpNIkCo6umVMY8os5K4
         tB3f/N9yF37+Tpow9JN0mFCWgjjI2Ow0yycmjaSckCw8eJKbxRSToEXQVHanw4qwyBat
         Ho8SmOhT9L2dhLQ9fqWt/oNE+00CGHoW9rt3vFNcSorprwk0iygiQgiXhGYXmVKrLwsq
         bgCyEOeRJTPZ4phuKxCQoeXomCu8X3O841q8HRF8cfMuzuS+WW89y1k3YaW5fnUsdluw
         NjS1EGD+CGjJyz7vQmKT6DveIzOiKRLB/gAu6c5aTY8QtptBdJXd9EtauNukDFpmYcpd
         rwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKAvJDJpixiodyXdGAtmOzYV+aUqoGHeW4SHKi5+c6A=;
        b=qsUsLW3ByW5lJ4myBeHOo8Bekq8Koid+dqXI66xlu1+yNZTgNiZ4tJqoeOJj08Gu13
         FU9wwYEM6cPwXv76yxwTilJrDmOqIeEegFKrIkIwf+g0f6bL5CjUisjXT2OsHbgSMXVh
         LkjCjfKhdt9uckJUiNXgEliTnZsp6EikLK8cT+x8ig/Mv6A8QpWnOo5+LR1kBF2nyGsN
         saJUw0OurtC0Y9XVIPTSiUNSGC/wAeu6ambnzgqqWzIrxIZF5pjNLnfTuPeQd6xSCBjN
         Gq5W0qGo82hmTuJnrac+DcSIyMU5dkopzsFLDPPLFnrt8hvhgPuPx64ojj1PfZpNUl2E
         eTGA==
X-Gm-Message-State: AOAM531jXfMnjbTK9ueFyowsaz38ov+5GtBAgsCakbhxkJH5ovK0L1rV
        XZ2PqmFrmPBj6/2Nm+N5vdCZ9Jmq6jTyiZfFjMcuFU6ClMw=
X-Google-Smtp-Source: ABdhPJz7UP91zKepWccuBuz4ccEnrvffKtIu7vZDqGGd4ab+dFazMOWxfufBjGZryAXz2dNP2izlSu8TYgfSyWjC+BQ=
X-Received: by 2002:a05:6638:210d:: with SMTP id n13mr17839165jaj.100.1618027833041;
 Fri, 09 Apr 2021 21:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183235.BCC49E8B@viggo.jf.intel.com>
In-Reply-To: <20210401183235.BCC49E8B@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 9 Apr 2021 21:10:21 -0700
Message-ID: <CAAPL-u-aWvMT9yVYj794TLt_2WBWfH6Hip68-avgsjhYEpEzmg@mail.gmail.com>
Subject: Re: [PATCH 10/10] mm/migrate: new zone_reclaim_mode to enable reclaim migration
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
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
> This proposes extending the existing "zone_reclaim_mode" (now
> now really node_reclaim_mode) as a method to enable it.

Nit: now now -> now

> We are open to any alternative that allows end users to enable
> this mechanism or disable it it workload harm is detected (just
> like traditional autonuma).

Nit: it it -> it if

> diff -puN mm/vmscan.c~RECLAIM_MIGRATE mm/vmscan.c
> --- a/mm/vmscan.c~RECLAIM_MIGRATE       2021-03-31 15:17:40.339000190 -0700
> +++ b/mm/vmscan.c       2021-03-31 15:17:40.357000190 -0700
> @@ -1074,6 +1074,9 @@ static bool migrate_demote_page_ok(struc
>         VM_BUG_ON_PAGE(PageHuge(page), page);
>         VM_BUG_ON_PAGE(PageLRU(page), page);
>
> +       if (!(node_reclaim_mode & RECLAIM_MIGRATE))
> +               return false;
> +

As I commented on an earlier patch in this series, the RECLAIM_MIGRATE check
needs to be added to other new callers of next_demotion_node() as well to avoid
unnecessarily splitting THP pages when neither swap nor RECLAIM_MIGRATE
is enabled.  It can be too late to check RECLAIM_MIGRATE only in
migrate_demote_page_ok().
