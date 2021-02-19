Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E131FE63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhBSRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhBSRxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:53:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99C2364ED9;
        Fri, 19 Feb 2021 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613757146;
        bh=mn9kn5Bs6DUDViauax7d710EWCSTYspffhf6L+06LIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzJ+FvVBQdPVf1lj9RM113HrwU01U1xj2WtvxuSkI4qgGUg2Ivrgg9zoYHe5aOwGE
         /AXWl68s6fAYoZZAnH/3ZPxYleclaytuzBtAc9lf4q8Da1Fu9HnnxAH+ZdMCfM0+Xo
         iIBz8iepMfnUTRTiDQf6waJbc15RFxaz79CNUupt4d7t2cMc0m8CCD161pYPY/Xx3i
         LRLVR1ZFAhb4pRqnChY5RZC59L8eLdKwQ/Sh1Jr0oZIgE+8VXGT1a02DUb27ekyB9i
         eerllH9Bnk8SKM7/fk5EhrLXisY5A4++EC9I4AYM7GRNSy7ePRAVWF51oCl3da0ba7
         ZMSTYn8NhuUsQ==
Date:   Fri, 19 Feb 2021 17:52:21 +0000
From:   Will Deacon <will@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     catalin.marinas@arm.com, saiprakash.ranjan@codeaurora.org,
        robh@kernel.org, konrad.dybcio@somainline.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Add part number for Arm Cortex-A78
Message-ID: <20210219175220.GB6352@willie-the-truck>
References: <1613580251-12694-1-git-send-email-neeraju@codeaurora.org>
 <20210217170612.GA4254@willie-the-truck>
 <c43d8eed-2665-9e9b-c6b5-799b5281c657@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43d8eed-2665-9e9b-c6b5-799b5281c657@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 11:37:04PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 2/17/2021 10:36 PM, Will Deacon wrote:
> > On Wed, Feb 17, 2021 at 10:14:11PM +0530, Neeraj Upadhyay wrote:
> > > Add the MIDR part number info for the Arm Cortex-A78.
> > > 
> > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > ---
> > >   arch/arm64/include/asm/cputype.h | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> > > index ef5b040..3aced88 100644
> > > --- a/arch/arm64/include/asm/cputype.h
> > > +++ b/arch/arm64/include/asm/cputype.h
> > > @@ -72,6 +72,7 @@
> > >   #define ARM_CPU_PART_CORTEX_A76		0xD0B
> > >   #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
> > >   #define ARM_CPU_PART_CORTEX_A77		0xD0D
> > > +#define ARM_CPU_PART_CORTEX_A78		0xD41
> > >   #define APM_CPU_PART_POTENZA		0x000
> > > @@ -109,6 +110,7 @@
> > >   #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
> > >   #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
> > >   #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
> > > +#define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
> > >   #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
> > >   #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
> > >   #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
> > 
> > This usually means there's an erratum to work around. What are you hiding ;)
> > 
> > Will
> > 
> 
> :) . This is needed for supporting implementation defined AMU counters in
> A78 [1]. However, there is no upstream user of it.

I don't think we should add this upstream without a user.

Will
