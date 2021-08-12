Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08903E9F77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhHLHea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhHLHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628753644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYH9IB8kLiUJPK2eGWH1AkGjFzTYCt4aUi+sk0Dhj6E=;
        b=Vz3D6WBB28s8Ccqu1K+2Q9h84fW4iw0i8I9bIxbMfBJcQ7cmcawVzFdzmwAeWNTiyWdUyu
        RN4Lz7jTMTaHNH++mkMB4meXikBNyEXdMu7H71VATqB3sdMjPFtGZ27rzgs4iw11daOyjj
        6RR8wiqPSZoyfIhtzjs7nOPwGXHcvVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-_p0_ghEoNDu2XcTPdiulkg-1; Thu, 12 Aug 2021 03:34:03 -0400
X-MC-Unique: _p0_ghEoNDu2XcTPdiulkg-1
Received: by mail-wm1-f71.google.com with SMTP id o26-20020a05600c511ab02902e6b1324690so1365225wms.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mYH9IB8kLiUJPK2eGWH1AkGjFzTYCt4aUi+sk0Dhj6E=;
        b=lJutLeHH1aYoaN1oeHBLWBiw63AnqTxdr6lJgVAiJ5fJDX4f+0eNWYz7P7mEmvJpP3
         6LP4nynQURIXGR/fAOsg5cg0kz5UYRTrwwXe4x9qSDV17MOeG5n5imbo1XT+hY4EmatG
         S2VH7FTqw0WBRQHsjqj+w5rUbBFtPsK9h/IbZr2OEzyNuCMCrcbrihrA6yno8AJ3wIhc
         P2JEeIiwUbeDTO/Pc3IVBQq7XlN0uu8nY4WMcs45JzB7Kn+yt4+9rHjrwTlXH01EV89W
         Pscm3z/svi3O+n65GfDofeioUo2EcY4TdxbcO6DbMtqpZeUktjHWjjIVTTBQsBCCaBmb
         RmyA==
X-Gm-Message-State: AOAM530ftXj7Gb0yYuy/InN4vfUWiowCREWWLn7PmAva2SCS5heIwI2U
        htcIj5inJk9K5JQUWAuOUtEFYHZB0E+CCWNt/ctPIRTaGHSAtrWDVk54DvbZF4GMQ3M5YYJviNm
        DtIKoCp0VvQ/23Ei23dvPyguL
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr2456017wmk.136.1628753641688;
        Thu, 12 Aug 2021 00:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXDY4HnbdNw6PM31nv/QfI9ZkXgq7IZiHchMbUa+C8ozEvyCRTCvh51tc4Bi0fHK++AFiliw==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr2455999wmk.136.1628753641495;
        Thu, 12 Aug 2021 00:34:01 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
        by smtp.gmail.com with ESMTPSA id n186sm9388381wme.40.2021.08.12.00.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 00:34:01 -0700 (PDT)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-4-david@redhat.com>
 <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
 <37179df3-13d7-9b98-4cd8-13bb7f735129@redhat.com>
 <CAHp75VcU2_qE1xt397L5dpxVMejZdHwWq0D_-Bo57_eWMtmgig@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/3] kernel/resource: cleanup and optimize
 iomem_is_exclusive()
