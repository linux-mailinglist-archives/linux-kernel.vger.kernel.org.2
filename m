Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA37E30DEEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhBCP6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:58:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234674AbhBCPz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:55:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 869C864F5D;
        Wed,  3 Feb 2021 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612367696;
        bh=0tzbGa7brGsNplQvhjfRaT8HNbr8dBf5jGW+q18QilI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNUyz+DjH/CsemTHfyE2WSJE+eJF1poA9n+9wSxhXQY+OFFoupu0EG08WSs7jBMxu
         zqVAme/SKvOmhtWQEyCaxE4bvDnhM6w9YioSV3fxxMqLm1ivyYIXLorunEQEZ8JQ4a
         L2YDYGm22GqyVYxFdlBI3lWGnr+ZaCqOwkfGs/KMu2EckoiPv7BNZu6gvVkcm24w3A
         qbG3jzGrbroCrHheg9cSQcQi8KN9urnDOcMS3IzLnQKEmWUo9H0yXnJjX5AsbyIWSI
         O8acyg89I/lswmaVlw9ZELJqjwVbb7eNwd4bGktqh5M7wgH5wHpwRB3XnX/GP8xBTN
         XyH2LemCf0jaA==
Date:   Wed, 3 Feb 2021 15:54:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 22/26] KVM: arm64: Refactor __load_guest_stage2()
Message-ID: <20210203155449.GF18974@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-23-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-23-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:20PM +0000, Quentin Perret wrote:
> Refactor __load_guest_stage2() to introduce __load_stage2() which will
> be re-used when loading the host stage 2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
