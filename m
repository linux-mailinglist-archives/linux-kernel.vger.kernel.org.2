Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B364235E7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 22:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbhDMUk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 16:40:59 -0400
Received: from mail.efficios.com ([167.114.26.124]:35594 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhDMUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 16:40:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EA6FF33CC1A;
        Tue, 13 Apr 2021 16:40:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LxrJC51uGUZE; Tue, 13 Apr 2021 16:40:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8160533CC81;
        Tue, 13 Apr 2021 16:40:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8160533CC81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618346433;
        bh=mhATnPcG2pEt9LaX/4iSx9SzPcWzgRXeAfgoBziMBkQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NLzPj6Q+8rL6yYgwRuJ9UwHcmjl2mATJ8E7yHWud0Mq1oii4dF3AsD5TMZq861LcP
         5nHt12O2TN8btQLzcmiQPyki+RwmsCBunupYPRzK/OzFiEDHorcPp8gHB2CPmh3aQY
         IzcS6wsHbDFieTBYdXeWDC1tHVGpj5wwelPBIhXzgtQ5h09K/yZL1H3LcNmDBOZ75w
         EC6x2C6A/dagQdm0mjeskYWeAltr8GXkOtxmJauWzsJl4UHPDCWsQXWLEGOiRpAMG2
         HaTWnzKJH3s9QoXK0UoZ5zTnu11l+Ihcl/Dpnpu7CA4TNpkv3DI8WUyO7yTMFBmwCs
         QrTU5k53iW98A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UwU4K-8J3AWD; Tue, 13 Apr 2021 16:40:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7672D33C84E;
        Tue, 13 Apr 2021 16:40:33 -0400 (EDT)
Date:   Tue, 13 Apr 2021 16:40:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Message-ID: <1447691783.73957.1618346433394.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210413203352.71350-1-eric.dumazet@gmail.com>
References: <20210413203352.71350-1-eric.dumazet@gmail.com>
Subject: Re: [PATCH v3 0/3] rseq: minor optimizations
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: minor optimizations
Thread-Index: 7vNPwzPJf/6sqmppvmRqLcFK/+bWPQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 13, 2021, at 4:33 PM, Eric Dumazet eric.dumazet@gmail.com wrote:

> From: Eric Dumazet <edumazet@google.com>
> 
> rseq is a heavy user of copy to/from user data in fast paths.
> This series tries to reduce the cost.
> 
> v3: Third patch going back to v1 (only deal with 64bit arches)
> v2: Addressed Peter and Mathieu feedbacks, thanks !

For the whole series:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks Eric!

Mathieu

> 
> Eric Dumazet (3):
>  rseq: optimize rseq_update_cpu_id()
>  rseq: remove redundant access_ok()
>  rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
> 
> kernel/rseq.c | 29 +++++++++++++++++++++--------
> 1 file changed, 21 insertions(+), 8 deletions(-)
> 
> --
> 2.31.1.295.g9ea45b61b8-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
