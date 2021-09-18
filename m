Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F6241042C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 07:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhIRFVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 01:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhIRFVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:21:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C01C061574;
        Fri, 17 Sep 2021 22:20:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v24so37755566eda.3;
        Fri, 17 Sep 2021 22:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGaGHk0/+MRuXa0WhEOc0SBFfauglLIi/BjuNoRZpL4=;
        b=Y3zILyDiqdDGH0HFI3Cjvl48XL+1HPQrngQFFB9LgbqvwLyZ/3hpBYztltWTafxbyo
         0WeDWHyxFvuZkUsXxz7btPJ3hqCU5UnFqVxkxxG6dmxYDZzQqsjep0yoRngsSejfiXrl
         ohaNKW8T3KF6g18B3rZtSXn6WhD1JKrOr0Tn8A6oonKNWtrJcLr3bEGI43+XOl1TNmse
         X3D2kMlbNE1LozxwzfxS0jWuTjUw4S9ry+MsPueWfGzqGh0CJYMCNgkO842V8kywmS7o
         9kR3tWtUPvvVqQbPba7VjIGdyqTvTDDUtKOnN735+qu6dRwFPBGOM+8QGct3A7FGnhX0
         jtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGaGHk0/+MRuXa0WhEOc0SBFfauglLIi/BjuNoRZpL4=;
        b=qX0vbAZcR2I8ZAwFW7M2SSk1nIqSTcZQcGJv6gH+Z/N8ObmEBVkzZ3aP7LVdgaGLXS
         a1JOYbA0CauEVRb0SB6pPyjmr7DdNlcsnwpqOHbcyPUv8MmS3gl6o7abx+xUTjjaKeyZ
         wKX6p4DPFBJqpKoa2Yszlo52PFvQMZNwYkG5OeQTQg2kdvcOgw3ugRLXoHeW0xUA/SYv
         M8r90WE3lTHzyXOTCtnZ/VuPNLUIGlxPCn8OmY8lxjh0GFrcJMWVBEtSnCyvh4dfoYC7
         jZoKIhoOXsqBN9LHCPh+mnv2/mo1LCJN5Yc7yEi31N+A7GSCx/j8prvJteuzll91MPnj
         Fd0A==
X-Gm-Message-State: AOAM5313YVXs4xOba0AffP4WAR4C8HbSpuhkARGVm7vE9qP6IhVV1x5f
        vS87II8TH/ujar51wHOA5eAV0AdFzTsYMVX69TtTDXcT0Ns=
X-Google-Smtp-Source: ABdhPJwld0v9fctoVsqZ8zemyLo0XdGyhSs1s6WAMyzu8Mgiy3wTK6jt+LVq0MqxBRBxbBp4Q7Rsx1sRZUz2MqhZ5Cs=
X-Received: by 2002:aa7:d0c9:: with SMTP id u9mr16513044edo.167.1631942420464;
 Fri, 17 Sep 2021 22:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com> <20210917034815.80264-5-songmuchun@bytedance.com>
In-Reply-To: <20210917034815.80264-5-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 18 Sep 2021 17:20:09 +1200
Message-ID: <CAGsJ_4wW6b5aC4va1_BZuWLqxzRkSi3vLcyJo7XGMbVi8i7iuw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 4/4] selftests: vm: add a hugetlb test case
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        osalvador@suse.de, mhocko@suse.com,
        Barry Song <song.bao.hua@hisilicon.com>, david@redhat.com,
        chenhuang5@huawei.com, bodeddub@amazon.com,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Since the head vmemmap page frame associated with each HugeTLB page is
> reused, we should hide the PG_head flag of tail struct page from the
> user. Add a tese case to check whether it is work properly.
>

TBH, I am a bit confused. I was thinking about some kernel unit tests to make
sure those kernel APIs touched by this patchset are still working as before.
This userspace test, while certainly useful for checking the content of page
frames as expected, doesn't directly prove things haven't changed.

