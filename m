Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8373CBD79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhGPUHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 16:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 16:07:01 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1557C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:04:05 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 23so9921506qke.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FEpYFedqACRZmPFNQmlaIVFTd/2gXqRNrTujmTN6xkU=;
        b=iImctWEKlRJwh5hGFXOJkYN0zM/8bw9rdTP5Cgt7kvZcJMQBLKmOe8ZBZ+KiagBA6L
         +oKibWYwH+JR6ZufSSMMM60wVz2oguX0Zxq8hF3/k7dKhzgwUME52Gt74ybTD2lR14C8
         m7sWfgHQyAt3Cn1nyaGmk5vfOBL83Uyv/jglcTeMzaNdMr2Y/4LeNHHqifQRrE67TAx/
         udu4dofh1d4LBM9/eSKjdvuO5I9lXqgK3+um9FITDAbRnpj/XB1xDMrrsdwKBZ69dA8p
         0mAehq346RqfIu0skNA2PBogtth6tX7Zr+sy1hEzg2c05LJao5GcZ/E1XJlF98Y3c5HF
         psiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEpYFedqACRZmPFNQmlaIVFTd/2gXqRNrTujmTN6xkU=;
        b=QLbtMOYtYBPJ6PLfjcKMxtl3ZwWpl3PZKlIP70ehI/02MWLxAa7v6SPH+W2r/OKhw0
         g3Z03U+Nfh1gp/VCLHD4jbvz6x3ZZsb+eq5uPWcNBc3VFI94BM5uAyLo/2pe7Ag05JCy
         OfhMqOw9j7rc49dgL6O6EtgfHWznRdnwyHyzX9LwZo0+ByLdNxjpZvHFR5NU5qYm8l+e
         ExKp4une0Y3BSJuZ2utKxQqE5fWb6L8uu44pNb7w31xP4g9y8IF/KGm1RXO0u6+Jlh00
         ewkYUaebsv8Y89lWSAIW8NtFQOA+eDkK5Pn9VC5r4cLlXdP2vz0Sd1DMrur2JAb59bwL
         sr8w==
X-Gm-Message-State: AOAM5301ueOzAMkNHslQ8uyck5pLo/UsEF+W0DL39BlN5yY983IwNgTV
        /LNZGWNrsDm2cgQ1eiDUg6U=
X-Google-Smtp-Source: ABdhPJzYz1xfsuNc9T853Xd2I2DQ4MSnWE+iLU7YzSTSD07sR/+4zl/Z5fFTD6QFNN90As2ShTHKcQ==
X-Received: by 2002:ae9:ed4e:: with SMTP id c75mr11472641qkg.124.1626465844200;
        Fri, 16 Jul 2021 13:04:04 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id u11sm4375180qkk.72.2021.07.16.13.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:04:03 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:04:02 -0700
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
Message-ID: <YPHmMu4OWPHwQXtT@yury-ThinkPad>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-3-song.bao.hua@hisilicon.com>
 <a74b62ef71be4348889bfc8c620e7b77@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74b62ef71be4348889bfc8c620e7b77@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 08:49:58AM +0000, Song Bao Hua (Barry Song) wrote:
