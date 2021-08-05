Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E743E1CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbhHET0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhHET0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:26:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61D7060E8D;
        Thu,  5 Aug 2021 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628191599;
        bh=/SIk1Ct6Y5mcuV42VIGuw7hDXxZz8BmlXHlb3k2//zU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TCIM/Fx/5X4uoIgBylthoxp417pA0rWdMteKRtWmeh700Me4N/0GnDBYMIgB00Xv2
         JCdRoSpfNGxYXsQENrQq240uX41QsT0lo48zIUzyZ7kVsAKl8TR/397+qt7534g9j3
         WNI2r4NQkzZPDD9TLxsbSpbY0OpKB8QMMWUGGS2fjCpTMab0wl3RuEWU5pr9VNDfpq
         cfXZzPzWn7YCAjlFFZKYTMM2E0mLV2LYtNkZhgG4wRmeyu92+PpApSbWRX9BcuL4+K
         WUaoa3LFSuoc/RPD+tU1o2Sn926fEF4GnkrYTaOJArnjL9o3F8AnwEbn8Eznqkdv2M
         fydkVg589xleQ==
Subject: Re: [PATCH v3] ucounts: add missing data type changes
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210730062854.3601635-1-svens@linux.ibm.com>
 <YQn+GomdRCoYc/E8@Ryzen-9-3900X.localdomain> <875ywlat5e.fsf@disp2133>
 <94478003-8259-4b57-6d93-5a07e0750946@kernel.org> <87v94jalck.fsf@disp2133>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <56b7c0fe-f2e1-7c4f-eb1b-1d9793dea5a8@kernel.org>
Date:   Thu, 5 Aug 2021 12:26:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87v94jalck.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/2021 9:48 AM, Eric W. Biederman wrote:
> Nathan Chancellor <nathan@kernel.org> writes:
> 
>> Hi Eric,
>>
>> On 8/4/2021 12:47 PM, Eric W. Biederman wrote:
>>> Nathan Chancellor <nathan@kernel.org> writes:
>>>
>>>> On Fri, Jul 30, 2021 at 08:28:54AM +0200, Sven Schnelle wrote:
>>>>> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
>>>>> changed the data type of ucounts/ucounts_max to long, but missed to
>>>>> adjust a few other places. This is noticeable on big endian platforms
>>>>> from user space because the /proc/sys/user/max_*_names files all
>>>>> contain 0.
>>>>>
>>>>> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
>>>>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>>>>
>>>> This patch in -next as commit e43fc41d1f7f ("ucounts: add missing data type
>>>> changes") causes Windows Subsystem for Linux to fail to start:
>>>>
>>>> [error 0x8007010b when launching `wsl.exe -d Arch'] Could not access starting
>>>> directory "\\wsl$\Arch\home\nathan"
>>>>
>>>> Specifically, it is the change to max_user_watches in
>>>> fs/notify/inotify/inotify_user.c, as the below diff gets me back to working.
>>>> Unfortunately, I have no additional information to offer beyond that as WSL's
>>>> init is custom and closed source (as far as I am aware) and there are no real
>>>> debugging utilities.
>>>
>>> Could you try this patch and tell us what value is being set?
>>>
>>> The only think I can imagine is that someone wants unlimited watches and
>>> sets the value to a ridiculously large value and the interpretation of
>>> that value winds up being different between int and long.
>>>
>>> This should allow you to read either dmesg or the kernel's log as it
>>> boots up and see what value is being written.  From there it should
>>> be relatively straight forward to figure out what is going on.
>>
>> I applied this diff on top of mine and running 'dmesg |& grep intvec' shows:
>>
>> [    0.282500] intvec: dmesg_restrict <- 0
>> [    0.282510] intvec: max_user_watches <- 524288
>>
>> This seems much smaller than INT_MAX so I am not sure how the value could be
>> different between int and long but I am not at all familiar with the sysctl
>> code.
>>
>> More than happy to continue to test debug patches or provide any additional
>> information as I can.
> 
> Yes.  Very strange.
> 
> Could you perhaps try the instrumenting proc_doulongvec_minmax the same
> way and see what is written in the failing case?
> 
> While looking at the code I did see one other serious bug.  The min and
> max values are int constants intstead of long constants.
> 
> Could you test the change below and see if it makes a difference?

That indeed fixes the issue! I assume you will squash it into the 
original commit but if not, feel free to add:

Tested-by: Nathan Chancellor <nathan@kernel.org>

> Eric
> 
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 6576657a1a25..28b67cb9458d 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -54,6 +54,9 @@ static int fanotify_max_queued_events __read_mostly;
>   
>   #include <linux/sysctl.h>
>   
> +static long ft_zero = 0;
> +static long ft_int_max = INT_MAX;
> +
>   struct ctl_table fanotify_table[] = {
>   	{
>   		.procname	= "max_user_groups",
> @@ -61,8 +64,8 @@ struct ctl_table fanotify_table[] = {
>   		.maxlen		= sizeof(long),
>   		.mode		= 0644,
>   		.proc_handler	= proc_doulongvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_INT_MAX,
> +		.extra1		= &ft_zero,
> +		.extra2		= &ft_int_max,
>   	},
>   	{
>   		.procname	= "max_user_marks",
> @@ -70,8 +73,8 @@ struct ctl_table fanotify_table[] = {
>   		.maxlen		= sizeof(long),
>   		.mode		= 0644,
>   		.proc_handler	= proc_doulongvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_INT_MAX,
> +		.extra1		= &ft_zero,
> +		.extra2		= &ft_int_max,
>   	},
>   	{
>   		.procname	= "max_queued_events",
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 55fe7cdea2fb..62051247f6d2 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -55,6 +55,9 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
>   
>   #include <linux/sysctl.h>
>   
> +static long it_zero = 0;
> +static long it_int_max = INT_MAX;
> +
>   struct ctl_table inotify_table[] = {
>   	{
>   		.procname	= "max_user_instances",
> @@ -62,8 +65,8 @@ struct ctl_table inotify_table[] = {
>   		.maxlen		= sizeof(long),
>   		.mode		= 0644,
>   		.proc_handler	= proc_doulongvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_INT_MAX,
> +		.extra1		= &it_zero,
> +		.extra2		= &it_int_max,
>   	},
>   	{
>   		.procname	= "max_user_watches",
> @@ -71,8 +74,8 @@ struct ctl_table inotify_table[] = {
>   		.maxlen		= sizeof(long),
>   		.mode		= 0644,
>   		.proc_handler	= proc_doulongvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_INT_MAX,
> +		.extra1		= &it_zero,
> +		.extra2		= &it_int_max,
>   	},
>   	{
>   		.procname	= "max_queued_events",
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 260ae7da815f..bb51849e6375 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -58,14 +58,17 @@ static struct ctl_table_root set_root = {
>   	.permissions = set_permissions,
>   };
>   
> +static long ue_zero = 0;
> +static long ue_int_max = INT_MAX;
> +
>   #define UCOUNT_ENTRY(name)					\
>   	{							\
>   		.procname	= name,				\
>   		.maxlen		= sizeof(long),			\
>   		.mode		= 0644,				\
>   		.proc_handler	= proc_doulongvec_minmax,	\
> -		.extra1		= SYSCTL_ZERO,			\
> -		.extra2		= SYSCTL_INT_MAX,		\
> +		.extra1		= &ue_zero,			\
> +		.extra2		= &ue_int_max,			\
>   	}
>   static struct ctl_table user_table[] = {
>   	UCOUNT_ENTRY("max_user_namespaces"),
> 
> 
> 
