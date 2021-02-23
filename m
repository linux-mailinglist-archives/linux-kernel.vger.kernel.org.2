Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD643227FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhBWJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231163AbhBWJqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:46:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE32F64E02;
        Tue, 23 Feb 2021 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614073537;
        bh=XDJd7zq5mb1m5QRiGL2lhuuFScDU1SW3A46RMF1gAyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxxntdcwJQo8anl3xwIhP0TfBMox1WV2Tr1Zlm1ybgRfXvBUwdVda4+oTnJPWlrvI
         9dR+lsEVwLi4oiTRnnm5FQsjVo4e8eVyw7o8dG3vO9wy4w5qmX/rikAxK61DdQ3Hg1
         eOkN/pc8kIR1u6tAgFlc2euaAJjECabTRnK8dcboXgPDtGzDusStEXGbX9ug2o1Jp1
         ZvNk/jNpqrif/+mwixb+50uinPuVdQ53/ZAlCEEDFBpacOK/ayTxXFteIN6/5XoOAx
         K29V/pj+cqjJo2hHAtU4my6oHIZJDB1FnUSpMau+AEQmIvxDSIHBNVktAlrxPllvUS
         GY3E+lCGScwBw==
Date:   Tue, 23 Feb 2021 09:45:32 +0000
From:   Will Deacon <will@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     james.morse@arm.com, jmorris@namei.org,
        tyhicks@linux.microsoft.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        kernel-team@android.com
Subject: Re: [PATCH v2] kexec: move machine_kexec_post_load() to public
 interface
Message-ID: <20210223094531.GA10254@willie-the-truck>
References: <20210219195142.13571-1-pasha.tatashin@soleen.com>
 <161399720788.2051103.17455817952511939013.b4-ty@kernel.org>
 <m1im6jmki1.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1im6jmki1.fsf@fess.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 11:16:38PM -0600, Eric W. Biederman wrote:
> Will Deacon <will@kernel.org> writes:
> 
> > On Fri, 19 Feb 2021 14:51:42 -0500, Pavel Tatashin wrote:
> >> machine_kexec_post_load() is called after kexec load is finished. It must
> >> declared in public header not in kexec_internal.h
> >> 
> >> Fixes the following compiler warning:
> >> 
> >> arch/arm64/kernel/machine_kexec.c:62:5: warning: no previous prototype for
> >> function 'machine_kexec_post_load' [-Wmissing-prototypes]
> >>    int machine_kexec_post_load(struct kimage *kimage)
> >
> > Applied to arm64 (for-next/fixes), thanks!
> >
> > [1/1] kexec: move machine_kexec_post_load() to public interface
> >       https://git.kernel.org/arm64/c/2596b6ae412b
> 
> As you have already applied this it seems a bit late,
> but I will mention that change could legitimately have the following
> tag.
> 
> Fixes: de68e4daea90 ("kexec: add machine_kexec_post_load()")
> 
> So far arm64 is the only implementation of that hook.

I added 'Fixes: 4c3c31230c91 ("arm64: kexec: move relocation function
setup")' when I applied the patch, so at least it's clearly marked as a
fix.

Will
