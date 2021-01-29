Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07841308F94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhA2VoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhA2VoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 16:44:08 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA77FC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:43:28 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w124so11506846oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pJFTtbp78s6l8/8Izrug7SmVLFzi2C0SNCS/3swOQlk=;
        b=AOGMynuRP0HLSl9DVel1k6yStOZ+jYsNI3yWKS396B+Iu6QthkKL/RTQU3TxR1scTP
         ZZ24fHBk3xkIRUPML/5/SUxVLnfN2EuIyFpxnkPQnyM+1x4anOadDRW+xTAcdCsux5ci
         h35wzP3K2LdauWrSd3asljrwny/5yEffJBvh2g3/e97acK1GQ4d2dKV3kyoAX4vEMnCX
         sEshkG76g62VtyQ+grOEmAawbGSClV/ikjO0qJJVDZb0gM16drzy/WDvbZpiRVNAAah5
         iRVAbXhWsZOW2icsc+cinnIgwT3l+lg4NpS8I/1Hoetu/4gbfTV1pVuZ5jguqFXL3I2y
         dLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pJFTtbp78s6l8/8Izrug7SmVLFzi2C0SNCS/3swOQlk=;
        b=G1T+4WA8UThM3/8DG8svisZhFxYcrQ+jgizTbTTf+6Wkpy9XM3GMaH4dzzaCCAp8id
         6KtNvQ2/ljp4eHLBzKAHyutbm0k/riVRZ0L1Ho+khnebiuS0q+DZ68qCfk2G8vq0irZW
         TKuix0GB1fMQPjwZpqO9Z2+dzUQ0rCQpObgS+lmYNoRCNj5cZHXbkjdlNuoskjuGqVWN
         04rFD3eMGADeniz2q94WESYQGA8MAygite3MnxPFhCHXVrlxMkL/KH9aVSrAtbGIbDLf
         UAcyFBgVPjme4yzjnJL5jA7XzlHl4zg5wTtI1kOAQq8M7523OU75VNeMxP96//nguEE0
         rLhg==
X-Gm-Message-State: AOAM531xFVkwLl/ETmejW98NJfmwlt79r5APYGWWL0ncOI99006g6RhV
        MVjG7KLWYDG19kgrHEcrYME=
X-Google-Smtp-Source: ABdhPJw7skXN9mjPf9Y9H4ILbI8XIkomeQ4ufQeW5J8yB7+84CtXcV+SmEKqncZMbsH3rb7oQA32dA==
X-Received: by 2002:aca:bcc2:: with SMTP id m185mr3819675oif.146.1611956608143;
        Fri, 29 Jan 2021 13:43:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x141sm2635428oia.3.2021.01.29.13.43.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jan 2021 13:43:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 29 Jan 2021 13:43:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v2 4/8] KVM: arm64: Generate hyp relocation data
Message-ID: <20210129214325.GA195322@roeck-us.net>
References: <20210105180541.65031-1-dbrazdil@google.com>
 <20210105180541.65031-5-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105180541.65031-5-dbrazdil@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 05, 2021 at 06:05:37PM +0000, David Brazdil wrote:
