Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9093A3E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFKJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:03:57 -0400
Received: from router.aksignal.cz ([62.44.4.214]:56292 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFKJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:03:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id 3ED8647326;
        Fri, 11 Jun 2021 11:01:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id ILpsyLn6D_EX; Fri, 11 Jun 2021 11:01:57 +0200 (CEST)
Received: from [172.25.161.48] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id C0ABC47325;
        Fri, 11 Jun 2021 11:01:57 +0200 (CEST)
Subject: Re: [PATCH v9 5/5] nvmem: eeprom: add documentation of sysfs fram and
 sernum file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-6-jiri.prchal@aksignal.cz> <YMMkgfRBKpwCo3PE@kroah.com>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <8ff601c4-776b-3973-2855-eb2013e72200@aksignal.cz>
Date:   Fri, 11 Jun 2021 11:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMMkgfRBKpwCo3PE@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11. 06. 21 10:53, Greg Kroah-Hartman wrote:
> On Fri, Jun 11, 2021 at 07:26:52AM +0200, Jiri Prchal wrote:
>> +Description:
>> +	Contains the FRAM binary data. Same as EEPROM, just another file
>> +	name to indicate that it employs ferroelectric process.
>> +	It performs write operations at bus speed - no write delays, capable
>> +	of 10^14 read/write cycles and 151 years data retention.
> 
> Are you sure of these statistics?  Don't promise something here that
> might not be true, this is not a marketing document :)

Just copied from datasheet. Is write at bus speed OK? And about others: 
much more then EEPROM would be OK? Or don't write about it?
