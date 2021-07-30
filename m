Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C63DB887
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbhG3MYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhG3MYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:24:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FB1F60F0F;
        Fri, 30 Jul 2021 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627647883;
        bh=4skOWnrpXbFXjOabP6T3ypo967ThsPE6KYZyHShRRh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYRRWB7dAwPvV/aGPP7PQMkZiIszM19lBt90KI4m5qM3Bv0Ee7bY8P6r6d28Mjfhf
         8BeIRdpmeLf1f8PEGnKPjFzCubQlc+EuwjgAMn9FI0/8NTxs3OYSqDYdNMWfXIaxmo
         ukaQ+koFqKyqhKb9nEYU5tPxVbE3XPyDzTPPti6/KBe6esJAryen8l1BWe28FTkaFL
         TfYL+8b6iaNd4I6CT1AV8lixiOShSRXBPTYJxCGSQvsdJXtgGucchoarod47N51TbU
         Oy1l6+Uq9wg9BNY8cILnmuZvL0ZMnMv0G91utzokt9f9kp9PB9qkzdJbrUZK37S/r3
         7z6cvlMX+ifQA==
Date:   Fri, 30 Jul 2021 13:24:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     catalin.marinas@arm.com, jthierry@redhat.com, amit.kachhap@arm.com,
        dave.martin@arm.com, mark.rutland@arm.com, tabba@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: use __func__ to get function name in pr_err
Message-ID: <20210730122438.GF23589@willie-the-truck>
References: <20210726122907.51529-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726122907.51529-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 08:29:07PM +0800, Jason Wang wrote:
> Prefer using '"%s...", __func__' to get current function's name in
> a debug message.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/arm64/lib/insn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
