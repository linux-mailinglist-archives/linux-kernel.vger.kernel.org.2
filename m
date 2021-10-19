Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FBE433579
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhJSMLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSMLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:11:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3F5160FD8;
        Tue, 19 Oct 2021 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634645376;
        bh=UOgNvwARgZ9gdIpG16PfgfHiVPyHkIWLxeN+h4uVwi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZT1kIiY/K6RVhqpiidhsoAHcn/kkUuPZa0KEpQFJK3mgDHzn5582RCR0YVGvWAY9
         9xkW6wT4jpwnT7K/IKIam/mVwFG3y0Xv74TQhdxjjfFRzcP1IkJ+LMGkbb6z/kqVbu
         SdvHUGNXHiswH5y4qqewTuGrOKkyezpHB4z2XX5qiB4pTzqyXMVXcEvhNwbnsxrmTw
         ULVfxlsfV+3jY+wXGeqOk4Ri/V8hRIIa4ZlfSApg9CD3iX/U9fDMibdFmWTDo51mdz
         vxWVjr63gtSYS4nW+sCDMcg1NQ43Mr8JhirQH/h0h0S0bzidK59C2adKMStmZMVv5W
         lMLNyeBp2Oy8Q==
Date:   Tue, 19 Oct 2021 13:09:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ptdump: Allow dumping user page tables
Message-ID: <20211019120931.GJ13251@willie-the-truck>
References: <20211001145603.22024-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001145603.22024-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 04:56:03PM +0200, Vincent Whitchurch wrote:
> Add a user_page_tables debugfs file (similar to kernel_page_tables) to
> dump out the userspace page tables for the current process.  This
> provides details which are not available via pagemap (such as the memory
> type) and is useful when, for example, debugging ->mmap()
> implementations.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/arm64/mm/ptdump.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

How does this serialise with things like task exit?

Will
