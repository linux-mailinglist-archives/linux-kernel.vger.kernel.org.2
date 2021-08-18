Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C5D3EFA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhHRFdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbhHRFdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:33:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FB3C061764;
        Tue, 17 Aug 2021 22:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=2zC73NgneGv8r0rNy+11rurbEC45FiruzWf40phAS6Y=; b=oIATTtM3ADQ3QTDvs0iGJBj4VU
        j+ZymCDfVMRqOX0Bs6AApeQ7EgI53hzm7ByuFJlTTKgHFpP2I2gkQ0pUfNJDiTRFCPADbYVeSkksH
        6MHbcOwDdQ1OZQ/EZ547mY1ihBLVAp3Tl91GXPKCBF0g95fNE6koik9sFJ11HN10uxIeuWGx7bYls
        laq3Lgk7MI9HmzvrTZYGidU0JEqevxWCqg5wEXvdm9ZQGW5ZlikVdAofrvVj9nlAwLCdF3UmlhZMS
        TRLmD9NrdkomJ/fpCa3A+J7LvC0pljdb4vj5EM4WqjaWOCzHndTQwZVDZUfH5vfnYjGj+QI4FhqAv
        6QPncMcg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGEBp-004Fdw-Np; Wed, 18 Aug 2021 05:32:37 +0000
Subject: Re: [PATCH] clk/at91: remove kernel-doc warnings in sama7g5.c
To:     Claudiu.Beznea@microchip.com, linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, mturquette@baylibre.com, sboyd@kernel.org,
        Eugen.Hristev@microchip.com, linux-clk@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        corbet@lwn.net
References: <20210810005431.22007-1-rdunlap@infradead.org>
 <1670a11e-98d8-1b55-34c0-3369aaa8a615@microchip.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <29f0b5d0-d9ab-6ef3-b280-ba3d64c8d828@infradead.org>
Date:   Tue, 17 Aug 2021 22:32:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1670a11e-98d8-1b55-34c0-3369aaa8a615@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 10:12 PM, Claudiu.Beznea@microchip.com wrote:
> Hi Randy,
> 
> On 10.08.2021 03:54, Randy Dunlap wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Fix multiple kernel-doc warnings in sama7g5.c. There are several
>> enums and structs that were not identified as such.
>> There are also several anonymous structs (that scripts/kernel-doc
>> has problems with), so add struct names to them.
>>
>> Fixes the following warnings:
>>
>> drivers/clk/at91/sama7g5.c:39: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>   * PLL clocks identifiers
>> drivers/clk/at91/sama7g5.c:60: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>   * PLL type identifiers
>> drivers/clk/at91/sama7g5.c:122: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>   * PLL clocks description
>> drivers/clk/at91/sama7g5.c:289: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>   * Master clock (MCK[1..4]) description
>> drivers/clk/at91/sama7g5.c:341: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>   * System clock description
>> drivers/clk/at91/sama7g5.c:365: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>   * Peripheral clock description
>> drivers/clk/at91/sama7g5.c:453: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>>   * Generic clock description
>> drivers/clk/at91/sama7g5.c:339: warning: Function parameter or member 'ep_chg_id' not described in 'master_clock'
>>
>> Some kernel-doc warnings are still printed, but they are all due to
>> problems in the kernel-doc script (if anyone is interested in playing
>> with some Perl :). These warnings are:
>>
>> sama7g5.c:287: warning: Function parameter or member '{' not described in 'sama7g5_plls'
>> sama7g5.c:287: warning: Function parameter or member '' not described in 'sama7g5_plls'
>> sama7g5.c:287: warning: Function parameter or member '}' not described in 'sama7g5_plls'
>> sama7g5.c:339: warning: Function parameter or member 'sama7g5_mckx' not described in 'master_clock'
>> sama7g5.c:339: warning: Function parameter or member '}' not described in 'master_clock'
>> sama7g5.c:360: warning: Function parameter or member 'sama7g5_systemck' not described in 'system_clock'
>> sama7g5.c:451: warning: Function parameter or member 'sama7g5_periphck' not described in 'periph_clock'
>> sama7g5.c:451: warning: Function parameter or member '' not described in 'periph_clock'
>> sama7g5.c:451: warning: Function parameter or member '}' not described in 'periph_clock'
>> sama7g5.c:841: warning: Function parameter or member 'sama7g5_gck' not described in 'generic_clock'
>> sama7g5.c:841: warning: Function parameter or member '}' not described in 'generic_clock'
> 
> What about keeping only one '*' instead of '**' where necessary as these
> data structures are only local to sama7g5.c file (according to
> Documentation/doc-guide/kernel-doc.rst "Functions and data structures in
> header files which are intended to be used by modules should also have
> kernel-doc comments."). This way all the warnings will be gone.

Sure, that works too.
I'll send an updated patch.

thanks.
-- 
~Randy

