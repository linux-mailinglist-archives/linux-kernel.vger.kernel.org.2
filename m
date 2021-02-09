Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271B3314EE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhBIMX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:23:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhBIMXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:23:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFB4664EB4;
        Tue,  9 Feb 2021 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612873390;
        bh=L+CvYP2l7yxFcu390LciJ5wzeQ4zlYr5y+5yTYVenYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LDSUx5Wy/6WXXiafzKEK/f2JAMCSwNDd8U9cvhpFPM6vk0Mg9SCYWzpf41Fw00BNT
         NuiGBA6Fxs4ZBiRYT7xF28QYktSPLVTV0Qu9MxT9SFh35axTZGqekyQrTtRkIhOFPC
         2N8+Re1ScL4ZFotJE4gNLw/5KZo5FqGXIG6S8nyCGVQFwe46xsZbi275T6tRngYX5o
         635JJP4Nh2sRTaUfygmLKAzzXF3EPHnWdUjwgzQL/tGfUYXzpHENg6mtfhmzfYCnCz
         aElTv+gkpGxAPFlb6u8nxWqDH9daBoPGppZZbCziF4YVldt+9Eev+4UKyrY9o5VhAo
         jPRrXPoki0DnQ==
Date:   Tue, 9 Feb 2021 12:23:04 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 16/26] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20210209122303.GA27058@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-17-qperret@google.com>
 <20210203143709.GA18907@willie-the-truck>
 <YBvQrHdbiNTSLQq6@google.com>
 <YCJdPXuGr9kCIKVM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCJdPXuGr9kCIKVM@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:00:29AM +0000, Quentin Perret wrote:
> On Thursday 04 Feb 2021 at 10:47:08 (+0000), Quentin Perret wrote:
> > On Wednesday 03 Feb 2021 at 14:37:10 (+0000), Will Deacon wrote:
> > > > +static void handle___pkvm_init(struct kvm_cpu_context *host_ctxt)
> > > > +{
> > > > +	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
> > > > +	DECLARE_REG(unsigned long, size, host_ctxt, 2);
> > > > +	DECLARE_REG(unsigned long, nr_cpus, host_ctxt, 3);
> > > > +	DECLARE_REG(unsigned long *, per_cpu_base, host_ctxt, 4);
> > > > +
> > > > +	cpu_reg(host_ctxt, 1) = __pkvm_init(phys, size, nr_cpus, per_cpu_base);
> > > 
> > > __pkvm_init() doesn't return, so I think this assignment back into host_ctxt
> > > is confusing.
> > 
> > Very good point, I'll get rid of this.
> 
> Actually not, I think I'll leave it like that. __pkvm_init can return an
> error, which is why I did this in the first place And it is useful for
> debugging to have it propagated back to the host.

Good point, but please add a comment!

Will
