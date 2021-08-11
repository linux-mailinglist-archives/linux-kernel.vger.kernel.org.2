Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4861F3E8E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhHKKNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236879AbhHKKM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:12:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C4E0604AC;
        Wed, 11 Aug 2021 10:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628676750;
        bh=k5j7pTJV1G1/uJTXFNYwXDPkN3zQameqJbn3FuQ+zfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOy5TVoWXDc9sN+JOLfAdHzSnl8kfTevmJIH9ykKKMFBnvnUccg/KhZ1g3/rBa+Sm
         tmujjPQovKdYIZcSEZ45m1SjqWX8l7fu7wZgc5GiyQjvQe+CSQSBhdjrTaxyc/g600
         uI7iz6P47c39LvkTj7w83jbEa/eJ2Kp75peghBgSilGZ8ro4EkfQpqswsgH4sN5vKW
         ug65vqnjPwwXNGhCg0cPlIKE6uKFrtyJgN5eShR57+iQW++NpL5ZCfYahPQb0VZWmZ
         vcYFyK6c6zkQ81NZ24yys7HSZcIZO40nqlQsW16z8+W8IZGz11ijstAUaAdwyN89GB
         iHIDebm/1RodQ==
Date:   Wed, 11 Aug 2021 11:12:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Define ID_AA64MMFR0_TGRAN_2_SHIFT
Message-ID: <20210811101225.GC4426@willie-the-truck>
References: <1628569782-30213-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628569782-30213-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 09:59:42AM +0530, Anshuman Khandual wrote:
> Streamline the Stage-2 TGRAN value extraction from ID_AA64MMFR0 register by
> adding a page size agnostic ID_AA64MMFR0_TGRAN_2_SHIFT. This is similar to
> the existing Stage-1 TGRAN shift i.e ID_AA64MMFR0_TGRAN_SHIFT.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.14-rc5.
> 
>  arch/arm64/include/asm/sysreg.h |  3 +++
>  arch/arm64/kvm/reset.c          | 17 ++---------------
>  2 files changed, 5 insertions(+), 15 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
