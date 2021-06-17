Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B313AB3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhFQMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhFQMjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:39:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3723610CA;
        Thu, 17 Jun 2021 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623933423;
        bh=vtIoA3RUe9cfBWUdhTz7R1sk/khl1Kit7uv87wGgMwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3s56ziwwBuYAAcAAaOb5NasxsTephHi7oyHCorEYVIRQufV3DpM+2sYXh/hqTEo0
         0xZU8wn8q+6PmzRxv3He6H+rW1zIuk5XDBdfnMOV8DahEKn8nW/ZAD09IGyiH8DVeu
         pfePkV2t/q4AZHSV7cR0iXMqNsU5geItSPo3ys2Vt7UEx53v2Kq8JiYMI86mYEW0wV
         nqJNFxofVKcLvxWJM8mlB6i38wThfWdODjuR5vPy/U46LDlJurv8mJQQVW3no6rlXL
         W9CC21egH4K6TdC7T9WFDEGUv5XXwPrrJ7qc9/3z/mbB3NF6vfYFvluImOdz9rGP1L
         7DpeLTuYBaarQ==
Date:   Thu, 17 Jun 2021 14:36:56 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v7 0/5] printk: Userspace format indexing support
Message-ID: <YMtB6Anv98O4mW9C@linux.fritz.box>
References: <cover.1623775748.git.chris@chrisdown.name>
 <YMsfo3/b1LvOoiM0@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YMsfo3/b1LvOoiM0@alley>
X-OS:   Linux linux.fritz.box 5.12.9-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Petr Mladek [17/06/21 12:10 +0200]:
>On Tue 2021-06-15 17:52:20, Chris Down wrote:
>> We have a number of systems industry-wide that have a subset of their
>> functionality that works as follows:
>>
>> 1. Receive a message from local kmsg, serial console, or netconsole;
>> 2. Apply a set of rules to classify the message;
>> 3. Do something based on this classification (like scheduling a
>>    remediation for the machine), rinse, and repeat.
>>
>> This provides a solution to the issue of silently changed or deleted
>> printks: we record pointers to all printk format strings known at
>> compile time into a new .printk_index section, both in vmlinux and
>> modules. At runtime, this can then be iterated by looking at
>> <debugfs>/printk/index/<module>, which emits the following format, both
>> readable by humans and able to be parsed by machines:
>>
>>     $ head -1 vmlinux; shuf -n 5 vmlinux
>>     # <level[,flags]> filename:line function "format"
>>     <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
>>     <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
>>     <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
>>     <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
>>     <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
>>
>> This mitigates the majority of cases where we have a highly-specific
>> printk which we want to match on, as we can now enumerate and check
>> whether the format changed or the printk callsite disappeared entirely
>> in userspace. This allows us to catch changes to printks we monitor
>> earlier and decide what to do about it before it becomes problematic.
>>
>> There is no additional runtime cost for printk callers or printk itself,
>> and the assembly generated is exactly the same.
>>
>> Chris Down (5):
>>   string_helpers: Escape double quotes in escape_special
>>   printk: Straighten out log_flags into printk_info_flags
>>   printk: Rework parse_prefix into printk_parse_prefix
>>   printk: Userspace format indexing support
>>   printk: index: Add indexing support to dev_printk
>
>The patchset looks ready for linux-next from my POV. I could fixup the
>messages as suggested by Andy when pushing.
>
>Well, I would still like to get acks from:
>
>   + Andy for the 1st patch
>   + Jessica for the changes in the module loader code in 4th patch.

Hi Petr, the module.{c,h} changes are fine by me:

     Acked-by: Jessica Yu <jeyu@kernel.org>

Thank you,

Jessica
