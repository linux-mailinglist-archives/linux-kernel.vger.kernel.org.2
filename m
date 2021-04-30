Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3091E36F85A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhD3KPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3KPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 06:15:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6066C06174A;
        Fri, 30 Apr 2021 03:15:04 -0700 (PDT)
Received: from [192.168.1.107] (unknown [81.0.122.160])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hs@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 239B282A8B;
        Fri, 30 Apr 2021 12:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1619777703;
        bh=GvJpbj/IkUt6NOGcBJRfVARVgloLsNnxV0D+I2RPASU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M25zclbgun5gh3CTuDQSW2XO8xr85zjfRUafPBHl+hyi/TdJr4e4thfNQdiqC+GSF
         zq9xarQ8gRRlU3AmPw3oDGJLEgMQf8NstcElUFTPnDTHkCW1AjHn1cJJXsjvQSbu45
         ihHJEgw543lBa+zryPdXxtaqA4lXMhs4rwR3ydY566J2J92e8GTSXujlSgwYk7Gkd5
         xm7lm2yMTuJ53NWUO0P8lwAsYy2faPXmJrLns9gjYYX0OZqUSBVRlxv2mV0+v3j78d
         VZeP/bKvoqa9vMJefGCjDp+CkDS3WcM+NwxScDG0nelJl4JOyVkyK4/eN9O/AhebsQ
         xNyaucHYstUsg==
Reply-To: hs@denx.de
Subject: Re: [PATCH] usb: dwc3: imx8mp: detect dwc3 child nodes with name
 "usb*"
To:     Felipe Balbi <balbi@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Teresa Remmet <t.remmet@phytec.de>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20210430091512.1026996-1-hs@denx.de> <87o8dwhywu.fsf@kernel.org>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <94d4d4ca-4910-99fa-18cf-478daeccc3b4@denx.de>
Date:   Fri, 30 Apr 2021 12:15:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87o8dwhywu.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 30.04.21 12:03, Felipe Balbi wrote:
> Heiko Schocher <hs@denx.de> writes:
> 
>> commit:
>> d1689cd3c0f4: ("arm64: dts: imx8mp: Use the correct name for child node "snps, dwc3")
>>
>> renamed "dwc3@3*" nodes in imx8mp.dtsi to "usb@3*"
>>
>> glue layer dwc3-imx8mp.c searches for "dwc3" and so drop failure
>> on boot:
>> imx8mp-dwc3 32f10100.usb: failed to find dwc3 core child
>> imx8mp-dwc3: probe of 32f10100.usb failed with error 1
>> imx8mp-dwc3 32f10108.usb: failed to find dwc3 core child
>> imx8mp-dwc3: probe of 32f10108.usb failed with error 1
>>
>> now. Fix this (and allow old style too)
>>
>> Tested on "PHYTEC phyBOARD-Pollux i.MX8MP" board.
>>
>> fixes: d1689cd3c0f4: ("arm64: dts: imx8mp: Use the correct name for child node "snps, dwc3")
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> already sent, see https://lore.kernel.org/r/1619765836-20387-1-git-send-email-jun.li@nxp.com

Ah, great. Missed this patch, thanks!

So, please forget this patch.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