> Hi Yury,
> Not sure if I have totally got your idea. But please see if the below
> is closer to what you prefer.
> 
> I haven't really tested it. But this approach can somehow solve the
> problem you mentioned(malloc/free and printing is done 1000times for
> a 1MB buffer which is read 1K each time).
> 
> Bitmap provides some API to alloc and return print_buf:
> 
> +ssize_t bitmap_get_print_buf(bool list, char **buf, const unsigned long *maskp,
> +               int nmaskbits)
> +{
> +       const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> +       ssize_t size;
> +
> +       size = snprintf(NULL, 0, fmt, nmaskbits, maskp);
> +       *buf = kmalloc_track_caller(size + 1, GFP_KERNEL);
> +       scnprintf(*buf, size + 1, fmt, nmaskbits, maskp);
> +
> +       return size + 1;
> +}
> +
> +static inline ssize_t
> +cpumap_get_print_buf(bool list, char **buf, const struct cpumask *mask)
> +{
> +       return bitmap_get_print_buf(list, buf, cpumask_bits(mask),
> +                       nr_cpu_ids);
> +}
> +
> +struct bitmap_print_buf
> +{
> +       char *buf;
> +       ssize_t size;
> +};
> +
> 
> In bin_attribute, move to get and save the buffer while sysfs entry is
> read at the first time and free it when file arrives EOF:
> 
>  #define define_id_show_func(name)                                      \
>  static ssize_t name##_show(struct device *dev,                         \
>                            struct device_attribute *attr, char *buf)    \
> @@ -27,9 +53,27 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,          \
>                                   loff_t off, size_t count)                     \
>  {                                                                              \
>         struct device *dev = kobj_to_dev(kobj);                                 \
> -                                                                               \
> -       return cpumap_print_to_buf(false, buf, topology_##mask(dev->id),        \
> -                                  off, count);                                 \
> +       struct bitmap_print_buf *bmb = dev_get_drvdata(dev);                    \
> +       if (!bmb) {                                                             \
> +               bmb = devm_kzalloc(dev, sizeof(*bmb), GFP_KERNEL);              \
> +               if (!bmb)                                                       \
> +                       return -ENOMEM;                                         \
> +               dev_set_drvdata(dev, bmb);                                      \
> +       }                                                                       \
> +       /* for the 1st time, getting the printed buffer */                \
> +       if (!bmb->buf)                                                           \
> +               bmb->size = cpumap_get_print_buf(false, &bmb->buf,       \
> +                                    topology_##mask(dev->id));                 \
> +       /* when we arrive EOF, free the printed buffer */                       \
> +       if (off >= bmb->size) {                                                 \
> +               kfree(bmb->buf);  bmb->buf = NULL;                                   \
> +               return 0;                                                       \
> +       }                                                                       \
> +       /* while a large printed buffer is read many times, we reuse         \
> +        * the buffer we get at the 1st time                                    \
> +        */                                                                     \
> +       strncpy(buf, bmb->buf + off, count);                                    \
> +       return min(count,  bmb->size - off);                                    \
>  }                                                                              \
>                                                                                 \
> This means a huge change in drivers though I am not sure Greg is
> a fan of this approach. Anyway, "1000 times" is not a real case.
> Typically we will arrive EOF after one time.

Not a real case in your driver doesn't mean not a real case at all.
You're adding your code to the very basic core layer, and so you'd
consider all possible scenarios, not only your particular one. 

On the other hand, if you add your function(s) at drivers/base/node.c
and explain that O(nbits**2) 'is not a real case' in _this_ driver -
I think it will be acceptable. Maybe this is your choice...
 
> Thanks
> Barry

> Not sure if I have totally got your idea. But please see if the below
> is closer to what you prefer.
>
> I haven't really tested it. But this approach can somehow solve the
> problem you mentioned(malloc/free and printing is done 1000times for
> a 1MB buffer which is read 1K each time).
> 
> Bitmap provides some API to alloc and return print_buf:

I'm not too familar to the topology things, and in fact never exposed
anything thru the sysfs.

From general knowledge, it's better to allocate memory for the string
on file creation to avoid situation when kernel has no memory to allocate
it when user tries to read.

So from my perspective, the most straightforward solution would be:

register(cpumask)
{
        size_t max_size = cpumap_max_string_size(list, cpumask)
        void *buf = kmalloc(max_size, ...);

        sysfs_create_file(..., buf)
}

unregister()
{
        kfree(buf);
}

show()
{
        snprintf(buf, max_size, "*pbl", cpumask);
}

This would require to add bitmap_max_string_size(list, bitmap, nbits),
but it's O(1), and I think, others will find it helpful.

Again, I'm not professional with sysfs, and fully admit that it might
be wrong.