> Add a post-processing step to compilation of KVM nVHE hyp code which
> calls a custom host tool (gen-hyprel) on the partially linked object
> file (hyp sections' names prefixed).
> 
> The tool lists all R_AARCH64_ABS64 data relocations targeting hyp
> sections and generates an assembly file that will form a new section
> .hyp.reloc in the kernel binary. The new section contains an array of
> 32-bit offsets to the positions targeted by these relocations.
> 
> Since these addresses of those positions will not be determined until
> linking of `vmlinux`, each 32-bit entry carries a R_AARCH64_PREL32
> relocation with addend <section_base_sym> + <r_offset>. The linker of
> `vmlinux` will therefore fill the slot accordingly.
> 
> This relocation data will be used at runtime to convert the kernel VAs
> at those positions to hyp VAs.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>

This patch results in the following error for me.

error: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o: assertion elf.ehdr->e_ident[5] == 1 failed (lhs=2, rhs=1, line=250)

The problem is seen when trying to build aarch64 images in big endian
mode.

Te script used to reproduce the problem as well as bisect results are
attached.

Guenter

---
Script used to reproduce the problem:

make-arm64 allmodconfig
echo "CONFIG_CPU_BIG_ENDIAN=y" >> .config
make-arm64 olddefconfig

rm -f arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o
make-arm64 -j arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o

where make-arm64 is:

make -j32 ARCH=arm64 CROSS_COMPILE=aarch64-linux- $*

---
# bad: [b01f250d83f6c3af5c77699dd14e7b48ee0b5383] Add linux-next specific files for 20210129
# good: [6ee1d745b7c9fd573fba142a2efdad76a9f1cb04] Linux 5.11-rc5
git bisect start 'HEAD' 'v5.11-rc5'
# good: [7b7f6e418b7121fd3f05029f843ff1eb76e4cc4d] Merge remote-tracking branch 'crypto/master'
git bisect good 7b7f6e418b7121fd3f05029f843ff1eb76e4cc4d
# good: [4a8b64f4e85b5f2d8e68641ce26af8cf9d9a66af] Merge remote-tracking branch 'keys/keys-next'
git bisect good 4a8b64f4e85b5f2d8e68641ce26af8cf9d9a66af
# bad: [79a914d7f707c1aa5ede7ce38588b32093b2abbe] Merge remote-tracking branch 'thunderbolt/next'
git bisect bad 79a914d7f707c1aa5ede7ce38588b32093b2abbe
# good: [f22712067d6f3d1884186509a942da26d2d52166] Merge remote-tracking branch 'rcu/rcu/next'
git bisect good f22712067d6f3d1884186509a942da26d2d52166
# bad: [4a42e6b0a53bcc4b58a35b8d5df50581e94b1daa] Merge remote-tracking branch 'usb/usb-next'
git bisect bad 4a42e6b0a53bcc4b58a35b8d5df50581e94b1daa
# good: [1a9e38cabd80356ffb98c2c88fec528ea9644fd5] usb: dwc2: Make "trimming xfer length" a debug message
git bisect good 1a9e38cabd80356ffb98c2c88fec528ea9644fd5
# bad: [589e25c6dfdd535e8eba052f7314054f6d75be4a] Merge remote-tracking branch 'drivers-x86/for-next'
git bisect bad 589e25c6dfdd535e8eba052f7314054f6d75be4a
# bad: [08c11d16ca91e770de81e5959e22eb34541f8af9] Merge remote-tracking branch 'percpu/for-next'
git bisect bad 08c11d16ca91e770de81e5959e22eb34541f8af9
# bad: [cc6d8fa3667aa5513dc2bbca896a4c287aa956f3] Merge branch 'kvm-arm64/misc-5.12' into kvmarm-master/next
git bisect bad cc6d8fa3667aa5513dc2bbca896a4c287aa956f3
# bad: [247bc166e6b3b1e4068f120f55582a3aa210cc2d] KVM: arm64: Remove hyp_symbol_addr
git bisect bad 247bc166e6b3b1e4068f120f55582a3aa210cc2d
# bad: [8c49b5d43d4c45ca0bb0d1faa23feef2e76e89fa] KVM: arm64: Generate hyp relocation data
git bisect bad 8c49b5d43d4c45ca0bb0d1faa23feef2e76e89fa
# good: [16174eea2e4fe8247e04c17da682f2034fec0369] KVM: arm64: Set up .hyp.rodata ELF section
git bisect good 16174eea2e4fe8247e04c17da682f2034fec0369
# good: [f7a4825d9569593b9a81f0768313b86175691ef1] KVM: arm64: Add symbol at the beginning of each hyp section
git bisect good f7a4825d9569593b9a81f0768313b86175691ef1
# first bad commit: [8c49b5d43d4c45ca0bb0d1faa23feef2e76e89fa] KVM: arm64: Generate hyp relocation data
