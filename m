Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A450A426546
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhJHHed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229820AbhJHHea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:34:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6757460F6E;
        Fri,  8 Oct 2021 07:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633678355;
        bh=jtxzHlcmTNymsY/kALU0/B4mdCrJTAMthkX0l84qdgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l52rlqfojlNs4qM/Qvzi+K03jtyq6BmunzzrIMJEWdBul3n5uRgScuUfEBs3jscgv
         dtGvQXsOtZetiUs+Z+RwE3r9N/3jgDUzTXpPg20qQw5/+ecS7Vi4XBzgBc1vydW3TA
         7hlyX6I3Hsr5tt7gt8AFgo6Iks6r3s5KXzCM+jJX6ihqFeIosisd8hcdgtaRGmK9Mr
         pLo9mHFzgWv0znYl/9d8VpwhUpNeWO6avjQ9yG5L2QTChcu8SoMWIBiolyfO8DpuZQ
         H+SzPK01MWHYDlqfjiqZeFOlLWlVaHdUKqNrdXbjusUVIOXXnxoVpAON8pYj0yvMKK
         c4jMVUUqLURKg==
Date:   Fri, 8 Oct 2021 08:32:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        lcherian@marvell.com, coresight@lists.linaro.org
Subject: Re: [PATCH v2 00/17] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <20211008073229.GB32625@willie-the-truck>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tue, Sep 21, 2021 at 02:41:04PM +0100, Suzuki K Poulose wrote:
> This series adds CPU erratum work arounds related to the self-hosted
> tracing. The list of affected errata handled in this series are :
> 
>  * TRBE may overwrite trace in FILL mode
>    - Arm Neoverse-N2	#2139208
>    - Cortex-A710	#211985
> 
>  * A TSB instruction may not flush the trace completely when executed
>    in trace prohibited region.
> 
>    - Arm Neoverse-N2	#2067961
>    - Cortex-A710	#2054223
> 
>  * TRBE may write to out-of-range address
>    - Arm Neoverse-N2	#2253138
>    - Cortex-A710	#2224489
> 
> The series applies on the self-hosted/trbe fixes posted here [0].
> A tree containing both the series is available here [1]

Any chance you could put the arch/arm64/ bits at the start of the series,
please? That way, I can queue them on their own branch which can be shared
with the coresight tree.

Thanks,

Will
