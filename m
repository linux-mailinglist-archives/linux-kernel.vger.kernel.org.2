Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1891D3A18B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhFIPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbhFIPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:11:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E36CC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 08:10:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h1so5036374plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3LZsPwexpDP/kj/j+5Ik9WCBYi4pMWZXQW1ZE6DwlU=;
        b=0C/XeUzxj/itIlpE3RuWPjtjfArIYgHt8XJGQJc9VYGYyWAwO1LBLJ+uQsD7BS7Ae3
         4M+U4CKXdoVBjmxNmY/w+jtJlvubyL08tvVVw07zSuiNHmKE2dMQU5z+W5cLxKXxM0ir
         +bKcQUg39FNZ0p9FgvIoVqPwdDluzGgB1/xtkw0jxmH/o/JNpTGU+7rX9vfOWABkox+l
         COnuhjZASXoLp/en6hwKIKCHRC+Fp2GpawjqS87UwHWfK1Ke6wnuPhYVS3Wf8Kql5hme
         lN2usqkHS04/zW/2TK2i2nI25H/l+mHlFj4TjGyDcHXtGoeSN0weUwG3TYGOYZgLOqSL
         e4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3LZsPwexpDP/kj/j+5Ik9WCBYi4pMWZXQW1ZE6DwlU=;
        b=StkQM8MVq9rD3fEXrrYMx4N77p0f1WIuwXL/+uN/9ccW3a9zTN/e2fHRRN8kAI4CZa
         QMJo60OTgF+tplFTtEJK8p4N+i7U3jFdSQTn++IHbCNiCFzyUorPMR2D5lxxr8KsAeJz
         u82nFPassqdNrfh2qYlO0xOCnNfDpP11lrf4srhmmC76dqttbV69oztVJ0WHEDlxbz/R
         ZkWM04qBu6GYMz5oOTF5MrUtyNNdzT+dy6ggiDxTV88m76uoYICGLaEK8oqY2HfSNblY
         swycYE4neh6rpGo+VeaN2oa3/t72f9nwJCZq/Gz3Z1Cpxy72cRwhluY1e7jvLbLdhmrI
         M2EA==
X-Gm-Message-State: AOAM5322rFTjOkmjQmd8WNrwMWUD83LiShaEhQeESWstep6TiA5yymhy
        U+MX/sHUYgbtErV9KAeUw0f27gskdKG5Xi6Uea1YZw==
X-Google-Smtp-Source: ABdhPJzs1y023JBtkSHe1ljP4uOLN3EhQ4rsB3NnheX2EvyFdAJZIEE0ZyczhHB9BZWY8EBCOfInHA8rDZSDn+9I3mI=
X-Received: by 2002:a17:90a:ea8c:: with SMTP id h12mr9024341pjz.149.1623251403714;
 Wed, 09 Jun 2021 08:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
 <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com> <CAPcyv4jfFPGm2-cvPExeujZnaSKKky3AQRp69tzG1gcZ09dj8A@mail.gmail.com>
 <ffedf1d2-e5ec-e0e3-8e83-edd186231029@linux.intel.com>
In-Reply-To: <ffedf1d2-e5ec-e0e3-8e83-edd186231029@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Jun 2021 08:09:52 -0700
Message-ID: <CAPcyv4haWYhqk_xLD56QnB0ahK+fynOmqGdSD907UW-=7B176g@mail.gmail.com>
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 9:27 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> here is no resume path.
>
> > Host is free to go into S3 independent of any guest state.
>
> Actually my understanding is that none of the systems which support TDX
> support S3. S3 has been deprecated for a long time.

Ok, I wanted to imply any power state that might power-off caches.

>
>
> >   A hostile
> > host is free to do just enough cache management so that it can resume
> > from S3 while arranging for TDX guest dirty data to be lost. Does a
> > TDX guest go fatal if the cache loses power?
>
> That would be a machine check, and yes it would be fatal.

Sounds good, so incorporating this and Andy's feedback:

"TDX guests, like other typical guests, use standard ACPI mechanisms
to signal sleep state entry (including reboot) to the host. The ACPI
specification mandates WBINVD on any sleep state entry with the
expectation that the platform is only responsible for maintaining the
state of memory over sleep states, not preserving dirty data in any
CPU caches. ACPI cache flushing requirements pre-date the advent of
virtualization. Given guest sleep state entry does not affect any host
power rails it is not required to flush caches. The host is
responsible for maintaining cache state over its own bare metal sleep
state transitions that power-off the cache. A TDX guest, unlike a
typical guest, will machine check if the CPU cache is powered off."

Andi, is that machine check behavior relative to power states
mentioned in the docs?
