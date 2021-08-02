Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10073DD5EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhHBMqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233604AbhHBMqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:46:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3E5560FC1;
        Mon,  2 Aug 2021 12:46:27 +0000 (UTC)
Date:   Mon, 2 Aug 2021 13:46:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: move the (z)install rules to arch/arm64/Makefile
Message-ID: <20210802124624.GG18685@arm.com>
References: <20210729140527.443116-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729140527.443116-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:05:27PM +0900, Masahiro Yamada wrote:
> Currently, the (z)install targets in arch/arm64/Makefile descend into
> arch/arm64/boot/Makefile to invoke the shell script, but there is no
> good reason to do so.
> 
> arch/arm64/Makefile can run the shell script directly.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/arm64/Makefile      | 7 +++++--
>  arch/arm64/boot/Makefile | 8 --------
>  2 files changed, 5 insertions(+), 10 deletions(-)

Is this part of some cross-arch clean-up? I can see x86 for example does
the same thing.

Thanks.

-- 
Catalin
