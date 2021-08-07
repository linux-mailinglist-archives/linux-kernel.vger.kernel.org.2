Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E343E35F7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhHGO4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhHGO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 10:56:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C188CC0613CF;
        Sat,  7 Aug 2021 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NMz/26uT2WRA5zyrDgg3yIeUQzzboyU0k+N1bjM2MZM=; b=cPZ15ULomfdRX2fu5rlpG0qu3i
        mRzqYnOPSL2JH4cHh9uaamsjMfXT1UeA4ANq+FkpgMcIirnS7YSyeYNYFgRDPuNYK/IUF52QJBHCK
        p/R7CNivssfZmXD86NPwuy/akez7R0VsvuhfOnF03M6pGW6ITu5q+U/0D56XvKaxx1m0oW0Lynd+W
        FXuAUP/DKhd9B/5G8kUfovTTZYpIXpUdYoOfk4X/gs/EzMH20wmvmH8S2C1n5GluP/UsIyve5uFZr
        mT8TVBgHAUiiLJEFrhSXCmqfrDDF5OUrdS4DmHDFpJRYz3Hpgsgkv9nKEtvicllVbrr/bx7som5wJ
        cmPm4yPA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCNj4-006i7G-GC; Sat, 07 Aug 2021 14:55:31 +0000
Subject: Re: Embedded USB Debug(EUD) driver
To:     Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAPY=qRS0F0iv15w34w13xutoUThbDqFtYniM=eLLmqaMdXya3g@mail.gmail.com>
 <YQTitrc49G7RxYi2@kroah.com>
 <CAPY=qRTx+V_P1390b09wyBwMqDOJ2MBH8=5iBgfLCz6t_mBKwQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1cd59c72-2221-ec3a-da8d-ca377530db80@infradead.org>
Date:   Sat, 7 Aug 2021 07:54:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPY=qRTx+V_P1390b09wyBwMqDOJ2MBH8=5iBgfLCz6t_mBKwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/21 7:23 AM, Subhashini Rao Beerisetty wrote:
> On Sat, Jul 31, 2021 at 11:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Fri, Jul 30, 2021 at 11:33:09PM +0530, Subhashini Rao Beerisetty wrote:
>>> Hi All,
>>>
>>> I'm currently looking for the Embedded USB Debug (EUD) interface driver.
>>
>> For what specific hardware?  Do you have the needed "special" cable?  We
>> have support in the kernel for some types of these cables, what kernel
>> versions have you tried that did not work for this?

> It's for MSM hardware and yes we have the "special" cable.
> I could not find the device driver for this in the mainline tree. It
> would be helpful if you could point me to the kernel tree which
> supports this feature. We will compile this suggested kernel and
> necessary drivers and then will give a try on our hardware

Hi,
See USB_SERIAL_DEBUG in drivers/usb/serial/.
That symbol builds usb_debug.c in that same directory.

It may help to read Documentation/x86/earlyprintk.rst.

My own cheat sheet (quick reference) says this: (it may or
may not help you) (it might need some updating for XHCI):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Using USB debug port (on a USB EHCI controller)

On the system under test:

CONFIG_USB_EHCI_HCD=y

kernel command line:
	earlyprintk=dbgpN,keep

With an XHCI controller, use:
	earlyprintk=xdbcN,keep

Also add:
	console=tty0
or	console=ttyUSB0
for console output to go to the serial port.

Make sure that USB_SERIAL=y, USB_SERIAL_CONSOLE=y,
and USB_SERIAL_DEBUG=y.

------
On the logging system:
(requires CONFIG_USB_SERIAL_DEBUG=y)

Run minicom and tell it to connect to /dev/ttyUSB#.
Optionally have it log all messages to a file.

#####

-- 
~Randy

