Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9BF3D991D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 00:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhG1Wzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 18:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhG1Wzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:55:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD683C061757;
        Wed, 28 Jul 2021 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=iXq6gtJgg/KgevAKbbPdcmL6v/tjqWXVyd71VWdu32g=; b=aI/AM99FpdL/zSIAo7Uo0E+CGl
        +6s2Jzg6JH7umPO7PnUwe9u26jTVXQ90CLsXspPyQcEh6GF7iq/xzNwOlz9QtYBUO1+Jior47Leye
        UHbOSgx9TfIJDmqaHIgYJpSATyZdCW09tJqjuopHP0ufQWUcBHwe0z5TPdOJcDcLU9iP6dQQr1abz
        ocoaW5D52xHSV9dtD/KAKwJ/Z4yAkC+zsAnAxwyZkj6mQFREHGcJ9yVQeohCgBX+xuqgGk4EodYGz
        wMCm3iDoURIPA+0kNsRrt1HPIOqu5kml7t1whfX/Ns632XWKij1/cjzkovQ3wo+iurrNMmiIZOtlb
        1dFvZjgg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8sSo-002Vco-EI; Wed, 28 Jul 2021 22:55:46 +0000
Subject: Re: patch suggestion: Kconfig symbols
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
References: <295b8f8c-4264-9f32-6723-9d2d574021ac@infradead.org>
 <e77e2329bdafdbea538be0d7edb8a9d7d3e45990.camel@perches.com>
 <09db53b9-7edf-44fc-c6b7-7c4e9198a2d4@infradead.org>
 <733d2747b67a8a172333b51bacbf77fe@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a89eefda-df18-0965-e56c-a1b73975b8c3@infradead.org>
Date:   Wed, 28 Jul 2021 15:55:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <733d2747b67a8a172333b51bacbf77fe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 2:30 PM, Joe Perches wrote:
> On 2021-07-28 12:41, Randy Dunlap wrote:
>> On 7/28/21 8:37 AM, Joe Perches wrote:
>>> On Mon, 2021-07-26 at 17:21 -0700, Randy Dunlap wrote:
>>>> Running scripts/checkkconfigsymbols.py reports several hundred (maybe thousand)
>>>> Kconfig symbols that are used questionably. Lots of these are false positives
>>>> but lots of the remainder could use some cleaning up.
>>> []
>>>> False positive example:
>>>>
>>>> XCHOFFLD_MEM
>>>> Referencing files: drivers/scsi/qla2xxx/qla_mbx.c
>>>> Similar symbols: OF_PMEM, CXL_MEM, CXL_PMEM
>>>>
>>>> The Referencing source file does this:
>>>> #define CONFIG_XCHOFFLD_MEM    0x3
>>>>
>>>> which is legitimate, so no change is needed.
>>>
>>> Legitimate is perhaps dubious.
>>>
>>> It might be better if Kconfig has exclusive use of CONFIG_<foo> naming so
>>> renaming all the other existing CONFIG_<foo> defines might be appropriate.
>>
>> I would prefer that as well -- maybe 15 years ago.
>> But I think it's too invasive to make that change now.
> 
> I do not think it's that invasive.
> 
> It's something that doesn't have to be done immediately either.
> 
> It's not too many macro defines and not too many uses of those defines.

OK :)

I'm not trying to prevent such a change.

Getting the exclusive use of CONFIG_symbols being dedicated to
Kconfig namespace is the bug hurdle (IMO).

-- 
~Randy

