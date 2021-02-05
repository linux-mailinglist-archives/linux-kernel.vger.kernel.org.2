Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770DA31106D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhBERMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:12:33 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:35984 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhBEQFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:05:22 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id A4101B04882
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 18:46:57 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1612547217; x=1613411218; bh=7P00f57/9R26tDFzPR1XDObGA+7xrXtFmKh
        cUybzuJE=; b=LzS6wXA7WSiR0I5PyBEXL5yqRYwU5fn+FbYWzuvod758TF1ubSe
        8pzWApqcKcWVu9pT+NnHWLoBTIg+bE11wvMwN/iFWEY4jxRW4/UUxRlDUukmy1jP
        3wjbu3ACRtkWzZbPCEPZn4i4Qvz4wHmUN9Wjm3q2s3imbZVEKwP3iZvU=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.085
X-Spam-Level: 
X-Spam-Status: No, score=-2.085 tagged_above=-10 required=4.5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, LOTS_OF_MONEY=0.001,
        MONEY_NOHTML=1.144, NICE_REPLY_A=-0.33]
        autolearn=no autolearn_force=no
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bEksrtJp9Z5D for <linux-kernel@vger.kernel.org>;
        Fri,  5 Feb 2021 18:46:57 +0100 (CET)
Received: from [192.168.50.85] (146-241-184-239.dyn.eolo.it [146.241.184.239])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 507F9B04671;
        Fri,  5 Feb 2021 18:46:56 +0100 (CET)
Subject: Re: [PATCH v3 5/5] serial: 8250_dw: add em485 support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, matwey.kornilov@gmail.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-6-heiko@sntech.de>
 <20200518152103.GI1634618@smile.fi.intel.com>
 <1f7881b5-f900-dbbe-3f8d-f990d2bdf5a7@micronovasrl.com>
 <YBk14xJhIyqTNH/k@smile.fi.intel.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <9b2a7c4c-2ef1-5198-9aae-83f9fec00289@micronovasrl.com>
Date:   Fri, 5 Feb 2021 18:46:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBk14xJhIyqTNH/k@smile.fi.intel.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/2021 12:22, Andy Shevchenko ha scritto:
> On Tue, Feb 02, 2021 at 01:31:17AM +0100, Giulio Benetti wrote:
>> Il 18/05/2020 17:21, Andy Shevchenko ha scritto:
>>> On Sun, May 17, 2020 at 11:56:10PM +0200, Heiko Stuebner wrote:
>>>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>>
>>>> Need to use rs485 transceiver so let's use existing em485 485 emulation
>>>> layer on top of 8250.
>>>>
>>>> Add rs485_config callback to port and uses the standard em485 start and
>>>> stop helpers.
>>>
>>> Would it prevent to use native RS485 support?
>>
>> 8250_dw doesn't have a native RS485 support, do you mean using hardware
>> RTS assertion? Anyway at the moment it's not present. This would be the
>> first rs485 support added to 8250_dw.
> 
> DW v4.0+ has it.

I have access to datasheet of DW v3, and I don't have access to hardware
with DW v4.0v Uart.
But I could add rs485emu for only UART version < 4.0 and I can find Uart
version by reading UCV register, would it be acceptable?

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
