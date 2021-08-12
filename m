Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5753E9D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhHLE2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:28:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50422 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLE2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:28:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17C4RRDo125344;
        Wed, 11 Aug 2021 23:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628742447;
        bh=iF6TXWlu/7BN6tFnOQ3ZbEOM5ijC2iPD8CFeDGOKIE4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a+QyFjd7T9tST0c8cqCFt0e18lXC5RxXOPfrQ1aVb6dyPz+uFQ/YBNnciKL6mhWs7
         Y32+4jPfgvNLWXHDAUvcJYeBOXbMczIdTLJ8ySvLeayhP5P1uv+H8O/zQ/CETwzpPd
         d2FcJfp7oZFIH6N2/qzvUhMnzEDn4lIV6oVe7IhE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17C4RR1j070725
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 23:27:27 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 23:27:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 23:27:26 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17C4RMUo100073;
        Wed, 11 Aug 2021 23:27:23 -0500
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Remove #address-cells and
 #size-cells property from at93c46d dt node
To:     Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210810064420.9489-1-a-govindraju@ti.com>
 <YRQhqHEl8wu2KZz+@lunn.ch>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <1cd133b5-5242-3394-5dc8-50a641dabf3a@ti.com>
Date:   Thu, 12 Aug 2021 09:57:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQhqHEl8wu2KZz+@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 12/08/21 12:44 am, Andrew Lunn wrote:
> On Tue, Aug 10, 2021 at 12:14:20PM +0530, Aswath Govindraju wrote:
> Hi Aswath
> 
> You did not put a To: in the email, so it is unclear which maintainer
> you expect to pickup this patch.
> 

Thank you for pointing it out and the review.

From the MAINTAINERS documentation I see that Shawn Guo, and Sascha
Hauer are the maintainers for this file.

Thanks,
Aswath

>> Remove #address-cells and #size-cells property from at93c46d device tree
>> node as it does not have child nodes.
>>
>> Fixes: 1556063fde42 ("ARM: dts: vf610-zii-dev: Add ZII development board.")
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
> 

