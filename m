Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203A1331CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhCICXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCICXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:23:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 18:23:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id i14so44549pjz.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 18:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jDz13J2Ic/rseTFIgsbUpalTQ6rauQ94sMWBebPKNBo=;
        b=B+wrMG148xSOQut1zLdIYxfkmA51sRhXQ+CwydWsxglnLUyzJyebOmenhOa8xHU3mp
         mNNnPKLl1WGr/+2lh9ba6v7qkFbi3nLgIsZ+IEVthGzaT8uhigxlnYxnTsivDaJ7eTi/
         +r9ra1NKqvkNF99kTBcX2V5W+FgjMid0lp3zaFQQjqrB3MkZ5XONDAbzVyXbMkejWcae
         uJo6fkiIlSzJ5tFA1Rr1b7gM0PTTm0hLSYmQLYoHAkhEJl8tsCSbcRwMTO5oRQdj3bN6
         vCZzpTSQ/lbpyZ1l2wEWQAq2hpARC+to2RQQQAquhG0nqzwk18boerwG3Usi09/o/o1O
         BDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jDz13J2Ic/rseTFIgsbUpalTQ6rauQ94sMWBebPKNBo=;
        b=OFQoBlQDoWJrJvgU3rc+t5pxWgYF01gReIsht4VFr/f87aDje9FlBoRe1zdXputAKc
         AsvKFkEOBVgLUWoZnkKlfbGC3hRHh8/UfgzKL9/j+H3laQchCgI3fwjmazpFEwne2HsL
         BUHQlcksiCq4At1KVPlXQLPoLC2rG54RFBihB6ztHDitrrbzxsX+tb0Pzo0y6OEucPQn
         gGldcOhsASMVmlja+oI900atq72NdSXPW2er4f2YQHNlC9jS5AeXAGrEngC0zhvfYniO
         ioTf/VAvnX3Crmcm68QamFHfgs+/CjZWRU9ivvflS9oWf5tN+LY1leLYZIc37N3IsH1F
         GVEg==
X-Gm-Message-State: AOAM533EnZjjlFEy5jr5BXUsVXR5PcMDFgCeEt1rphn3v2ly/Y7kvuh4
        PkW53SgxiYMyo3rVZGNRbtE=
X-Google-Smtp-Source: ABdhPJw1SxvmBDIvoxd/6zwjhMPEI1fV9zrHpkxtKLybJOelTcIN23xLNhCzyA8UKRMZAyo3RmGO8w==
X-Received: by 2002:a17:902:c317:b029:e4:aecd:8539 with SMTP id k23-20020a170902c317b02900e4aecd8539mr23798801plx.61.1615256600587;
        Mon, 08 Mar 2021 18:23:20 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id s200sm11440914pfs.53.2021.03.08.18.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 18:23:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Mar 2021 18:23:17 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, kbuild-all@01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [kbuild-all] Re: [PATCH v2] mm: page_alloc: dump migrate-failed
 pages
Message-ID: <YEbcFc0up0NFnSjY@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <202103090555.LtLPf1Ho-lkp@intel.com>
 <YEalYUiTH45XO2EV@google.com>
 <d994f666-7883-25a3-9d46-ca431874dc18@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d994f666-7883-25a3-9d46-ca431874dc18@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 08:41:44AM +0800, Rong Chen wrote:
> 
> 
> On 3/9/21 6:29 AM, Minchan Kim wrote:
> > On Tue, Mar 09, 2021 at 05:29:30AM +0800, kernel test robot wrote:
> > > Hi Minchan,
> > > 
> > > I love your patch! Perhaps something to improve:
> > > 
> > > [auto build test WARNING on hnaz-linux-mm/master]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Minchan-Kim/mm-page_alloc-dump-migrate-failed-pages/20210309-042205
> > > base:   https://github.com/hnaz/linux-mm master
> > > config: m68k-allmodconfig (attached as .config)
> > > compiler: m68k-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # https://github.com/0day-ci/linux/commit/3c635af37b862e9c601ee8d5818f7da9cd3e2e57
> > >          git remote add linux-review https://github.com/0day-ci/linux
> > >          git fetch --no-tags linux-review Minchan-Kim/mm-page_alloc-dump-migrate-failed-pages/20210309-042205
> > >          git checkout 3c635af37b862e9c601ee8d5818f7da9cd3e2e57
> > >          # save the attached .config to linux build tree
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >     arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
> > >       169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
> > >           |                                                 ^~
> > >     include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
> > >        78 | # define unlikely(x) __builtin_expect(!!(x), 0)
> > >           |                                          ^
> > >     include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
> > >       143 |  BUG_ON(!virt_addr_valid(buf));
> > >           |  ^~~~~~
> > >     include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
> > >       143 |  BUG_ON(!virt_addr_valid(buf));
> > >           |          ^~~~~~~~~~~~~~~
> > >     In file included from arch/m68k/include/asm/page.h:60,
> > >                      from arch/m68k/include/asm/thread_info.h:6,
> > >                      from include/linux/thread_info.h:38,
> > >                      from include/asm-generic/preempt.h:5,
> > >                      from ./arch/m68k/include/generated/asm/preempt.h:1,
> > >                      from include/linux/preempt.h:78,
> > >                      from include/linux/spinlock.h:51,
> > >                      from include/linux/mmzone.h:8,
> > >                      from include/linux/gfp.h:6,
> > >                      from include/linux/mm.h:10,
> > >                      from mm/page_alloc.c:19:
> > I am not sure this is triggered by the patch since I could see the
> > warn with reverting the patch.
> 
> Hi Minchan,
> 
> Only the lines prefixed by ">>" are related with the patch:
> 
> > > mm/page_alloc.c:8348:5: warning: no previous prototype for 'alloc_contig_ratelimit' [-Wmissing-prototypes]
> 
>     8348 | int alloc_contig_ratelimit(void)
>          |     ^~~~~~~~~~~~~~~~~~~~~~
> 
> > > mm/page_alloc.c:8353:6: warning: no previous prototype for 'dump_migrate_failure_pages' [-Wmissing-prototypes]
> 
>     8353 | void dump_migrate_failure_pages(struct list_head *page_list)
> 

Thanks for the clarification.

Then, below should fix the warning.
I will respin it at next revision once I get more feedback.

+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+       (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+static void dump_migrate_failure_pages(struct list_head *page_list)
+{
+       static DEFINE_RATELIMIT_STATE(_rs,
+                                       DEFAULT_RATELIMIT_INTERVAL,
+                                       DEFAULT_RATELIMIT_BURST);
+
+       DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
+                       "migrate failure");
+       if (DYNAMIC_DEBUG_BRANCH(descriptor) && __ratelimit(&_rs)) {
+               struct page *page;
+
+               WARN(1, "failed callstack");
+               list_for_each_entry(page, page_list, lru)
+                       dump_page(page, "migration failure");
+       }
+}
+#else
+static inline void dump_migrate_failure_pages(struct list_head *page_list)
+{
+}
+#endif
+
 /* [start, end) must belong to a single zone. */
 static int __alloc_contig_migrate_range(struct compact_control *cc,
                                        unsigned long start, unsigned long end)
@@ -8496,6 +8520,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
                                NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
        }
        if (ret < 0) {
+               dump_migrate_failure_pages(&cc->migratepages);
                putback_movable_pages(&cc->migratepages);
                return ret;
        }
