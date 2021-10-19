Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6997C4333C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhJSKox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234955AbhJSKos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:44:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CFE36113D;
        Tue, 19 Oct 2021 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634640155;
        bh=tvotoiogVbvu3iu5GXzxolttFF7sERBoYG0umB8B4oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQhgj8BlxzKyfk/bZvkY5dXEihWBz/52lsUJHqjujmrA/JXtYu2H9bL+hnRX4t8LA
         fjOaeDKfPyOa5qx/g3xW0rbGdaV6DaIdhB6M4oaJ231VGRZR6D0C4fXA/uj4hjO3tL
         XytuEdgAK/zOYqXMUo26tU5B27NMnATYNopY2JuiV+4WnGA78qdJZnxNcgyryUQSdK
         q91n546j1SlLRBepFszaCPWMQvsKzyzI1icfpDgmFaGz72/hF/Jlhc+pz1nV5itF14
         gmLEH+LSvZQKmHEUYthb0ITBXHaMBVSmmPWV8BBh/5VSEQbwVXu+GWnPA9iny1pR+L
         efyq9DhKbEKfQ==
Date:   Tue, 19 Oct 2021 11:42:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/15] arm64: errata: Enable TRBE workaround for write
 to out-of-range address
Message-ID: <20211019104229.GC13251@willie-the-truck>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-16-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014223125.2605031-16-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:31:25PM +0100, Suzuki K Poulose wrote:
> With the TRBE driver workaround available, enable the config symbols
> to be built without COMPILE_TEST
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
