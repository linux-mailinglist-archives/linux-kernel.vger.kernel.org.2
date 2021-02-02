Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C130BD49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBBLkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhBBLkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:40:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8CCA64E34;
        Tue,  2 Feb 2021 11:39:35 +0000 (UTC)
Date:   Tue, 2 Feb 2021 11:39:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESENT PATCH] arm64: cpuinfo: Add "model name" in /proc/cpuinfo
 for 64bit tasks also
Message-ID: <20210202113932.GB26895@gaia>
References: <20210201235809.401-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201235809.401-1-cnsztl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 07:58:09AM +0800, Tianling Shen wrote:
> From: Sumit Gupta <sumitg@nvidia.com>
> 
> Removed restriction of displaying model name for 32 bit tasks only.
> This can be used for 64 bit tasks as well, and it's useful for some
> tools that already parse this, such as coreutils `uname -p`, Ubuntu
> model name display etc.
> 
> It should be like this:
> ```
> $ cat '/proc/cpuinfo' | grep 'model name' | head -n 1
> model name : ARMv8 Processor rev X (v8l)
> ```
> 
> Link: https://lore.kernel.org/lkml/1472461345-28219-1-git-send-email-sumitg@nvidia.com/

The thread above already has arguments against this patch. Has anything
changed since?

-- 
Catalin
