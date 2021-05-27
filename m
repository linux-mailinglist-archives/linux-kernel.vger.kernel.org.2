Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD039281A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhE0HBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:01:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62013 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhE0HA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:00:56 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14R6xDM8046659;
        Thu, 27 May 2021 15:59:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Thu, 27 May 2021 15:59:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14R6xCVq046654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 May 2021 15:59:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] unexpected kernel reboot (5)
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com>,
        Joey Jiao <joey.jiaojg@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000b808c705c345b35d@google.com>
 <0000000000009dfd7c05c3463b32@google.com>
 <CACT4Y+ZkGw8GDs9vYzs5t7iBba+5ZRKmTnp3zXAnkOsmyWp6Rw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ced68605-f4b2-9daf-4832-cdf8dd8cb5de@i-love.sakura.ne.jp>
Date:   Thu, 27 May 2021 15:59:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZkGw8GDs9vYzs5t7iBba+5ZRKmTnp3zXAnkOsmyWp6Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/27 15:40, Dmitry Vyukov wrote:
> The reproducer writes into /sys/power/state. I assume this is an
> intentional way to reboot a machine and we can't let the fuzzer mess
> with all sysfs files with:
> 
> openat$sysfs(fd const[AT_FDCWD], dir ptr[in, glob["/sys/**/*"]], flags
> flags[open_flags], mode flags[open_mode]) fd
> 
> +Joey, how do you deal with this?
> 

I have CaitSith LSM module ( https://caitsith.osdn.jp/#5.2 ).
Maybe we could invent a simple LSM module for excluding access to specific pseudo files?
