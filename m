Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E685C341BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhCSLqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCSLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:46:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:46:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lNDa0-0005zG-3l; Fri, 19 Mar 2021 12:46:12 +0100
Subject: Re: [PATCH v2 2/2] driver core: add helper for deferred probe reason
 setting
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210319110459.19966-1-a.fatoum@pengutronix.de>
 <20210319110459.19966-2-a.fatoum@pengutronix.de>
 <CAHp75VdjefJHMu2ot7RoZZZis0aNyV097J34wxDSwLgh3bQ8Pg@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <d8317cce-f5de-062f-70f5-6317032d6991@pengutronix.de>
Date:   Fri, 19 Mar 2021 12:46:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdjefJHMu2ot7RoZZZis0aNyV097J34wxDSwLgh3bQ8Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.21 12:13, Andy Shevchenko wrote:
> On Fri, Mar 19, 2021 at 1:05 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> We now have three places within the same file doing the same operation
>> of freeing this pointer and setting it anew. A helper make this
> 
> makes
> 
>> arguably easier to read, so add one.
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks will add for v3.

> Now I'm wondering why deferred_probe_reason is not defined with const.
> 
> Can you check and maybe squeeze a patch in the middle (before these
> two of this series) to move to const?

The deferred_probe_reason is only used in this file and it either holds
NULL or a pointer to a dynamically allocated string. I don't see a reason
why the member should be const.

Cheers,
Ahmad

>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>> v1 -> v2:
>>  - no change
>> ---
>>  drivers/base/dd.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index e2cf3b29123e..4201baa1cc13 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -69,6 +69,12 @@ static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
>>   */
>>  static bool defer_all_probes;
>>
>> +static void __device_set_deferred_probe_reason(const struct device *dev, char *reason)
>> +{
>> +       kfree(dev->p->deferred_probe_reason);
>> +       dev->p->deferred_probe_reason = reason;
>> +}
>> +
>>  /*
>>   * deferred_probe_work_func() - Retry probing devices in the active list.
>>   */
>> @@ -97,8 +103,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>>
>>                 get_device(dev);
>>
>> -               kfree(dev->p->deferred_probe_reason);
>> -               dev->p->deferred_probe_reason = NULL;
>> +               __device_set_deferred_probe_reason(dev, NULL);
>>
>>                 /*
>>                  * Drop the mutex while probing each device; the probe path may
>> @@ -140,8 +145,7 @@ void driver_deferred_probe_del(struct device *dev)
>>         if (!list_empty(&dev->p->deferred_probe)) {
>>                 dev_dbg(dev, "Removed from deferred list\n");
>>                 list_del_init(&dev->p->deferred_probe);
>> -               kfree(dev->p->deferred_probe_reason);
>> -               dev->p->deferred_probe_reason = NULL;
>> +               __device_set_deferred_probe_reason(dev, NULL);
>>         }
>>         mutex_unlock(&deferred_probe_mutex);
>>  }
>> @@ -220,11 +224,12 @@ void device_unblock_probing(void)
>>  void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf)
>>  {
>>         const char *drv = dev_driver_string(dev);
>> +       char *reason;
>>
>>         mutex_lock(&deferred_probe_mutex);
>>
>> -       kfree(dev->p->deferred_probe_reason);
>> -       dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
>> +       reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
>> +       __device_set_deferred_probe_reason(dev, reason);
>>
>>         mutex_unlock(&deferred_probe_mutex);
>>  }
>> --
>> 2.29.2
>>
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