Message-ID: <a2af90f4-5bce-df8d-2466-8dabe85dd4b7@redhat.com>
Date:   Thu, 12 Aug 2021 09:34:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcU2_qE1xt397L5dpxVMejZdHwWq0D_-Bo57_eWMtmgig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.21 09:14, Andy Shevchenko wrote:
> 
> 
> On Thursday, August 12, 2021, David Hildenbrand <david@redhat.com 
> <mailto:david@redhat.com>> wrote:
> 
>     On 11.08.21 22:47, Andy Shevchenko wrote:
> 
> 
> 
>         On Wednesday, August 11, 2021, David Hildenbrand
>         <david@redhat.com <mailto:david@redhat.com>
>         <mailto:david@redhat.com <mailto:david@redhat.com>>> wrote:
> 
>              Let's clean it up a bit, removing the unnecessary usage of
>         r_next() by
>              next_resource(), and use next_range_resource() in case we
>         are not
>              interested in a certain subtree.
> 
>              Signed-off-by: David Hildenbrand <david@redhat.com
>         <mailto:david@redhat.com>
>              <mailto:david@redhat.com <mailto:david@redhat.com>>>
>              ---
>                kernel/resource.c | 19 +++++++++++--------
>                1 file changed, 11 insertions(+), 8 deletions(-)
> 
>              diff --git a/kernel/resource.c b/kernel/resource.c
>              index 2938cf520ca3..ea853a075a83 100644
>              --- a/kernel/resource.c
>              +++ b/kernel/resource.c
>              @@ -1754,9 +1754,8 @@ static int strict_iomem_checks;
>                 */
>                bool iomem_is_exclusive(u64 addr)
>                {
>              -       struct resource *p = &iomem_resource;
>              +       struct resource *p;
>                       bool err = false;
>              -       loff_t l;
>                       int size = PAGE_SIZE;
> 
>                       if (!strict_iomem_checks)
>              @@ -1765,27 +1764,31 @@ bool iomem_is_exclusive(u64 addr)
>                       addr = addr & PAGE_MASK;
> 
>                       read_lock(&resource_lock);
>              -       for (p = p->child; p ; p = r_next(NULL, p, &l)) {
>              +       for (p = iomem_resource.child; p ;) {
> 
> 
>     Hi Andy,
> 
> 
>         I consider the ordinal part of p initialization is slightly
>         better and done outside of read lock.
> 
>         Something like
>         p= &iomem_res...;
>         read lock
>         for (p = p->child; ...) {
> 
> 
>     Why should we care about doing that outside of the lock? That smells
>     like a micro-optimization the compiler will most probably overwrite
>     either way as the address of iomem_resource is just constant?
> 
>     Also, for me it's much more readable and compact if we perform a
>     single initialization instead of two separate ones in this case.
> 
>     We're using the pattern I use in, find_next_iomem_res() and
>     __region_intersects(), while we use the old pattern in
>     iomem_map_sanity_check(), where we also use the same unnecessary
>     r_next() call.
> 
>     I might just cleanup iomem_map_sanity_check() in a similar way.
> 
> 
> 
> Yes, it’s like micro optimization. If you want your way I suggest then 
> to add a macro
> 
> #define for_each_iomem_resource_child() \
>   for (iomem_resource...)

I think the only thing that really makes sense would be something like this on top (not compiled yet):


diff --git a/kernel/resource.c b/kernel/resource.c
index ea853a075a83..35aaa72df0ce 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -80,6 +80,11 @@ static struct resource *next_resource_skip_children(struct resource *p)
         return p->sibling;
  }
  
+#define for_each_resource(_root, _p, _skip_children) \
+       for ((_p) = (_root)->child; (_p); \
+            (_p) = (_skip_children) ? next_resource_skip_children(_p) : \
+                                      next_resource(_p))
+
  static void *r_next(struct seq_file *m, void *v, loff_t *pos)
  {
         struct resource *p = v;
@@ -1714,16 +1719,16 @@ int iomem_map_sanity_check(resource_size_t addr, unsigned long size)
  bool iomem_range_contains_excluded(u64 addr, u64 size)
  {
         const unsigned int flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_EXCLUSIVE;
-       bool excluded = false;
+       bool skip_children, excluded = false;
         struct resource *p;
  
         read_lock(&resource_lock);
-       for (p = iomem_resource.child; p ;) {
+       for_each_resource(&iomem_resource, p, skip_children) {
                 if (p->start >= addr + size)
                         break;
                 if (p->end < addr) {
                         /* No need to consider children */
-                       p = next_resource_skip_children(p);
+                       skip_children = true;
                         continue;
                 }
                 /*
@@ -1735,7 +1740,7 @@ bool iomem_range_contains_excluded(u64 addr, u64 size)
                         excluded = true;
                         break;
                 }
-               p = next_resource(p);
+               skip_children = false;
         }
         read_unlock(&resource_lock);
  
@@ -1755,7 +1760,7 @@ static int strict_iomem_checks;
  bool iomem_is_exclusive(u64 addr)
  {
         struct resource *p;
-       bool err = false;
+       bool skip_children, err = false;
         int size = PAGE_SIZE;
  
         if (!strict_iomem_checks)
@@ -1764,7 +1769,7 @@ bool iomem_is_exclusive(u64 addr)
         addr = addr & PAGE_MASK;
  
         read_lock(&resource_lock);
-       for (p = iomem_resource.child; p ;) {
+       for_each_resource(&iomem_resource, p, skip_children) {
                 /*
                  * We can probably skip the resources without
                  * IORESOURCE_IO attribute?
@@ -1773,7 +1778,7 @@ bool iomem_is_exclusive(u64 addr)
                         break;
                 if (p->end < addr) {
                         /* No need to consider children */
-                       p = next_resource_skip_children(p);
+                       skip_children = true;
                         continue;
                 }
  
@@ -1788,7 +1793,7 @@ bool iomem_is_exclusive(u64 addr)
                         err = true;
                         break;
                 }
-               p = next_resource(p);
+               skip_children = false;
         }
         read_unlock(&resource_lock);
  


Thoughts?


-- 
Thanks,

David / dhildenb

