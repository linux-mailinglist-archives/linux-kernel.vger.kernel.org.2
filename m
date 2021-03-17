Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB92133F44E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhCQPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:48:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49868 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhCQPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:13 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12HFcvwH085191;
        Thu, 18 Mar 2021 00:38:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Thu, 18 Mar 2021 00:38:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12HFcrHG085100
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Mar 2021 00:38:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <YEkQ4qS7tkwmjzDn@kroah.com>
 <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
 <YEoTw7CoK7Ob0YR+@kroah.com>
 <8dc1e893-4338-90ff-ea61-de727cad1d11@i-love.sakura.ne.jp>
 <afd1341b-2ed1-f781-d6c8-6064fea3aeb8@i-love.sakura.ne.jp>
 <192bdb07-da84-ce96-2e25-7c0df749940a@i-love.sakura.ne.jp>
 <9e089560-388a-a82d-4841-8092578b9d5d@i-love.sakura.ne.jp>
 <465479ca-544e-3703-cf4e-30f5be04fa11@i-love.sakura.ne.jp>
 <fbf64c33-87c3-137c-4faf-66de651243fc@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c4172173-3e54-4b09-303d-9c368b2b49c4@i-love.sakura.ne.jp>
Date:   Thu, 18 Mar 2021 00:38:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fbf64c33-87c3-137c-4faf-66de651243fc@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/18 0:06, Shuah Khan wrote:
> Yes. I haven't sent the patch for that reason. I am trying to test a
> solution. I haven't come up with a solution yet.
> 
> Holding event_lock isn't the right solution. I am not going to accept
> that. This is a window that gets triggered by syzbot injecting errors
> in a sequence. Fixing this should be done taking other moving parts of
> the driver into account.

What is event_lock ? I questioned you what the event_lock is at
https://lkml.kernel.org/r/3dab66dc-2981-bc88-a370-4b3178dfd390@i-love.sakura.ne.jp ,
but you haven't responded to that post.

Also, you need to send https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/commit/?h=usbip_test&id=f345de0d2e51a20a2a1c30fc22fa1527670d2095
because Greg already sent this regression into upstream and stable kernels.

