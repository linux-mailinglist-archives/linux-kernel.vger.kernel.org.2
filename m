Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856A4416B21
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 07:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbhIXFMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 01:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhIXFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 01:12:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A29C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 22:11:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t1so8802346pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 22:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzqjuklikXd1yyaVBqex7jIXr6EPFUdZGObWj4aWYco=;
        b=L2Ksg0xpwm7l/+7qy95yUW5KQa6egIJ835QqbCQwPK44M2VneUTbSROw2muZDAUFOE
         2pe3J5MHRCwW+5mNJ1Tp8f3gbivSj+QbsDecWg/nNNL2dju1+nmgs4g3FCAjBDmyu/bM
         oyR7rgqoYrOhq6m3ZmblUnutCnKWzQXfvK596tkZkwXacJnL+k6y5/5wMFoO4pN/iSHT
         382yS1h2BLTtjah+AH7hWyL+Rz2DJmsTfuirtyD2l4m0sN0TmRqwWRJcVEbof8dcSuEr
         IWLCW3hN5dv/9TgOJWtJU9LS7jpdmPwgv3XAnCF4rzhGDp56c87qyclv9XZ9+kc6UWPJ
         tQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzqjuklikXd1yyaVBqex7jIXr6EPFUdZGObWj4aWYco=;
        b=qCav+J8XxrfSaw38U5RKA5Riv3TWi+o6OoKmQnkBEFMlDElrG2iFVGCV4yI1Oz0yj3
         qqKjhz/i1mzu2OIQMn7jmPWbMMXwDqwUtQch4r2/MSv+5CN5TzmpKrF8hDdhlbzcftaG
         BL6FYWCIt0N9BOyAWEgc7UU8VBsMwZIZHyze04nIIPJeAxwHvZLwNHmrsm8BVJKou4/d
         gEUoO3/vfCj/zx9oru96aLKojHem/z9dddW0KqZY8xVceas5A7aQNlRmC2R8xj7Zj1oj
         VMdW2fmQNtjCG1QkcC9awdqXNLKAvW1d60OuF/ukHiRz2OQ9QI9sL/JFCsqFHWdybGAS
         +BMQ==
X-Gm-Message-State: AOAM5332itlFnmRjgVCiFwCr15eG6zDgOnJDYSYcHrp+2gHua9zr+5FE
        BphgjOXsKFhitXNIBfBIPE5nFb+4/honsJbf5guYZg==
X-Google-Smtp-Source: ABdhPJzkE+tv3MCnLS/iXDLKnueQlx+9lpsTOIPRPuRi3tYaTN1v5cB+yOMHogKiycnI+FMp7WpvlQFLSUjypaWP65Y=
X-Received: by 2002:a63:1a64:: with SMTP id a36mr2164845pgm.225.1632460263042;
 Thu, 23 Sep 2021 22:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210922102411.34494-1-songmuchun@bytedance.com>
 <20210922102411.34494-5-songmuchun@bytedance.com> <CAGsJ_4yYx-ASMGQinS2J_J=2jeUGZCMqxJ0ww+pFy70kcxU3Ow@mail.gmail.com>
In-Reply-To: <CAGsJ_4yYx-ASMGQinS2J_J=2jeUGZCMqxJ0ww+pFy70kcxU3Ow@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 24 Sep 2021 13:10:24 +0800
Message-ID: <CAMZfGtU=SRKP10B701ZSmcyrJu31uXYbfdJUFVsFu44BB3yK1g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selftests: vm: add a hugetlb test case
To:     Barry Song <21cnbao@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 6:29 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Sep 22, 2021 at 10:27 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Since the head vmemmap page frame associated with each HugeTLB page is
> > reused, we should hide the PG_head flag of tail struct page from the
> > user. Add a tese case to check whether it is work properly. The test
> > steps are as follows.
> >
> >   1) alloc 2MB hugeTLB
> >   2) get each page frame
> >   3) apply those APIs in each page frame
> >   4) Those APIs work completely the same as before.
> >
> > Reading the flags of a page by /proc/kpageflags is done in
> > stable_page_flags(), which has invoked PageHead(), PageTail(),
> > PageCompound() and compound_head(). If those APIs work properly, the
> > head page must have 15 and 17 bits set. And tail pages must have 16
> > and 17 bits set but 15 bit unset. Those flags are checked in
> > check_page_flags().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  tools/testing/selftests/vm/vmemmap_hugetlb.c | 144 +++++++++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >  create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c
> >
> > diff --git a/tools/testing/selftests/vm/vmemmap_hugetlb.c b/tools/testing/selftests/vm/vmemmap_hugetlb.c
> > new file mode 100644
> > index 000000000000..4cc74dd4c333
> > --- /dev/null
> > +++ b/tools/testing/selftests/vm/vmemmap_hugetlb.c
> > @@ -0,0 +1,144 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * A test case of using hugepage memory in a user application using the
> > + * mmap system call with MAP_HUGETLB flag.  Before running this program
> > + * make sure the administrator has allocated enough default sized huge
> > + * pages to cover the 2 MB allocation.
> > + *
> > + * For ia64 architecture, Linux kernel reserves Region number 4 for hugepages.
> > + * That means the addresses starting with 0x800000... will need to be
> > + * specified.  Specifying a fixed address is not required on ppc64, i386
> > + * or x86_64.
> > + */
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <sys/mman.h>
> > +#include <fcntl.h>
> > +
> > +#define MAP_LENGTH             (2UL * 1024 * 1024)
> > +
> > +#ifndef MAP_HUGETLB
> > +#define MAP_HUGETLB            0x40000 /* arch specific */
> > +#endif
> > +
> > +#define PAGE_SIZE              4096
> > +
> > +#define PAGE_COMPOUND_HEAD     (1UL << 15)
> > +#define PAGE_COMPOUND_TAIL     (1UL << 16)
> > +#define PAGE_HUGE              (1UL << 17)
> > +
> > +#define HEAD_PAGE_FLAGS                (PAGE_COMPOUND_HEAD | PAGE_HUGE)
> > +#define TAIL_PAGE_FLAGS                (PAGE_COMPOUND_TAIL | PAGE_HUGE)
> > +
> > +#define PM_PFRAME_BITS         55
> > +#define PM_PFRAME_MASK         ~((1UL << PM_PFRAME_BITS) - 1)
> > +
>
> better to move the comment here:
>
> + * For ia64 architecture, Linux kernel reserves Region number 4 for hugepages.
> + * That means the addresses starting with 0x800000... will need to be
> + * specified.  Specifying a fixed address is not required on ppc64, i386
> + * or x86_64.
>
> With the change,
>
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

