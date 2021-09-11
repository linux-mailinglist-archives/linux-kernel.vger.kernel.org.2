Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A391D4078D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhIKOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhIKOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:35:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED925C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ShRjim8n5p6DQpCLWF2gXVF23dXXXzBR5oQN0FhTBgU=; b=iuNRsqjnZHSPqNpRzhAyTHbMEF
        VWO3+v1gWI1hszFdHXOf0fMQ8AyJ0CpF5KiBjS27bkoARpW5io38UVKMHAjlLRGXsJ1o2oTSVD8Lp
        Btq324bXVsrKSziJuwvWXgUzKPESBrpa8KwqsFcGCm2qpWHjsa4Br6h3WjHSPpZ0Aa9TgnKuVggHy
        /9kW0nqTZWmwhpBKdS0B/Zp8WgzFQA89HQJrZkiv5PDE+ppBEvrhtQg1NCm0MRFJ0luWOgWlijot6
        OpHvQRY3WmjdF18rTeRcBJvmjT3ISp69tALn5uq+Mx5hEt9a+qBL7cNXWCuqldrIeLjjYAsMJsqa6
        MKUEPMJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mP44m-002Ocj-SG; Sat, 11 Sep 2021 14:33:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57EC69862C9; Sat, 11 Sep 2021 16:33:52 +0200 (CEST)
Date:   Sat, 11 Sep 2021 16:33:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     rostedt@goodmis.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scripts: ftrace - move the nop-processing in
 ftrace_init to compile time
Message-ID: <20210911143352.GA4323@worktop.programming.kicks-ass.net>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
 <20210911135043.16014-3-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911135043.16014-3-yinan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 09:50:43PM +0800, Yinan Liu wrote:
> When ftrace is enabled, ftrace_init will consume a period of
> time, usually around 15~20ms. Approximately 60% of the time is
> consumed by nop-processing. Moving the nop-processing to the
> compile time can speed up the kernel boot process.
> 
> performance test:
>         env:    Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz

If you use objtool's -M argument instead of recordmcount, you already
get this and you can avoid running recordmcount entirely.
