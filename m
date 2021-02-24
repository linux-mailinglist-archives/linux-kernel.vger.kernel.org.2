Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6CD3243B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhBXSXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhBXSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:23:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF6C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:22:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q20so1855645pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Ekz/GZccERa3C1AHrp2icdATneuYRFX37mYpxu1zrQ=;
        b=njGvsO8oCNC80bXLA/su7EZCfgpaKEj+gTEierQXqYKbYtwjxbONX+BgrJCYejrNW4
         AtHlF0gYNE6m4O/ISBqN/n5663VyRVg07SEiR3sUfg65CJDWFefVpQiQEA74ick9DOGa
         NiWdrePl7Qpms0n6i2Tz/XEIxLKr7V3P6Na5pEzDO+k1uaXuZC9zMi/lA5Feqz8HmLWj
         xhXECg599qgL5TzAnjXR0n4pUJyQ8kKOOgJTpS+UWaMA/6kNwCKl/dmjBxeXsuwcLZ4+
         A5iIntAwScQCf4rWvFF0eK/MuAQiYxbi6Zt/BryIMckp5BWknj4ldLK10ZmMiyd4DyIY
         YCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Ekz/GZccERa3C1AHrp2icdATneuYRFX37mYpxu1zrQ=;
        b=hL9yjfd3+hoTh866V0Ot/WZM+MfLz+cQYCjeKl5W4MQVTaH6KvE0K7xF5MHIrkm+f1
         nGzEcy+qha/Qc3aIlTAcpaEDzsNWv9JmBqH6V2UkOVzXds/HSEwq0D3hwueQIqaYWlij
         ELzJQ6xV/ot/bX5DL9ijTUF/iv1Vb+1J0GNTv7PbcCwU+D3tKyk747KkIBTkuY5V2ftl
         BIqVsjKfRRaLYU9brfQtaZ1DqeaFzaICti1Ik+2wjvZp8DsDYAcqzjxQgONaYe9wE44/
         XrKP8+J31Muy0y0/JUyXWD59q+a+T+ZgrlPF/2IHhyyx09LT7WeE/gKYH511W2k+64gV
         p5jw==
X-Gm-Message-State: AOAM533UEA3T+CT12U+SRnokPdbg3JC6IZlvULotzwP94N3gXAtFdPqe
        /oGhVC0Bl2FRRLFs42L4v6SoRQ==
X-Google-Smtp-Source: ABdhPJwA2UgGDe5GNZf6z02NEbFcGcz1+uwS5k87G0Qizj5n2D+EpMCdlBdy20pPBAMzr06coaDmsA==
X-Received: by 2002:a05:6a00:23c5:b029:1e6:2f2e:a438 with SMTP id g5-20020a056a0023c5b02901e62f2ea438mr33576304pfc.75.1614190960438;
        Wed, 24 Feb 2021 10:22:40 -0800 (PST)
Received: from google.com ([2620:15c:f:10:385f:4012:d20f:26b5])
        by smtp.gmail.com with ESMTPSA id g19sm3441554pjv.43.2021.02.24.10.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:22:39 -0800 (PST)
Date:   Wed, 24 Feb 2021 10:22:33 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>, "bp@suse.de" <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srutherford@google.com" <srutherford@google.com>,
        "venu.busireddy@oracle.com" <venu.busireddy@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH v10 10/16] KVM: x86: Introduce KVM_GET_SHARED_PAGES_LIST
 ioctl
Message-ID: <YDaZacLqNQ4nK/Ex@google.com>
References: <cover.1612398155.git.ashish.kalra@amd.com>
 <7266edd714add8ec9d7f63eddfc9bbd4d789c213.1612398155.git.ashish.kalra@amd.com>
 <YCxrV4u98ZQtInOE@google.com>
 <SN6PR12MB27672FF8358D122EDD8CC0188E859@SN6PR12MB2767.namprd12.prod.outlook.com>
 <20210224175122.GA19661@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224175122.GA19661@ashkalra_ubuntu_server>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021, Ashish Kalra wrote:
> # Samples: 19K of event 'kvm:kvm_hypercall'
> # Event count (approx.): 19573
> #
> # Overhead  Command          Shared Object     Symbol
> # ........  ...............  ................  .........................
> #
>    100.00%  qemu-system-x86  [kernel.vmlinux]  [k] kvm_emulate_hypercall
> 
> Out of these 19573 hypercalls, # of page encryption status hcalls are 19479,
> so almost all hypercalls here are page encryption status hypercalls.

Oof.

> The above data indicates that there will be ~2% more Heavyweight VMEXITs
> during SEV guest boot if we do page encryption status hypercalls 
> pass-through to host userspace.
> 
> But, then Brijesh pointed out to me and highlighted that currently
> OVMF is doing lot of VMEXITs because they don't use the DMA pool to minimize the C-bit toggles,
> in other words, OVMF bounce buffer does page state change on every DMA allocate and free.
> 
> So here is the performance analysis after kernel and initrd have been
> loaded into memory using grub and then starting perf just before booting the kernel.
> 
> These are the performance #'s after kernel and initrd have been loaded into memory, 
> then perf is attached and kernel is booted : 
> 
> # Samples: 1M of event 'kvm:kvm_userspace_exit'
> # Event count (approx.): 1081235
> #
> # Overhead  Trace output
> # ........  ........................
> #
>     99.77%  reason KVM_EXIT_IO (2)
>      0.23%  reason KVM_EXIT_MMIO (6)
> 
> # Samples: 1K of event 'kvm:kvm_hypercall'
> # Event count (approx.): 1279
> #
> 
> So as the above data indicates, Linux is only making ~1K hypercalls,
> compared to ~18K hypercalls made by OVMF in the above use case.
> 
> Does the above adds a prerequisite that OVMF needs to be optimized if 
> and before hypercall pass-through can be done ? 

Disclaimer: my math could be totally wrong.

I doubt it's a hard requirement.  Assuming a conversative roundtrip time of 50k
cycles, those 18K hypercalls will add well under a 1/2 a second of boot time.
If userspace can push the roundtrip time down to 10k cycles, the overhead is
more like 50 milliseconds.

That being said, this does seem like a good OVMF cleanup, irrespective of this
new hypercall.  I assume it's not cheap to convert a page between encrypted and
decrypted.

Thanks much for getting the numbers!
