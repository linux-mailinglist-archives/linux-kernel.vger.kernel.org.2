Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EFC30AEF4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhBASSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:18:40 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:42728 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232191AbhBASPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:13 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 8C9257FF8;
        Mon,  1 Feb 2021 10:13:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8C9257FF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1612203239;
        bh=ayfW5Vkdhajy5MUk6icIafXqQPZa9kC/7ZCnvXke+7U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SPLuYfLatgtOGgWRNVr3gh/KnEvmo05T5a8ulg+cLzV25Gj7Su8s2u+RaroKnKuf5
         JZWNDTXxf3JKJ7GxXlIm/D1X2udEBWq7l9fN3lvP3i70I0gu6jY7oP+En7lRkubpqg
         MQ+BCF1IB4Q6XsGTsgqDHC8bAOSow9Im+5QUsF20=
Subject: Re: [PATCH v3] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20210131233049.5500-1-scott.branden@broadcom.com>
 <YBexqH9KZEMs2fq0@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <30098c21-f0aa-55f3-8e1f-c7bb8ae8be0e@broadcom.com>
Date:   Mon, 1 Feb 2021 10:13:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBexqH9KZEMs2fq0@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,,

I need a few clarifications before sending (hopefully) final revisions to the patch.

On 2021-01-31 11:45 p.m., Greg Kroah-Hartman wrote:
> On Sun, Jan 31, 2021 at 03:30:49PM -0800, Scott Branden wrote:
>> Correct compile issue if CONFIG_TTY is not set by
>> only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>
>> ---
>> Changes since v2:
>> - add CONFIG_BCM_VK_TTY
>> - add function and stub for bcm_vk_tty_set_irq_enabled
>> Changes since v1:
>> - add function stubs rather than compiling out code
>> ---
>>  drivers/misc/bcm-vk/Kconfig      | 16 ++++++++++++
>>  drivers/misc/bcm-vk/Makefile     |  4 +--
>>  drivers/misc/bcm-vk/bcm_vk.h     | 42 +++++++++++++++++++++++++++++---
>>  drivers/misc/bcm-vk/bcm_vk_dev.c |  5 ++--
>>  drivers/misc/bcm-vk/bcm_vk_tty.c |  6 +++++
>>  5 files changed, 65 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
>> index 052f6f28b540..16ce98c964b8 100644
>> --- a/drivers/misc/bcm-vk/Kconfig
>> +++ b/drivers/misc/bcm-vk/Kconfig
>> @@ -15,3 +15,19 @@ config BCM_VK
>>  	  accelerators via /dev/bcm-vk.N devices.
>>  
>>  	  If unsure, say N.
>> +
>> +if BCM_VK
> No need for this, just put it on the depends line, right?
If you prefer I can but it on the depends on line.
But, I actually prefer the if syntax in this case as it more clearly shows
BCM_VK_TTY is a suboption of BCM_VK.

Please let me know which method is "right"?
>
>> +
>> +config BCM_VK_TTY
>> +	bool "Enable ttyVK"
> Better config help text to explain what this is?
I'll change it to the following?

"Enable tty's on VK devices"
>
>> +	depends on TTY
>> +	default y
> Default y is only there if your system can not boot without it, please
> remove it.
I can remove if really needed but I'd like to learn more about such convention.
Is there a document I can learn from describing such?

We actually want a full featured driver by default.  Otherwise we'll end up asking people to enable this
feature and recompile the driver to get missing features such as this.
>
>> +	help
>> +	  Select this option to enable ttyVK support to allow console
>> +	  access to VK cards from host.
> Again, more help text, what is a "VK"?
VK is already described in BCM_VK.  Why would I need to add the same information again to a suboption?
Perhaps you would like "config BCM_VK" changed to "menuconfig BCM_VK"
>
> thanks,
>
> greg k-h
Thanks,
 Scott
