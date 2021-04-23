Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752A6368D36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbhDWGfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWGfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:35:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6F5C061574;
        Thu, 22 Apr 2021 23:34:33 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lZpOY-0005Wh-NT; Fri, 23 Apr 2021 08:34:30 +0200
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        ksummit@lists.linux.dev, workflows@vger.kernel.org
References: <268a3049-7c0b-8a33-1ff6-5a2d35fcba16@leemhuis.info>
 <20210422145107.GH4572@sirena.org.uk>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: RFC: building a regression tracking bot for Linux kernel
 development
Message-ID: <1390e998-4847-eebf-1d7b-e9cb6625cff7@leemhuis.info>
Date:   Fri, 23 Apr 2021 08:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210422145107.GH4572@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1619159674;71a19a93;
X-HE-SMSGID: 1lZpOY-0005Wh-NT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.21 16:51, Mark Brown wrote:
> On Thu, Apr 22, 2021 at 09:16:40AM +0200, Thorsten Leemhuis wrote:
> 
>> That's it already. The regression was tracked with:
> 
>>  * minimal overhead for the reporter
>>  * no additional overhead for the developers – only something they ought
>> to do already became more important
> 
> For things that are caught by the various automated systems the
> deduplication might get annoying - even for the systems with a human in
> the loop it's very common for things that the automated systems pick up
> to end up getting reported several times over due to things like race
> conditions in the reporting process.  We'll have to see how that goes,
> it might be possible to automate some of it.

Yeah, good point, thx for pointing it out, will keep an eye on this
aspect to make sure it doesn't become a big problem.

Ciao, Thorsten

