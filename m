Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068FE452C75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhKPIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhKPIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:13:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CDC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ryd4e3aWrhWGKZf+JM8vRc5zseSY9Wnyi0ZJAsZWhsY=; b=XvcxygbQVAOcRRInUn74hon8BJ
        u0UF4BL2hwNZNxxNvCeqcD43aBcWNZYtIOkHqrNHUKj30FvEnKkZmU8mklcRArMRlsNqFLxhKAv5D
        6AaIJR7JMeU33Jf891oOT4kuLpyOdXsMaWQE/1L2n3mZOFpyicmwYlVC8clR+wpo5jWNNh+WllNNo
        mCopF3CcDppUKMDI3ufLmBHHIrmyYP9jJ3BTIzSIBjzMHIcprc739qWz0YIegIy9/UkACkTH0qzi5
        gY88MWBj9RgDiPudI+/q7mR96/ReK+xTD80aGmkOsxQsAgzJhN6hnUDrI1Z+EuOTAOQ2Ywdv22uKj
        0l+9dsKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmtXo-006Zdc-QC; Tue, 16 Nov 2021 08:10:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F392198651D; Tue, 16 Nov 2021 09:10:20 +0100 (CET)
Date:   Tue, 16 Nov 2021 09:10:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     rostedt@goodmis.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
Message-ID: <20211116081020.GW174703@worktop.programming.kicks-ass.net>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20211116024942.60644-1-yinan@linux.alibaba.com>
 <20211116024942.60644-3-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116024942.60644-3-yinan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 10:49:42AM +0800, Yinan Liu wrote:
> In some business scenarios, GCC versions are so old that
> optimizations in ftrace cannot be completed, such as
> -mrecord-mcount and -mnop-mcount. The recordmCount in the
> kernel is actually used. In this case, ftrace_init will
> consume a period of time, usually around 9~12ms. Do nop
> substitution in recordmcount.c to speed up ftrace_init.

I really don't buy this.. if you can build a fresh kernel, you can
install a fresh gcc too -- and if you care about performance that's a
very good idea anyway.


