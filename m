Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B8F3373CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhCKNZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:25:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56134 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCKNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:24:53 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12BDOkql055153;
        Thu, 11 Mar 2021 22:24:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Thu, 11 Mar 2021 22:24:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12BDOjbO055145
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Mar 2021 22:24:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <YEkQ4qS7tkwmjzDn@kroah.com>
 <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
 <YEoTw7CoK7Ob0YR+@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8dc1e893-4338-90ff-ea61-de727cad1d11@i-love.sakura.ne.jp>
Date:   Thu, 11 Mar 2021 22:24:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YEoTw7CoK7Ob0YR+@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/11 21:57, Greg KH wrote:
> On Thu, Mar 11, 2021 at 09:34:38PM +0900, Tetsuo Handa wrote:
>> On 2021/03/11 3:33, Greg KH wrote:
>>> On Sun, Mar 07, 2021 at 08:53:25PM -0700, Shuah Khan wrote:
>>>> This patch series fixes the following problems founds in syzbot
>>>> fuzzing.
>>>
>>> Thanks for these, all now queued up.
>>
>> I send SIGSTOP to
>>
>>   [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races leading to gpf
>>   [PATCH 5/6] usbip: fix vhci_hcd attach_store() races leading to gpf
>>   [PATCH 6/6] usbip: fix vudc usbip_sockfd_store races leading to gpf
>>
>> because these patches merely converted NULL pointer dererefence bug to use-after-free bug
>> by breaking kthread_get_run() into kthread_create()/get_task_struct()/wake_up_process().
> 
> I'll take follow-on patches to fix that other issue, if it's proven to
> be valid.  It's nice to fix up NULL dereference issues as soon as
> possible :)

Not an "other issue". Shuah's [PATCH 4,5,6/6] is failing to fix NULL pointer dereference issue.
These patches simply replaces NULL pointer dereference issue (caused by preemption) with
use after free issue (caused by exactly same preemption) issue. Shuah has to understand
the consequence of calling wake_up_process() on rx thread in order to fix this NULL pointer
dereference issue.

The only fix we can safely apply now is
https://lkml.kernel.org/r/20210205135707.4574-1-penguin-kernel@I-love.SAKURA.ne.jp .
Since I and Shuah agreed that we will remove kthread_get_run(), it is nice to fix up
frequently happening -EINTR pointer dereference issue as soon as possible.

