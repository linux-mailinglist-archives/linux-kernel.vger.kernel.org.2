Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C95347D59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhCXQL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:11:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25210 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCXQLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:11:31 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210324161129epoutp0288782efe02299d011f74d1ca22726acc~vUzeuQCP61979219792epoutp02t
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:11:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210324161129epoutp0288782efe02299d011f74d1ca22726acc~vUzeuQCP61979219792epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616602289;
        bh=d43yLrzKbn02WYo5J6DVqU1nSTLECdjBpQgbBipXsxc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=eDQIPPMmLkjpgBr9Adz5QIIktNDO/bzKnIFT9YWMgX8n5Glh4WMuBvfN7SyTZpHbA
         wzVRVxQg7ex4m7rykg75GUV6TyDNgXz6KbJBwryfefBGnKkFvS+v8bNImOg4pVAACU
         xJQ8L44Qs2h7whkjvXP7/6liTZU8w548sfyggKak=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210324161128epcas5p437701f0a32ac71ae2c28c2aa74ac3151~vUzdPBYjP0161901619epcas5p4J;
        Wed, 24 Mar 2021 16:11:28 +0000 (GMT)
X-AuditID: b6c32a4a-625ff7000000989c-a5-605b64b06d69
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.C2.39068.0B46B506; Thu, 25 Mar 2021 01:11:28 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 2/2] arm64: print alloc free paths for address in
 registers
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "pcc@google.com" <pcc@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "amit.kachhap@arm.com" <amit.kachhap@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20210324115113.GA19135@C02TD0UTHF1T.local>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210324144031epcms5p30f848873ba3a4e20f4eb4e5d13d381f7@epcms5p3>
Date:   Wed, 24 Mar 2021 20:10:31 +0530
X-CMS-MailID: 20210324144031epcms5p30f848873ba3a4e20f4eb4e5d13d381f7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7bCmhu6GlOgEg3+3uCwmTHvBYnFxd6rF
        nPVr2CymfNjBavF+WQ+jxf19y5ksznTnWmx6fI3V4vKuOWwWS69fZLLYNms5m0X/netA7oq3
        rBaHTs5ltNj77yeLRcsdUwcBjzXz1jB6zG64yOKxc9Zddo8Fm0o9Nq3qZPM4MeM3i8fmJfUe
        fVtWMXpsPl3t8XmTXABXFJdNSmpOZllqkb5dAlfGoQMPWQt2SlXcXruVuYHxkXAXIyeHhICJ
        xNKf05m7GLk4hAR2M0pMu7KKtYuRg4NXQFDi7w6wGmGBQIk1a38xgthCAooSF2asYQQpERYw
        kPi1VQMkzCagJ7Fq1x4WEFtEQF2iZ9cXFpCRzALtbBIHD0xjh9jFKzGj/SkLhC0tsX35VrCZ
        nAIWEr8v32CGiItK3Fz9lh3Gfn9sPiOELSLReu8sVI2gxIOfu6HiMhKrN/eCLZMQ6GaUePyj
        Gap5DqPEjyU+ELa5xO4N88AW8wr4Sjy8O40NxGYRUJX4cGI9E0SNi8TDI0fAhjILyEtsfzuH
        GeRJZgFNifW79CFKZCWmnlrHBFHCJ9H7+wkTzF875sHYqhItNzewwvz4+eNHqH89JM5uBfkL
        FM7fGSW+PJrBNoFRYRYiqGch2TwLYfMCRuZVjJKpBcW56anFpgVGeanlesWJucWleel6yfm5
        mxjBiU7Lawfjwwcf9A4xMnEwHmKU4GBWEuFtCY9IEOJNSaysSi3Kjy8qzUktPsQozcGiJM67
        w+BBvJBAemJJanZqakFqEUyWiYNTqoFpubB0nqTryvkz5y+LWbLssfwn+WtHF1x9uji2rjvy
        4BGDgHkaKxSkIl+wL/nxefLn9oP6YvOE5SV3v/72klP6z5Jcdadrl5a8N55jtGzq+i6FmOt3
        uAXVqx+E/V+q/2OGvsDB/B950yVmdTYxengJ/lk4fWcE31TJjhk/Dirs3LHsiuKHw1kSF+cs
        u99ltm1nwbFrt9ZppD+5mHBiYkz0/9nhG49VvTV6KVN/1Lt2nlfApH7Zz3P8Rdij0qPKj56c
        eM3U8mrF/f+CfXzX9dq8NU1N+p59qVwcFra0T4V93qy/YhyuNUkn1bcHtRyOc1bjO86rqSHb
        6q887ZXDgq3mrIznIh5Y73xsqGpbe3b9SSWW4oxEQy3mouJEABIlWc/jAwAA
