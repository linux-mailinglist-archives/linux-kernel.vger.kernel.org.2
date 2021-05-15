Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3915A3818E1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 14:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhEOMxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhEOMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 08:53:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11CFC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DtXt01q/DleMBxjMxb+DNNjDdJ1wlgZKFyJsF3PwjU0=; b=NMoMd915B4XGX8F1Qe0bNahNDn
        Q3v6tqHHln/XFJnAhmhuRH4TwVVoVEz+xuUArTVUak1W3FowlZv6Q0JJ7GbxBuXatdc+k+HxuchiQ
        F7xld4H881lCr8ElRk9gIyrom6wND12JcBIpkxKnLD23jNMe8qA32v2Nl4TkpuLsighCopLsvY9oW
        tBxvYR6fYt5cZYSjFMhsN/Q7GjLp2azc9Ny3MsPg4iBkrWUcAYIY7+YXk6jogXZi6x1nqQ6dpQtdt
        Bm9u1khah4V1p3iBQ1YFl3Jkbui6/YP6mH5HQ1wVM+V5B8LBFcfCqMfTAWVDrnVxKT/l6Pzw6lwsO
        KYLKxMKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhtlb-00AJr5-CE; Sat, 15 May 2021 12:51:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFCC8986476; Sat, 15 May 2021 14:51:36 +0200 (CEST)
Date:   Sat, 15 May 2021 14:51:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH] openrisc: Define memory barrier mb
Message-ID: <20210515125136.GF5618@worktop.programming.kicks-ass.net>
References: <20210515075810.163206-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515075810.163206-1-shorne@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 04:58:08PM +0900, Stafford Horne wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> This came up in the discussion of the requirements of qspinlock on an
> architecture.  OpenRISC uses qspinlock, but it was noticed that the
> memmory barrier was not defined.
> 
> Peter defined it in the mail thread writing:
> 
>     As near as I can tell this should do. The arch spec only lists
>     this one instruction and the text makes it sound like a completion
>     barrier.
> 
> This is correct so applying this patch.
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> [shorne@gmail.com:Turned the mail into a patch]
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> I just applied the patch posted by Peter in the mail as is hence it is labeled
> from peter.  This also required me to set the Signed-off-by to Peter.
> 
> If there is any issue with that let me know.  I tested this out on my single
> processor setup and it all works fine, it will take me some time to get my SMP
> setup up and running again to test the other patches, but I figured I would send
> this patch first.

Works for me; thanks for not loosing it ;-)

> Also, I got delayed because I had to rebuild my main workstation after a
> hardware failure.

*ouch*, hate it when that happens.
