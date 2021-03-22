Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49E343FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCVL1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhCVL1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C85F6191F;
        Mon, 22 Mar 2021 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616412467;
        bh=2rQCKuAt/izeJLTYF4MTljlVoBabkTjdYFUOiQ846kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCdtEo/cGqar4OAPPbwzZ28D6YUm9xkGkk1tyTKkmhP5BD0PvzRwzSgkiCBHJAHi3
         0Oi+rd9f0hcStg2vT2O9d7ZbUfYzXiJdeqZcXb9Ep/TxIScPofF1zjqC16ZAlJeIxt
         QsT72YQmboZA/spmbvmXpElGMuaRW9TfpgpoP5EL2NSZNf8MFAJYAM98BddOjwfg2f
         C1oL7A2WJbicW71oOLiWXHvVnxBpNesdUlv2Gek+l4o+2ydE6+/ijgQs+EiILfSYm+
         lPzMM8JFbFyGUpV+oX40F9xnPg1R8+0vIof9WNSw2uQxt47WjJFWBpJdWbMGLtz9xw
         1NDgNzSETgyYg==
Date:   Mon, 22 Mar 2021 11:27:41 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v6 29/38] KVM: arm64: Use page-table to track page
 ownership
Message-ID: <20210322112741.GC10318@willie-the-truck>
References: <20210319100146.1149909-1-qperret@google.com>
 <20210319100146.1149909-30-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319100146.1149909-30-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:01:37AM +0000, Quentin Perret wrote:
> As the host stage 2 will be identity mapped, all the .hyp memory regions
> and/or memory pages donated to protected guestis will have to marked
> invalid in the host stage 2 page-table. At the same time, the hypervisor
> will need a way to track the ownership of each physical page to ensure
> memory sharing or donation between entities (host, guests, hypervisor) is
> legal.
> 
> In order to enable this tracking at EL2, let's use the host stage 2
> page-table itself. The idea is to use the top bits of invalid mappings
> to store the unique identifier of the page owner. The page-table owner
> (the host) gets identifier 0 such that, at boot time, it owns the entire
> IPA space as the pgd starts zeroed.
> 
> Provide kvm_pgtable_stage2_set_owner() which allows to modify the
> ownership of pages in the host stage 2. It re-uses most of the map()
> logic, but ends up creating invalid mappings instead. This impacts
> how we do refcount as we now need to count invalid mappings when they
> are used for ownership tracking.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h |  20 +++++
>  arch/arm64/kvm/hyp/pgtable.c         | 126 ++++++++++++++++++++++-----
>  2 files changed, 122 insertions(+), 24 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
