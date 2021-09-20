Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27534412B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbhIUCJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbhIUB4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:56:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D4EC0313CF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:50:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t20so13122897pju.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vrcaCp8wAG9WhMElbt3SFMZG1ccQwS5//7td2G4tQVw=;
        b=LbiW+vJtWL6WTaQ9//JZW46yS0oAh/MegbVt3qRem/mZh8AZkW9/CtaaV68C2JpLDq
         HCdEdkmUj0NM+oSrHNiBCk1krYVqBi3PQQ8J0h7ZpCH4Ac26oiLjkr6fDYzW/yypRVxI
         dIAH6YU2L4BTKvOgMUjY4umP3hCeLgZkWgkaofw2QzaVmalf7TfjuNS/tC6L9AH9SRac
         QeG/LDCjrFoimKWuFio9+wRhYfdJo4F255JIdMSb3NSElXNXzRGesDkCUNn+PJZdsBwR
         K/p0IX7K4Ekh23lwVSeZXVedOFnpeqYCwmPPtx545Xo9cis/N5oZ48V1MQiP2CWkTK6e
         36Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vrcaCp8wAG9WhMElbt3SFMZG1ccQwS5//7td2G4tQVw=;
        b=CKxets030QvC9ljH34yc2+dBlR/5tn410MtsD4wK4rNCh0Ji4xc+5ai6Ot9EvRpNmm
         BeihIHn/ULGxEF649xQfgTHMQMCue4w583kIYat4SbtjLZqTJnmuiCvyjejIo6AqYwTk
         aMTPkK7HE+TtJAkRa5MzxOZIANJ4HEfHQYvKKxWyHAQIbx0QzB3tvs3f0AerHxJON3oI
         ih2MbQtjMh1eRiD75Zc7WmxvMMiuBcOfYyOaDkczlGBPlp4YPSDXOo2EtSR/zq/JoO9V
         n/g9cl4VxghQinQqit3xP0idm9Gb8hkBUcpJzlDgIMHTjbBAfupQ8HzQ+eTpLzZMggDx
         OUYw==
X-Gm-Message-State: AOAM533Bdd+XTM/1Yw+p6X14GTgwXHMmSCALJDHcOOivSt6t+l8uOR4f
        DkIpiG9Fc4J3ZN9O5w/dS1c=
X-Google-Smtp-Source: ABdhPJyCkWnH/ODUdB0PfCikz0qGRII4E6ykCQSbknL+UxCNgxM+O1u+BheueEC6OBltMBZncJh5CA==
X-Received: by 2002:a17:90a:f2cd:: with SMTP id gt13mr1779693pjb.153.1632181819626;
        Mon, 20 Sep 2021 16:50:19 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:9a49:e1f0:6fe9:6fd9])
        by smtp.gmail.com with ESMTPSA id e13sm15147485pfi.210.2021.09.20.16.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:50:19 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 20 Sep 2021 16:50:16 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        zhengjun.xing@intel.com
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
Subject: Re: [PATCH v3] mm: fs: invalidate bh_lrus for only cold path
Message-ID: <YUkeOB3GfK6KO8KG@google.com>
References: <20210907212347.1977686-1-minchan@kernel.org>
 <CAHk-=wh2_yEuAC5=9VWefK+0JD9pAKf8qL-vpSmS7MtLA8SZEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2_yEuAC5=9VWefK+0JD9pAKf8qL-vpSmS7MtLA8SZEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:29:52PM -0700, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 2:24 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > kernel test robot reported the regression of fio.write_iops[1]
> > with [2].
> >
> > Since lru_add_drain is called frequently, invalidate bh_lrus
> > there could increase bh_lrus cache miss ratio, which needs
> > more IO in the end.
> >
> > This patch moves the bh_lrus invalidation from the hot path(
> > e.g., zap_page_range, pagevec_release) to cold path(i.e.,
> > lru_add_drain_all, lru_cache_disable).
> 
> Was this confirmed to fix the regression?
> 
> I only see the "tested with 5.14" that the regression was still there
> 
>    https://lore.kernel.org/lkml/034fc860-d0d0-0c61-09d2-3c41c4f020c6@intel.com/
> 
> I don't see a confirmation that this patch fixed it.
> 
> It looks likely, but if you have the confirmation somewhere, it would
> help to link that too.
> 
> Or did I miss it?

I have no idea why I couldn't find the reply from lore.kernel.org/lkml/
The message id was 89e2b66b-c706-c020-bff5-b815dcd5c461@intel.com
in the thread(https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/)

Xing, Zhengjun zhengjun.xing@intel.com confirmed 

Quote -
```
Hi Minchan,

...

I test the patch, the regression reduced to -2.9%.
```
Since then, I modified the patch a little more and couldn't find the
message from the public URL. Thus, do we need to confirm it again against
latest kernel?

Xing, could you confirm whether this patch fixes the regression?
