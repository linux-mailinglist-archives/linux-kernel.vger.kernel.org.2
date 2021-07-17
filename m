Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9B3CC077
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 03:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhGQBPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 21:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGQBPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 21:15:20 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BB9C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 18:12:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ay16so5467419qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 18:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0L6McW/EfSaTB8xvzgos9KNquVmI4Fg3MOgNn7h2beA=;
        b=jqMA2AD3JzVM4Tbn3mSD6YRlnXTq886iPDHv89aktmls68sMUGn/1jg4f6dWZvTqxI
         /2o6EV6cejvuRNsLDGv6AT+OMH2f1PuEzQsqsjfv76Xgo5ZooZZpv1FN5qPjo7j9ZTXP
         a/xliLvgoSiGMfJ+KyQ3fRM5yd1lhVNnyHG5K3EFmWvkhDPzPCZeWyEtvsF0jHIsj+t6
         UhA6SxazKdteMpCGs3WANB4wGmV2WwabYu6qAGCqs8Vmcei6YiOJMQ3Pqr24qPXULBCO
         evx5LVKNeSxeNa2LtSTQbURm6NgqjX4obeyugIiECv3MR5erLjKHbCuvfdDaoRkihp0s
         6+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0L6McW/EfSaTB8xvzgos9KNquVmI4Fg3MOgNn7h2beA=;
        b=MAXGoYCuJoVqnVzTXmbnroVmrTaSZhSSRYbaQlwkp4lEod0m9ouR0FLhPncdFt4ToO
         aNnq4gOhfIWKpgAdQJ3Zb4KpV8EhVc9HFTJZ3kP9cMam9dUMhtrpoJA3z0wNuJNF5KKT
         9KxGxx9E0zHs6Cr0QQCvSyAkpFBMwqOH2PAN2I4xNpBoBsULZRKk/k9n8jcgpVrdLGmZ
         ZO4itaKtBgdqghh9YVmhneEGG2iTJDvddLnk9ZboqNx6sGoAM++XuL6m/vAJQvkHKmks
         Y9uzjBQwV0bRLixOnEd5lhOJIE96kxFZKi4ixa9+UPbiau2rwT49F0vh0oKtsAMAQFAE
         4D4A==
X-Gm-Message-State: AOAM531k0KGhLaVp2Y4fZ645HNT+XNCUTBQDbkv4cvB9LY/Umukgd+eD
        7kev0lhVz4tDm3vPPD4qeH4=
X-Google-Smtp-Source: ABdhPJzVT5yqZ6rBL9ytYBzTlQ1HohvlH1nZ8XqPfuVqnX9fh1iJ3sVMNA7g23E5uPkWf1aDE0X9NQ==
X-Received: by 2002:ad4:4a03:: with SMTP id m3mr13126752qvz.33.1626484342526;
        Fri, 16 Jul 2021 18:12:22 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id r4sm3982192qtc.66.2021.07.16.18.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 18:12:22 -0700 (PDT)
Date:   Fri, 16 Jul 2021 18:12:21 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        tangchengchang <tangchengchang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: Re: [PATCH v7 2/4] topology: use bin_attribute to break the size
 limitation of cpumap ABI
Message-ID: <YPIudYST90WC4k4U@yury-ThinkPad>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-3-song.bao.hua@hisilicon.com>
 <a74b62ef71be4348889bfc8c620e7b77@hisilicon.com>
 <YPHmMu4OWPHwQXtT@yury-ThinkPad>
 <3d83c6b11dae4a83add9d8dcc04bbd80@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d83c6b11dae4a83add9d8dcc04bbd80@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 12:16:48AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Yury Norov [mailto:yury.norov@gmail.com]