In patch 1/4, a couple of APIs have the fixup for the fake head issue.
Do you think a test like the below would be more sensible?
1. alloc 2MB hugeTLB
2. get each page frame
3. apply those APIs in each page frame
4. Those APIs work completely the same as before.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  tools/testing/selftests/vm/vmemmap_hugetlb.c | 139 +++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c
>
> diff --git a/tools/testing/selftests/vm/vmemmap_hugetlb.c b/tools/testing/selftests/vm/vmemmap_hugetlb.c
> new file mode 100644
> index 000000000000..b6e945bf4053
> --- /dev/null
> +++ b/tools/testing/selftests/vm/vmemmap_hugetlb.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A test case of using hugepage memory in a user application using the
> + * mmap system call with MAP_HUGETLB flag.  Before running this program
> + * make sure the administrator has allocated enough default sized huge
> + * pages to cover the 2 MB allocation.
> + *
> + * For ia64 architecture, Linux kernel reserves Region number 4 for hugepages.
> + * That means the addresses starting with 0x800000... will need to be
> + * specified.  Specifying a fixed address is not required on ppc64, i386
> + * or x86_64.
> + */
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> +
> +#define MAP_LENGTH             (2UL * 1024 * 1024)
> +
> +#ifndef MAP_HUGETLB
> +#define MAP_HUGETLB            0x40000 /* arch specific */
> +#endif
> +
> +#define PAGE_SIZE              4096
> +
> +#define PAGE_COMPOUND_HEAD     (1UL << 15)
> +#define PAGE_COMPOUND_TAIL     (1UL << 16)
> +#define PAGE_HUGE              (1UL << 17)
> +
> +#define HEAD_PAGE_FLAGS                (PAGE_COMPOUND_HEAD | PAGE_HUGE)
> +#define TAIL_PAGE_FLAGS                (PAGE_COMPOUND_TAIL | PAGE_HUGE)
> +
> +#define PM_PFRAME_BITS         55
> +#define PM_PFRAME_MASK         ~((1UL << PM_PFRAME_BITS) - 1)
> +
> +/* Only ia64 requires this */
> +#ifdef __ia64__
> +#define MAP_ADDR               (void *)(0x8000000000000000UL)
> +#define MAP_FLAGS              (MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_FIXED)
> +#else
> +#define MAP_ADDR               NULL
> +#define MAP_FLAGS              (MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB)
> +#endif
> +
> +static void write_bytes(char *addr, size_t length)
> +{
> +       unsigned long i;
> +
> +       for (i = 0; i < length; i++)
> +               *(addr + i) = (char)i;
> +}
> +
> +static unsigned long virt_to_pfn(void *addr)
> +{
> +       int fd;
> +       unsigned long pagemap;
> +
> +       fd = open("/proc/self/pagemap", O_RDONLY);
> +       if (fd < 0)
> +               return -1UL;
> +
> +       lseek(fd, (unsigned long)addr / PAGE_SIZE * sizeof(pagemap), SEEK_SET);
> +       read(fd, &pagemap, sizeof(pagemap));
> +       close(fd);
> +
> +       return pagemap & ~PM_PFRAME_MASK;
> +}
> +
> +static int check_page_flags(unsigned long pfn)
> +{
> +       int fd, i;
> +       unsigned long pageflags;
> +
> +       fd = open("/proc/kpageflags", O_RDONLY);
> +       if (fd < 0)
> +               return -1;
> +
> +       lseek(fd, pfn * sizeof(pageflags), SEEK_SET);
> +
> +       read(fd, &pageflags, sizeof(pageflags));
> +       if ((pageflags & HEAD_PAGE_FLAGS) != HEAD_PAGE_FLAGS) {
> +               close(fd);
> +               printf("Head page flags (%lx) is invalid\n", pageflags);
> +               return -1;
> +       }
> +
> +       for (i = 1; i < MAP_LENGTH / PAGE_SIZE; i++) {
> +               read(fd, &pageflags, sizeof(pageflags));
> +               if ((pageflags & TAIL_PAGE_FLAGS) != TAIL_PAGE_FLAGS ||
> +                   (pageflags & HEAD_PAGE_FLAGS) == HEAD_PAGE_FLAGS) {
> +                       close(fd);
> +                       printf("Tail page flags (%lx) is invalid\n", pageflags);
> +                       return -1;
> +               }
> +       }
> +
> +       close(fd);
> +
> +       return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       void *addr;
> +       unsigned long pfn;
> +
> +       addr = mmap(MAP_ADDR, MAP_LENGTH, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
> +       if (addr == MAP_FAILED) {
> +               perror("mmap");
> +               exit(1);
> +       }
> +
> +       /* Trigger allocation of HugeTLB page. */
> +       write_bytes(addr, MAP_LENGTH);
> +
> +       pfn = virt_to_pfn(addr);
> +       if (pfn == -1UL) {
> +               munmap(addr, MAP_LENGTH);
> +               perror("virt_to_pfn");
> +               exit(1);
> +       }
> +
> +       printf("Returned address is %p whose pfn is %lx\n", addr, pfn);
> +
> +       if (check_page_flags(pfn) < 0) {
> +               munmap(addr, MAP_LENGTH);
> +               perror("check_page_flags");
> +               exit(1);
> +       }
> +
> +       /* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
> +       if (munmap(addr, MAP_LENGTH)) {
> +               perror("munmap");
> +               exit(1);
> +       }
> +
> +       return 0;
> +}
> --
> 2.11.0
>

Thanks
Barry
