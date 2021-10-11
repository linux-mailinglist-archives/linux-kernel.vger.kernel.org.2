Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26334295BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhJKRhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:37:13 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:46583 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJKRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:37:11 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id D272312B;
        Mon, 11 Oct 2021 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633973711;
        bh=37FA9CA4jkUipLpx6mASR21lCskkzjZexvQxoi2xAds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irpmmvZaPGMwlOIi9xZHr3WBV5ncQWV2tnQ7+PODTjtFt/nLyMkYsSujDA1/KBMDH
         C7Q552FOG8yEcEz8F7jAtrlZ65FGfi3sqnSaQPCcIrfrEa56FbPZ/m6A9dB5SxQlVW
         BF6O/6HS+yaMjymyFad5ZFyQu2ObOVmlZ5Lr6w+4=
Date:   Mon, 11 Oct 2021 10:35:05 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] of: add support for 'dynamic' DT property
Message-ID: <YWR1yRmcFU66DnO5@hatter.bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-7-zev@bewilderbeest.net>
 <7bf5cfce-e84d-f0e8-e6e8-8e6fedffd154@gmail.com>
 <05e4c31e-db7e-e8f2-fa37-3cdcdf902e19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <05e4c31e-db7e-e8f2-fa37-3cdcdf902e19@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Thanks for the thorough consideration on this.  (More inline below.)

On Mon, Oct 11, 2021 at 06:58:32AM PDT, Frank Rowand wrote:
>Hi Matt, Greg,
>
>On 10/8/21 1:51 PM, Frank Rowand wrote:
>> On 10/6/21 7:09 PM, Zev Weiss wrote:
>>> Nodes marked with this (boolean) property will have a writable status
>>> sysfs file, which can be used to toggle them between "okay" and
>>> "reserved", effectively hot-plugging them.  Note that this will only
>>> be effective for devices on busses that register for OF reconfig
>>> notifications (currently spi, i2c, and platform), and only if
>>> CONFIG_OF_DYNAMIC is enabled.
>>>
>>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>> ---
>>>  drivers/of/kobj.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 69 insertions(+)
>>>
>>> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
>>> index 378cb421aae1..141ae23f3130 100644
>>> --- a/drivers/of/kobj.c
>>> +++ b/drivers/of/kobj.c
>>> @@ -36,6 +36,69 @@ static ssize_t of_node_property_read(struct file *filp, struct kobject *kobj,
>>>      return memory_read_from_buffer(buf, count, &offset, pp->value, pp->length);
>>>  }
>>>
>>> +static ssize_t of_node_status_write(struct file *filp, struct kobject *kobj,
>>> +                                    struct bin_attribute *bin_attr, char *buf,
>>> +                                    loff_t offset, size_t count)
>>> +{
>>> +    int rc;
>>> +    char *newstatus;
>>> +    struct property **deadprev;
>>> +    struct property *newprop = NULL;
>>> +    struct property *oldprop = container_of(bin_attr, struct property, attr);
>>> +    struct device_node *np = container_of(kobj, struct device_node, kobj);
>>> +
>>> +    if (WARN_ON_ONCE(strcmp(oldprop->name, "status")))
>>> +            return -EIO;
>>> +
>>> +    if (offset)
>>> +            return -EINVAL;
>>> +
>>> +    if (sysfs_buf_streq(buf, count, "okay") || sysfs_buf_streq(buf, count, "ok"))
>>> +            newstatus = "okay";
>>> +    else if (sysfs_buf_streq(buf, count, "reserved"))
>>> +            newstatus = "reserved";
>>> +    else if (sysfs_buf_streq(buf, count, "disabled"))
>>> +            newstatus = "disabled";
>>> +    else
>>> +            return -EINVAL;
>>> +
>>> +    if (!strcmp(newstatus, oldprop->value))
>>> +            return count;
>>> +
>>
>> If the general approach of this patch set is the correct way to provide the desired
>> functionality (I'm still pondering that), then a version of the following code
>
>After pondering, this approach does not appear workable to me.
>

Okay -- I had come to a similar conclusion, if for slightly different 
reasons (basically, just that the sets of "things that would avoid 
binary sysfs attr abuse" and "things that would maintain userspace 
compatibility" seemed pretty disjoint).

> <snip>
>
>So another approach is needed.  I have no yet thought this through, but I
>have an alternative.  First, change the new property name from "dynamic"
>to something more descriptive like "ownership_shifts_between_os_and_others"
>(yes, my suggestions is way too verbose and needs to be word smithed, but
>the point is to clearly state the underlying action that occurs), then
>define the result of this variable to be driver specific, where the
>driver is required upon probe to instantiate the device in a manner
>that does not impact the other user(s) of the underlying hardware
>and to use a driver specific method to transfer control of the
>hardware between the os and the other user(s).  I propose the method
>would be via a device specific file (or set of files) in sysfs (Greg's
>input invited on the use of sysfs in this manner - if I recall correctly
>this is the current preferred mechanism).
>

I'm not sure if you've had a chance to take a look at it already, but 
this sounds fairly similar to the approach I took in the semi-prequel 
series that preceded this one: 
https://lore.kernel.org/openbmc/20210929115409.21254-1-zev@bewilderbeest.net/

The general idea there was to start making use of the "reserved" status 
value (defined in the DT spec but thus far not really implemented 
anywhere that I'm aware of) instead of introducing a new property.

The implementation in that series was very driver-specific (probably 
overly so), but I think could be generalized somewhat in a couple 
directions without an enormous amount of additional work.  First 
(top-down), we could have the driver core avoid automatically binding 
drivers for reserved devices.  Second (bottom-up), the machinery 
implemented in the aspeed-smc driver in that series could be lifted into 
the MTD spi-nor framework as suggested by Dhananjay.

Rob, Greg -- do you think another version of that patch series with 
those changes might be a viable strategy?


Thanks,
Zev

