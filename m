Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4A43345E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhJSLHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235513AbhJSLHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:07:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E0F760C4C;
        Tue, 19 Oct 2021 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634641492;
        bh=tEZ51GfXQpwAyDguBNgyD6QxHphRkSWmZbEHqsLaEto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+J+ad581PmIK9B+MC2LwTg7ydgeXcOpOwUZHIzkC+svaS59i2algUd4l7vUzhSSa
         XupH4Y/uvVNg7dKBYtfoEKd5YtOllmJ2EBIw503mEUmsY+j3lvbKCUryC7eSAwgOaI
         TyZJmQVfUCyESAMNbqaX/L1qvfDr0bTGo8KrsG/5Wa9fjuxECgkeXMHSw1LriUCHrF
         SLyRRJZ8DtVUZ1qi/Qw6+P0uFSQyEjuLUXElfAqQ3e2wDB/6x+YJ2h+m6Ck09ut2co
         eZWPwL8p+s9bZjkBK2dWPHeKU5PFQQzM1tDoxM9i9BGa1x1ut/vGS4NhIeicfobUeg
         JZu0NAWxDHgYw==
Date:   Tue, 19 Oct 2021 12:04:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 02/15] arm64: errata: Add detection for TRBE overwrite
 in FILL mode
Message-ID: <20211019110443.GE13251@willie-the-truck>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014223125.2605031-3-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:31:12PM +0100, Suzuki K Poulose wrote:
> Arm Neoverse-N2 and the Cortex-A710 cores are affected
> by a CPU erratum where the TRBE will overwrite the trace buffer
> in FILL mode. The TRBE doesn't stop (as expected in FILL mode)
> when it reaches the limit and wraps to the base to continue
> writing upto 3 cache lines. This will overwrite any trace that
> was written previously.
> 
> Add the Neoverse-N2 erratumi(#2139208) and Cortex-A710 erratum
> (#2119858) to the  detection logic.

Weird typo and double space in this sentence.

Will
