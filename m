Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5583A0596
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhFHVQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhFHVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:16:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52E3660FD8;
        Tue,  8 Jun 2021 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623186852;
        bh=G2smJxvAvuJyR2PVlfkCgvduPlzSv6hHhHX7NFNY20I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FSXWgxmd8Uuly+8F/DNMxKu28peM0aEDJWzKxZhCGVBW3OFtmBlFiFDRnIaxVwEjp
         U+bMQ8ZGcX8xc9CsXU0xGdx9cw1evm79PHu5nuqSh5775dEpcL/aIdLs0/8ZpVRs0n
         pieXRb46jjM8WiXkFPegtAY9/fQA7BshRhnEuDpc=
Date:   Tue, 8 Jun 2021 14:14:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Young <dyoung@redhat.com>, Boris Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crash_core, vmcoreinfo: Append 'SECTION_SIZE_BITS' to
 vmcoreinfo
Message-Id: <20210608141410.0026a925ba3a609b0dd4e560@linux-foundation.org>
In-Reply-To: <20210608142432.GA587883@MiWiFi-R3L-srv>
References: <20210608103359.84907-1-kernelfans@gmail.com>
        <20210608142432.GA587883@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 22:24:32 +0800 Baoquan He <bhe@redhat.com> wrote:

> On 06/08/21 at 06:33am, Pingfan Liu wrote:
> > As mentioned in kernel commit 1d50e5d0c505 ("crash_core, vmcoreinfo:
> > Append 'MAX_PHYSMEM_BITS' to vmcoreinfo"), SECTION_SIZE_BITS in the
> > formula:
> >     #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> > 
> > Besides SECTIONS_SHIFT, SECTION_SIZE_BITS is also used to calculate
> > PAGES_PER_SECTION in makedumpfile just like kernel.
> > 
> > Unfortunately, this arch-dependent macro SECTION_SIZE_BITS changes, e.g.
> > recently in kernel commit f0b13ee23241 ("arm64/sparsemem: reduce
> > SECTION_SIZE_BITS"). But user space wants a stable interface to get this
> > info. Such info is impossible to be deduced from a crashdump vmcore.
> > Hence append SECTION_SIZE_BITS to vmcoreinfo.
> 
> ...
>
> Add the discussion of the original thread in kexec ML for reference:
> http://lists.infradead.org/pipermail/kexec/2021-June/022676.html

I added a Link: for this.
 
> This looks good to me.
> 
> Acked-by: Baoquan He <bhe@redhat.com>

I'm thinking we should backport this at least to Fixes:f0b13ee23241. 
But perhaps it's simpler to just backport it as far as possible, so I
added a bare cc:stable with no Fixes:.  Thoughts?
