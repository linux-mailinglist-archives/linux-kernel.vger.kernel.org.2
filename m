Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830C431C35C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 22:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBOVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 16:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhBOVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 16:01:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B54C061574;
        Mon, 15 Feb 2021 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bkf1wtr5hHvAMJ6KcVEaAvu26TZYq3kxwEwKiBWYxdg=; b=rDy/0sCwM5eJKU6XpTzrxv7ZbS
        XScDIGSRWRhANlq4WHbdMaYT566UEAoclzz9B90k0o3cYFCzqH+miOm+Ifrd77106zEZTT34HQUs3
        s0ZtxFcxFGhlOegqrj400UaRuXsZExbyz/xi55fUmLIzXwW/dzZlSXYlS/OR9kqBm1GRGHGI1Gqq7
        UIlrS8nZZauZAfLVZ62HhvhCI847eav4MHa99QKsA3Xpp0q7wgtx3SXmM8t1uSA7OwapJgCoOaRJr
        xjIDhlmxE7jGGaMIyHPWZMufS3ExQkEZsgknK6vzhZY0URuXXcK/0Mkd6PSoqR3fIEELBD7y8LYe0
        cKsls3JA==;
Received: from [2601:1c0:6280:3f0::b669]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBkzS-0008Se-LS; Mon, 15 Feb 2021 21:01:06 +0000
Subject: Re: [PATCH v2 25/25] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-26-marcan@marcan.st>
 <20210215192906.7k3unuhph5wnkj5g@kozik-lap>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9dd4731c-7826-c1f5-3ce4-831d5186d270@infradead.org>
Date:   Mon, 15 Feb 2021 13:00:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215192906.7k3unuhph5wnkj5g@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/21 11:29 AM, Krzysztof Kozlowski wrote:
>> diff --git a/arch/arm64/boot/dts/apple/apple-j274.dts b/arch/arm64/boot/dts/apple/apple-j274.dts
>> new file mode 100644
>> index 000000000000..9a1be91a2cf0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/apple/apple-j274.dts
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> () around licenses, so:
> (GPL-2.0+ OR MIT)

Hi,
When/where does that "() around licenses" apply, please?

thanks.
-- 
~Randy

