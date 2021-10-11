Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF40429279
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhJKOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbhJKOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:48:19 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248EDC061570;
        Mon, 11 Oct 2021 07:46:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bi9so2735726qkb.11;
        Mon, 11 Oct 2021 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9FhSApa8SGKwm062OTtOkqvZSFcRaBYX9rKYawmdJ7g=;
        b=DEwwSEW3Bm6YfRPwm97Xw1mgFE4BWlGpGhWTH0aRwH3lhLbjtPiEzQC1bU+Mz3zFpC
         05xNWUSliXQOJi8mJZXc67MIDaflgyNeImZTAobNwGPiD+sfA+IVbJikWR0kTnZjLbMx
         KZIZeIFpvEZQ8Bty+odWGwfpaGckIUv/a0LqIRWyF95YeAiKFVsBXMo7CY2op+nM7HbK
         pYHWVakEkiBfdY7sxrFIQmhSoAinQMR3s0SS7BKLS10WOzch2Q6dJlZAsd00dTKxcMMs
         uJUacXa+Yo2eEFBUbSU0+BTUHVuT9m283h1KBfL12p+FoF9VSDzfkZZycr4F+yjgtUaW
         opxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9FhSApa8SGKwm062OTtOkqvZSFcRaBYX9rKYawmdJ7g=;
        b=qVhlnzfH03vOn/a1yLP+84GwOH2JtxHSNv3L9BXnuQvIo2OGs3JM2+F3NP5Dml/mhQ
         qxIP4zId5BQzTRc9ng+J+OzcZ1YDK3mrgdHEnKgoYw8aDbrv2OWaZN/rgLTRR/uEE/ug
         B2zruLoJ8sn7MAkUQ5IaqioKZWxdT7TiHF5AegsiK25G/bVjr3MweMDG0Pq81aMN6rtL
         WAVEZ9NchFBi5rRvv9IKeBHMFAtURSZUJ86XAZtkUcS0zJk1KscY318pNzk4OselznGZ
         M8sIBXnZmatzqGZt0mgQW2vvzQnWSeDkqu+94l8N3zv8M0Q3kxPuRap8ElSUIx+HPwnS
         DS9Q==
X-Gm-Message-State: AOAM531uz8/nEOckfLJEe9f/ikeJZU7znu7Dl5S7YeZB3aM9cVnt0kp8
        iPPnUDc8CPB188NTz24CAN4=
X-Google-Smtp-Source: ABdhPJzx8LMBmhPf+1vDInmOxDTwr2Bo1SGvrK5nf/1Zf1ljpsDbGZsCMykcUdfZfzeYlkrBYqEJVQ==
X-Received: by 2002:a37:6cc:: with SMTP id 195mr14895425qkg.473.1633963578284;
        Mon, 11 Oct 2021 07:46:18 -0700 (PDT)
Received: from ?IPv6:2600:2b00:7f04:c300:b01e:1134:3ab1:111a? ([2600:2b00:7f04:c300:b01e:1134:3ab1:111a])
        by smtp.gmail.com with ESMTPSA id q11sm2619127qkj.96.2021.10.11.07.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 07:46:17 -0700 (PDT)
Subject: Re: [PATCH 6/9] of: add support for 'dynamic' DT property
From:   Frank Rowand <frowand.list@gmail.com>
To:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <20211007000954.30621-7-zev@bewilderbeest.net>
 <7bf5cfce-e84d-f0e8-e6e8-8e6fedffd154@gmail.com>
 <05e4c31e-db7e-e8f2-fa37-3cdcdf902e19@gmail.com>
Message-ID: <c6001d43-b47c-e232-38de-9227b8d3581a@gmail.com>
Date:   Mon, 11 Oct 2021 09:46:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <05e4c31e-db7e-e8f2-fa37-3cdcdf902e19@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 10/11/21 8:58 AM, Frank Rowand wrote:
> Hi Matt, Greg,

That was meant to be Rob, not Matt.

-Frank