> > Sent: Saturday, July 17, 2021 8:04 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: gregkh@linuxfoundation.org; akpm@linux-foundation.org;
> > andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> > dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> > rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> > jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> > bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> > <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> > <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>
> > Subject: Re: [PATCH v7 2/4] topology: use bin_attribute to break the size
> > limitation of cpumap ABI
> > 
> > On Fri, Jul 16, 2021 at 08:49:58AM +0000, Song Bao Hua (Barry Song) wrote:
> > > Hi Yury,
> > > Not sure if I have totally got your idea. But please see if the below
> > > is closer to what you prefer.
> > >
> > > I haven't really tested it. But this approach can somehow solve the
> > > problem you mentioned(malloc/free and printing is done 1000times for
> > > a 1MB buffer which is read 1K each time).
> > >
> > > Bitmap provides some API to alloc and return print_buf:
> > >
> > > +ssize_t bitmap_get_print_buf(bool list, char **buf, const unsigned long
> > *maskp,
> > > +               int nmaskbits)
> > > +{
> > > +       const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > > +       ssize_t size;
> > > +
> > > +       size = snprintf(NULL, 0, fmt, nmaskbits, maskp);
> > > +       *buf = kmalloc_track_caller(size + 1, GFP_KERNEL);
> > > +       scnprintf(*buf, size + 1, fmt, nmaskbits, maskp);
> > > +
> > > +       return size + 1;
> > > +}
> > > +
> > > +static inline ssize_t
> > > +cpumap_get_print_buf(bool list, char **buf, const struct cpumask *mask)
> > > +{
> > > +       return bitmap_get_print_buf(list, buf, cpumask_bits(mask),
> > > +                       nr_cpu_ids);
> > > +}
> > > +
> > > +struct bitmap_print_buf
> > > +{
> > > +       char *buf;
> > > +       ssize_t size;
> > > +};
> > > +
> > >
> > > In bin_attribute, move to get and save the buffer while sysfs entry is
> > > read at the first time and free it when file arrives EOF:
> > >
> > >  #define define_id_show_func(name)                                      \
> > >  static ssize_t name##_show(struct device *dev,                         \
> > >                            struct device_attribute *attr, char *buf)    \
> > > @@ -27,9 +53,27 @@ static ssize_t name##_read(struct file *file, struct kobject
> > *kobj,          \
> > >                                   loff_t off, size_t count)                     \
> > >  {                                                                              \
> > >         struct device *dev = kobj_to_dev(kobj);                                 \
> > > -                                                                               \
> > > -       return cpumap_print_to_buf(false, buf, topology_##mask(dev->id),
> > \
> > > -                                  off, count);                                 \
> > > +       struct bitmap_print_buf *bmb = dev_get_drvdata(dev);                    \
> > > +       if (!bmb) {                                                             \
> > > +               bmb = devm_kzalloc(dev, sizeof(*bmb), GFP_KERNEL);              \
> > > +               if (!bmb)                                                       \
> > > +                       return -ENOMEM;                                         \
> > > +               dev_set_drvdata(dev, bmb);                                      \
> > > +       }                                                                       \
> > > +       /* for the 1st time, getting the printed buffer */                \
> > > +       if (!bmb->buf)                                                           \
> > > +               bmb->size = cpumap_get_print_buf(false, &bmb->buf,       \
> > > +                                    topology_##mask(dev->id));                 \
> > > +       /* when we arrive EOF, free the printed buffer */                       \
> > > +       if (off >= bmb->size) {                                                 \
> > > +               kfree(bmb->buf);  bmb->buf = NULL;
> > \
> > > +               return 0;                                                       \
> > > +       }                                                                       \
> > > +       /* while a large printed buffer is read many times, we reuse         \
> > > +        * the buffer we get at the 1st time                                    \
> > > +        */                                                                     \
> > > +       strncpy(buf, bmb->buf + off, count);                                    \
> > > +       return min(count,  bmb->size - off);                                    \
> > >  }                                                                              \
> > >                                                                                 \
> > > This means a huge change in drivers though I am not sure Greg is
> > > a fan of this approach. Anyway, "1000 times" is not a real case.
> > > Typically we will arrive EOF after one time.
> > 
> > Not a real case in your driver doesn't mean not a real case at all.
> > You're adding your code to the very basic core layer, and so you'd
> > consider all possible scenarios, not only your particular one.
> > 
> 
> Generally yes. And generally I agree with your point. That point is
> exactly what I have always adhered to in software design. But my point
> I have been arguing is that the new APIs are for sysfs ABI only. So it
> is not particular one, it is common.
> 
> In my understanding, only ABI things to users will need to print bitmap
> to mask or list. Rarely a kernel module will need it. Kernel modules
> would be running real and/or/andnot bit operations on binary bitmap
> directly.
> 
> Anyway, I'm glad to take a step in the way you prefer.
> 
> > On the other hand, if you add your function(s) at drivers/base/node.c
> > and explain that O(nbits**2) 'is not a real case' in _this_ driver -
> > I think it will be acceptable. Maybe this is your choice...
> > 
> > > Thanks
> > > Barry
> > 
> > > Not sure if I have totally got your idea. But please see if the below
> > > is closer to what you prefer.
> > >
> > > I haven't really tested it. But this approach can somehow solve the
> > > problem you mentioned(malloc/free and printing is done 1000times for
> > > a 1MB buffer which is read 1K each time).
> > >
> > > Bitmap provides some API to alloc and return print_buf:
> > 
> > I'm not too familar to the topology things, and in fact never exposed
> > anything thru the sysfs.
> > 
> > From general knowledge, it's better to allocate memory for the string
> > on file creation to avoid situation when kernel has no memory to allocate
> > it when user tries to read.
> > 
> > So from my perspective, the most straightforward solution would be:
> > 
> > register(cpumask)
> > {
> >         size_t max_size = cpumap_max_string_size(list, cpumask)
> >         void *buf = kmalloc(max_size, ...);
> > 
> >         sysfs_create_file(..., buf)
> > }
> > 
> > unregister()
> > {
> >         kfree(buf);
> > }
> > 
> > show()
> > {
> >         snprintf(buf, max_size, "*pbl", cpumask);
> > }
> > 
> 
> Generally good idea. However, for sysfs ABI entries, it might not be
> that true.
> 
> A sysfs entry might never be read for its whole life. As I explained
> before, a sysfs entry - especially for list,  is randomly "cat" by users.
> Many of them won't be read forever. And after they are read once, they
> will probably never be read again. The operations to read ABI could be
> random and rare. Performance wouldn't be a concern.
> 
> To avoid holding the memory which might never be used, it is better to
> allocate and free the memory during runtime. I mean to allocate in show()
> and free in show(), aka, to do it on demand.
> 
> For example, for a server with 256CPU and each cpu has dozens of sysfs ABI
> entries, only a few of sysfs list entries might be randomly "cat" by users.
> Holding 256*entries memory doesn't look good.

Ok, makes sense.
 
> > This would require to add bitmap_max_string_size(list, bitmap, nbits),
> > but it's O(1), and I think, others will find it helpful.
> 
> What about getting size and memory at the same time?

1. We already have kasprintf()
2. It breaks coding style.

Documentation/process/coding-style.rst:
        Functions should be short and sweet, and do just one thing. 

From practical point of view, there should be some balance between
granularity and ease-of-use. But in this case, bitmap_list cries for 
a function that will help to estimate size of output buffer. And it's
easy to imagine a case where the estimated length of bitmap is needed
explicitly:

        size_t max_size = bitmap_max_string_size(nbits);
        char *buf = kmalloc(PAGE_ALIGN(max_size) * nr_cpus);

Thought, I don't insist. In your driver you can do:

        size_t size = snprintf(NULL, 0, ...);
        void *buf = kmalloc(size);

It will be fully correct, and you already have everything you need.
 
> ssize_t bitmap_get_print_buf(bool list, char **buf, const unsigned long
>  *maskp, int nmaskbits)
> 
> ssize_t cpumap_get_print_buf(bool list, char **buf, const struct cpumask *mask);
>
> This API returns the size of printed buffer, and it also gets the
> printed result saved in *buf. Then drivers don't need to do three
> steps:
> 
> 1. get cpumap buffer size which is your cpumap_max_string_size()
> 2. allocate memory for buffer according to size got in step 1
> 3. print bitmap(cpumap) to buffer by "pbl"
> 
> It will only need to call bitmap_get_print_buf() and all three
> things are done inside bitmap_get_print_buf().
> 
> How to use the size and memory allocated in cpumap_get_print_buf
> will be totally up to users.
> 
> The other benefit for this is that if we get string size during initialization,
> and then we print in show() entries, the size got at the beginning might be not
> enough as system topology might have changed. Sysfs ABI reflects the status of
> system at this moment.
> 
> > 
> > Again, I'm not professional with sysfs, and fully admit that it might
> > be wrong.
> 
> Never mind.
> 
> Thanks
> Barry