X-CMS-RootMailID: 20210324065516epcas5p450958011b69f5941e8f2bc993b82b904
References: <20210324115113.GA19135@C02TD0UTHF1T.local>
        <1616568899-986-1-git-send-email-maninder1.s@samsung.com>
        <1616568899-986-2-git-send-email-maninder1.s@samsung.com>
        <CGME20210324065516epcas5p450958011b69f5941e8f2bc993b82b904@epcms5p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
>This path is used for a number of failures that might have nothing to do
>with a use-after-free, and from the trimmed example below it looks like
>this could significantly bloat the panic and potentially cause important
>information to be lost from the log, especially given the large number
>of GPRs arm64 has.
> 
>Given that, I suspect this is not something we want enabled by default.
>

Yes it will add a lot of logs in case of normal die also.
But it can suggest free and alloc paths which can help in some debugging.

>When is this logging enabled? I assume the kernel doesn't always record
>the alloc/free paths. Is there a boot-time option to control this?
> 

if SLUB_DEBUG_ON is enabled at build time then it is enabled from boot,
otherwise it can be enabled by kernel command line parameter of "slub_debug=u"
if SLUB_DEBUG is enabled.


>How many lines does this produce on average?
> 

16 traces at max for alloc and 16 for free path.
so in total for slab object 34 lines will be printed,
otherwise one line for each object info of vmalloc.

>>  
>> +void __show_regs_alloc_free(struct pt_regs *regs)
>> +{
>> +        int i;
>> +
>> +        /* check for x0 - x29 only */
> 
>Why x29? The AAPCS says that's the frame pointer, so much like the SP it
>shouldn't point to a heap object.

yes x29 can be ignored.

> 
>> +        for (i = 0; i <= 29; i++) {
>> +                pr_alert("Register x%d information:", i);
>> +                mem_dump_obj((void *)regs->regs[i]);
>> +        }
>> +}
> 
>The pr_alert() is unconditional -- can mem_dumpo_obj() never be
>disabled?
>

mem_dump_obj is dependent on CONFIG_PRINTK

>What loglevel does mem_dump_obj() use? Generally we try to keep that
>matched, so I'm surprised it isn't taken as a parameter.
> 

loglevel of mem_dump_obj is pr_cont, so it will be with the caller's loglevel

/**
 * mem_dump_obj - Print available provenance information
 * @object: object for which to find provenance information.
 *
 * This function uses pr_cont(), so that the caller is expected to have
 * printed out whatever preamble is appropriate.  
 
 
But loglvel will be changed to pr_info when it goes for printing of traces.

void kmem_dump_obj(void *object)
{
....
                pr_cont("\n");
        for (i = 0; i < ARRAY_SIZE(kp.kp_stack); i++) {
                if (!kp.kp_stack[i])
                        break;
                pr_info("    %pS\n", kp.kp_stack[i]);
        }

...

>> +
>>  void show_regs(struct pt_regs *regs)
>>  {
>>          __show_regs(regs);
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index a05d34f0e82a..cb4858c6e57b 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -104,6 +104,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
>>  
>>          print_modules();
>>          show_regs(regs);
>> +        __show_regs_alloc_free(regs);
> 
>As above, I'm not sure this is the right place to put this. We can get
>here for reasons other than UAF, and I'm sure we can trigger panics via
>UAF without going via this.
> 

Adding call here, because we though in case of use after free __die will be called.
due to unhandled page fault of 0x6b6b6 MAGIC value. thats why picked this place.

Thanks,
Maninder Singh
 
