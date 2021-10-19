Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29CA433B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhJSPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhJSPzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:55:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F498610E7;
        Tue, 19 Oct 2021 15:53:03 +0000 (UTC)
Date:   Tue, 19 Oct 2021 16:53:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YW7p3ARYbpxmeLCF@arm.com>
References: <20211013054756.12177-1-rppt@kernel.org>
 <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
 <YW5bjV128Qk1foIv@kernel.org>
 <YW6t5tBe/IjSYWn3@arm.com>
 <089478ad-3755-b085-d9aa-c68e9792895c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089478ad-3755-b085-d9aa-c68e9792895c@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 11:06:11AM -0400, Qian Cai wrote:
> On 10/19/2021 7:37 AM, Catalin Marinas wrote:
> >>> I could help to confirm if it hangs right in the early boot somewhere if needed.
> >>
> >> The kernel config and a log of working kernel would help to start with.
> 
> http://lsbug.org/tmp/

Thanks. I guess the log here is with the Mike's patch reverted.

> > I don't think there's much in the log other than the EFI stub above.
> > 
> >>> start_kernel()
> >>>   setup_arch()
> >>>     paging_init()
> >>>       map_mem()
> >>>         memblock_mark_nomap(
> > 
> > Is this actual trace? It would be good to know where exactly it got
> > stuck.
> 
> No, I did not confirm anything yet. There is going to take a while to
> figure out the exactly location that hang since even the early console
> was not initialized yet. Any suggestion on how to debug in this case?

Try "earlycon=pl011,mmio32,0x12600000" on the kernel command line
and hopefully we get some early log.

-- 
Catalin
