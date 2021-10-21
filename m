Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4443628B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhJUNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJUNP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:15:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16DC061243
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HNvxY7dt5Sl/mo/s/qX7jMIlXw5UUksffXn2espR6TA=; b=ot9yZM0c4vWM2S08QkPzXKtePc
        m9Df6vBDdpewpZQNWe7W2BLlVuKUpeyr83DE3+LMZigeRen8VGHuzBEhSM9Uz5fa2lLClX7UmS2pI
        QTBY7RmC7g4qyvhDtSI3n7laYfHAB5WViNm7LG04cQU78X2vC9n9wgnJ1GnC8qNjnSYddd0pKodeZ
        6rqYMxtiMIZV/JVni1gkFMekRFjS6kB416Y0WtchtL3czfqYXfS4K2///2+Z5DpT+RtSfn1jGw3W/
        AQ43PTsj5JgD7BhsnOwfUyVeQpcxcyCvbRBnB4jGu/YcIxLl3jLG6FXKmuKXA7IEYLha7dhz1k6W7
        VZvrqRuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdXsw-00BKlY-Hk; Thu, 21 Oct 2021 13:13:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D297D30082D;
        Thu, 21 Oct 2021 15:13:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 960742BD29975; Thu, 21 Oct 2021 15:13:29 +0200 (CEST)
Date:   Thu, 21 Oct 2021 15:13:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YXFneUzcD+DsSkaC@hirez.programming.kicks-ass.net>
References: <20210919165331.224664-1-guoren@kernel.org>
 <CAJF2gTQu3qa2biCdYHTgfcJCBdAE=03zMs53XbiU4a8svMQmcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQu3qa2biCdYHTgfcJCBdAE=03zMs53XbiU4a8svMQmcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:47:14PM +0800, Guo Ren wrote:
> ping Peter, would you continue your generic ticket-lock work? Then
> riscv could directly use it.

Just posted an update on that, please see here:

  https://lkml.kernel.org/r/YXFli3mzMishRpEq@hirez.programming.kicks-ass.net
