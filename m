Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA4367EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhDVKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhDVKft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:35:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8E7061452;
        Thu, 22 Apr 2021 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619087714;
        bh=Xly/PNBxfg6q+VLy0P8lQnS09I1OdzNZSkLQIpowCoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oolPl8QySuxosoKVPWJcdXpgaCZD37NaA86RsB40hv4f1EACbqALa8MsWoJLCDg2c
         u7TBTOo0gDbCdwb3hg94yWHpjn6adYUbfQYLWkQNS6At4McbXItdZmoFYk02zKwZVe
         hSCufp729MWaJiB3mJ2WaLb3ALVXzrykisWivp9bMmlHPaIrvKwoXcvzV1VlFAKBeg
         QIHdeBTdc4zpYWGEznZWhsl9hL9j+DoDHcuF11mqoE/TFU6ycTZTPbSobbkqznIDkh
         qBt44qL1BY/8SVesYsFuLvhzF1/81VNOqZg6stawCW7XKPZkKdpk7TlHSmwDKFDCzY
         W0TPC1AaQYxuA==
Date:   Thu, 22 Apr 2021 11:35:08 +0100
From:   Will Deacon <will@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Show three registers per line
Message-ID: <20210422103508.GA1442@willie-the-truck>
References: <20210420172245.3679077-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420172245.3679077-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 06:22:45PM +0100, Matthew Wilcox (Oracle) wrote:
> Displaying two registers per line takes 15 lines.  That improves to just
> 10 lines if we display three registers per line, which reduces the amount
> of information lost when oopses are cut off.  It stays within 80 columns
> and matches x86-64.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/arm64/kernel/process.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
