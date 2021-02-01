Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84230AE58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhBARrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232384AbhBARrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:47:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01F2964E2A;
        Mon,  1 Feb 2021 17:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612201604;
        bh=+LG8JJC83lkhV2mXkT0DrcP7GWmpNTMsT8hay1pPWhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lq8FUTr3dPjyr2lA53+NzwaAZ6xMno3oS9wye3cjVCTF7C0RP9XfAL0ZeQUECfH6M
         yRg6/JVHBih3p+LNNdST5NXyG4iQ/m3iyVYdnjDiSO3Htunc2NRf6NayMm4Ol9IiRT
         ekz7ClGHRYPHXBi4zcf1xXUfMDmlMylwk4YCUjYDSV8h7/XcHphODxoH2SIdJNwmeL
         DheBNhjve/Xx7i6XU7JPzDHuxojj9NNodM0vbjzqojXInQtfyv+n4V8r3ohBgXPcgr
         6gUZXJI2uceTQtnS1hVDRephIznxUrwSgYfo/QgtvaC2eRZzQ/5IqhCdCDxDCYEF0T
         zFQ+KiVsfmtNw==
Date:   Mon, 1 Feb 2021 17:46:38 +0000
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
Subject: Re: [RFC PATCH v2 05/26] KVM: arm64: Avoid free_page() in page-table
 allocator
Message-ID: <20210201174638.GC15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-6-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-6-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:03PM +0000, Quentin Perret wrote:
> Currently, the KVM page-table allocator uses a mix of put_page() and
> free_page() calls depending on the context even though page-allocation
> is always achieved using variants of __get_free_page().
> 
> Make the code consitent by using put_page() throughout, and reduce the

typo: consistent

> memory management API surface used by the page-table code. This will
> ease factoring out page-alloction from pgtable.c, which is a
> pre-requisite to creating page-tables at EL2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
