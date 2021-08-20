Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025A63F373E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbhHTXSm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Aug 2021 19:18:42 -0400
Received: from seshat.vectro.org ([212.24.108.39]:59474 "EHLO
        seshat.vectro.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbhHTXSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:18:40 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 19:18:39 EDT
Received: from [IPv6:2603:7000:7f02:f340:9b48:c1b6:d6b0:73ad] (2603-7000-7f02-f340-9b48-c1b6-d6b0-73ad.res6.spectrum.com [IPv6:2603:7000:7f02:f340:9b48:c1b6:d6b0:73ad])
        by seshat.vectro.org (Postfix) with ESMTPSA id C0841100244;
        Sat, 21 Aug 2021 02:08:59 +0300 (EEST)
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20201009144047.505957-1-benjamin@sipsolutions.net>
 <20201028091043.GC1947336@kroah.com> <20201106104725.GC2785199@kroah.com>
 <YR+nwZtz9CQuyTn+@lorien.valinor.li>
 <077990d1e354777c4c6a33866a0916bed6a97ed5.camel@sipsolutions.net>
From:   Ian Turner <vectro@vectro.org>
Subject: Re: [PATCH 0/2] UCSI race condition resulting in wrong port state
Message-ID: <bd81136b-3b52-fbda-780a-9dc58bdeb268@vectro.org>
Date:   Fri, 20 Aug 2021 19:08:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <077990d1e354777c4c6a33866a0916bed6a97ed5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 9:29 AM, Benjamin Berg wrote:
> On Fri, 2021-08-20 at 15:01 +0200, Salvatore Bonaccorso wrote:
>> At least one user in Debian (https://bugs.debian.org/992004) would be
>> happy to have those backported as well to the 5.10.y series (which we
>> will pick up).
>>
>> So if Benjamin ack's this, this would be great to have in 5.10.y.
> Sure, it is reasonable to pull it into 5.10. At the time it just seemed
> to me that it was enough of a corner case to not bother.
>
> Note that there was a somewhat related fix later on (for Qualcomm UCSI
> firmware), which probably makes sense to pull in too then.
>
> Including Bjorn into the CC list for that.
>
> commit 8c9b3caab3ac26db1da00b8117901640c55a69dd
> Author: Bjorn Andersson <bjorn.andersson@linaro.org>
> Date:   Sat May 15 21:09:53 2021 -0700
>
>      usb: typec: ucsi: Clear pending after acking connector change
>   
> Benjamin

I feel that I should mention that I haven't actually tested this change, 
so it's just conjecture on my part that it would fix my issue (though it 
does seem to track pretty closely). I am happy to do that testing if it 
would save others time.

Ian Turner


