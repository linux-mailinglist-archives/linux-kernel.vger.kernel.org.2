Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E3C3AA2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhFPSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:10:41 -0400
Received: from mail.efficios.com ([167.114.26.124]:57400 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhFPSKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:10:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2974B34A6DD;
        Wed, 16 Jun 2021 14:08:32 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tBhqg2yREHVV; Wed, 16 Jun 2021 14:08:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D82DF34AACE;
        Wed, 16 Jun 2021 14:08:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D82DF34AACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1623866911;
        bh=XHjzwm+Qk6dV84haijn1vWryMlunqNQUoDh0KBzrHXY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=h3aaimjb9J8elYZlzXSS44DCxezgoi7MHnYcKywxf5D+bK6D23HAVmH6gUKr/49fi
         lJoLgwcIqohW8UP93te3Czbqn/KX7a0uwS1/hAceMp0Ch/EkC8TfW99V3qsgLBKv3d
         xM8E+bUqDwUPAwnurygDvFN1usVQR0F0BnASMWUg5qFtWL/JyFMTqFKAsoyjwtt+ow
         zkpCM67CGcx/m6l3bROv0Yl4qpqAUUV45FX4GNNL+MWZMWTIvVNaT8/X1+wFlNY2WF
         42ZUVsMFeIBSoX7j46gAD9jIeTJij8FoRI47lhdZFrLqKcZdv6tYwkqoc+OvtDhbV9
         lG712ceuu1Xmg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c-3lUd37Ru1R; Wed, 16 Jun 2021 14:08:31 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CB6B634A8D5;
        Wed, 16 Jun 2021 14:08:31 -0400 (EDT)
Date:   Wed, 16 Jun 2021 14:08:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86 <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <987970694.9105.1623866911729.JavaMail.zimbra@efficios.com>
In-Reply-To: <74ace142f48db7d0e71b05b5ace72bfe8e0a2652.1623813516.git.luto@kernel.org>
References: <cover.1623813516.git.luto@kernel.org> <74ace142f48db7d0e71b05b5ace72bfe8e0a2652.1623813516.git.luto@kernel.org>
Subject: Re: [PATCH 5/8] membarrier, kthread: Use _ONCE accessors for
 task->mm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4026)
Thread-Topic: membarrier, kthread: Use _ONCE accessors for task->mm
Thread-Index: jSWeuglZnPsonKah7Uz3PhyqbxusGQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 15, 2021, at 11:21 PM, Andy Lutomirski luto@kernel.org wrote:

> membarrier reads cpu_rq(remote cpu)->curr->mm without locking.  Use
> READ_ONCE() and WRITE_ONCE() to remove the data races.

I notice that kernel/exit.c:exit_mm() also has:

        current->mm = NULL;

I suspect you may want to add a WRITE_ONCE() there as well ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
