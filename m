Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214673A1B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFIQwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230242AbhFIQwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623257446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrCtXf49JzCZn5dpJiNF9Oj4zY4Qes8vs6vhU+MkX5Y=;
        b=I0S0+PPe+5y1du0tN2jJ7TxFucVIy7rej8iVDH7PBG9tV9nxubDY2oWcSe64on7KFR+OPX
        8wHILOnC/0xdakPgK20BGLh1h8pHLwkZUwHdN4b9LUBHQS9AfDCvKGHjyuLn/1a7EVjYMg
        dH9GqYzX2rGsKeohXlX40pVqJGGS6VQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-MyGz9V_ANlqcg2gvNVlqTw-1; Wed, 09 Jun 2021 12:50:43 -0400
X-MC-Unique: MyGz9V_ANlqcg2gvNVlqTw-1
Received: by mail-oo1-f69.google.com with SMTP id b9-20020a4a87890000b0290248cb841124so13778813ooi.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 09:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OrCtXf49JzCZn5dpJiNF9Oj4zY4Qes8vs6vhU+MkX5Y=;
        b=T3AKW1r4q5eR1FI50EE4mp2vyFidOhObFcnXQ1IpGHIMFQkLd1+IJmVuz89fb1u3W3
         2DRxd5eNWsWiGWzhgfWIgzdC4iV1ujdDDHKrqDGpqP0OlR1qqMAzqdEzPlA9Jx2BD9ma
         VDB/HEfUakbCNYKPqH0p/Z9KdLsTINyh86xnz27EdfsH9o4POXCngiMjlzXGsWezgZw1
         G6HwbscIsC9Q05Og39jybnDhWY54+OQMsmAo6xdlRhMR3Tt7F2J+j5/9HmV5PCE09UQU
         23VujloN1L+pdXgH4Xmx7CvqCUvnRQWDxaOenjJNj0U++G6OARoPRykKoVLjVkuzfmyy
         YOqQ==
X-Gm-Message-State: AOAM530XGXG4uQUbOQ+AO6namsTNUb+DxTS4iH7SyWwPmWhFd14wX9hw
        WNXUGmtt5fF9nzFDtesD6OMyFyc1ZnDHEr8KjiGbofzJcMhSQHJlXS7kCx8lolgin0IIgxuxeBl
        ALMvBapnA3z8KBqlO2uOr0tR6
X-Received: by 2002:a9d:4105:: with SMTP id o5mr316331ote.20.1623257442830;
        Wed, 09 Jun 2021 09:50:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlqxLGv0YiZs5n6IvS0gh+tJjoLR7xG7pb5AgIFw1+rbYfRnBn+0w4EjGkNDFxCJKICpMBPw==
X-Received: by 2002:a9d:4105:: with SMTP id o5mr316304ote.20.1623257442552;
        Wed, 09 Jun 2021 09:50:42 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o21sm62806oie.34.2021.06.09.09.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 09:50:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] fpga: reorganize to subdirs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210609142208.3085451-1-trix@redhat.com>
 <YMDV7R52QUTFhpHH@kroah.com>
 <2738ee7a-448f-c327-c430-13fb44da45ec@redhat.com>
 <YMDueTEHGWuAcknP@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a35f5fda-a202-dc66-4445-b3ce333a55e6@redhat.com>
Date:   Wed, 9 Jun 2021 09:50:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMDueTEHGWuAcknP@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/21 9:38 AM, Greg KH wrote:
> On Wed, Jun 09, 2021 at 08:08:06AM -0700, Tom Rix wrote:
>> On 6/9/21 7:53 AM, Greg KH wrote:
>>> On Wed, Jun 09, 2021 at 07:22:03AM -0700, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> The incoming xrt patchset has a toplevel subdir xrt/
>>>> The current fpga/ uses a single dir with filename prefixes to subdivide owners
>>>> For consistency, there should be only one way to organize the fpga/ dir.
>>>> Because the subdir model scales better, refactor to use it.
>>>> The discussion wrt xrt is here:
>>>> https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/
>>>>
>>>> Follow drivers/net/ethernet/ which has control configs
>>>> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
>>>> Since fpgas do not have many vendors, drop the 'VENDOR' and use
>>>> FPGA_BLA.
>>>>
>>>> There are several new subdirs
>>>> altera/
>>>> dfl/
>>>> lattice/
>>>> xilinx/
>>>>
>>>> Each subdir has a Kconfig that has a new/reused
>>>>
>>>> if FPGA_BLA
>>>>     ... existing configs ...
>>>> endif FPGA_BLA
>>>>
>>>> Which is sourced into the main fpga/Kconfig
>>>>
>>>> Each subdir has a Makefile whose transversal is controlled in the
>>>> fpga/Makefile by
>>>>
>>>> obj-$(CONFIG_FPGA_BLA) += bla/
>>>>
>>>> Some cleanup to arrange thing alphabetically and make fpga/Makefile's
>>>> whitespace look more like net/'s
>>>>
>>>> Changes from
>>>> v1
>>>>     Drop renaming files
>>>>     Cleanup makefiles
>>> You can rename the files, you just can not rename the .ko objects
>>> without everyone knowing what you are doing and you trying to bury it in
>>> the middle of a differently described patch.
>>>
>>> If you want to do that, do you?  I don't really understand why you want
>>> to move things around right now other than "we have 40 files in one
>>> directory, ick!".
>> I am trying to resolve the layout inconsistency between what we have and
>> what the xrt patchset does.
> Why does it matter?  New stuff can be added to a new dir, why worry
> about old stuff?  What does it hurt?
>
>> The big issue is the files vs dirs.
>>
>> Over specified filenames is secondary, so I dropped them.
>>
>> 40 files in one dir is itself not a problem.
>>
>> having 40 files and an xrt/ is.
> Why is that a "problem"?
>
>> fpga/ layout should be consistent so the Makefile and Kconfig are easier to
>> maintain.
> Is it somehow hard to maintain today?  Seems pretty trivial to me...

This change was to help move xrt along.

If you are fine with xrt/, I will drop this patchset.

Tom

>
> thanks,
>
> greg k-h
>

