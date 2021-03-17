Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48EC33FA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbhCQVK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:10:56 -0400
Received: from relay.yourmailgateway.de ([188.68.63.162]:58471 "EHLO
        relay.yourmailgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCQVKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:10:31 -0400
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
        by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4F12qm5WYCz4jFL;
        Wed, 17 Mar 2021 22:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=alexander-lochmann.de; s=key2; t=1616015428;
        bh=CtjrMpiYXpGAoavqdVjCxSnQK5vOrMamspHrP88M4kY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XwKFVm/g8EOvtnEWTKueYOc8ktS1wKYFZ34/c713H0uCaRTggPtXTiLSabuXhAmTU
         wCn6B0qXJFneLZb5outL8Z13tEj1u4Gf1itGdgJMgN9sbAmdRFiXmfvM2gNdDsnTV/
         Nhl3Ls2RxwaWWgxPS1ZfUk2dmUve5z2pZJX9tMjdqaZIbb6FPYw2+pvTXzQn9fOcJT
         0FkSfWgulQVKdgL48s+0lpxeTKmDn7Hv4MkWwteCphn1Q3igFFH2p2Fthak4kiO1ZC
         VSfqFivb3jDkKo++1uvUNhXLo01UtL4eww96RbpH621fAvep6bKydwVJ1p/gL8Zxce
         rBg7JTcVvim1g==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4F12qm576nz4jBl;
        Wed, 17 Mar 2021 22:10:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
X-Spam-Status: No, score=-2.901 required=6.31 tests=[ALL_TRUSTED=-1,
        BAYES_00=-1.9, SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Received: from mx2e12.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4F12qk6Zckz8tsh;
        Wed, 17 Mar 2021 22:10:26 +0100 (CET)
Received: from [IPv6:2003:ed:7f0a:3df0:4122:177f:5aab:be1b] (p200300ed7f0a3df04122177f5aabbe1b.dip0.t-ipconnect.de [IPv6:2003:ed:7f0a:3df0:4122:177f:5aab:be1b])
        by mx2e12.netcup.net (Postfix) with ESMTPSA id C7CEEA174E;
        Wed, 17 Mar 2021 22:10:25 +0100 (CET)
Authentication-Results: mx2e12;
        spf=pass (sender IP is 2003:ed:7f0a:3df0:4122:177f:5aab:be1b) smtp.mailfrom=info@alexander-lochmann.de smtp.helo=[IPv6:2003:ed:7f0a:3df0:4122:177f:5aab:be1b]
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
Message-ID: <46db8e40-b3b6-370c-98fe-37610b789596@alexander-lochmann.de>
Date:   Wed, 17 Mar 2021 22:10:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZPX43ihuL0TCiCY-ZNa4RmfwuieLb1XUDJEa4tELsUsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <161601542610.499.17322500893737558040@mx2e12.netcup.net>
X-PPP-Vhost: alexander-lochmann.de
X-NC-CID: 2WGiPwQUUoDFxYChPZmyidfLQddIA3fSFBMzr29sGlta+0MY4C/ts3lB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.03.21 09:02, Dmitry Vyukov wrote:
>>> Does this introduce an additional real of t->kcov_mode?
>>> If yes, please reuse the value read in check_kcov_mode.
>> Okay. How do I get that value from check_kcov_mode() to the caller?
>> Shall I add an additional parameter to check_kcov_mode()?
> 
> Yes, I would try to add an additional pointer parameter for mode. I
> think after inlining the compiler should be able to regestrize it.
First, I'll go for the extra argument. However, the compiler doesn't
seem to inline check_kcov_mode(). Can I enforce inlining?
I'm using GCC 9.3 on Debian Testing.

- Alex

-- 
Alexander Lochmann                PGP key: 0xBC3EF6FD
Heiliger Weg 72                   phone:  +49.231.28053964
D-44141 Dortmund                  mobile: +49.151.15738323
