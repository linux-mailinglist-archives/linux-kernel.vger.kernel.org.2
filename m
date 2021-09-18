Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A24102DA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 04:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbhIRCEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 22:04:14 -0400
Received: from netrider.rowland.org ([192.131.102.5]:55889 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233488AbhIRCEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 22:04:11 -0400
Received: (qmail 69335 invoked by uid 1000); 17 Sep 2021 22:02:45 -0400
Date:   Fri, 17 Sep 2021 22:02:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        a.darwish@linutronix.de, johan@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        oneukum@suse.com
Subject: Re: INFO: task hung in hub_port_init
Message-ID: <20210918020245.GA69263@rowland.harvard.edu>
References: <CACkBjsYQxQxGQwb3YS4obVWH3EODzqky5=nM3ADP7+13hBYgAA@mail.gmail.com>
 <20210913135459.GA120302@rowland.harvard.edu>
 <CACkBjsZcg0B=tF8cr54VqaJMVURD9R463epZqRQfesnoY=+L8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsZcg0B=tF8cr54VqaJMVURD9R463epZqRQfesnoY=+L8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 09:56:52AM +0800, Hao Sun wrote:
> Hi Alan,
> 
> Alan Stern <stern@rowland.harvard.edu> 于2021年9月13日周一 下午9:55写道：
> >
> > On Mon, Sep 13, 2021 at 11:13:15AM +0800, Hao Sun wrote:
> > > Hello,
> > >
> > > When using Healer to fuzz the Linux kernel, the following crash was triggered.
> > >
> > > HEAD commit: ac08b1c68d1b Merge tag 'pci-v5.15-changes'
> > > git tree: upstream
> > > console output:
> > > https://drive.google.com/file/d/1ZeDIMe-DoY3fB32j2p5ifgpq-Lc5N74I/view?usp=sharing
> > > kernel config: https://drive.google.com/file/d/1qrJUXD8ZIeAkg-xojzDpp04v9MtQ8RR6/view?usp=sharing
> > > Syzlang reproducer:
> > > https://drive.google.com/file/d/1tZe8VmXfxoPqlNpzpGOd-e5WCSWgbkxB/view?usp=sharing
> > > Similar report:
> > > https://groups.google.com/g/syzkaller-bugs/c/zX55CUzjBOY/m/uf91r0XqAgAJ
> > >
> > > Sorry, I don't have a C reproducer for this crash but have a Syzlang
> > > reproducer. Also, hope the symbolized report can help.
> > > Here are the instructions on how to execute Syzlang prog:
> > > https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md
> > >
> > > If you fix this issue, please add the following tag to the commit:
> > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> >
> > There's not much hope of finding the cause of a problem like this
> > without seeing the kernel log.
> >
> 
> Healer found another Syzlang prog to reproduce this task hang:
> https://paste.ubuntu.com/p/HCNYbKJYtx/
> 
> Also here is a very simple script to execute the reproducer:
> https://paste.ubuntu.com/p/ZTGmvFSP6d/
> 
> The `syz-execprog` and `syz-executor` are needed, so please build
> Syzkaller first before running the script.
> Hope this can help to find the root cause of the problem.

I don't have time to install and figure out how to use Healer and 
Syzkaller.  But if you run the reproducer and post the kernel log, 
I'll take a look at it.

Alan Stern
