Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CAE3327E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhCIN44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:56:56 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61821 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhCIN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:56:30 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 129DuNVN019727;
        Tue, 9 Mar 2021 22:56:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 09 Mar 2021 22:56:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 129DuIrh019685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Mar 2021 22:56:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races
 leading to gpf
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <268a0668144d5ff36ec7d87fdfa90faf583b7ccc.1615171203.git.skhan@linuxfoundation.org>
 <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
 <5df3d221-9e78-4cbe-826b-81cbfc4d5888@i-love.sakura.ne.jp>
 <3305d1a1-12e2-087b-30f5-10f4bf8eaf83@linuxfoundation.org>
 <f8f5e763-da2d-b26f-c6a5-d345bbe55448@i-love.sakura.ne.jp>
Message-ID: <22bc31d7-b599-dc6a-2ef0-0dfc551a4715@i-love.sakura.ne.jp>
Date:   Tue, 9 Mar 2021 22:56:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f8f5e763-da2d-b26f-c6a5-d345bbe55448@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/09 20:04, Tetsuo Handa wrote:
> On 2021/03/09 1:27, Shuah Khan wrote:
>> Yes. We might need synchronization between events, threads, and shutdown
>> in usbip_host side and in connection polling and threads in vhci.
>>
>> I am also looking at the shutdown sequences closely as well since the
>> local state is referenced without usbip_device lock in these paths.
>>
>> I am approaching these problems as peeling the onion an expression so
>> we can limit the changes and take a spot fix approach. We have the
>> goal to address these crashes and not introduce regressions.
> 
> I think my [PATCH v4 01/12]-[PATCH v4 06/12] simplify your further changes
> without introducing regressions. While ud->lock is held when checking ud->status,
> current attach/detach code is racy about read/update of ud->status . I think we
> can close race in attach/detach code via a simple usbip_event_mutex serialization.
> 

Commit 04679b3489e048cd ("Staging: USB/IP: add client driver") says

  /*
   * The important thing is that only one context begins cleanup.
   * This is why error handling and cleanup become simple.
   * We do not want to consider race condition as possible.
   */
  static void vhci_shutdown_connection(struct usbip_device *ud)

but why are we allowing multiple contexts to begin startup?
That's where a subtle race window syzbot is reporting happened.
This driver has never thought the possibility that multiple userspace
processes can concurrently begin startup. Then, it is quite natural that
we make startup simple and safe, by enforcing that only one context
begins startup.

Without serialization between startup/cleanup/event_handler(),
"Fix the above problems:" in your changelog cannot become true.
First step should be closing time-of-check to time-of-use bug
via entire serialization as if "nonpreemptible UP kernel".
