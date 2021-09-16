Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC3D40EDD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhIPXUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbhIPXUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:20:16 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE216C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:18:55 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r2so7738810pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RQtXF3APZjK/N35tmHC1JHFxBEcZ6P3L5oNdvxpH9yc=;
        b=lAiykl3UhVOE/7/WuxHeAz/iKbUxKVaW1ejor5n1AEh8uankf8us7fjyFvVqH1s9fi
         Gm43QkO6CGKQrw+kn65Kwi7ubUToQa+E8GIQ5mQEWQF9Q1Pcs5l0EL+cj7yeRBytjbBo
         IN3rsBpONqVEVKBYOj9IYAn3V0kp/ch5Rc0nclHz1EGorsb8R9YGY0KXxUBoYooowgtH
         cIetxWXGPs43eC9QOHvd3lvPYf+mQL2aa6SqjKPp5XfHzdKobaJTLxuqJ59ulsalGNRQ
         Xr70Ov+51VmxR1Z16IXMWnDVLO2fAxY8+cMudpBnIAxU7si8GGHZtZhSM5knzfmCrQye
         1DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQtXF3APZjK/N35tmHC1JHFxBEcZ6P3L5oNdvxpH9yc=;
        b=5IB7ee+X2/6tawYm04eLHq37uIatKlpjM3ifokSa3M1KFaTD+VcMPTMr5uc2BMirFo
         MhsHxRxHvaRmnwpzDjs+nMJSUiyDcp3kxzqmdjBvwVXA+miYgaY/MtRB1v6JPoakOgwQ
         H2hNCMvA7OQecpRowMASTP7KHLlvq05kSdYdWjqzx+45I70VJCPfLRMnp+34uSPns4aM
         nvUynUN+88A4Ot8OWcOwl8Ta6kXp6oq64kFtx7cT+L+MJdMrjJMqQ/OnSp4oo8Euw59i
         Aoq1YGsW5hpJCssCIx3DsT4Q6kpbY+xloX8EblQGDRMUALpqG+I6D8crVKVZwZbsxXak
         bKKw==
X-Gm-Message-State: AOAM533+0Mt/iap/959rCbAbg4uONU7tahUEj9j0Koh8HqzfKLyrQ6+P
        RrRHWzQzncxqgOtJvl/vzIs=
X-Google-Smtp-Source: ABdhPJzp0OUlxCsxoGVg2PF2JxmO30Mu7Eda4KpcL5qmWtmL2WC2xMhQhnmop1MWiVzLujQmaDOQbg==
X-Received: by 2002:a62:178f:0:b029:3e0:35c4:f0f with SMTP id 137-20020a62178f0000b02903e035c40f0fmr7636007pfx.64.1631834335199;
        Thu, 16 Sep 2021 16:18:55 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 31sm4208767pgy.26.2021.09.16.16.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:18:54 -0700 (PDT)
Date:   Thu, 16 Sep 2021 16:19:04 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpumask: Omit terminating null byte in
 cpumap_print_{list,bitmask}_to_buf
Message-ID: <YUPQ6F8M822fLzpx@yury-ThinkPad>
References: <20210916222705.13554-1-tklauser@distanz.ch>
 <aa4bc59c44b345ae814c61f6593a7178@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa4bc59c44b345ae814c61f6593a7178@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC Greg KH <gregkh@linuxfoundation.org>]

On Thu, Sep 16, 2021 at 10:53:39PM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Tobias Klauser [mailto:tklauser@distanz.ch]
> > Sent: Friday, September 17, 2021 10:27 AM
> > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>; Song Bao
> > Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Yury Norov <yury.norov@gmail.com>; Peter
> > Zijlstra <peterz@infradead.org>; linux-kernel@vger.kernel.org
> > Subject: [PATCH] cpumask: Omit terminating null byte in
> > cpumap_print_{list,bitmask}_to_buf
> > 
> > The changes in the patch series [1] introduced a terminating null byte
> > when reading from cpulist or cpumap sysfs files, for example:
> > 
> >   $ xxd /sys/devices/system/node/node0/cpulist
> >   00000000: 302d 310a 00                             0-1..
> > 
> > Before this change, the output looked as follows:
> > 
> >   $ xxd /sys/devices/system/node/node0/cpulist
> >   00000000: 302d 310a                                0-1.
> 
> If we don't use xxd, I don't see any actual harm of this NULL byte
> by cat, lscpu, numactl etc. this doesn't break them at all.

Barry, Tobias' script that uses xxd is userspace. Linux kernel never breaks
userspace. 

> if we only want to make sure the output is exactly same with before
> for every single character, this patch is right.

We don't want to make the output exactly the same. The "0,1" would
also work for the example above. But garbage characters following \0
is a bug that should be fixed.

Greg, would you like to move this patch through your tree?

Acked-by: Yury Norov <yury.norov@gmail.com>

> > Fix this regression by excluding the terminating null byte from the
> > returned length in cpumap_print_list_to_buf and
> > cpumap_print_bitmask_to_buf.
> > 
> > [1]
> > https://lore.kernel.org/all/20210806110251.560-1-song.bao.hua@hisilicon.co
> > m/
> > 
> > Fixes: 1fae562983ca ("cpumask: introduce cpumap_print_list/bitmask_to_buf to
> > support large bitmask and list")
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  include/linux/cpumask.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index 5d4d07a9e1ed..1e7399fc69c0 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -996,14 +996,15 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct
> > cpumask *mask)
> >   * cpumask; Typically used by bin_attribute to export cpumask bitmask
> >   * ABI.
> >   *
> > - * Returns the length of how many bytes have been copied.
> > + * Returns the length of how many bytes have been copied, excluding
> > + * terminating '\0'.
> >   */
> >  static inline ssize_t
> >  cpumap_print_bitmask_to_buf(char *buf, const struct cpumask *mask,
> >  		loff_t off, size_t count)
> >  {
> >  	return bitmap_print_bitmask_to_buf(buf, cpumask_bits(mask),
> > -				   nr_cpu_ids, off, count);
> > +				   nr_cpu_ids, off, count) - 1;
> >  }
> > 
> >  /**
> > @@ -1018,7 +1019,7 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask
> > *mask,
> >  		loff_t off, size_t count)
> >  {
> >  	return bitmap_print_list_to_buf(buf, cpumask_bits(mask),
> > -				   nr_cpu_ids, off, count);
> > +				   nr_cpu_ids, off, count) - 1;
> >  }
> > 
> >  #if NR_CPUS <= BITS_PER_LONG
> > --
> > 2.33.0
> 
> Thanks
> Barry
