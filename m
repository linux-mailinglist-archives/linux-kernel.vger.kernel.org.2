Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7CB306704
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbhA0WKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbhA0WKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:10:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:09:40 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611785378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRHi3vNzIfr8TCLFZ6ldJ5CafgzcNszokGa318PJPEk=;
        b=4m3utNItU5lTkzKPDwpu6Ls28uBgchIegkVXHvHZmHpy7XJ3B86OXr5O4NICMLQdsx8dYG
        EsCqOXQY4fxWUbsJ7FTYPJGK3QffKdgwPS/8RmYu6G/e8GC14u169liwvUtPvWxFkkwxe8
        1/zl5iLa6U+qd4Gx5epmenev0dGWql84q2MjGwAosMzVGIB0EBnlxj2SJP9GHZBzkbqDK9
        VmCzuynlMlAqlZknS9txUfuKPrg4jBVV2HOWCQtbIJu1zebO9HVL+6odSHw9Qm8+sBawtp
        AmEeyfzkLlqH4Z2MWeDXoMzCilWT/wP7Zfbigd8y8WFDLPXI/QWF7RQy2fbbrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611785378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRHi3vNzIfr8TCLFZ6ldJ5CafgzcNszokGa318PJPEk=;
        b=K7y1cVn38ujc2CSQ/vRCbO/1Z+SLHEzcmRUGEhlEL3sxstdfMi74aKB5ujNk6jWgf6ZIBW
        Iksf60JMloEO1NCQ==
To:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 4/4] Documentation/admin-guide: Change doc for split_lock_detect parameter
In-Reply-To: <20201124205245.4164633-5-fenghua.yu@intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com> <20201124205245.4164633-5-fenghua.yu@intel.com>
Date:   Wed, 27 Jan 2021 23:09:38 +0100
Message-ID: <87o8hadobh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24 2020 at 20:52, Fenghua Yu wrote:
> Since #DB for bus lock detect changes the split_lock_detect parameter,
> update the documentation for the changes.

Why is this seperate and an all in one thing? patch 2/4 changes the
parameter first and 3/4 adds a new option....

>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Change Log:
> v4:
> - Fix a ratelimit wording issue in the doc (Randy).
> - Patch 4 is acked by Randy (Randy).
>
> v3:
> - Enable Bus Lock Detection when fatal to handle bus lock from non-WB
>   (PeterZ).
>
> v1:
> - Fix a few wording issues (Randy).
>
> RFC v2:
> - Simplify the documentation (Randy).
>
>  .../admin-guide/kernel-parameters.txt         | 30 +++++++++++++++----
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 44fde25bb221..28228539b02a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5051,27 +5051,45 @@
>  	spia_peddr=
> +
> +			ratelimit:N -
> +				  Set rate limit to N bus locks per second
> +				  for bus lock detection. 0 < N <= HZ/2.

Oh well. So if I have ratelimit:500 on the kernel command line and then
this works for CONFIG_HZ=1000, but after rebuilding the kernel with
HZ=250 it fails. What?

If I allow 500 hits per second then CONFIG_HZ has absolutely nothing to
do with it. A second stays a second independent of CONFIG_HZ.

So what's the purpose of this HZ business?

Thanks,

        tglx
