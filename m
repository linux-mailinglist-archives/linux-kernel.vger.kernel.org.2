Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5247A3D198A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhGUVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGUVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:23:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE3C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:04:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dt7so5412004ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nX5aqOHY9HgaYebkuFtX4Rr9OCAl7jIPuc9xY87G2ms=;
        b=i8jZLH7QWGH392+y6KKCsDXWau5mWKnuU5S2rFJptlP3f2uiYpDZach9xzawO5no+z
         BE7w5ih0UKHzsNQsvzxorhf6GyjSfcDz1Ivn4BbzD9HK18JbL5wA2VCrYuE7cFPy6FY/
         JtEsGmSABTrZosYpH2ek9J+Fw2DkR8578PgmYzxVuvj5zrhjbKUo33qf+WYA78sGO/hq
         efK4B2WYgckHT1QNDHhfiCBQjKCgrhu1O8mvpoxyjUXnKNcK0HqGQWl430pPU82fKT2z
         Y3Zf6BoFKYCvaFj050inSFGLmhYeXsUbSHic2UweI6LwZBSieqt4RLC2bTSOv9/fQQEL
         QBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nX5aqOHY9HgaYebkuFtX4Rr9OCAl7jIPuc9xY87G2ms=;
        b=nXjxXCY3KgZKWAY9HMg/M31oOWL1z5eyGfUriiP5UhqdNM2RKGnwUHBnXT6S2o+s1C
         mAaq/2BZesMduWlYj7Id2VyG4moCHAaJyBPoaNea/6vLWVD2gPq7kzn3vaVFSezxqJRT
         WSwb9bQEo8MK6Lm+GgbxgTdIW3gSjd9UvzvqOD9ylCJHv8L8mj5ahpcfHFuLfDDXJokr
         1+3jTuORfUKEcI+oYn4Gf30CksN6RC8NlyortCfC9hqrJYprawnwU85hrfZW59s791t3
         dWzhzdiSXyNo3lIAraS+BlxaN7X2Oqc5owQnAOussZWQNR0+kDugp6VpjfJpyR2eIWMM
         5ADQ==
X-Gm-Message-State: AOAM531be3jXAr2+CO8yWwRE1QGswMavBSxT0aLtas2PC7Zb9KApW8UH
        td7Y4Wj6NBmZaeC9/B/gucuvGTDdWjQvqXgbb7A=
X-Google-Smtp-Source: ABdhPJyiuD5aAfpuE/L9yRsGvic6uzV/QC+cEizXXgEKW/OiEhhpdW3X7cgmWFigm6hlZd/49aS8uKtMpPoxKJRU9fE=
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr16091424ejr.499.1626905047927;
 Wed, 21 Jul 2021 15:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210721063926.3024591-1-ying.huang@intel.com>
 <20210721063926.3024591-8-ying.huang@intel.com> <43A1CB83-6127-427F-94AF-40CE1B283BE1@nvidia.com>
 <59a92898-4a8a-05d3-5f75-1f8defb6feda@intel.com>
In-Reply-To: <59a92898-4a8a-05d3-5f75-1f8defb6feda@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 21 Jul 2021 15:03:56 -0700
Message-ID: <CAHbLzkoBUCNqD1DVhsToCe457v=rBQCm2=4Ezyjb7-6wuNr+LQ@mail.gmail.com>
Subject: Re: [PATCH -V11 8/9] mm/vmscan: never demote for memcg reclaim
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Zi Yan <ziy@nvidia.com>, Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 2:58 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/21/21 2:38 PM, Zi Yan wrote:
> > On 21 Jul 2021, at 2:39, Huang Ying wrote:
> >> From: Dave Hansen <dave.hansen@linux.intel.com>
> >>
> >> Global reclaim aims to reduce the amount of memory used on a
> >> given node or set of nodes.  Migrating pages to another node
> >> serves this purpose.
> >>
> >> memcg reclaim is different.  Its goal is to reduce the total
> >> memory consumption of the entire memcg, across all nodes.
> >> Migration does not assist memcg reclaim because it just moves
> >> page contents between nodes rather than actually reducing memory
> >> consumption.
> ...
> > Should this be folded into Patch 4 when can_demote() is
> > introduced?
>
> I guess it could be.  But, it's logically separate since it has its
> own justification which is rather discrete.
>
> I think it's best to keep it separate.

Yes, I agree.
