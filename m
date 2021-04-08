Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0973589D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhDHQey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:34:54 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:13947 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhDHQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617899682; x=1649435682;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WfEHTG10xBDz0nGkP9+hAXfmCPTtjRlM1cFKSmKMj8w=;
  b=FbHNXtQbQVWNrVvggHS+gE2rKi7GfeoUnmKbOhUu18zLe0thrlkhAc4F
   dMs9pEfu8Y37lx4BexgFsgUcckc+NlEGi0jmexTrQet2Rr7OVDmhbhMJP
   KGGE/4E+EfODg71zjdG61kvPwB8xOw/d+brbXBqOaTvUmrqPVA550Em6w
   0hVVPNV3ZSIyVNMBHUWmP4tXRFXJoZHbXPpWgo9Hi73ZAJ096nIosa4Wd
   2rf03e4+SZkSulGYPkS8XUwG7LphAxcFQqaKel5DDZsVp5AT/QZbrlbaW
   FXyNG3009BZFb/vYvhqtKLMs0qxtcJAMaOowDbhmUIn/Z3xBIhzVRgZ1t
   g==;
IronPort-SDR: BE/jK9+Ral/0gW3kccI5onJb+ppx+Z2xYiJlIZAeJXXvcODPTV1kxD0QpVbVweHO1hygS62k3S
 LwlSUl8fUYEuYxUN4apHFzFV0OIVCtH+CPdHc5wrf03a3j70pgB/TFYoTy9DYC130RyYDYG4lG
 vIqzZXeHxAMQfEKLJEJ4R1qIqx4tHAwmNaJKjpFNHkZfDs7sW9FzdIvGhy4iasMlcFyacDxInM
 9tgcys81AKGSpYEDren4npe4wb7Gh85j8+wT+LixeG45JLMXkwgNNQuj07syYVGA5bfam2BVRe
 T4k=
X-IronPort-AV: E=Sophos;i="5.82,206,1613458800"; 
   d="scan'208";a="112922907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2021 09:34:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 09:34:40 -0700
Received: from [10.12.88.246] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 8 Apr 2021 09:34:38 -0700
Subject: Re: [GIT PULL] ARM: at91: dt for 5.13
To:     Arnd Bergmann <arnd@kernel.org>, <soc@kernel.org>,
        Olof Johansson <olof@lixom.net>, <arm@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20210407114415.13180-1-nicolas.ferre@microchip.com>
 <161789493817.1630479.5024717274217057698.b4-ty@arndb.de>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <71b2bd27-0d3b-3331-4f79-85b22594e20b@microchip.com>
Date:   Thu, 8 Apr 2021 18:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161789493817.1630479.5024717274217057698.b4-ty@arndb.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 08/04/2021 at 17:24, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On Wed, 7 Apr 2021 13:44:15 +0200, nicolas.ferre@microchip.com wrote:
>> Arnd, Olof,
>>
>> Here is first batch of dt changes for 5.13. Please pull.
>>
>> Thanks, best regards,
>>    Nicolas
>>
>> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
>>
>> [...]
> 
> Merged into arm/dt, thanks!
> 
> I saw two new warnings from 'make dtbs_check W=1':
> 
> arch/arm/boot/dts/at91-sama5d2_ptc_ek.dt.yaml: /: 'etm@73C000' does not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'
> arch/arm/boot/dts/at91-kizbox3-hs.dt.yaml: /: 'etm@73C000' does not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'

Oh, got it: it's the upper case letter withing the etm hex address. I 
used this one to mach what was done in the reg property. I'm fixing both 
of them and sending the patch to the ml right now.

Tell me if I add it to a subsequent pull-request or if you prefer to 
take it the soonest in order to not generate additional warnings upstream.

BTW, I now have a dtschema at the proper level of support for running 
"make dtbs_check W=1" and will do it before sending pull-requests in the 
future.

Thanks for the heads-up. Best regards,
   Nicolas

> 
> merge commit: e2b064fec8e49112f7dac779fcec12ded40728c2
> 
>         Arnd
> 


-- 
Nicolas Ferre
