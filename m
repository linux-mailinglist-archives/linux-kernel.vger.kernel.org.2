Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB43777EF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 20:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhEIS1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 14:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhEIS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 14:27:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316CC061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 11:26:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s82so7914133wmf.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rOrxa6aSiXbwul0GfHks5tuaylucNUuVWRXguFZdR+A=;
        b=VAVGukZZggRN1Hg4BJmMwnMVgjAXe7CXQQOb/ICiFbeFn016ZbG64fLwId3Y1lIuKH
         OLl8EDcXUX1u/sXXPgLooroZkAsX73mXT2uEVkLYcDiKXhBFQrlgLTJnOLghmhw8n9rK
         Q7dBek29kptQOxz6X4avo2pEr6w5xBGyCtu3yMikebfwcCtayfCcHLhnb+PIqH7VLgSh
         4FHCCfx4qRTHNqMkVROt9xuriV/JO9vXLNuJhzG+1OyWypunyiq2jxoia67/NI+bg+s4
         vNlPKxe/RDMUYsKOMjZooEozdocklw0j04xQjc3sj2mO8ZR2XdPELsp+QrByb5m23ugZ
         UTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rOrxa6aSiXbwul0GfHks5tuaylucNUuVWRXguFZdR+A=;
        b=EOMsbIlouKr8VVWGssBv8Hfh/lfdIHJ8BWWgB9gAjU8YDea0nO+Ev3ENHp2pSuqLjs
         /3q4mXirq7Z2YL+wB9/R98B4yBGh2wL8zG55QVYpe8jIGKnO0waardxjL6htiRUrGuKV
         3uC8HDfzfZFtWS9cHk7WH+aDLDYce3+v3sorDmim54T7HKlOtB9UMLdOo9cjaM+p37Y8
         cW6yNuzt+SfWo80EA0kExe9HMlB6izdcWwg3us5uhgOiC4+5BIAM5gzXBV3DEz99NeTq
         MSubsdLmOMUZhz31L8Xbn8bV0Q9asxiQMCgz5WTjjx8XcD4iNClJ7jfC3j83MLokJyO5
         X+XQ==
X-Gm-Message-State: AOAM53324Ing5frQ7YsTJjyQEJWtS/roWG4n5J1GslSzcjCpSwGgRL+P
        J+I6CWlfT1uwrTQoNACqwGg=
X-Google-Smtp-Source: ABdhPJwBfBEcUc219PTxGPorMh8d8ehCPU7hrqsADD1rCJoczUBT+hoyrA7YDXpcR5hakYkr1wh4jg==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr22464068wml.0.1620584761398;
        Sun, 09 May 2021 11:26:01 -0700 (PDT)
Received: from michael-VirtualBox (cbl217-132-244-50.bb.netvision.net.il. [217.132.244.50])
        by smtp.gmail.com with ESMTPSA id j10sm19120864wrt.32.2021.05.09.11.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 11:26:00 -0700 (PDT)
Date:   Sun, 9 May 2021 21:25:58 +0300
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        michael.zaidman@gmail.com
Subject: Re: [kbuild-all] Re: drivers/hid/hid-ft260.c:794:44: warning: format
 specifies type 'short' but the argument has type 'int'
Message-ID: <20210509182558.GA4940@michael-VirtualBox>
References: <202105060637.LeEC6ztp-lkp@intel.com>
 <20210506115546.GA1745@michael-VirtualBox>
 <0102b8fe-3edf-3d4f-2622-d1fefb36274f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102b8fe-3edf-3d4f-2622-d1fefb36274f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 06:00:31PM +0800, Chen, Rong A wrote:
> 
> 
> On 5/6/2021 7:55 PM, Michael Zaidman wrote:
> > On Thu, May 06, 2021 at 06:47:46AM +0800, kernel test robot wrote:
> > > 
> > >     drivers/hid/hid-ft260.c:515:59: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
> > >                     hid_err(hdev, "%s: unsupported wr len: %d\n", __func__, len);
> > >                                                                             ^~~
> > >     include/linux/hid.h:1190:30: note: expanded from macro 'hid_err'
> > >             dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
> > >                                         ^~~~~~~~~~~
> > >     include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
> > >             _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >                                           ^~~~~~~~~~~
> > >     drivers/hid/hid-ft260.c:507:9: note: initialize the variable 'len' to silence this warning
> > >             int len, ret;
> > >                    ^
> > >                     = 0
> > 
> > This warning has already been found and fixed by Dan Carpenter in
> > the "HID: ft260: fix an error message in ft260_i2c_write_read()" commit
> > on March 18, 2021.
> 
> Hi Michael,
> 
> This report is about the below warning prefixed by '>>', it's still in
> mainline:
> 
> >> drivers/hid/hid-ft260.c:794:44: warning: format specifies type 'short'
> but the argument has type 'int' [-Wformat]
>            return scnprintf(buf, PAGE_SIZE, "%hi\n", le16_to_cpu(*field));
>                                              ~~~     ^~~~~~~~~~~~~~~~~~~
>                                              %i
> 
> Best Regards,
> Rong Chen

Hi Rong,

Sure, but since the report states - "2 warnings generated", I addressed
the first one for which we already have a commit with the fix.

I tried to reproduce the second warning you referred to in this e-mail,
but make.cross script failed since the "clang-latest" directory does not
exist under the "0day". As a workaround, I modified the make command
generated by the script replacing all "clang-latest" occurrences with
"clang" and run it manually.

Another workaround could be to use the symbolic link as reported in the
https://groups.google.com/g/clang-built-linux/c/qCjZblHi8lY/m/eBEEl2JxBgAJ
on March 27, 2021.

Anyway, I reproduced this warning and am going to submit a fix shortly.

Thanks,
Michael

