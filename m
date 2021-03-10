Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6694333329A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhCJBDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:03:16 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62846 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCJBCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:02:52 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12A12j47096799;
        Wed, 10 Mar 2021 10:02:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Wed, 10 Mar 2021 10:02:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12A12jfY096795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 Mar 2021 10:02:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races
 leading to gpf
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <268a0668144d5ff36ec7d87fdfa90faf583b7ccc.1615171203.git.skhan@linuxfoundation.org>
 <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
 <5df3d221-9e78-4cbe-826b-81cbfc4d5888@i-love.sakura.ne.jp>
 <3305d1a1-12e2-087b-30f5-10f4bf8eaf83@linuxfoundation.org>
 <f8f5e763-da2d-b26f-c6a5-d345bbe55448@i-love.sakura.ne.jp>
 <30a1afb2-d5a4-40b2-385d-24a2bf110e92@linuxfoundation.org>
 <7b9465aa-213e-a513-d033-12c048df15d6@i-love.sakura.ne.jp>
 <05e8e744-0847-cde2-b978-0bfd7ef93a9f@linuxfoundation.org>
 <9653ae69-86f4-7608-ce97-4ec39b063ed2@i-love.sakura.ne.jp>
 <1edb9542-59c9-bbf6-9f16-99614605a800@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <47dbbf10-368c-6e45-5eac-c57b75f7ae9c@i-love.sakura.ne.jp>
Date:   Wed, 10 Mar 2021 10:02:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1edb9542-59c9-bbf6-9f16-99614605a800@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/10 9:29, Shuah Khan wrote:
>> It is not a large grain lock. Since event_handler() is exclusively executed, this lock
>> does _NOT_ block event_handler() unless attach/detach operations run concurrently.
>>
>>>
> 
> event handler queues the events. It shouldn't be blocked by attach
> and detach. The events could originate for various reasons during
> the host and vhci operations. I don't like using this lock for
> attach and detach.

How can attach/detach deadlock event_handler()?
event_handler() calls e.g. vhci_shutdown_connection() via ud->eh_ops.shutdown(ud).
vhci_shutdown_connection() e.g. waits for termination of tx/rx threads via kthread_stop_put().
event_handler() is already blocked by detach operation.
How it can make situation worse to wait for creation of tx/rx threads in attach operation?

