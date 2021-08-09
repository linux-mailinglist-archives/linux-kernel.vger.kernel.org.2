Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEAB3E46D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhHINl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:41:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:65117 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbhHINl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628516496; x=1660052496;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Yu+ZKXheXQH6ORhC5K4vYtn0mCS4/OBMjcOH9TigR58=;
  b=SqlrquyfB01yhCpfjHgsvwEe4Z6NChu9XGWs8wHGn06reIxZmPnOewM4
   77fIMPkCgFDnHtMZbf/l0IKTnLreK84EYOfjXHMWHOecEJW6TULvXCFON
   UrzSlkiO/vowKUYKQLnIOtAwgkEML0A4PFsRFSUqaS0FQsqvzvsFoeM0S
   ZqqCZ03brOe8BwvmsWBqZFjZVcopmjP3AT/AVqDT844tKU7dyum0T8zkO
   /v9OnHle65HoyFlUOF6AIA2pXEP6Zm7SSnpoPTrCjHe5olscl67cxFcgr
   jXmvQgx4sSE3tDr2xSkU7Du/w7u/9x+bbOsW6Fc1QJTczHdyrW3JlNpZc
   A==;
IronPort-SDR: YEMOctqGGt7Hwovd5M3mj7p50Z7ersSwrYKsMPVc4SFtIJOgxQwyDasg4tU8G8cRe3KxCLP7N5
 amcZK3JL3TQg+ReaJK9kT7EU2vltYJN4bZB/LyOI2BKLnjUPXPXwgDD2I6TC8xTggmXo7ebg7q
 bauqlcDNFD4h4y3+HlbVOIfQ0039Jhu4SL3DQbOIoeKkY8P4LOZHqsJ42WaYH26M93mgq2TRUQ
 NlWPyR/ehT7HLaVBBkI3S2SfmjC6dxsU4RGmiEm/2NVbCnHzBzDEt1JyyMzcWpJ48+x4EKpurl
 ekS0RR6+q9KS1bnbDNgttG+E
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="139340485"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2021 06:41:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 06:41:35 -0700
Received: from [10.171.246.59] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 9 Aug 2021 06:41:33 -0700
Subject: Re: [GIT PULL] ARM: at91: defconfig for 5.15
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
References: <20210804084631.12934-1-nicolas.ferre@microchip.com>
 <CAK8P3a1Ru-qawBWtbmfJm-jiPpJTRJ9zSufXHNCZvxt1RCMFBA@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <5f5e8843-1a07-760a-db1a-aee084f00405@microchip.com>
Date:   Mon, 9 Aug 2021 15:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1Ru-qawBWtbmfJm-jiPpJTRJ9zSufXHNCZvxt1RCMFBA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2021 at 16:02, Arnd Bergmann wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Wed, Aug 4, 2021 at 10:46 AM <nicolas.ferre@microchip.com> wrote:
>> AT91 defconfig for 5.15:
>>
>> - add defconfig entries for new SoC: SAMA7G5
>>    - dedicated sama7_defconfig to match the needed peripherals and
>>      dependencies
> 
> I feel this needs  better description in the changelog: Why do you need another
> defconfig file in addition to the existing sama5_defconfig? Are they so
> different that a single config is not a good fit for both?

Hi Arnd,

I'm pushing another tag for this with better description. I hope it's 
convincing ;-)

Best regards,
   Nicolas

-- 
Nicolas Ferre
