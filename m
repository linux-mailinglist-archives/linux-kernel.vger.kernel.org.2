Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F8A32D457
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbhCDNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241384AbhCDNjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:39:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FF4C64F2C;
        Thu,  4 Mar 2021 13:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614865147;
        bh=if92YC9vio4Wnb8KGrOYHJJSJjqsc9o370GPKUYZUkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hmsy7aJYf1pooezRgKSoYG7UiOpJ4DvBb6h3ohC4bVI3IEpgJT1OKDGPBKsu/v5EF
         nYNyd79i7vP6zNnD/A5Bq9F4TMnZWMBajt8XGtq0y5xk7q1xZrbJxQpQX1SUL/O3E2
         0ZyITH9ie9AkxQvTvDw2E8z+eigm7fjJkEV5OyTs0jL5LQMLWZfHCJ42YyHTpFINmf
         C0Y6g98QkSFpFISLc8sbik2kbTKbuwMDxY+4X8x2n8lCYEJMInevvWAFwmMgaJDhI0
         kN1KpXtEtWJKVJBwCtSil93ZkrFeNH/HDJ0cjlcpaeOtiRH6bSCbjD7UNSa4ZMWueU
         GO2ECp/5S3Hng==
Date:   Thu, 4 Mar 2021 13:39:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 04/32] KVM: arm64: Initialize kvm_nvhe_init_params
 early
Message-ID: <20210304133900.GB21229@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-5-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-5-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:34PM +0000, Quentin Perret wrote:
> Move the initialization of kvm_nvhe_init_params in a dedicated function
> that is run early, and only once during KVM init, rather than every time
> the KVM vectors are set and reset.
> 
> This also opens the opportunity for the hypervisor to change the init
> structs during boot, hence simplifying the replacement of host-provided
> page-table by the one the hypervisor will create for itself.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/arm.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
