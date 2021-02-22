Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E90A321A37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBVOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:22:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhBVOAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:00:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AC4E64E74;
        Mon, 22 Feb 2021 13:59:55 +0000 (UTC)
Date:   Mon, 22 Feb 2021 13:59:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, Linu Cherian <lcherian@marvell.com>,
        mike.leach@linaro.org
Subject: Re: [PATCH V2 07/11] arm64: Add TRBE definitions
Message-ID: <20210222135952.GC19604@arm.com>
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-8-git-send-email-anshuman.khandual@arm.com>
 <20210222135552.GB19604@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222135552.GB19604@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 01:55:52PM +0000, Catalin Marinas wrote:
> On Wed, Jan 13, 2021 at 09:48:14AM +0530, Anshuman Khandual wrote:
> > This adds TRBE related registers and corresponding feature macros.
> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Ah, ignore this. I seem to have already acked v3:

https://lore.kernel.org/r/20210128171822.GB29183@gaia

-- 
Catalin
