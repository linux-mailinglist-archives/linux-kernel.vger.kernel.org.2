Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B261F409129
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbhIMN65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:58:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41949 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S243988AbhIMN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:56:18 -0400
Received: (qmail 120803 invoked by uid 1000); 13 Sep 2021 09:54:59 -0400
Date:   Mon, 13 Sep 2021 09:54:59 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        a.darwish@linutronix.de, johan@kernel.org,
        linux-kernel@vger.kernel.org, oneukum@suse.com
Subject: Re: INFO: task hung in hub_port_init
Message-ID: <20210913135459.GA120302@rowland.harvard.edu>
References: <CACkBjsYQxQxGQwb3YS4obVWH3EODzqky5=nM3ADP7+13hBYgAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsYQxQxGQwb3YS4obVWH3EODzqky5=nM3ADP7+13hBYgAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:13:15AM +0800, Hao Sun wrote:
> Hello,
> 
> When using Healer to fuzz the Linux kernel, the following crash was triggered.
> 
> HEAD commit: ac08b1c68d1b Merge tag 'pci-v5.15-changes'
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1ZeDIMe-DoY3fB32j2p5ifgpq-Lc5N74I/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1qrJUXD8ZIeAkg-xojzDpp04v9MtQ8RR6/view?usp=sharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1tZe8VmXfxoPqlNpzpGOd-e5WCSWgbkxB/view?usp=sharing
> Similar report:
> https://groups.google.com/g/syzkaller-bugs/c/zX55CUzjBOY/m/uf91r0XqAgAJ
> 
> Sorry, I don't have a C reproducer for this crash but have a Syzlang
> reproducer. Also, hope the symbolized report can help.
> Here are the instructions on how to execute Syzlang prog:
> https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>

There's not much hope of finding the cause of a problem like this 
without seeing the kernel log.

Alan Stern
