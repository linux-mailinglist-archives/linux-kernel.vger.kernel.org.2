Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE810332155
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCIIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCIIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:49:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA638C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m1ySQThwTqktk5pDTj/PB3KoGJ3+/G2QSnHKkn6zu4I=; b=kgi82zMtcJ/J1JDoBz/wvZ7F7L
        c34PbfwE2GfjeMr66NLGf9naAaDA0abPmsePtQrCdcg3G4MdCff4BdtBU/POATwYMLxUbpEkbRvSg
        ISqcvZCYCWRHszLCQVsQ2aRazcgsZtqIz2kvUsXnFBUjSQfNTIvr4FB8jcuti8Q3jhUiVnB/1BAYc
        xdUlwI8xLHMKtIWS4s+Gmj7oO3ySUYwfllzDF1QLzVvbQAlL4ngASeB+T45CVUr4tNgqXKSlDKzlu
        6e02FzekhGY7p6LO1H64FI6LX20pJptyoyX0BRFVp5AYFtReoThMvyI3G9MEbnBptAblKkesTgfk3
        C9/4F8EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJY3s-0045fg-IL; Tue, 09 Mar 2021 08:49:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2D2F301A32;
        Tue,  9 Mar 2021 09:49:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB6F22351CF0E; Tue,  9 Mar 2021 09:49:51 +0100 (CET)
Date:   Tue, 9 Mar 2021 09:49:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zack Rusin <zackr@vmware.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] locking/rwsem: Add down_write_interruptible
Message-ID: <YEc2ry1h1qC3N2m9@hirez.programming.kicks-ass.net>
References: <20210308205456.1317366-1-zackr@vmware.com>
 <20210308205456.1317366-2-zackr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308205456.1317366-2-zackr@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 03:54:55PM -0500, Zack Rusin wrote:
> Add an interruptible version of down_write. It's the other
> side of the already implemented down_read_interruptible.
> It allows drivers which used custom locking code to
> support interruptible rw semaphores to switch over
> to rwsem.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

No SoB!

Assuning you actually wrote and and simply forgot to add it, the patch
does look ok, so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
