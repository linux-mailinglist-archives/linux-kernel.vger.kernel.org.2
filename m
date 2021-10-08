Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12B1426730
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhJHJy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhJHJy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:54:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72D4F60F93;
        Fri,  8 Oct 2021 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633686781;
        bh=yxEO719H410bfEaxUqcpWIxDNzgp9VnW2l0SEVXbgN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gibCG+VDmRtWSLTug7EvMrTKTzGXI//OEqTO+nqzjjRA+rPJcZV+rT1VgkoOlG3sz
         4vlPpDSoXu1ANea0dYmq7bz1SPiXQBZKotJIOqbsmbJ+Fqrdvb8zwYK8BC3KiW3t7x
         0l5ZJRXmroBMPmRu4CUNYrWp4GRJ5Q+aSK5UdqSiywCpryf7148rV6+Cq5yPLwYNgb
         94bEigJfNwPv1FTTXZckrBXIr7z6DXUAhZU+d/yeiGzKmvKS20CGNLe8PUnJBxN76X
         kBVFn804tyOx+2wgPqB5WrwZqrr6Ccv1EVjm0f1a5Js3pZKNeQC6o8CB3FcbmdTuCT
         29PFp0CnvG9DA==
Date:   Fri, 8 Oct 2021 10:52:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        lcherian@marvell.com, coresight@lists.linaro.org
Subject: Re: [PATCH v2 00/17] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <20211008095255.GA790@willie-the-truck>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20211008073229.GB32625@willie-the-truck>
 <b2527493-d4ca-2c42-eb22-7e8ddbe50279@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2527493-d4ca-2c42-eb22-7e8ddbe50279@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:25:03AM +0100, Suzuki K Poulose wrote:
> Hi Will
> 
> On 08/10/2021 08:32, Will Deacon wrote:
> > Hi Suzuki,
> > 
> > On Tue, Sep 21, 2021 at 02:41:04PM +0100, Suzuki K Poulose wrote:
> > > This series adds CPU erratum work arounds related to the self-hosted
> > > tracing. The list of affected errata handled in this series are :
> > > 
> > >   * TRBE may overwrite trace in FILL mode
> > >     - Arm Neoverse-N2	#2139208
> > >     - Cortex-A710	#211985
> > > 
> > >   * A TSB instruction may not flush the trace completely when executed
> > >     in trace prohibited region.
> > > 
> > >     - Arm Neoverse-N2	#2067961
> > >     - Cortex-A710	#2054223
> > > 
> > >   * TRBE may write to out-of-range address
> > >     - Arm Neoverse-N2	#2253138
> > >     - Cortex-A710	#2224489
> > > 
> > > The series applies on the self-hosted/trbe fixes posted here [0].
> > > A tree containing both the series is available here [1]
> > 
> > Any chance you could put the arch/arm64/ bits at the start of the series,
> > please? That way, I can queue them on their own branch which can be shared
> > with the coresight tree.
> 
> I could move the bits around. I have a question though.
> 
> Will, Catalin, Mathieu,
> 
> The workaround for these errata, at least two of them are
> in the TRBE driver patches. Are we happy with enabling the Kconfig
> entry in the kernel, without the CoreSight patches to implement the work
> around ?

I suppose you could move all the Kconfig changes into their own patch and
stick it right at the end in the Coresight tree.

Will
