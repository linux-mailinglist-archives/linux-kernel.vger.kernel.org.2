Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB65E36CAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhD0SLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhD0SLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:11:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E28C061574;
        Tue, 27 Apr 2021 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=iSFwWZDgq06eV2j6xMstjt+tfTQP9r/fGWLHY8KCDgY=; b=E14V1iHnWizv6jQBIpVNVsFFsN
        4CZUnf+NhNCPUfoXYjeIZdOaU+TE5uXPsadfYDIeSNnzXU7g5h99a5EXpDC/sn+9JfHgFmbZ9ceAk
        wr22TnxplBhdNIi1uSzoWyfZ6v8WJEt6+MInzDIEJO7Dea4geNCeAbrl1XlG/Hfu/9pkf6219v4vr
        ieTWDaz/+urBCeW9HVi5AyuIkLtTGfn2mlCEU7+dlNMaw1dREgLwxsmSVDJmtJF8WVsm2phaksArm
        bMlQcq0Xjv9jeSKyj9wn1feWjhi0rLjIBZS3u2C0StdtqkBHgO3OhEYPqa634Kkz3fTUon32n0sD7
        LW+KBd6g==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbSAX-007ElB-4f; Tue, 27 Apr 2021 18:10:48 +0000
Subject: Re: [PATCH] clk: <linux/clk.h>: correct clk_get_parent()
 documentation
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20210427031342.5333-1-rdunlap@infradead.org>
 <20210427093809.GU1463@shell.armlinux.org.uk>
 <9574eefa-84ed-8674-f575-be47d2a51a1c@infradead.org>
 <20210427180354.GV1463@shell.armlinux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5db90f0d-a272-3f7b-ed9e-c025c14c00fd@infradead.org>
Date:   Tue, 27 Apr 2021 11:10:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210427180354.GV1463@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 11:03 AM, Russell King - ARM Linux admin wrote:
> On Tue, Apr 27, 2021 at 10:07:04AM -0700, Randy Dunlap wrote:
>> On 4/27/21 2:38 AM, Russell King - ARM Linux admin wrote:
>>> On Mon, Apr 26, 2021 at 08:13:42PM -0700, Randy Dunlap wrote:
>>>> Make the kernel-doc return value agree with both the stub implementation
>>>> in <linux/clk.h> and the non-stub function in drivers/clk/clk.c.
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Cc: linux-clk@vger.kernel.org
>>>> ---
>>>> There are several drivers that call clk_get_parent() and use its
>>>> return value as though it returns an ERR_PTR(). I am working on a
>>>> patch series to fix those.
>>>
>>> The whole premise of the CLK API is that:
>>>
>>> - clk values that IS_ERR() returns true are errors
>>> - clk values that IS_ERR() returns false are valid
>>>
>>> and that is that - nice, simple, easy to understand. So the
>>> documentation is correct. If clk_get_parent() needs to return an
>>> error, it does so by returning an error-pointer, not by returning
>>> NULL.
>>
>> Hm, so the 6 drivers that do this are OK then, if
>> clk_get_parent() returns NULL?
>>
>>
>> 	parent = clk_get_parent(clk);
>> 	if (IS_ERR(parent)) {
>> 		dev_err(cpu_dev, "Cannot get parent clock for CPU0\n");
>> 		clk_put(clk);
>> 		return PTR_ERR(parent);
>> 	}
>>
>> 	/* Get parent CPU frequency */
>> 	base_frequency =  clk_get_rate(parent);
>>
>> boom?
> 
> As I say, the premise is that only clocks where IS_ERR(clk) is true
> are an error. Everything else must be treated as an acceptable clock.
> 
> Sometimes the NULL clock is used for "I don't have a clock", and that
> must not cause the API to go "boom".
> 
> In the case of the CCF implementation, clk_get_rate(NULL) will return
> 0.
> 

Thank you for the clarification. That is helpful.

-- 
~Randy

