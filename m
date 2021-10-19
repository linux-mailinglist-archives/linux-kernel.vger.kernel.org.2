Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8A4333BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhJSKo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhJSKo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:44:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B071560F6E;
        Tue, 19 Oct 2021 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634640134;
        bh=LNhk+kfizD7KdFsuEL+4FeltuKz6GQ3BPx00Cy56/XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awAIipdkHsfIFTT6mJ4KJH2W7BlaCT5m5gLdaSOMlY7HZcMSf00V/A+KrwzTjA1qB
         clutAPTfwN/QgF/2z+qEJYwPIZI/lM0tgH3TiQS/ANItwS26nClnk5T47Dlv5RMPTj
         0UvdHtDid7AgYtVq/n4FXSWxxzUxlIDMqFZxVJ6XPWjm2BYgU2VyABO8GkiJEvXb5F
         zH+HHByJu29V5ELzj3o3VoG0pDxylXll0j3OeIH43pL4vwzmRZn373a8Q9mnNwMCf6
         3AV5Ey8uacCemZqrD+V8u4tyThdV5c5FPqZdtNdc9pTDt6g/Jj/JY7HqqwEVsIaNaZ
         w/JHEHNSelXKg==
Date:   Tue, 19 Oct 2021 11:42:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/15] arm64: errata: Enable workaround for TRBE
 overwrite in FILL mode
Message-ID: <20211019104207.GB13251@willie-the-truck>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-15-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014223125.2605031-15-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:31:24PM +0100, Suzuki K Poulose wrote:
> With the workaround enabled in TRBE, enable the config entries
> to be built without COMPILE_TEST
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
