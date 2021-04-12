Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F8C35C578
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbhDLLnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:43:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2921 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbhDLLnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618227772; x=1649763772;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=54pILV5Cfgxhme73gcj3lgSwJw+HJPBn75ACjnoOkpU=;
  b=MJtA91QYGnxcZx+7+fQLXsmXky07jQN4KlboizPwNqDvhc5y4FbME0pk
   m2a4jW0ryaDQowFJ5gNLxeL71nzEhMQOaTuUPWbX2vVWyvS5RqMTQg3iG
   WL5C+2Y/fuYjm4zNEcGXV09vUnQY2YLmBlbZhObl0zxk3xmZm/SvCv7/4
   wd6vzdc4G8NpTHO55F/ea/2cY+gOwgvDXJ0i55o7qMUqBhQfmtIRI/woT
   9PuD8ZHHLWWOjp9mthuq6UdtsHanhgENHzYMv/k77SAf94zAXLifBu13V
   XDXci+dOxp56LjF1YLVTULiiuZodl43jtKl9oEXKNEY7px7aosLaLuMnI
   g==;
IronPort-SDR: C8vMucpo8S4CK2NqOlqonvByif3iX4/w9nA/jdFAewPDUR+tnUL9G3vc10SDzd2KqeR9NAN0+Q
 LniS8yzKsBUX9H+vmTcFxehbk6ggKEMYcxy5OuDkIM4silNE91SHQPe00D4D2xAunDg44oY7HG
 mKhWRmrfTegzHwaI75IWwWkQpmNm8+jlYsfCXJCrWDmj6uSNn/itQOcYX/diJJoNBK7Y/Wzj5R
 tw6nHfDAQAh2D7XDXnEqSU/iqEocGgA6Y0kEAvHn8Re3k1t+dIfeRTfNePhM7QaUWsjwBRlK6n
 ARI=
X-IronPort-AV: E=Sophos;i="5.82,216,1613458800"; 
   d="scan'208";a="113260732"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2021 04:42:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 04:42:51 -0700
Received: from [10.12.72.197] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 12 Apr 2021 04:42:49 -0700
Subject: Re: [GIT PULL] ARM: at91: dt for 5.13
To:     Arnd Bergmann <arnd@kernel.org>
CC:     SoC Team <soc@kernel.org>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20210407114415.13180-1-nicolas.ferre@microchip.com>
 <161789493817.1630479.5024717274217057698.b4-ty@arndb.de>
 <71b2bd27-0d3b-3331-4f79-85b22594e20b@microchip.com>
 <CAK8P3a1dyccHquEoSv4kECw-=RKNQAFVQap-DYTX-sDfwEPTGQ@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <6968a992-c3d5-eb56-ec71-1908e7be6ca3@microchip.com>
Date:   Mon, 12 Apr 2021 13:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1dyccHquEoSv4kECw-=RKNQAFVQap-DYTX-sDfwEPTGQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

On 08/04/2021 at 22:15, Arnd Bergmann wrote:
> On Thu, Apr 8, 2021 at 6:35 PM Nicolas Ferre
> <nicolas.ferre@microchip.com> wrote:
>> On 08/04/2021 at 17:24, Arnd Bergmann wrote:
>> Oh, got it: it's the upper case letter withing the etm hex address. I
>> used this one to mach what was done in the reg property. I'm fixing both
>> of them and sending the patch to the ml right now.
> 
> Ok
> 
>> Tell me if I add it to a subsequent pull-request or if you prefer to
>> take it the soonest in order to not generate additional warnings upstream.
> 
> I'd like to have it before the merge window, but don't bother making it
> an additional pull request if you already plan for another pull request with
> 5.13 material.

I don't plan to make another PR on DT for 5.13 so I would like you to 
take it as a patch.
https://lore.kernel.org/linux-arm-kernel/20210408164443.38941-1-nicolas.ferre@microchip.com/

Thanks for your help. Best regards,
   Nicolas


-- 
Nicolas Ferre
