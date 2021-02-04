Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAEF30FFC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhBDWAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhBDWAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:00:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 227A464F8C;
        Thu,  4 Feb 2021 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612475964;
        bh=j/3APdsf1wIq6kaIz46332EwR6+YXppcN/WPCOjUHiI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cpbXz0LbHwfXjX9aewuwsYc4Bu9hfj2eU8ez7JGqUIoJ7cppdMUGiX3ATqhq/+yBD
         oRcwcbVCCjZKc2Z+u0/vLcqJRINJl1+j4+sOeVv6yE+TxMPip8cDuBg7r9QXci5Kx4
         KhszjV0jkbd8odYidjW5zC9HBKqWJCN+fMyqe9syWmTyWdZiijU+fq8AFSKflXkF0n
         yNiAKA99YFTgCB3XnSc5dUZEqm5TEoHMAb1SqxlZsg1PPJA99UGGDUfJ7H/zyUeBhd
         dFUGUSSLydLuuLAa53gbor23h7RsoBv5TQ8R5Ub46oIbHvCBWHykdr2JJmcgp8P0m3
         vDVGyXqKqSTgw==
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
To:     Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
References: <20210202201846.716915-1-timur@kernel.org>
 <20210204204835.GA7529@amd> <20210204155423.2864bf4f@gandalf.local.home>
 <20210204214944.GA13103@amd>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
Date:   Thu, 4 Feb 2021 15:59:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204214944.GA13103@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 3:49 PM, Pavel Machek wrote:
> This machine is insecure. Yet I don't see ascii-art *** all around..
> 
> "Kernel memory addresses are exposed, which is bad for security."

I'll use whatever wording everyone can agree on, but I really don't see 
much difference between "which may compromise security on your system" 
and "which is bad for security".  "may compromise" doesn't see any more 
alarmist than "bad".  Frankly, "bad" is a very generic term.

I think the reason behind the large banner has less to do how insecure 
the system is, and more about making sure vendors and sysadmins don't 
enable it by default everywhere.
