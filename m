Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8562E455464
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 06:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbhKRFrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 00:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbhKRFq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 00:46:59 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02950C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:43:59 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mnaDF-0004TW-Pt; Thu, 18 Nov 2021 06:43:57 +0100
Message-ID: <23cc4d9c-c20c-cc68-d1fe-e3fda96b357d@leemhuis.info>
Date:   Thu, 18 Nov 2021 06:43:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
Content-Language: en-BS
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637214240;e66f581f;
X-HE-SMSGID: 1mnaDF-0004TW-Pt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.21 19:47, Kyle Huey wrote:
> rr, a userspace record and replay debugger[0], is completely broken on
> 5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.

TWIMC: To be sure this issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7
#regzbot title SA_IMMUTABLE breaks debuggers like rr
#regzbot ignore-activity

FYI: I removed everyone else and the other lists from the To or CC to
avoid noise, as this mail is meaningless for them.

Ciao, Thorsten, your Linux kernel regression tracker.

P.S.: If you want to know more about regzbot, check out its
web-interface, the getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

But note, regzbot is doing its first field-testing now and thus still
has some bugs. Adding this regression will help be to find them, hence
feel free to ignore this mail or any errors you spot in the web-ui.

