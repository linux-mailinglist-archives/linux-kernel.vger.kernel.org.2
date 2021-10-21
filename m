Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7B435FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJUKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhJUKxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:53:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD6C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:50:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id k29so148911qve.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bqX9x6YQncATiAls6ExqHqgaKBd6ejlt9Ox6O0pKsds=;
        b=GnJdYMoPQBtPdVKg4E2m6psjbP+1RCogmKs0+tMbRlcxxsm7DA+Jz2d85FuKmD/wyj
         Qm2q2KC1a8SvL53VfIEEzfOfz6fI6IZlJ1k2FfqGF8Au1OGUT90/WaeZeIGZDmMYP+OE
         o/JTsXouY1yhbVKDvELifUmFd22OBC5Q8I0ms5q90VkXUz9wZyY+rrDnfBpG9o7jrfMy
         0j5mnGh0KIZiueLowVvBDysTplvJ1VCi/4tvgyL9xTi6b1PZHifcLEyySNI5eiBhhW1c
         W531viMMseW7NNogYJqrGTmFVrCCwcPQ3HTtE49XJLKQLqXRSOUmiZuw8QRolOuZzpkD
         NyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=bqX9x6YQncATiAls6ExqHqgaKBd6ejlt9Ox6O0pKsds=;
        b=C+Lu9lVOdQce078FZatraMNL30uLPEgrFL6Wvbv1SZjyeAOIfa9+G91IhXYXiUrKeD
         tIIk8i10vln7dMPPyzrj5UoEdcCqgIUDHJS5N38xvg5RMsR6SGtLCusLRLP+hsRCMnFy
         gNkuGhP/voxrxV/VLy/rbxz5zqMVZvVna50NmtK7RQfcRCJubDNrcY77G+25f2ZpK7z5
         nj3teMULN9AnoYD22WAWSGat7aWUaAh2SuH06DorwkyfZ6GPPySlsAf944B9DpdxZU7O
         k8wFQLXNra0Ype5jfal+jO2Weu022LfDVZr9F+wJuiqP/YjM3+AulxfnsEOBqp1k8bXm
         179g==
X-Gm-Message-State: AOAM5314ucIXgHMWYKU7FbgO8GqT9s2MqmqucSCSfrlk/yf4GQ3nLres
        MdbK17EiShTVAHxUQlFkvOVg
X-Google-Smtp-Source: ABdhPJzCU4os3ExM2GTlJZOkb84xZLSjZvt9t/NGs0SpXdy7OvNPM+9mOPhpY51fidDHPL38uxxJfQ==
X-Received: by 2002:a05:6214:c26:: with SMTP id a6mr4439051qvd.40.1634813444820;
        Thu, 21 Oct 2021 03:50:44 -0700 (PDT)
Received: from bruce.bluespec.com ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id b19sm2233319qto.46.2021.10.21.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:50:44 -0700 (PDT)
Date:   Thu, 21 Oct 2021 06:50:42 -0400
From:   Darius Rad <darius@bluespec.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [RFC PATCH v8 09/21] riscv: Add task switch support for vector
Message-ID: <YXFGAqTzHMeQA+R+@bruce.bluespec.com>
Mail-Followup-To: Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Chen <vincent.chen@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
 <0e65c165e3d54a38cbba01603f325dca727274de.1631121222.git.greentime.hu@sifive.com>
 <c81267bc-4c91-3978-8c1f-78925c46c78b@bluespec.com>
 <CAHCEehJ1uuSFqFWreS1kh+fR5GFfnEycdLMe+4FHXpFsHrRUvA@mail.gmail.com>
 <YVRp5uWFGQrwBpgf@bruce.bluespec.com>
 <CAHCEeh+dA9243=PwNtYvyU1Myu_E8YO2g4UNACxRogQ=6UavLQ@mail.gmail.com>
 <YVxZspMO7rAvtMBS@bruce.bluespec.com>
 <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c9797f6-2fd3-5530-ba34-6e4c4deec984@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 06:01:31PM -0700, Paul Walmsley wrote:
> Hello Darius,
> 
> On Tue, 5 Oct 2021, Darius Rad wrote:
> 
> > On Mon, Oct 04, 2021 at 08:36:30PM +0800, Greentime Hu wrote:
> > > Darius Rad <darius@bluespec.com> 於 2021年9月29日 週三 下午9:28寫道：
> > > >
> > > > On Tue, Sep 28, 2021 at 10:56:52PM +0800, Greentime Hu wrote:
> > > > > Darius Rad <darius@bluespec.com> 於 2021年9月13日 週一 下午8:21寫道：
> > > > > >
> > > > > > On 9/8/21 1:45 PM, Greentime Hu wrote:
> > > > > > > This patch adds task switch support for vector. It supports partial lazy
> > > > > > > save and restore mechanism. It also supports all lengths of vlen.
> 
> [ ... ]
> 
> > > > > > So this will unconditionally enable vector instructions, and allocate
> > > > > > memory for vector state, for all processes, regardless of whether vector
> > > > > > instructions are used?
> > > > >
> > > > > Yes, it will enable vector if has_vector() is true. The reason that we
> > > > > choose to enable and allocate memory for user space program is because
> > > > > we also implement some common functions in the glibc such as memcpy
> > > > > vector version and it is called very often by every process. So that
> > > > > we assume if the user program is running in a CPU with vector ISA
> > > > > would like to use vector by default. If we disable it by default and
> > > > > make it trigger the illegal instruction, that might be a burden since
> > > > > almost every process will use vector glibc memcpy or something like
> > > > > that.
> > > >
> > > > Do you have any evidence to support the assertion that almost every process
> > > > would use vector operations?  One could easily argue that the converse is
> > > > true: no existing software uses the vector extension now, so most likely a
> > > > process will not be using it.
> > > 
> > > Glibc ustreaming is just starting so you didn't see software using the 
> > > vector extension now and this patchset is testing based on those 
> > > optimized glibc too. Vincent Chen is working on the glibc vector 
> > > support upstreaming and we will also upstream the vector version glibc 
> > > memcpy, memcmp, memchr, memmove, memset, strcmp, strlen. Then we will 
> > > see platform with vector support can use vector version mem* and str* 
> > > functions automatically based on ifunc and platform without vector 
> > > will use the original one automatically. These could be done to select 
> > > the correct optimized glibc functions by ifunc mechanism.
> 
> In your reply, I noticed that you didn't address Greentime's response 
> here.  But this looks like the key issue.  If common library functions are 
> vector-accelerated, wouldn't it make sense that almost every process would 
> wind up using vector instructions?  And thus there wouldn't be much point 
> to skipping the vector context memory allocation?
> 

This issue was addressed in the thread regarding Intel AMX I linked to in a
previous message.  I don't agree that this is the key issue; it is one of a
number of issues.  What if I don't want to take the potential
power/frequency hit for the vector unit for a workload that, at best, uses
it for the occasional memcpy?  What if the allocation fails, how will that
get reported to user space (hint: not well)?  According to Greentime,
RISC-V vector is similar to ARM SVE, which allocates memory for context
state on first use and not unconditionally for all processes.

// darius

