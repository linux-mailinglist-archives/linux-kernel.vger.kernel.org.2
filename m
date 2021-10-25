Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0F438F06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJYF41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 01:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhJYF4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 01:56:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FEC061745;
        Sun, 24 Oct 2021 22:54:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n2so9357710qta.2;
        Sun, 24 Oct 2021 22:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hd7Jz3ZJ8odvevTvYp5rQZ4T+oiL45RD8cRRUWullVk=;
        b=iVohobba9cc/xCW1riSDrqiEFKZDej+qd3rbCOpZ582iOg4d+AaTJUonPj8oLSsEs7
         byfW9R+o+hu+oSyfxd8aKwI4FnH6k+R2JUZ8a9/AmfDYsbg61DjBr3q1HGyiGYRwUhrf
         1ryOWEXr0mEHGHShoahKsgxltr6O5PmC1Balv8VOQTd29j3e5jPAOzz6W3pKGtLBhSdg
         OoFxhQfjQh/60ZbU1tRuHpr0OvJc48nJ91x2veHi1NvlKvhkTiF3vdzhBwxnR0pS7KfA
         nuD2IbUtRFM1S8ayBc4mPOQdzvZdpXk0ki+gemyZR9m1F026ftwELX09yj5ok8XDMoh/
         yZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hd7Jz3ZJ8odvevTvYp5rQZ4T+oiL45RD8cRRUWullVk=;
        b=Ij3nEpr4h4JXIQH+9/DTYe6i5iLKh+dQ0vivcTtSBBv1NVdRN1IHi67iYw0ARN/462
         yACJupF4WpH7H2zhVjC9b0anbMJsppqLcvBTcz/6IwrTln1uT8ZdnbscXUrpDG1lTx0y
         9vPS05bfpzbCunux2fBMkVFWb1RX6wPqBT8ddjdOYi6ZjEcGrS2I8/OwaMGJEHfBmIfA
         rEmfbeDePpZiE6b2KnAi2KLiPTy6k7yLgXtq92+3g5IA70picBSQa54+zVeOjz/B+kv0
         /SOFFDjCqcXbWCtLIFtQxflB2pYA8i3naRPIVHQxbQnfasex4jc7xJpasMn78uUN+K3b
         iCBg==
X-Gm-Message-State: AOAM532Hpo25UsthHmGSXTY2S6FN8y4kXIqoED72Q7m7e4n9H5JL6HHA
        U9QvsuSq0f0Zg5rtXZcfWcE=
X-Google-Smtp-Source: ABdhPJzjiafIyejagX3sK442FZam2KKfQeKHakEAR+veMDkvLKGUAya8FhMSsZ9hffDuhq50hfAezw==
X-Received: by 2002:a05:622a:1804:: with SMTP id t4mr15809135qtc.251.1635141239604;
        Sun, 24 Oct 2021 22:53:59 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id l3sm8447606qkj.110.2021.10.24.22.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 22:53:59 -0700 (PDT)
Subject: Re: [PATCH 0/5] driver core, of: support for reserved devices
To:     Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>
References: <20211022020032.26980-1-zev@bewilderbeest.net>
 <YXJfHwzIdksUKPIe@kroah.com> <YXJ9yR6b5vI3NwF7@hatter.bewilderbeest.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3a5e271d-d977-7eca-21c5-fd75a2366920@gmail.com>
Date:   Mon, 25 Oct 2021 00:53:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXJ9yR6b5vI3NwF7@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/21 4:00 AM, Zev Weiss wrote:
> On Thu, Oct 21, 2021 at 11:50:07PM PDT, Greg Kroah-Hartman wrote:
>> On Thu, Oct 21, 2021 at 07:00:27PM -0700, Zev Weiss wrote:
>>> Hello all,
>>>
>>> This series is another incarnation of a couple other patchsets I've
>>> posted recently [0, 1], but again different enough in overall
>>> structure that I'm not sure it's exactly a v2 (or v3).
>>>
>>> As compared to [1], it abandons the writable binary sysfs files and at
>>> Frank's suggestion returns to an approach more akin to [0], though
>>> without any driver-specific (aspeed-smc) changes, which I figure might
>>> as well be done later in a separate series once appropriate
>>> infrastructure is in place.
>>>
>>> The basic idea is to implement support for a status property value
>>> that's documented in the DT spec [2], but thus far not used at all in
>>> the kernel (or anywhere else I'm aware of): "reserved".  According to
>>> the spec (section 2.3.4, Table 2.4), this status:
>>>
>>>   Indicates that the device is operational, but should not be used.
>>>   Typically this is used for devices that are controlled by another
>>>   software component, such as platform firmware.
>>>
>>> With these changes, devices marked as reserved are (at least in some
>>> cases, more on this later) instantiated, but will not have drivers
>>> bound to them unless and until userspace explicitly requests it by
>>> writing the device's name to the driver's sysfs 'bind' file.  This
>>> enables appropriate handling of hardware arrangements that can arise
>>> in contexts like OpenBMC, where a device may be shared with another
>>> external controller not under the kernel's control (for example, the
>>> flash chip storing the host CPU's firmware, shared by the BMC and the
>>> host CPU and exclusively under the control of the latter by default).
>>> Such a device can be marked as reserved so that the kernel refrains
>>> from touching it until appropriate preparatory steps have been taken
>>> (e.g. BMC userspace coordinating with the host CPU to arbitrate which
>>> processor has control of the firmware flash).
>>>
>>> Patches 1-3 provide some basic plumbing for checking the "reserved"
>>> status of a device, patch 4 is the main driver-core change, and patch
>>> 5 tweaks the OF platform code to not skip reserved devices so that
>>> they can actually be instantiated.
>>
>> Again, the driver core should not care about this, that is up to the bus
>> that wants to read these "reserved" values and do something with them or
>> not (remember the bus is the thing that does the binding, not the driver
>> core).
>>
>> But are you sure you are using the "reserved" field properly?
> 
> Well, thus far both Rob Herring and Oliver O'Halloran (originator of the "reserved" status in the DT spec, whom I probably should have CCed earlier, sorry) have seemed receptive to this interpretation of it, which I'd hope would lend it some credence.

I am not on board with this interpretation.  To me, if the value of
status is "reserved", then the Linux kernel should _never_ use the
device described by the node.

If a "reserved" node is usable by the Linux kernel, then the specification
should be updated to allow this.  And the specification should probably
be expanded to either discuss how to describe the coordination between
multiple entities or state that the coordination is outside of the
specification and will be implemention dependent.

I am wary of the complexity of the operating system treating a node as
reserved at initial boot, then at some point via coordination with
some other entity starting to use the node.  It is not too complex if
the node is a leaf node with no links (phandles) to or from any other node,
but as soon as links to or from other nodes exist, then other drivers or
subsystems may need to be aware of when the node is available to the
operating system or given back to the other entity then any part of the
operating system has to coordinate in that state transition.  This is
driving a lot of my caution that we be careful to create architecture
and not an ad hoc hack.

-Frank

> 
>> You are
>> wanting to do "something" to the device to later on be able to then have
>> the kernel touch the device, while it seems that the reason for this
>> field is for the kernel to NEVER touch the device at all.  What will
>> break if you change this logic?
> 
> Given that there's no existing usage of or support for this status value anywhere I can see in the kernel, and that Oliver has indicated that it should be compatible with usage in OpenPower platform firmware, my expectation would certainly be that nothing would break, but if there are examples of things that could I'd be interested to see them.
> 
> 
> Thanks,
> Zev
> 

