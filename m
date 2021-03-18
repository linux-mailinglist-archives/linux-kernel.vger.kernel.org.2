Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366153403BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCRKor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhCRKoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:44:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0169C64F3B;
        Thu, 18 Mar 2021 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616064279;
        bh=1wFwF4VmWJoYRcMM00vbE2GRjaZ3NZEyo2k1k1yxUKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLLKnym4TvfswwMVZqQ434uKjDQyFQMbCIaXVaEPpPnziV0DpriH0B0oOJQakv4l2
         UQDwx3sx2FfAYvEZu7evlvWJDQdt2qLuA7oFeLXEqQUz4OKo3eVq+dSvcblE4Ms+R1
         9NptfnK5hSp9FBgB/j1v+NuhYbOA6ZhuW9tgA6CkSjKkER3j+1LadOmgNOVXuXyqbA
         v3vWKdIgKyDS8nCf3C48rO7Sj4DYdNlItNztyI0q5egDE3jW8lUgq4gDmVbcoQwLS1
         YK2loDs/EX2m3YLp61kNXVivXLh4pUzZdcNhhoXzOZ7dHTx/wW/0UwxGeVwixNMI5G
         3GxFnWoNucoAg==
Date:   Thu, 18 Mar 2021 10:44:33 +0000
From:   Will Deacon <will@kernel.org>
To:     Tom Saeger <tom.saeger@oracle.com>, lorenzo.pieralisi@arm.com
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Al Stone <al.stone@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm64/acpi : clarify arm64 support of IBFT
Message-ID: <20210318104433.GA6959@willie-the-truck>
References: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9efc652df2b8d6b53d9acb170eb7c9ca3938dfef.1615920441.git.tom.saeger@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Lorenzo]

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

Lorenzo, please could you ack the change below if you're happy with it?
If so, I can take it as a fix.

Thanks,

Will

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
