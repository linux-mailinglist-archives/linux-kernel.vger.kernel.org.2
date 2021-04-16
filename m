Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEE3628AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhDPTbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:31:20 -0400
Received: from mail.efficios.com ([167.114.26.124]:35420 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhDPTbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:31:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4A4DB33A762;
        Fri, 16 Apr 2021 15:30:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gcgjM8I8umO1; Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B7B4133A951;
        Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B7B4133A951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618601453;
        bh=p7XB97T5n4R7z4Fj+GUXbiw/P8xhfjfYKjRpfCWR4UA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EJ4YF+QbW/Xw5UawLEnSZX+EW3DA9+PCNDauA383bIf6VDZ770rorpJBoGZ0/LnwZ
         RQ1IxraYTRm2xSuJ6v8lRUTp49vOHSPmH8TiHK6FKNCmPPaDHXv/1Imj+PdUN29rAX
         W5LbNA+eVC9X75jMBwnDciB14zG6i+BhSW7pYG1Krb09SonTFoaE12DYi4Vb4R46L7
         E+QTW7l1nnX6r3xxgQYNOI97FYCZ3JCC46klNCnSccK7kqQNYIiUIdeTVxxfywmNS9
         I9gRtyZiL8pZVsC37SVmvzlTexiBvOA2XhoAYWylUn8UjG7QReyoWQnv+OrWL+9Rah
         20Xab0zeLIm+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 79Qiehg1WzRj; Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id AA81133A761;
        Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
Date:   Fri, 16 Apr 2021 15:30:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>,
        Carlos O'Donell <carlos@redhat.com>
Message-ID: <2056094038.84390.1618601453585.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210416190244.GJ4212@paulmck-ThinkPad-P17-Gen-1>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com> <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net> <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1> <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com> <20210416190244.GJ4212@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: liburcu: LTO breaking rcu_dereference on arm64 and possibly other architectures ?
Thread-Index: U+jByog9nw+xnur8wetlu9vzLfobNQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 16, 2021, at 3:02 PM, paulmck paulmck@kernel.org wrote:
[...]
> 
> If it can be done reasonably, I suggest also having some way for the
> person building userspace RCU to say "I know what I am doing, so do
> it with volatile rather than memory_order_consume."

Like so ?

#define CMM_ACCESS_ONCE(x) (*(__volatile__  __typeof__(x) *)&(x))
#define CMM_LOAD_SHARED(p) CMM_ACCESS_ONCE(p)

/*
 * By defining URCU_DEREFERENCE_USE_VOLATILE, the user requires use of
 * volatile access to implement rcu_dereference rather than
 * memory_order_consume load from the C11/C++11 standards.
 *
 * This may improve performance on weakly-ordered architectures where
 * the compiler implements memory_order_consume as a
 * memory_order_acquire, which is stricter than required by the
 * standard.
 *
 * Note that using volatile accesses for rcu_dereference may cause
 * LTO to generate incorrectly ordered code starting from C11/C++11.
 */

#ifdef URCU_DEREFERENCE_USE_VOLATILE
# define rcu_dereference(x)     CMM_LOAD_SHARED(x)
#else
# if defined (__cplusplus)
#  if __cplusplus >= 201103L
#   include <atomic>
#   define rcu_dereference(x)   ((std::atomic<__typeof__(x)>)(x)).load(std::memory_order_consume)
#  else
#   define rcu_dereference(x)   CMM_LOAD_SHARED(x)
#  endif
# else
#  if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L)
#   include <stdatomic.h>
#   define rcu_dereference(x)   atomic_load_explicit(&(x), memory_order_consume)
#  else
#   define rcu_dereference(x)   CMM_LOAD_SHARED(x)
#  endif
# endif
#endif

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
