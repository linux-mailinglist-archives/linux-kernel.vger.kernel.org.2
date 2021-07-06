Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576903BDE50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 22:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhGFUTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhGFUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 16:19:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7302C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=24DiGvb3bNj3woHW5ajaP60VvbnhCq7gaBZxkab0T04=; b=FPS4kdnpn+Rd0yLKaMmPxepqVe
        NyT2S/XG+z4aMKBrL5SadlsofjlATPJSOZgYs14XxTsOMBbKcqMjoJFB56khuz7r3Dcjo6XEQ3ZFm
        0dV7KquK+8epmZ/IPhdpBzeT7wSXxu9rSRE3JP8h7zKN/eXGSLll0fIhbchaEkTLvH9G8/9ce7Wof
        cPQu97QJvwZ0+ukfLcp4WIv3VMtCjcdNqX8titQnZxgn5eVeACwy3YlVwuno6XcBwg0HQFhfpofZE
        m6a5T+92B9x9tb0gHv8JETAX09gko+mhT2+ct0+rlkPGmF9lMVsd2kPhu23DE7A7z/TaBj6AD7RNw
        WTlr5QBg==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0rVH-00Ckxk-Ve; Tue, 06 Jul 2021 20:17:12 +0000
Subject: Re: Char Driver for Silicon Labs Si446x Transceivers
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sunip Mukherjee <sunipkmukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <CADLJR24hQya0MkJhdDAJ0KO4MG+Fj4tRU5dNrbNdD9DMG_gLHg@mail.gmail.com>
 <YOPl3dXamM3FERYT@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fe95e46b-fbc9-6411-0e4c-7b72040cddc5@infradead.org>
Date:   Tue, 6 Jul 2021 13:17:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOPl3dXamM3FERYT@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 10:10 PM, Greg KH wrote:
> On Mon, Jul 05, 2021 at 06:09:28PM -0400, Sunip Mukherjee wrote:
>> Hi,
>>
>> I am very new to the kernel community; this is my first message in the
>> LKML so my apologies if I am doing things wrong.
>>
>> I have been using an Si4463 transceiver for UHF communication with a
>> cubesat I developed. I could not find any code to control the
>> transceiver on Linux. The closest thing I could find was an AVR
>> implementation by Zak Kemble
>> (https://blog.zakkemble.net/si4463-radio-library-avr-arduino/).
>> I followed the API docs and rewrote the whole thing at first for
>> userland only (can be found here:
>> https://github.com/SPACE-HAUC/si446x_linux/releases/tag/v3.1), and
>> then I decided it would be a great learning opportunity for me to port
>> it to the kernel.
>>
>> The kernel port has gone mostly smoothly. The transceiver communicates
>> with the host MCU over SPI, and requires a pin for RESET, and another
>> pin for IRQ.
>> I have implemented the driver to provide a char device (/dev/si446x#)
>> to the userland for open, read, write, poll and ioctl.
>> I had initially set up a pull request for the driver and the device
>> tree overlay to the Raspberry Pi kernel community. They have agreed to
>> accept the device tree overlay for the device, however the driver
>> needs to be included by the Linux Kernel community. I want to use this
>> opportunity to find some people who have access to a Si446x
>> transceiver and a Raspberry Pi, so that the code I have can be tested,
>> and if deemed worthy, included in the kernel tree.
>>
>> My code is hosted here: https://github.com/sunipkmukherjee/silabs.git
>>
>> Any suggestions/criticisms are welcome.
> 
> If you post it in a patch form, as described in our documentation, I
> will be glad to review it.  Otherwise just looking at a random github
> repo is quite difficult and provides no way to give proper feedback.
> 
> Instructions on how to make a patch and submit it and the proper format
> for everything can be found in the Documentation/SubmittingPatches file.

which is now known as Documentation/process/submitting-patches.rst


-- 
~Randy

