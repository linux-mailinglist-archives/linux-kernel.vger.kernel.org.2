Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1404035E6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhDMTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:13:59 -0400
Received: from mail.efficios.com ([167.114.26.124]:45122 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhDMTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:13:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 202A633B5A0;
        Tue, 13 Apr 2021 15:13:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1jrIwwa5gEeN; Tue, 13 Apr 2021 15:13:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 598C233B416;
        Tue, 13 Apr 2021 15:13:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 598C233B416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618341216;
        bh=LnwYjKW7sL7zD3ESlP5rxVzHGRgfTuHoEH4jd1qxduc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KaZlU+9Pjpc1ai5zkcYhZEQnxOHS04U3qEsdYFBxzHolgp9vd/nNVpYSQyesB6OBV
         5BY7XIVD9KqpCpWHI+PNb4I0zqra9Md5J0TkMjcYzA9rLUwDk9E3+Iazry6fvCCsGj
         SYjUy/PRx4C8GsLuCPgdDgD/zZKW35MeIp34/lhBj4s1GWzYY8xcQCQoqR1QL9Kw+3
         ShbKTMkmwDyTFnhRZbIM/yojSORR6i53qk4qSLkgcxsAhQbJ/KW+qA6K8ww88zuPlN
         +o2oUwpWvCgSwMkG4drpQHiguwq2FO4MNaUeuWUDZIcnGpjAmjHIhGPHS45TjSB0ys
         Zty9C9KYfs7YQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id foOJk3EHtdTA; Tue, 13 Apr 2021 15:13:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4AAC833B415;
        Tue, 13 Apr 2021 15:13:36 -0400 (EDT)
Date:   Tue, 13 Apr 2021 15:13:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <64670607.73039.1618341216196.JavaMail.zimbra@efficios.com>
In-Reply-To: <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com> <CANn89iJi=RY5HE6+TDvNv0HPEuedtsYHkEZSoEb45EO=tQM2tw@mail.gmail.com> <CANn89iKChc2Xf7fnJN0A7OfA7v=S0f6KruB91dKmEPVRhxQyPg@mail.gmail.com> <CANn89iKnQ7KeCo0os0c67GMgEkmrRqhmGhug-xL-Mx5BhR+BkQ@mail.gmail.com> <989543379.72506.1618334454075.JavaMail.zimbra@efficios.com> <CANn89iLXE6V2gpbJeE6KVU+YiNkmYZKjpRxKv8b69k1ECsyE9g@mail.gmail.com> <1347243835.72576.1618336812739.JavaMail.zimbra@efficios.com> <CANn89iKhKrHgTduwUtZ6QhxE6xFcK=ijadwACg9aSEJ7QQx4Mg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
Thread-Index: cC6InJlBdTHf/5kUmfCSjYRTTL2VnQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Apr 13, 2021, at 2:22 PM, Eric Dumazet edumazet@google.com wrote:

> On Tue, Apr 13, 2021 at 8:00 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
> 
>> As long as the ifdefs are localized within clearly identified wrappers in the
>> rseq code I don't mind doing the special-casing there.
>>
>> The point which remains is that I don't think we want to optimize for speed
>> on 32-bit architectures when it adds special-casing and complexity to the 32-bit
>> build. I suspect there is less and less testing performed on 32-bit
>> architectures
>> nowadays, and it's good that as much code as possible is shared between 32-bit
>> and
>> 64-bit builds to share the test coverage.
>>
> 
> Quite frankly V1 was fine, I can't really make it looking better.

Yes, I'm OK with V1 of that patch.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
