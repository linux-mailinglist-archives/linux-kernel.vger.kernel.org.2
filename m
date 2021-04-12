Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF96035B9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhDLGHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:07:14 -0400
Received: from router.aksignal.cz ([62.44.4.214]:59200 "EHLO
        router.aksignal.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhDLGHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:07:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by router.aksignal.cz (Postfix) with ESMTP id A8FA04307A;
        Mon, 12 Apr 2021 08:06:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
        by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id Y9rT_o_lsjxK; Mon, 12 Apr 2021 08:06:53 +0200 (CEST)
Received: from [172.25.161.36] (unknown [83.240.30.185])
        (Authenticated sender: jiri.prchal@aksignal.cz)
        by router.aksignal.cz (Postfix) with ESMTPSA id 01FE843079;
        Mon, 12 Apr 2021 08:06:52 +0200 (CEST)
Subject: Re: [PATCH 0/3] nvmem: eeprom: add support for FRAM
To:     Christian Eggers <ceggers@arri.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>
References: <20210409154720.130902-1-jiri.prchal@aksignal.cz>
 <4311739.LvFx2qVVIh@n95hx1g2>
From:   =?UTF-8?B?SmnFmcOtIFByY2hhbA==?= <jiri.prchal@aksignal.cz>
Message-ID: <5624cedb-e9e2-d1c3-2fb3-b03f7fe51a99@aksignal.cz>
Date:   Mon, 12 Apr 2021 08:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4311739.LvFx2qVVIh@n95hx1g2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09. 04. 21 19:21, Christian Eggers wrote:
> Hi Jiri,
> 
> I have two Fujitsu different FRAMs running with the stock at25 driver. I set
> the page size equal to the device size (as FRAMs have no pages).
> 
> Are you able to run your FRAM with the unmodified driver?
> 
> I assume that getting the device geometry from the chip is vendor specific (in
> contrast to flash devices which have standard commands for this).  I suppose
> that there is no much value getting vendor specific information from a chip. If
> the drivers knows the vendor, it should also know the chip (e.g. from the dt).

Hi Christian,
main purpose of this patch is to get serial number from this chip. I 
don't have it done yet, in older kernels I expose it as separate file in 
sysfs, but in this kernel no luck. So a post first things while I'm 
working on sernum exposing.

Does your chip has serial number? Can you read it?

Any help welcomed.
Thanks
Jiri

PS: If standard EEPROMs has some commands to get size etc., why it's not 
used? I guess that size is increased as time goes while board is still 
the same, so isn't it annoying changing dt every new lot with bigger 
eeproms.
