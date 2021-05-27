Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB37C392F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhE0NS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:18:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53473 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbhE0NSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:18:42 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14RDGvhw055499;
        Thu, 27 May 2021 22:16:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Thu, 27 May 2021 22:16:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14RDGv45055492
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 May 2021 22:16:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot] unexpected kernel reboot (5)
To:     "joey.jiaojg" <joey.jiaojg@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+6fb8ff5211d3e821398f@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000b808c705c345b35d@google.com>
 <0000000000009dfd7c05c3463b32@google.com>
 <CACT4Y+ZkGw8GDs9vYzs5t7iBba+5ZRKmTnp3zXAnkOsmyWp6Rw@mail.gmail.com>
 <9B8B972A-EC9F-4806-9897-41581578646A@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ea23ca6b-0893-1303-524c-a7e07d909931@i-love.sakura.ne.jp>
Date:   Thu, 27 May 2021 22:16:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <9B8B972A-EC9F-4806-9897-41581578646A@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/27 21:15, joey.jiaojg wrote:
> I tested on qemu and Android device, not found the reboot.
> Any kernel version different?

Kernel version needs to be v5.11-rc5+ because this reproducer
depends on commit f2d6c2708bd8 ("kernfs: wire up ->splice_read
and ->splice_write"). Also, this reproducer depends on contents
of /sys/power/state file.

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/sendfile.h>

int main(int argc, char *argv[])
{
        const int fd = open("/sys/power/state", O_RDWR);
        off_t offset = 7;

        /* Assumes that 3 bytes from offset 7 in /sys/power/state are "mem". */
        sendfile(fd, fd, &offset, 3);
        return 0;
}
----------

On 2021/05/27 21:19, joey.jiaojg wrote:
> Or we can add glob code like
> /sys/**/*:-/sys/power/state to exclude.

Well, since /sys/ includes mount points for other filesystems such as
securityfs ( /sys/kernel/security/ ), debugfs ( /sys/kernel/debug/ )
and cgroup ( /sys/fs/cgroup/ ), just excluding this specific file is not
sufficient. I think we have to start from removing glob["/sys/**/*"] .

