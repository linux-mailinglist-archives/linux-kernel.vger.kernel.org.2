Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381323F92D2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 05:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbhH0DSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244142AbhH0DSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:18:02 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6845EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ddaB2RSKhEwgBWI3aDfrz9TkVGL7sLHCNG/hdLCIqm4=; b=ijv1S0ori6jYk7EeoR/hFnvWLW
        AapNxLz6IOefDZH07trOeJ7RoEgAi8IV0h+MAQzsWcMbjKFKPVe56UzposToKLnPoZTSudmZnqFMf
        RdDHEQ2+hL1qff6dAbSPR6riEsnN5BlOyUeFm9MwRRXRuQxHtMv9zEXWA+s5QFcWRChS2Eg76b7p3
        g4272wFazDIFZjloO3g1DrsHyxjJk+WMmVLWI9yBVk/QU9MNyuj7S99BZyWnvtxWxWLEA88okTUYK
        IO9vp/6uz6irz8mSX0yDVzHh7ReeV1IYvBAT0onEBh5kCVOWX7wMb1muEIG67cKCkUPbmX5k8Lnfm
        QAoCgIBQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJSMj-00BPGz-19; Fri, 27 Aug 2021 03:17:13 +0000
Subject: Re: [PATCH] maintainers: Add Alyssa Rosenzweig as M1 reviewer
To:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sven Peter <sven@svenpeter.dev>
References: <20210823151738.6273-1-alyssa@rosenzweig.io>
 <3112bc2c-7c6a-3190-26cd-a873b4029429@marcan.st>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c60b3e06-1a59-927b-d567-52e9b009133a@infradead.org>
Date:   Thu, 26 Aug 2021 20:17:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3112bc2c-7c6a-3190-26cd-a873b4029429@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 8:00 PM, Hector Martin wrote:
> On 24/08/2021 00.17, Alyssa Rosenzweig wrote:
>> Add myself as a reviewer for Asahi Linux (Apple M1) patches.
>>
>> I would like to be CC'ed on Asahi Linux patches for review and testing.
>> I am also collecting Asahi Linux patches downstream, rebasing on
>> linux-next periodically, and would like to be notified of what to
>> cherry-pick from lists.
>>
>> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Cc: Hector Martin <marcan@marcan.st>
>> Cc: Sven Peter <sven@svenpeter.dev>
>> ---
>>   MAINTAINERS | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b63403793c81..399e536bf629 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1264,6 +1264,7 @@ F:    drivers/input/mouse/bcm5974.c
>>   APPLE DART IOMMU DRIVER
>>   M:    Sven Peter <sven@svenpeter.dev>
>> +R:    Alyssa Rosenzweig <alyssa@rosenzweig.io>
>>   L:    iommu@lists.linux-foundation.org
>>   S:    Maintained
>>   F:    Documentation/devicetree/bindings/iommu/apple,dart.yaml
>> @@ -1693,6 +1694,7 @@ F:    drivers/*/*alpine*
>>   ARM/APPLE MACHINE SUPPORT
>>   M:    Hector Martin <marcan@marcan.st>
>> +R:    Alyssa Rosenzweig <alyssa@rosenzweig.io>
>>   L:    linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   S:    Maintained
>>   W:    https://asahilinux.org
>>
> 
> Acked-by: Hector Martin <marcan@marcan.st>
> 
> P.S. fix your mail server, I had to pull this from the list and I doubt I'm the only one ;)

I recall seeing it, so do you have any suggestions or points
about what needs to be fixed?

thanks.
-- 
~Randy

