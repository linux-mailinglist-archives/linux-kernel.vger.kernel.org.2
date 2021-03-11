Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A517E3372C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhCKMfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:35:22 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58652 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhCKMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:34:49 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12BCYe8D004118;
        Thu, 11 Mar 2021 21:34:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Thu, 11 Mar 2021 21:34:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12BCYetI004115
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Mar 2021 21:34:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
To:     Greg KH <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <YEkQ4qS7tkwmjzDn@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
Date:   Thu, 11 Mar 2021 21:34:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YEkQ4qS7tkwmjzDn@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/11 3:33, Greg KH wrote:
> On Sun, Mar 07, 2021 at 08:53:25PM -0700, Shuah Khan wrote:
>> This patch series fixes the following problems founds in syzbot
>> fuzzing.
> 
> Thanks for these, all now queued up.

I send SIGSTOP to

  [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races leading to gpf
  [PATCH 5/6] usbip: fix vhci_hcd attach_store() races leading to gpf
  [PATCH 6/6] usbip: fix vudc usbip_sockfd_store races leading to gpf

because these patches merely converted NULL pointer dererefence bug to use-after-free bug
by breaking kthread_get_run() into kthread_create()/get_task_struct()/wake_up_process().
