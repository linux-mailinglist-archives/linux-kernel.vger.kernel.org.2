Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C866933C8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhCOVoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:44:02 -0400
Received: from relay.yourmailgateway.de ([188.68.63.162]:33797 "EHLO
        relay.yourmailgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbhCOVng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:43:36 -0400
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
        by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4Dzqfm2M7tz4Xvn;
        Mon, 15 Mar 2021 22:43:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=alexander-lochmann.de; s=key2; t=1615844608;
        bh=eac9es/MFe3+8Al59Tl1zCNa/rwo+Zo9V4U9qpBACTg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y3Xl6hwsbo86uGUELqv2FXJcSzPXWjZ/mu1tTvpE1UvBvsD6uBAfAlqbma4JKQhUL
         hYMDzbe3nAlh/kZ7sdkNZFXXwNQac71s7EWM/t+mHFn0MNw5w12xpMHPuzMtR2crdF
         0oRTNPXXme/L23ejJVmmdyQob/mCxaQ/6cbwALCKWhWZ/dHWPNBxu+chFpqqU1Qcuv
         QEBEqXIMCMH9bZaGY/9iHgpNcEBUhbM6qXEOXObBn5Cb4RRWf4GePM0shzLOd5H2Hs
         U1gdk6iDItIPWUof9qNgELC3MnIUiKFhhfTqKS6cuSUzh5CPEAImCDvwUBJzSVmGfm
         icyx8HC4seyjA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4Dzqfm1xtzz4Xv9;
        Mon, 15 Mar 2021 22:43:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
X-Spam-Status: No, score=-2.901 required=6.31 tests=[ALL_TRUSTED=-1,
        BAYES_00=-1.9, SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Received: from mx2e12.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4Dzqfk6jqDz8sX5;
        Mon, 15 Mar 2021 22:43:26 +0100 (CET)
Received: from [IPv6:2003:ed:7f03:fff0:8c65:f932:36e8:7b85] (p200300ed7f03fff08c65f93236e87b85.dip0.t-ipconnect.de [IPv6:2003:ed:7f03:fff0:8c65:f932:36e8:7b85])
        by mx2e12.netcup.net (Postfix) with ESMTPSA id AB678A128E;
        Mon, 15 Mar 2021 22:43:25 +0100 (CET)
Authentication-Results: mx2e12;
        spf=pass (sender IP is 2003:ed:7f03:fff0:8c65:f932:36e8:7b85) smtp.mailfrom=info@alexander-lochmann.de smtp.helo=[IPv6:2003:ed:7f03:fff0:8c65:f932:36e8:7b85]
Received-SPF: pass (mx2e12: connection is authenticated)
Subject: Re: [PATCH] KCOV: Introduced tracing unique covered PCs
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <20210211080716.80982-1-info@alexander-lochmann.de>
 <CACT4Y+YwRE=YNQYmQ=7RWde33830YOYr5pEAoYbrofY2JG43MA@mail.gmail.com>
 <01a9177f-bfd5-251a-758f-d3c68bafd0cf@alexander-lochmann.de>
 <CACT4Y+ZPX43ihuL0TCiCY-ZNa4RmfwuieLb1XUDJEa4tELsUsQ@mail.gmail.com>
From:   Alexander Lochmann <info@alexander-lochmann.de>
Message-ID: <8841773d-c7d2-73aa-6fa6-fe496952f2ba@alexander-lochmann.de>
Date:   Mon, 15 Mar 2021 22:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZPX43ihuL0TCiCY-ZNa4RmfwuieLb1XUDJEa4tELsUsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <161584460608.10283.10375834804910803558@mx2e12.netcup.net>
X-PPP-Vhost: alexander-lochmann.de
X-NC-CID: y7MpuFzfc+D6xQwpyqU+yQrRwg5OG3Qa4gGl9FcY9NcwZPR4oX0OeM0v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.03.21 09:02, Dmitry Vyukov wrote:
>>>>  static notrace unsigned long canonicalize_ip(unsigned long ip)
>>>> @@ -191,18 +192,26 @@ void notrace __sanitizer_cov_trace_pc(void)
>>>>         struct task_struct *t;
>>>>         unsigned long *area;
>>>>         unsigned long ip = canonicalize_ip(_RET_IP_);
>>>> -       unsigned long pos;
>>>> +       unsigned long pos, idx;
>>>>
>>>>         t = current;
>>>> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
>>>> +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC | KCOV_MODE_UNIQUE_PC, t))
>>>>                 return;
>>>>
>>>>         area = t->kcov_area;
>>>> -       /* The first 64-bit word is the number of subsequent PCs. */
>>>> -       pos = READ_ONCE(area[0]) + 1;
>>>> -       if (likely(pos < t->kcov_size)) {
>>>> -               area[pos] = ip;
>>>> -               WRITE_ONCE(area[0], pos);
>>>> +       if (likely(t->kcov_mode == KCOV_MODE_TRACE_PC)) {
>>>
>>> Does this introduce an additional real of t->kcov_mode?
>>> If yes, please reuse the value read in check_kcov_mode.
>> Okay. How do I get that value from check_kcov_mode() to the caller?
>> Shall I add an additional parameter to check_kcov_mode()?
> 
> Yes, I would try to add an additional pointer parameter for mode. I
> think after inlining the compiler should be able to regestrize it.
> 
Should kcov->mode be written directly to that ptr?
Otherwise, it must be written to the already present variable mode, and
than copied to the ptr (if not NULL).

- Alex

-- 
Alexander Lochmann                PGP key: 0xBC3EF6FD
Heiliger Weg 72                   phone:  +49.231.28053964
D-44141 Dortmund                  mobile: +49.151.15738323
