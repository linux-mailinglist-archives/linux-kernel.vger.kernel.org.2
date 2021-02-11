Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C94E3182F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 02:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhBKBOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 20:14:50 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:49797 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhBKBOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 20:14:48 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11B1E6NG034653;
        Thu, 11 Feb 2021 10:14:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Thu, 11 Feb 2021 10:14:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11B1E6lX034649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Feb 2021 10:14:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com
References: <000000000000647eff05b3f7e0d4@google.com>
 <20201113120055.11748-1-hdanton@sina.com>
 <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
 <ea4028b7-53f2-aeaf-76e7-69874efcdec5@I-love.SAKURA.ne.jp>
 <2b70d360-a293-4acb-ea6c-2badda5e8b8b@linuxfoundation.org>
 <9bdd3f10-bddb-bd87-d7ad-b4b706477006@i-love.sakura.ne.jp>
 <6b8da36f-a994-7604-77f4-52e29434605f@linuxfoundation.org>
 <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
 <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
 <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
 <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
 <4368349b-fc0c-6da3-a502-2733f953d271@i-love.sakura.ne.jp>
 <92a4c6ae-172d-91cb-b89e-8eb857fdfb3a@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d177302a-3050-41db-cf44-6d614fd0c3a0@i-love.sakura.ne.jp>
Date:   Thu, 11 Feb 2021 10:14:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <92a4c6ae-172d-91cb-b89e-8eb857fdfb3a@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Dropping LSM ML because this is not a TOMOYO's bug.)

On 2021/02/11 4:29, Shuah Khan wrote:
> This is a good find. I already replied to the thread to send a complete
> fix.

As I said at https://lkml.kernel.org/r/f8cae6b1-8f84-0e6a-7d9c-fc4aec68f07b@i-love.sakura.ne.jp ,
the as-is patch is effectively a complete fix. And applying the as-is patch should help spending
syzbot resources for reproducing "general protection fault in tomoyo_socket_sendmsg_permission"
with debug printk() patch applied, which in turn will help you in

> Right. I would like to get a clear understanding of how this condition
> is triggered. I am not saying this isn't a problem. Understanding how
> it is triggered helps find the best fix.

part. Therefore, I strongly expect you to apply this version now.

