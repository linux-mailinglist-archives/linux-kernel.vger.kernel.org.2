Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD629358518
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhDHNr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:47:58 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53837 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhDHNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:47:55 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 138DlP9k044243;
        Thu, 8 Apr 2021 22:47:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Thu, 08 Apr 2021 22:47:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 138DlPXr044239
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 8 Apr 2021 22:47:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 05/13] tty: remove tty_warn()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
 <20210408125134.3016837-6-gregkh@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <92b1f39d-9c9c-c319-a351-f3cb9a1c0497@i-love.sakura.ne.jp>
Date:   Thu, 8 Apr 2021 22:47:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408125134.3016837-6-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/08 21:51, Greg Kroah-Hartman wrote:
> Remove users of tty_warn() and replace them with calls to dev_warn()
> which provides more information about the tty that has the error and
> uses the standard formatting logic.

Ouch. This series would be good for clean up, but this series might be
bad for handling lockdep warning syzbot is reporting.

Since tty_warn() is using plain printk(), we can avoid lockdep warning by
using printk_deferred(). If we use dev_warn() instead, we need to modify
__dev_printk() to use printk_deferred(), which means that all dev_*() users
are affected by this change.

Also, we need to modify dev_printk_emit()/dev_vprintk_emit() callers to embed
loglevel into the format string so that we pass LOGLEVEL_SCHED to vprintk_emit() ...
maybe just change from "if (!in_sched)" to "if (!in_sched && !dev_info)" instead ?


Also, dev_vprintk_emit() need to start calling defer_console_output()
after returning from vprintk_emit() in order to behave like printk_deferred().

I'm not sure whether this change is safe.
