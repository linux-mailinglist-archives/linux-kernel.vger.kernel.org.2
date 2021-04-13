Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1186235E24B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346531AbhDMPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:09:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:58308 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346523AbhDMPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:09:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D455D3391E1;
        Tue, 13 Apr 2021 11:08:55 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8qhseak6W9aO; Tue, 13 Apr 2021 11:08:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7296E339276;
        Tue, 13 Apr 2021 11:08:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7296E339276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618326535;
        bh=f9cu17tEd4NJRWtv1nKub5dMfDdJvW4Oedy14FJ1kSI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MIUrKSD5HR81VIg/4AJgB0cRawbyyrSxrICMye+7P2hOQrAVmojGbE0b5ZHXsNeLw
         T4hnadoQpVTGAsLD0wCFy4DWFEFdc1hN1yc+s0gCSAUbF96gr2YR37cUVKnj9ceUJw
         G67gZkBx8l9eJ6QAt2ONsHKQK1glgRQkPD9c9YWgZKswmuOsLqckYyCG6grlUh84uI
         nFsy3u3cT1E27UOMA4+ZGHk6ZNBTmflhoQ5qeqg4P6bRS2++qpo1trnXfz/8DTC0Jc
         XHHi1EdanSxxQaG8Ia4MIIhTJGsvLoZY83Y3HyHGQzPxp4r6u9ByEagxlP/tVqBeOJ
         GW8OEujgY/N9w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1wVZhtVBF9ox; Tue, 13 Apr 2021 11:08:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 61C0E338FD2;
        Tue, 13 Apr 2021 11:08:55 -0400 (EDT)
Date:   Tue, 13 Apr 2021 11:08:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Message-ID: <611952974.71663.1618326535246.JavaMail.zimbra@efficios.com>
In-Reply-To: <56c227c1defe4b9ca9c6a75537234e20@AcuMS.aculab.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com> <20210413073657.2308450-4-eric.dumazet@gmail.com> <YHVf+F3sKlWyZags@hirez.programming.kicks-ass.net> <fbf1a4449b0148b5b9c3baa32088c32a@AcuMS.aculab.com> <644332839.71291.1618323708305.JavaMail.zimbra@efficios.com> <56c227c1defe4b9ca9c6a75537234e20@AcuMS.aculab.com>
Subject: Re: [PATCH 3/3] rseq: optimise for 64bit arches
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: optimise for 64bit arches
Thread-Index: AQHXMETc4NN4/ddyHEK6qBKOxo8eAaqyQOlAaWt3qjT8tO0Y8Kdq5m51
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 13, 2021, at 11:06 AM, David Laight David.Laight@ACULAB.COM wrote:
[...]
> 
> Hmmm... too much replication.
> You could do:
> #ifdef CONFIG_64BIT
> #define PTR_TYPE u64
> #define PTR_FLD ptr64
> #else
> #define PTR_TYPE u32
> #define PTR_FLD ptr32
> #endif
> 
> Then have one copy of the code and the #undefs.

Good point, agreed.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
