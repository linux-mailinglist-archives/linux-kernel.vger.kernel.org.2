Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5D343FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhCVLe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:34:27 -0400
Received: from foss.arm.com ([217.140.110.172]:58026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhCVLeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:34:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B83C81063;
        Mon, 22 Mar 2021 04:33:59 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B9493F718;
        Mon, 22 Mar 2021 04:33:58 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:33:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Stone <al.stone@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm64/acpi : clarify arm64 support of IBFT
Message-ID: <20210322113353.GA10630@e121166-lin.cambridge.arm.com>
References: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:50:41PM -0600, Tom Saeger wrote:
> In commit 94bccc340710 ("iscsi_ibft: make ISCSI_IBFT dependson ACPI instead
> of ISCSI_IBFT_FIND") Kconfig was disentangled to make ISCSI_IBFT selection
> not depend on x86.
> 
> Update arm64 acpi documentation, changing IBFT support status from
> "Not Supported" to "Optional".
> Opportunistically re-flow paragraph for changed lines.
> 
> Link: https://lore.kernel.org/lkml/1563475054-10680-1-git-send-email-thomas.tai@oracle.com/
> 
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> ---
>  Documentation/arm64/acpi_object_usage.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/Documentation/arm64/acpi_object_usage.rst b/Documentation/arm64/acpi_object_usage.rst
> index 377e9d224db0..0609da73970b 100644
> --- a/Documentation/arm64/acpi_object_usage.rst
> +++ b/Documentation/arm64/acpi_object_usage.rst
> @@ -17,12 +17,12 @@ For ACPI on arm64, tables also fall into the following categories:
>  
>         -  Recommended: BERT, EINJ, ERST, HEST, PCCT, SSDT
>  
> -       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IORT,
> -          MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT, STAO,
> -	  TCPA, TPM2, UEFI, XENV
> +       -  Optional: BGRT, CPEP, CSRT, DBG2, DRTM, ECDT, FACS, FPDT, IBFT,
> +          IORT, MCHI, MPST, MSCT, NFIT, PMTT, RASF, SBST, SLIT, SPMI, SRAT,
> +          STAO, TCPA, TPM2, UEFI, XENV
>  
> -       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IBFT, IVRS, LPIT,
> -          MSDM, OEMx, PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
> +       -  Not supported: BOOT, DBGP, DMAR, ETDT, HPET, IVRS, LPIT, MSDM, OEMx,
> +          PSDT, RSDT, SLIC, WAET, WDAT, WDRT, WPBT
>  
>  ====== ========================================================================
>  Table  Usage for ARMv8 Linux
> -- 
> 2.31.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
