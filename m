Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D23451A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhCVVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:15:04 -0400
Received: from relay.yourmailgateway.de ([188.68.63.98]:36847 "EHLO
        relay.yourmailgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhCVVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:14:40 -0400
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
        by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4F46h71Xhqz6QSW;
        Mon, 22 Mar 2021 22:14:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=alexander-lochmann.de; s=key2; t=1616447671;
        bh=m5Fh3iue/DEDYesjHqsKNJdSbpjrXQ6szUxSBhPjM8I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i614trfF/AQwO29b+v98r9jkMgIAoaS7XhDJ/k/ujUn1+8p7T2T0aPxNC3A2nrwkW
         a4tTAqxhgd43PlWKq29inLcYbpy6N910S1QeWgRkcsauxsZn1vlH+RnwO/zFVzEGUV
         hE5lxzSvePfqerYjIDFwF0CKTMaOu5t6BqK/pghrKNFzA84ZuZ8J4JfcVrD+fairgr
         8KPJS6ckAjljGOVrTOb8wge9hjK/ujn7YvHegx+8aXwA+DXLr1Q+UCb+WHKC9xtLqt
         82KhLDxosZIxzdSja3cBc8qnNPaJ6ylCbUPDFBS/3oHFpkjx4IldNTHzXXHJeHSxMG
         eQT7Cc/PZ9YHA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4F46h7166Xz5DJR;
        Mon, 22 Mar 2021 22:14:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=6.31 tests=[ALL_TRUSTED=-1,
        BAYES_00=-1.9, SPF_PASS=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx2e12.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy01-mors.netcup.net (Postfix) with ESMTPS id 4F46h441jQz8tGR;
        Mon, 22 Mar 2021 22:14:28 +0100 (CET)
Received: from [IPv6:2003:ed:7f03:8df0:3b15:ded:17a1:3116] (p200300ed7f038df03b150ded17a13116.dip0.t-ipconnect.de [IPv6:2003:ed:7f03:8df0:3b15:ded:17a1:3116])
        by mx2e12.netcup.net (Postfix) with ESMTPSA id 2364CA1AFC;
        Mon, 22 Mar 2021 22:14:27 +0100 (CET)
Authentication-Results: mx2e12;
        spf=pass (sender IP is 2003:ed:7f03:8df0:3b15:ded:17a1:3116) smtp.mailfrom=info@alexander-lochmann.de smtp.helo=[IPv6:2003:ed:7f03:8df0:3b15:ded:17a1:3116]
Received-SPF: pass (mx2e12: connection is authenticated)
Subject: Re: [PATCH] Introduced new tracing mode KCOV_MODE_UNIQUE.
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CACT4Y+bdXrFoL1Z_h5s+5YzPZiazkyr2koNvfw9xNYEM69TSvg@mail.gmail.com>
 <20210321184403.8833-1-info@alexander-lochmann.de>
 <CANiq72n+hqW5i4Cj8jS9oHYTcjQkoAZkw6OwhZ0vhkS=mayz_g@mail.gmail.com>
From:   Alexander Lochmann <info@alexander-lochmann.de>
Message-ID: <09e2b5a1-16ad-037a-88d2-6b29bc3fea6a@alexander-lochmann.de>
Date:   Mon, 22 Mar 2021 22:14:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CANiq72n+hqW5i4Cj8jS9oHYTcjQkoAZkw6OwhZ0vhkS=mayz_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <161644766760.12995.11637851970269855327@mx2e12.netcup.net>
X-PPP-Vhost: alexander-lochmann.de
X-NC-CID: kW0vvfUiLZdNgXacqVw4qIspfyEOcREZsez+ffHhqAayMnL2gBkxpC7V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.21 13:17, Miguel Ojeda wrote:
> Hi Alexander,
> 
> On Sun, Mar 21, 2021 at 8:14 PM Alexander Lochmann
> <info@alexander-lochmann.de> wrote:
>>
>> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
>> index d2c4c27e1702..e105ffe6b6e3 100644
>> --- a/Documentation/dev-tools/kcov.rst
>> +++ b/Documentation/dev-tools/kcov.rst
>> @@ -127,6 +127,86 @@ That is, a parent process opens /sys/kernel/debug/kcov, enables trace mode,
>>  mmaps coverage buffer and then forks child processes in a loop. Child processes
>>  only need to enable coverage (disable happens automatically on thread end).
>>
>> +If someone is interested in a set of executed PCs, and does not care about
>> +execution order, he or she can advise KCOV to do so:
> 
> Please mention explicitly that KCOV_INIT_UNIQUE should be used for
> that, i.e. readers of the example shouldn't need to read every line to
> figure it out.
> 
>> +    #define KCOV_INIT_TRACE                    _IOR('c', 1, unsigned long)
> 
> Trace is not used in the example.
> 
>> +       /* KCOV was initialized, but recording of unique PCs hasn't been chosen yet. */
>> +       KCOV_MODE_INIT_UNQIUE = 2,
> 
> Typo? It isn't used?
It is a typo. It should be used...
> 
> PS: not sure why I was Cc'd, but I hope that helps.
Thx for your feedback. get_maintainer.pl told me to include you in Cc.

Cheers,
Alex
> 
> Cheers,
> Miguel
> 

-- 
Alexander Lochmann                PGP key: 0xBC3EF6FD
Heiliger Weg 72                   phone:  +49.231.28053964
D-44141 Dortmund                  mobile: +49.151.15738323