Thanks. Will do.

>
> > +/* Only ia64 requires this */
> > +#ifdef __ia64__
> > +#define MAP_ADDR               (void *)(0x8000000000000000UL)
> > +#define MAP_FLAGS              (MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_FIXED)
> > +#else
> > +#define MAP_ADDR               NULL
> > +#define MAP_FLAGS              (MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB)
> > +#endif
> > +
> > +static void write_bytes(char *addr, size_t length)
> > +{
> > +       unsigned long i;
> > +
> > +       for (i = 0; i < length; i++)
> > +               *(addr + i) = (char)i;
> > +}
> > +
> > +static unsigned long virt_to_pfn(void *addr)
> > +{
> > +       int fd;
> > +       unsigned long pagemap;
> > +
> > +       fd = open("/proc/self/pagemap", O_RDONLY);
> > +       if (fd < 0)
> > +               return -1UL;
> > +
> > +       lseek(fd, (unsigned long)addr / PAGE_SIZE * sizeof(pagemap), SEEK_SET);
> > +       read(fd, &pagemap, sizeof(pagemap));
> > +       close(fd);
> > +
> > +       return pagemap & ~PM_PFRAME_MASK;
> > +}
> > +
> > +static int check_page_flags(unsigned long pfn)
> > +{
> > +       int fd, i;
> > +       unsigned long pageflags;
> > +
> > +       fd = open("/proc/kpageflags", O_RDONLY);
> > +       if (fd < 0)
> > +               return -1;
> > +
> > +       lseek(fd, pfn * sizeof(pageflags), SEEK_SET);
> > +
> > +       read(fd, &pageflags, sizeof(pageflags));
> > +       if ((pageflags & HEAD_PAGE_FLAGS) != HEAD_PAGE_FLAGS) {
> > +               close(fd);
> > +               printf("Head page flags (%lx) is invalid\n", pageflags);
> > +               return -1;
> > +       }
> > +
> > +       /*
> > +        * pages other than the first page must be tail and shouldn't be head;
> > +        * this also verifies kernel has correctly set the fake page_head to tail
> > +        * while hugetlb_free_vmemmap is enabled.
> > +        */
> > +       for (i = 1; i < MAP_LENGTH / PAGE_SIZE; i++) {
> > +               read(fd, &pageflags, sizeof(pageflags));
> > +               if ((pageflags & TAIL_PAGE_FLAGS) != TAIL_PAGE_FLAGS ||
> > +                   (pageflags & HEAD_PAGE_FLAGS) == HEAD_PAGE_FLAGS) {
> > +                       close(fd);
> > +                       printf("Tail page flags (%lx) is invalid\n", pageflags);
> > +                       return -1;
> > +               }
> > +       }
> > +
> > +       close(fd);
> > +
> > +       return 0;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +       void *addr;
> > +       unsigned long pfn;
> > +
> > +       addr = mmap(MAP_ADDR, MAP_LENGTH, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
> > +       if (addr == MAP_FAILED) {
> > +               perror("mmap");
> > +               exit(1);
> > +       }
> > +
> > +       /* Trigger allocation of HugeTLB page. */
> > +       write_bytes(addr, MAP_LENGTH);
> > +
> > +       pfn = virt_to_pfn(addr);
> > +       if (pfn == -1UL) {
> > +               munmap(addr, MAP_LENGTH);
> > +               perror("virt_to_pfn");
> > +               exit(1);
> > +       }
> > +
> > +       printf("Returned address is %p whose pfn is %lx\n", addr, pfn);
> > +
> > +       if (check_page_flags(pfn) < 0) {
> > +               munmap(addr, MAP_LENGTH);
> > +               perror("check_page_flags");
> > +               exit(1);
> > +       }
> > +
> > +       /* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
> > +       if (munmap(addr, MAP_LENGTH)) {
> > +               perror("munmap");
> > +               exit(1);
> > +       }
> > +
> > +       return 0;
> > +}
> > --
> > 2.11.0
> >
>
> Thanks
> barry
