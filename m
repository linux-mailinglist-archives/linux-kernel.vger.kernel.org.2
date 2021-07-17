Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5EA3CC005
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 02:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhGQATs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jul 2021 20:19:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6945 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGQATr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 20:19:47 -0400
Received: from dggeme714-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GRT8n3DYcz7tSx;
        Sat, 17 Jul 2021 08:13:13 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme714-chm.china.huawei.com (10.1.199.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 17 Jul 2021 08:16:48 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Sat, 17 Jul 2021 08:16:48 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Yury Norov <yury.norov@gmail.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Subject: RE: [PATCH v7 2/4] topology: use bin_attribute to break the size
 limitation of cpumap ABI
Thread-Topic: [PATCH v7 2/4] topology: use bin_attribute to break the size
 limitation of cpumap ABI
Thread-Index: AQHXeXDlNwZNI9Wk4UqsPQdyS/XZkqtFQm+QgABABACAAMKqIA==
Date:   Sat, 17 Jul 2021 00:16:48 +0000
Message-ID: <3d83c6b11dae4a83add9d8dcc04bbd80@hisilicon.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-3-song.bao.hua@hisilicon.com>
 <a74b62ef71be4348889bfc8c620e7b77@hisilicon.com>
 <YPHmMu4OWPHwQXtT@yury-ThinkPad>
In-Reply-To: <YPHmMu4OWPHwQXtT@yury-ThinkPad>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.172]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yury Norov [mailto:yury.norov@gmail.com]
> Sent: Saturday, July 17, 2021 8:04 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: gregkh@linuxfoundation.org; akpm@linux-foundation.org;
> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org;
> dave.hansen@intel.com; linux@rasmusvillemoes.dk; rafael@kernel.org;
> rdunlap@infradead.org; agordeev@linux.ibm.com; sbrivio@redhat.com;
> jianpeng.ma@intel.com; valentin.schneider@arm.com; peterz@infradead.org;
> bristot@redhat.com; guodong.xu@linaro.org; tangchengchang
> <tangchengchang@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> yangyicong <yangyicong@huawei.com>; tim.c.chen@linux.intel.com; Linuxarm
> <linuxarm@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>
> Subject: Re: [PATCH v7 2/4] topology: use bin_attribute to break the size
> limitation of cpumap ABI
> 
> On Fri, Jul 16, 2021 at 08:49:58AM +0000, Song Bao Hua (Barry Song) wrote:
> > Hi Yury,
> > Not sure if I have totally got your idea. But please see if the below
> > is closer to what you prefer.
> >
> > I haven't really tested it. But this approach can somehow solve the
> > problem you mentioned(malloc/free and printing is done 1000times for
> > a 1MB buffer which is read 1K each time).
> >
> > Bitmap provides some API to alloc and return print_buf:
> >
> > +ssize_t bitmap_get_print_buf(bool list, char **buf, const unsigned long
> *maskp,
> > +               int nmaskbits)
> > +{
> > +       const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> > +       ssize_t size;
> > +
> > +       size = snprintf(NULL, 0, fmt, nmaskbits, maskp);
> > +       *buf = kmalloc_track_caller(size + 1, GFP_KERNEL);
> > +       scnprintf(*buf, size + 1, fmt, nmaskbits, maskp);
> > +
> > +       return size + 1;
> > +}
> > +
> > +static inline ssize_t
> > +cpumap_get_print_buf(bool list, char **buf, const struct cpumask *mask)
> > +{
> > +       return bitmap_get_print_buf(list, buf, cpumask_bits(mask),
> > +                       nr_cpu_ids);
> > +}
> > +
> > +struct bitmap_print_buf
> > +{
> > +       char *buf;
> > +       ssize_t size;
> > +};
> > +
> >
> > In bin_attribute, move to get and save the buffer while sysfs entry is
> > read at the first time and free it when file arrives EOF:
> >
> >  #define define_id_show_func(name)                                      \
> >  static ssize_t name##_show(struct device *dev,                         \
> >                            struct device_attribute *attr, char *buf)    \
> > @@ -27,9 +53,27 @@ static ssize_t name##_read(struct file *file, struct kobject
> *kobj,          \
> >                                   loff_t off, size_t count)                     \
> >  {                                                                              \
> >         struct device *dev = kobj_to_dev(kobj);                                 \
> > -                                                                               \
> > -       return cpumap_print_to_buf(false, buf, topology_##mask(dev->id),
> \
> > -                                  off, count);                                 \
> > +       struct bitmap_print_buf *bmb = dev_get_drvdata(dev);                    \
> > +       if (!bmb) {                                                             \
> > +               bmb = devm_kzalloc(dev, sizeof(*bmb), GFP_KERNEL);              \
> > +               if (!bmb)                                                       \
> > +                       return -ENOMEM;                                         \
> > +               dev_set_drvdata(dev, bmb);                                      \
> > +       }                                                                       \
> > +       /* for the 1st time, getting the printed buffer */                \
> > +       if (!bmb->buf)                                                           \
> > +               bmb->size = cpumap_get_print_buf(false, &bmb->buf,       \
> > +                                    topology_##mask(dev->id));                 \
> > +       /* when we arrive EOF, free the printed buffer */                       \
> > +       if (off >= bmb->size) {                                                 \
> > +               kfree(bmb->buf);  bmb->buf = NULL;
> \
> > +               return 0;                                                       \
> > +       }                                                                       \
> > +       /* while a large printed buffer is read many times, we reuse         \
> > +        * the buffer we get at the 1st time                                    \
> > +        */                                                                     \
> > +       strncpy(buf, bmb->buf + off, count);                                    \
> > +       return min(count,  bmb->size - off);                                    \
> >  }                                                                              \
> >                                                                                 \
> > This means a huge change in drivers though I am not sure Greg is
> > a fan of this approach. Anyway, "1000 times" is not a real case.
> > Typically we will arrive EOF after one time.
> 
> Not a real case in your driver doesn't mean not a real case at all.
> You're adding your code to the very basic core layer, and so you'd
> consider all possible scenarios, not only your particular one.
> 

Generally yes. And generally I agree with your point. That point is
exactly what I have always adhered to in software design. But my point
I have been arguing is that the new APIs are for sysfs ABI only. So it
is not particular one, it is common.

In my understanding, only ABI things to users will need to print bitmap
to mask or list. Rarely a kernel module will need it. Kernel modules
would be running real and/or/andnot bit operations on binary bitmap
directly.

Anyway, I'm glad to take a step in the way you prefer.

> On the other hand, if you add your function(s) at drivers/base/node.c
> and explain that O(nbits**2) 'is not a real case' in _this_ driver -
> I think it will be acceptable. Maybe this is your choice...
> 
> > Thanks
> > Barry
> 
> > Not sure if I have totally got your idea. But please see if the below
> > is closer to what you prefer.
> >
> > I haven't really tested it. But this approach can somehow solve the
> > problem you mentioned(malloc/free and printing is done 1000times for
> > a 1MB buffer which is read 1K each time).
> >
> > Bitmap provides some API to alloc and return print_buf:
> 
> I'm not too familar to the topology things, and in fact never exposed
> anything thru the sysfs.
> 
> From general knowledge, it's better to allocate memory for the string
> on file creation to avoid situation when kernel has no memory to allocate
> it when user tries to read.
> 
> So from my perspective, the most straightforward solution would be:
> 
> register(cpumask)
> {
>         size_t max_size = cpumap_max_string_size(list, cpumask)
>         void *buf = kmalloc(max_size, ...);
> 
>         sysfs_create_file(..., buf)
> }
> 
> unregister()
> {
>         kfree(buf);
> }
> 
> show()
> {
>         snprintf(buf, max_size, "*pbl", cpumask);
> }
> 

Generally good idea. However, for sysfs ABI entries, it might not be
that true.

A sysfs entry might never be read for its whole life. As I explained
before, a sysfs entry - especially for list,  is randomly "cat" by users.
Many of them won't be read forever. And after they are read once, they
will probably never be read again. The operations to read ABI could be
random and rare. Performance wouldn't be a concern.

To avoid holding the memory which might never be used, it is better to
allocate and free the memory during runtime. I mean to allocate in show()
and free in show(), aka, to do it on demand.

For example, for a server with 256CPU and each cpu has dozens of sysfs ABI
entries, only a few of sysfs list entries might be randomly "cat" by users.
Holding 256*entries memory doesn't look good.

> This would require to add bitmap_max_string_size(list, bitmap, nbits),
> but it's O(1), and I think, others will find it helpful.

What about getting size and memory at the same time?

ssize_t bitmap_get_print_buf(bool list, char **buf, const unsigned long
 *maskp, int nmaskbits)

ssize_t cpumap_get_print_buf(bool list, char **buf, const struct cpumask *mask);

This API returns the size of printed buffer, and it also gets the
printed result saved in *buf. Then drivers don't need to do three
steps:

1. get cpumap buffer size which is your cpumap_max_string_size()
2. allocate memory for buffer according to size got in step 1
3. print bitmap(cpumap) to buffer by "pbl"

It will only need to call bitmap_get_print_buf() and all three
things are done inside bitmap_get_print_buf().

How to use the size and memory allocated in cpumap_get_print_buf
will be totally up to users.

The other benefit for this is that if we get string size during initialization,
and then we print in show() entries, the size got at the beginning might be not
enough as system topology might have changed. Sysfs ABI reflects the status of
system at this moment.

> 
> Again, I'm not professional with sysfs, and fully admit that it might
> be wrong.

Never mind.

Thanks
Barry

