Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9F338C69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCLMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCLMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:09:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37AC061574;
        Fri, 12 Mar 2021 04:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7CDKLNvPOs6luVR4r1nFvdWWOhad35qKWOWXJYwAjrs=; b=G7c7cV5QhrCIxV+Psz7/BVBh1R
        wwsWytq7TVvI4jUBoYLY8snOPRvTCP2kRbdE0/ALasWXxegCkqaMpDBYk7yvCHszVrm1+97HA4uU8
        jlwyU3HEa6kXhFDHk0zDdaXhgOzlsOiUQWRsrpU7+0hQIvJL4jmJ/23JmTNWoIgaJKLTFnwez4o2p
        DUieQSErD+llVgNrezI/mELZS2ftO9QSBlo+5pFBbt+4NdUJItV8APvafPzQF/obCfC1GY1j2Kveu
        Q8mE24wwCQxEAQ5DhMRz1T3FazQ0N716YHpx1nutxUqcr8rgvSW/ibpL7QsGToNhVd3HYFFje0xm9
        W6U7JoAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKgbT-00BN8s-NY; Fri, 12 Mar 2021 12:09:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60861300238;
        Fri, 12 Mar 2021 13:09:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E8992DA8633B; Fri, 12 Mar 2021 13:09:15 +0100 (CET)
Date:   Fri, 12 Mar 2021 13:09:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        torvalds@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
Message-ID: <YEtZ63iAralvR9eC@hirez.programming.kicks-ass.net>
References: <20210312113253.305040674@infradead.org>
 <20210312115749.065275711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312115749.065275711@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:32:54PM +0100, Peter Zijlstra wrote:
> +#ifndef CONFIG_64BIT
> +
> +/*
> + * Generic 32bit nops from GAS:
> + *
> + * 1: nop
> + * 2: movl %esi,%esi
> + * 3: leal 0x0(%esi),%esi
> + * 4: leal 0x0(%esi,%eiz,1),%esi
> + * 5: leal %ds:0x0(%esi,%eiz,1),%esi
> + * 6: leal 0x0(%esi),%esi
> + * 7: leal 0x0(%esi,%eiz,1),%esi
> + * 8: leal %ds:0x0(%esi,%eiz,1),%esi
>   *
> + * Except 5 and 8, which are DS prefixed 4 and 7 resp, where GAS would emit 2
> + * nop instructions.
>   */
> +#define BYTES_NOP1	0x90
> +#define BYTES_NOP2	0x89,0xf6
> +#define BYTES_NOP3	0x8d,0x76,0x00
> +#define BYTES_NOP4	0x8d,0x74,0x26,0x00
> +#define BYTES_NOP5	0x3e,BYTES_NOP4
> +#define BYTES_NOP6	0x8d,0xb6,0x00,0x00,0x00,0x00
> +#define BYTES_NOP7	0x8d,0xb4,0x26,0x00,0x00,0x00,0x00
> +#define BYTES_NOP8	0x3e,BYTES_NOP7
> +
> +#else
>  
> +/*
> + * Generic 64bit nops from GAS:
> + *
> + * 1: nop
> + * 2: osp nop
> + * 3: nopl (%eax)
> + * 4: nopl 0x00(%eax)
> + * 5: nopl 0x00(%eax,%eax,1)
> + * 6: osp nopl 0x00(%eax,%eax,1)
> + * 7: nopl 0x00000000(%eax)
> + * 8: nopl 0x00000000(%eax,%eax,1)
> + */
> +#define BYTES_NOP1	0x90
> +#define BYTES_NOP2	0x66,BYTES_NOP1
> +#define BYTES_NOP3	0x0f,0x1f,0x00
> +#define BYTES_NOP4	0x0f,0x1f,0x40,0x00
> +#define BYTES_NOP5	0x0f,0x1f,0x44,0x00,0x00
> +#define BYTES_NOP6	0x66,BYTES_NOP5
> +#define BYTES_NOP7	0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
> +#define BYTES_NOP8	0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00
>  
> +#endif /* CONFIG_64BIT */

Note that this also made all NOPs single instructions and removed the
special atomic nop.

