Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E44D32F367
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhCETCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:32768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCETCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:02:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43CA96509A;
        Fri,  5 Mar 2021 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614970932;
        bh=+HY4tyg5MEsNmrtevimpEfoDy4PsjuAzV42+G/FLMVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0cXkUhfqGyQIPH14jJKrVOWqS+nkTdjAw7+FncqA/3JiGVSK+/buLmQR5CPX0Lkh
         dCW7dcorA8Yx48N9S2h9g8R6GdPZXZYvGcN7K0Y5c7YEU2XCqb+THvNf39KKmGJPvg
         7SlguW8KOncXG2JrcnBGVpunFHsss2GoyrMFKsQFZP5J3xQ2z4EDXBStFAxnJPxUzg
         aey5TwsRQzPpuo0eVRH2m/iUb2g8ydUomIz9TElX1hpK5ZM3qVToNjiQU/XknJ3DEC
         KaxOe0sr57aCvtJqjnsfjIielTW4HTsR6GLfySdzgt5AgvwD20BCAzORpz6fubBLwx
         lvJZ9Wwx+U9Wg==
Date:   Fri, 5 Mar 2021 19:02:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 31/32] KVM: arm64: Disable PMU support in protected
 mode
Message-ID: <20210305190205.GA23633@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-32-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-32-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 03:00:01PM +0000, Quentin Perret wrote:
> The host currently writes directly in EL2 per-CPU data sections from
> the PMU code when running in nVHE. In preparation for unmapping the EL2
> sections from the host stage 2, disable PMU support in protected mode as
> we currently do not have a use-case for it.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/perf.c | 3 ++-
>  arch/arm64/kvm/pmu.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
