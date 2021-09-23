Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1D41680C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbhIWWbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243451AbhIWWbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:31:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1478C061574;
        Thu, 23 Sep 2021 15:29:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c21so28199237edj.0;
        Thu, 23 Sep 2021 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgVSKBEuHze6exBeUanURS4ipvYaInWvl/Yx3hoo6G4=;
        b=SJwlyYoLdyelvLMaK2xHgiiR1pT0fhjReWqAq6Q5k/vB409dNGMraAGiEq9eR6fSl9
         +Wma2r5WbaJCNcuk/HzHCqhaTJWAjju3iyIL1vAlJkLTQcZn7nTMr8vuRlLW2Zr/7C9X
         UD+cu2FL5UJew+nGvCHT6ITCEjsMzH8uaDzJsdvwQNFhkokX0L58NhHuNax8g6IBtguG
         +6lCYA+38bDwkNn60Ai7aL004dOj8OsQvO+7Bt6oNIEBzHuFrs+/jkLqSESE61zDTlIG
         RfxTDfBulzZlhvIHSU3hhXljMz7vUHUZSYtCmB5RTSDRX6ZPgAwYjVj66Q7QAI9gDTQP
         tDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgVSKBEuHze6exBeUanURS4ipvYaInWvl/Yx3hoo6G4=;
        b=6AfVPvi4NIS8+fjs+FSvf3XorEA2fkf/LowEGxZ7+2tNMzH18DK/ndVG5k2gbOGaBV
         CGVlSEI44Kmb6HW5rYsl40JTygRUV2KrfHycSAeerpehFRXBUMeJdwCr6EeJqVpffUIi
         oTDTtDP0qKgedrP683ZYJu9Nz4cm/QJFW6vQdhx3+DNSsZdlcVCmAoq16QknnLOjJxWO
         Xq74h/Ahz+Q6IFEQBkweWle5XdNq0ANk2B1jsj0a7YwXkRrj8IfWRJ6VQQoaxP7Am0S7
         SJhd0MG/ORYLuQTeR81/WD6YtlT9UIovJqNk+B8Q/H6WOBddNu4wUYXfKxUUPnm4cH4i
         Dfag==
X-Gm-Message-State: AOAM532yONZ7fGBecNCHEkQwnkNYMx/xyYNt8knVcUnbE+V+HsGW1xIN
        jajtLKmHQQkeg1ohxQRM9NAkWhNpn2UooYu8AIk=
X-Google-Smtp-Source: ABdhPJxpeJzEy3InxgoPqwYS/T5aYWx5nIjPcOP0OIDq7D6ggOaxMmFEBhgQClT9kghoCMTDpL6Zn7ogrlM1EVEDjvw=
X-Received: by 2002:a17:906:1341:: with SMTP id x1mr7826650ejb.277.1632436179312;
 Thu, 23 Sep 2021 15:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210922102411.34494-1-songmuchun@bytedance.com> <20210922102411.34494-5-songmuchun@bytedance.com>
In-Reply-To: <20210922102411.34494-5-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 24 Sep 2021 10:29:28 +1200
Message-ID: <CAGsJ_4yYx-ASMGQinS2J_J=2jeUGZCMqxJ0ww+pFy70kcxU3Ow@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] selftests: vm: add a hugetlb test case
To:     Muchun Song <songmuchun@bytedance.com>
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

On Wed, Sep 22, 2021 at 10:27 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Since the head vmemmap page frame associated with each HugeTLB page is
> reused, we should hide the PG_head flag of tail struct page from the
> user. Add a tese case to check whether it is work properly. The test
> steps are as follows.
>
>   1) alloc 2MB hugeTLB
>   2) get each page frame
>   3) apply those APIs in each page frame
>   4) Those APIs work completely the same as before.
>
> Reading the flags of a page by /proc/kpageflags is done in
> stable_page_flags(), which has invoked PageHead(), PageTail(),
> PageCompound() and compound_head(). If those APIs work properly, the
> head page must have 15 and 17 bits set. And tail pages must have 16
> and 17 bits set but 15 bit unset. Those flags are checked in
> check_page_flags().
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  tools/testing/selftests/vm/vmemmap_hugetlb.c | 144 +++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c
>
> diff --git a/tools/testing/selftests/vm/vmemmap_hugetlb.c b/tools/testing/selftests/vm/vmemmap_hugetlb.c
> new file mode 100644
> index 000000000000..4cc74dd4c333
> --- /dev/null
> +++ b/tools/testing/selftests/vm/vmemmap_hugetlb.c
> @@ -0,0 +1,144 @@
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

better to move the comment here:

+ * For ia64 architecture, Linux kernel reserves Region number 4 for hugepages.
+ * That means the addresses starting with 0x800000... will need to be
+ * specified.  Specifying a fixed address is not required on ppc64, i386
+ * or x86_64.

With the change,

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

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
> +       /*
> +        * pages other than the first page must be tail and shouldn't be head;
> +        * this also verifies kernel has correctly set the fake page_head to tail
> +        * while hugetlb_free_vmemmap is enabled.
> +        */
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
barry
