Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF33FA821
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 03:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhH2BT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 21:19:29 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:45031 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhH2BT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 21:19:28 -0400
X-Greylist: delayed 21711 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Aug 2021 21:19:27 EDT
Received: from [87.92.210.171] (helo=[192.168.0.111])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <lukas.prediger@lumip.de>)
        id 1mJvWn-0000E5-1t; Sat, 28 Aug 2021 12:25:33 +0200
Subject: Re: [PATCH] drivers/cdrom: improved ioctl for media change detection
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org
References: <20210805194417.12439-1-lumip@lumip.de>
 <6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk>
 <f0d33ff3-6b9d-bbe7-1776-a22f9f271155@lumip.de>
 <5f3b7d8b-9e97-094b-efd1-cad6cab793b6@kernel.dk>
From:   Lukas Prediger <lukas.prediger@lumip.de>
Message-ID: <6bbfc86d-8e3b-db5e-0bf5-8bce63d2049f@lumip.de>
Date:   Sat, 28 Aug 2021 13:27:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5f3b7d8b-9e97-094b-efd1-cad6cab793b6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Df-Sender: bHVrYXMucHJlZGlnZXJAbHVtaXAuZGU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply and sorry for the spam :/. I am not sure what 
happened there.

>> 2. As the last_media_change field will be in ms now, is it safe to
>> convert those back to jiffies for comparison or is there a risk of
>> information loss (due to rounding or whatever) in either conversion?
>> More technically, can I make the assumption that for any jiffies value
>> x it holds that
> The granularity of jiffies depends on the HZ setting, generally just
> consider it somewhere in between 100 and 1000. That's where my initial
> granularity numbers came from.
>
>> time_before(msecs_to_jiffies(jiffies_to_msecs(x)), x) is always false ?
> I don't think that matters. Internally, always keep things in jiffies.
> That's what you use to compare with, and to check if it's changed since
> last time. The only time you convert to ms is to pass it back to
> userspace. And that's going to be a delta of jiffies always, just ensure
> you assign last_checked = jiffies when it's setup initially.
>
The issue I have is that the value I am comparing to is provided by the code
calling the ioctl so that I don't have to maintain state for every potential
calling process in the kernel. Therefore, if we want the API to work with ms,
I have to convert the user provided value back to jiffies for comparison. 

I now ran a brief test that suggests that the above condition does not hold
and therefore the value returned in has_changed may be 1 for subsequent calls
when the disc was not in fact changed.

Workarounds I see would be to either expose the jiffies value through the
API (which is maybe not really clean), or making the comparison on the ms value
(but how to deal with potential wraparounds then?). Of those, I would currently
tend to the first and treat the nature of the returned timestamp as an opaque
value from the user perspective - it is probably not really of any use to them
outside of passing it back into the ioctl for subsequent calls. Do you
see other ways to resolve this I may not have thought of?

Kind regards,
Lukas

