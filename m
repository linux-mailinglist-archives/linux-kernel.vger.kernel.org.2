Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26369358D27
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhDHTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232804AbhDHTBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617908466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYj2NbbPHdZxWOqVjXDc+Fhrs0vHkYF53Hr5bnrf7Wk=;
        b=Y9PVO6Ub2qaVdo9oZgqF/3Dbtn7cGE9j3WQArE3NRE9cv0izSHWFiwa21bgq17CPXsMEI4
        io7BM7fNEsLDVQHcwBTgsbsnIb4oVNFpIFXH1emf7RTS5W2MGosD53gyUZQBdNHZke2LHN
        1FWuZ2MEC8mfVaakdCpPO4Zh0yNq44M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-nv9j8raePK-o-0Web69C_A-1; Thu, 08 Apr 2021 15:01:04 -0400
X-MC-Unique: nv9j8raePK-o-0Web69C_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C25331883527;
        Thu,  8 Apr 2021 19:01:02 +0000 (UTC)
Received: from llong.remote.csb (ovpn-119-36.rdu2.redhat.com [10.10.119.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12A63101F501;
        Thu,  8 Apr 2021 19:00:59 +0000 (UTC)
Subject: Re: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Stafford Horne <shorne@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     guoren@kernel.org, linux-arch@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        Anup Patel <anup@brainfault.org>, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
 <20210406235208.GG3288043@lianli.shorne-pla.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1199af5f-275a-5812-fc73-f1d33449036b@redhat.com>
Date:   Thu, 8 Apr 2021 15:00:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210406235208.GG3288043@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 7:52 PM, Stafford Horne wrote:
>
> For OpenRISC I did ack the patch to convert to
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y.  But I think you are right, the
> generic code in xchg_tail and the xchg16 emulation code in produced by OpenRISC
> using xchg32 would produce very similar code.  I have not compared instructions,
> but it does seem like duplicate functionality.
>
> Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
> OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
> one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
> xchg16/xchg8 emulation code?

For the record, the latest qspinlock code doesn't use xchg8 anymore. It 
still need xchg16, though.

Cheers,
Longman

