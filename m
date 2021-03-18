Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D4340499
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCRL3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:29:41 -0400
Received: from foss.arm.com ([217.140.110.172]:38682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhCRL3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:29:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73110ED1;
        Thu, 18 Mar 2021 04:29:22 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5BAB3F792;
        Thu, 18 Mar 2021 04:29:20 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:29:10 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Tom Saeger <tom.saeger@oracle.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Stone <al.stone@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ahs3@redhat.com, ardb@kernel.org
Subject: Re: [PATCH] Documentation: arm64/acpi : clarify arm64 support of IBFT
Message-ID: <20210318112859.GA25002@e121166-lin.cambridge.arm.com>
References: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
 <20210318104433.GA6959@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318104433.GA6959@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Al, Ard]

On Thu, Mar 18, 2021 at 10:44:33AM +0000, Will Deacon wrote:
> [+Lorenzo]
> 
> On Tue, Mar 16, 2021 at 12:50:41PM -0600, Tom Saeger wrote:
> > In commit 94bccc340710 ("iscsi_ibft: make ISCSI_IBFT dependson ACPI instead
> > of ISCSI_IBFT_FIND") Kconfig was disentangled to make ISCSI_IBFT selection
> > not depend on x86.
> > 
> > Update arm64 acpi documentation, changing IBFT support status from
> > "Not Supported" to "Optional".
> > Opportunistically re-flow paragraph for changed lines.
> > 
> > Link: https://lore.kernel.org/lkml/1563475054-10680-1-git-send-email-thomas.tai@oracle.com/
> > 
> > Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> > ---
> >  Documentation/arm64/acpi_object_usage.rst | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Lorenzo, please could you ack the change below if you're happy with it?
> If so, I can take it as a fix.

I don't see any issue with this patch, more so given that the IBFT
legacy discovery method was decoupled from the ACPI table method,
so it looks sound on ARM64.

However, I would like to get Al and Ard opinions on this to make sure
there is not something I am missing (in particular wrt the rationale
behind the "Not Supported" in the docs).

Lorenzo

> Thanks,
> 
> Will
> 
> > diff --git a/Documentation/arm64/acpi_object_usage.rst b/Documentation/arm64/acpi_object_usage.rst
> > index 377e9d224db0..0609da73970b 100644
> > --- a/Documentation/arm64/acpi_object_usage.rst
> > +++ b/Documentation/arm64/acpi_object_usage.rst
> > @@ -17,12 +17,12 @@ For ACPI on arm64, tables also fall into the following categories:
> >  
> >         -  Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
> >  
> > -       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IORT,
> > -          MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO,
> > -	  TCPA, TPM2, UEFI, XENV
> > +       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IBFT,
> > +          IORT, MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT,
> > +          STAO, TCPA, TPM2, UEFI, XENV
> >  
> > -       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT,
> > -          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
> > +       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT, MSDM, OEMx,
> > +          PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
> >  
> >  ====== ========================================================================
> >  Table  Usage for ARMv8 Linux
> > -- 
> > 2.31.0
> > 