> 
> On 10/8/21 1:51 PM, Frank Rowand wrote:
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
> After pondering, this approach does not appear workable to me.
> 
> If we allow one property to be writable via sysfs we open the door for any property to
> be writable from sysfs.  This will likely lead to a desire to modify more than one
> related property as a single transaction (so that the changes occur as a single
> transaction, under a single lock event, with a single notification after all
> of the properties are modified).  This is not meant to be an exhaustive list of
> the issues that have already been thought through in the context of overlays
> (though not all of the issues have been addressed with overlays, at least many
> of them, such as one transaction to apply an entire overlay, have been.)
> 
> I don't want to make this a long missive, but will at least note the next
> issue that popped up in my pondering, which is complications from modifying
> the same items in a devicetree via different methods, such as both writing
> to sysfs and applying/removing overlays.  If the problems in the previous
> paragraph are not sufficient to prevent the sysfs approach then I can
> elaborate further on these additional issues.
> 
> So another approach is needed.  I have no yet thought this through, but I
> have an alternative.  First, change the new property name from "dynamic"
> to something more descriptive like "ownership_shifts_between_os_and_others"
> (yes, my suggestions is way too verbose and needs to be word smithed, but
> the point is to clearly state the underlying action that occurs), then
> define the result of this variable to be driver specific, where the
> driver is required upon probe to instantiate the device in a manner
> that does not impact the other user(s) of the underlying hardware
> and to use a driver specific method to transfer control of the
> hardware between the os and the other user(s).  I propose the method
> would be via a device specific file (or set of files) in sysfs (Greg's
> input invited on the use of sysfs in this manner - if I recall correctly
> this is the current preferred mechanism).
> 
> -Frank
> 
> 
>> probably belongs in drivers/of/dynamic.c so that it is easier to maintain and keep
>> consistent with other dynamic devicetree updates.  If you look at the code there
>> that touches deadprops (eg __of_changeset_entry_apply()) you will notice that the
>> locking issues are more extensive than what is implemented here.
>>
>> I'm still thinking about how this interacts with other forms of dynamic devicetree
>> changes (eg drivers/of/dynamic.c and also overlays).
>>
>>> +    /*
>>> +     * of_update_property_self() doesn't free replaced properties, so
>>> +     * rifle through deadprops first to see if there's an equivalent old
>>> +     * status property we can reuse instead of allocating a new one.
>>> +     */
>>> +    mutex_lock(&of_mutex);
>>> +    for (deadprev = &np->deadprops; *deadprev; deadprev = &(*deadprev)->next) {
>>> +            struct property *deadprop = *deadprev;
>>> +            if (!strcmp(deadprop->name, "status") &&
>>> +                deadprop->length == strlen(newstatus) + 1 &&
>>> +                !strcmp(deadprop->value, newstatus)) {
>>> +                    *deadprev = deadprop->next;
>>> +                    deadprop->next = NULL;
>>> +                    newprop = deadprop;
>>> +                    break;
>>> +            }
>>> +    }
>>> +    mutex_unlock(&of_mutex);
>>> +
>>> +    if (!newprop) {
>>> +            newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
>>> +            if (!newprop)
>>> +                    return -ENOMEM;
>>> +
>>> +            newprop->name = oldprop->name;
>>> +            newprop->value = newstatus;
>>> +            newprop->length = strlen(newstatus) + 1;
>>> +    }
>>> +
>>> +    rc = of_update_property_self(np, newprop, true);
>>
>> -Frank
>>
>>> +
>>> +    return rc ? rc : count;
>>> +}
>>> +
>>>  /* always return newly allocated name, caller must free after use */
>>>  static const char *safe_name(struct kobject *kobj, const char *orig_name)
>>>  {
>>> @@ -79,6 +142,12 @@ int __of_add_property_sysfs(struct device_node *np, struct property *pp)
>>>      pp->attr.size = secure ? 0 : pp->length;
>>>      pp->attr.read = of_node_property_read;
>>>  
>>> +    if (!strcmp(pp->name, "status") && of_property_read_bool(np, "dynamic")) {
>>> +            pp->attr.attr.mode |= 0200;
>>> +            pp->attr.write = of_node_status_write;
>>> +            pp->attr.growable = true;
>>> +    }
>>> +
>>>      rc = sysfs_create_bin_file(&np->kobj, &pp->attr);
>>>      WARN(rc, "error adding attribute %s to node %pOF\n", pp->name, np);
>>>      return rc;
>>>

