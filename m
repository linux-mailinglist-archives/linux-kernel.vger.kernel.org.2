Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9683433F9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhCQUMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhCQUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:12:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE4C06174A;
        Wed, 17 Mar 2021 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=KLAHwcd2QZ23rDr/5Z70QKfxvKIFkoTNZ3q3rZSsusQ=; b=jEgVG4lCtXmAMEgO1vHsH/ZGOt
        NXcTYviTA2tIgXt+11oFfLAcHdOKvmooiSV5dX1TwBSXQ222coDHKFSS1t+Qsgg/XsYRsYxJQDCsk
        C0YjQU4Q7YciUegtyud+vPBlk7/FOUL2e5CvIV7jm5bQuEzyrVqY39JfFHt+HNfr5XbJvJd0qV5K8
        EFCqO4hHfMok65hHp+PyY7CEHAdcWFML7WHqpgaaWCGRhppsEtyTsubfnTCsKZ+uYcWYjMcx2QSu6
        ZP9I/D1HGaHYKzxI6RhQ8bvArBhvLPMdFDwUxX5eso3Y74XFvHQ99gbIlCA2Arr8ILCgd0+kr+Sye
        mRq5FkEQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMcWs-001gXv-Vf; Wed, 17 Mar 2021 20:12:31 +0000
Subject: Re: [PATCH] devicetree: bindings: clock: Minor typo fix in the file
 armada3700-tbg-clock.txt
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20210317100840.2449462-1-unixbhaskar@gmail.com>
 <546989ea-c6b2-42e4-46b2-d7de5d208728@infradead.org>
 <YFJcl6i95cRM22MI@ArchLinux>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <efc138db-d82d-a9f0-ca7b-61ae993e0459@infradead.org>
Date:   Wed, 17 Mar 2021 13:12:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFJcl6i95cRM22MI@ArchLinux>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 12:46 PM, Bhaskar Chowdhury wrote:
> On 10:32 Wed 17 Mar 2021, Randy Dunlap wrote:
>> On 3/17/21 3:08 AM, Bhaskar Chowdhury wrote:
>>>
>>> s/provde/provide/
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>
>> Bhaskar,
>>
>> Did you send this one to "robh+dt@kernel.org"?
>> AFAICT, it was sent to "dt@kernel.org", which bounces.
>>
>> If you used "robh+dt@kernel.org", it appears that 'get send-email' has a problem with that.
>>
> I sent out a mail to David and Rob, including you for the same problem . Hope
> David will do something to change that address or Rob might do something . So
> that it will not bounce in future.

David said that vger isn't modifying the email address.
And there is nothing wrong with it (robh+dt@kernel.org),
although it appears that either git send-email or just gmail.com
does not like it.


> Lets see.
>> thanks.
>>
>>> ---
>>>  .../devicetree/bindings/clock/armada3700-tbg-clock.txt          | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
>>> index 0ba1d83ff363..ed1df32c577a 100644
>>> --- a/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
>>> +++ b/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
>>> @@ -1,6 +1,6 @@
>>>  * Time Base Generator Clock bindings for Marvell Armada 37xx SoCs
>>>
>>> -Marvell Armada 37xx SoCs provde Time Base Generator clocks which are
>>> +Marvell Armada 37xx SoCs provide Time Base Generator clocks which are
>>>  used as parent clocks for the peripheral clocks.
>>>
>>>  The TBG clock consumer should specify the desired clock by having the
>>> -- 
>>
>>
>> -- 
>> ~Randy
>>


-- 
~Randy

