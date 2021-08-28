Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148D73FA510
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhH1KsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:48:06 -0400
Received: from mail.ispras.ru ([83.149.199.84]:43030 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233732AbhH1KsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:48:04 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1B89D40A2BAF;
        Sat, 28 Aug 2021 10:47:13 +0000 (UTC)
Subject: Re: [PATCH] usb: ehci-orion: Handle errors of clk_prepare_enable() in
 probe
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Mike Turquette <mturquette@linaro.org>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <20210825170902.11234-1-novikov@ispras.ru>
 <20210825172937.GD192480@rowland.harvard.edu>
 <c22d943a-581c-c1bd-d453-3f0f6176c8a5@ispras.ru>
 <20210826152438.GB228824@rowland.harvard.edu>
From:   Evgeny Novikov <novikov@ispras.ru>
Message-ID: <303a5695-e0c4-1cae-ee1f-6f34a9717b77@ispras.ru>
Date:   Sat, 28 Aug 2021 13:47:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210826152438.GB228824@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 26.08.2021 18:24, Alan Stern wrote:
> On Thu, Aug 26, 2021 at 04:30:22PM +0300, Evgeny Novikov wrote:
>> Hi Alan,
>>
>> On 25.08.2021 20:29, Alan Stern wrote:
>>> On Wed, Aug 25, 2021 at 08:09:02PM +0300, Evgeny Novikov wrote:
>>>> ehci_orion_drv_probe() did not account for possible errors of
>>>> clk_prepare_enable() that in particular could cause invocation of
>>>> clk_disable_unprepare() on clocks that were not prepared/enabled yet,
>>>> e.g. in remove or on handling errors of usb_add_hcd() in probe. Though,
>>>> there were several patches fixing different issues with clocks in this
>>>> driver, they did not solve this problem.
>>>>
>>>> Add handling of errors of clk_prepare_enable() in ehci_orion_drv_probe()
>>>> to avoid calls of clk_disable_unprepare() without previous successful
>>>> invocation of clk_prepare_enable().
>>>>
>>>> Found by Linux Driver Verification project (linuxtesting.org).
>>>>
>>>> Fixes: 8c869edaee07 ("ARM: Orion: EHCI: Add support for enabling clocks")
>>>> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
>>>> Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
>>>> Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
>>>> ---
>>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>>>
>>> Do you intend to submit patches for the other EHCI drivers that don't
>>> check for errors in clk_prepare_enable()?  It looks like
>>> ehci-atmel.c, ehci-mv.c, and ehci-spear.c all need some attention.
>>>
>>> The same is true for a bunch of the OHCI drivers: ohci-at91.c,
>>> ohci-exynos.c, ohci-s3c2410.c, and ohci-spear.c.
>>>
>>> Didn't the Linux Driver Verification project identify this problem in
>>> all of these drivers?
>> Our verification framework report numerous issues like the one for which I
>> sent the given patch. There are many warnings for different USB drivers and
>> other types of device drivers as well. We sent several patches that were
>> acknowledged by the developers already, though, after the Andrew's reply [1]
>> I have doubts that we need to treat these warnings as potential bugs and fix
>> them. The verification framework performs static analysis in a way that I
>> described before [2]. Regarding the clock API it uses such models of
>> clk_prepare() and clk_enable() that can fail independently on underlying
>> hardware since is not easy to either model all such hardware or try to
>> relate and consider corresponding drivers in addition to drivers using
>> clocks at verification. Thus, potentially the verification framework can
>> produce warnings for all drivers that invoke clk_prepare(), clk_enable() or
>> clk_prepare_enable(), but do not check for their return values.
>>
>> I look forward whether you will confirm that it makes sense to handle errors
>> from mentioned functions anyway or it would be better not to sent such bug
>> reports unless we will be strictly sure that they can happen. In the former
>> case it would be better if somebody will teach built-in Linux kernel static
>> analyzers to detect these issues on a regular basis.
> I don't know whether these errors can occur or not.  To find out, you need to
> ask someone who knows more about the clock framework.
>
> On the other hand, the fact that the functions do return an error code means
> that they expect callers to check its value.  In fact, whoever changed the API
> should have gone through all the callers to make sure they did so.
>
> (Let's put it this way:  If those functions can return an error, we should
> check the return code.  If they can't return an error then they shouldn't be
> defined to return an int, so the API should be changed.)
>
> So on the whole, I think making these changes would be a good thing.  At the
> very least, it will help make all the different EHCI and OHCI drivers
> consistent with each other.
Though I may be wrong, but after the discussion with Dan, it does not 
seem that we can expect any considerable changes in the clock API and 
support from the static analysis tools soon. So, if you still would like 
to see corresponding fixes in EHCI and OHCI drivers, I can prepare them.

Best regards,
Evgeny Novikov
> Alan Stern
>
>> [1] https://lkml.org/lkml/2021/8/25/794
>> [2] https://lkml.org/lkml/2021/8/17/239
>>
>> Best regards,
>> Evgeny Novikov
