Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2623234750C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhCXJuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:50:18 -0400
Received: from verein.lst.de ([213.95.11.211]:36232 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232685AbhCXJtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:49:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6360C68B05; Wed, 24 Mar 2021 10:49:47 +0100 (CET)
Date:   Wed, 24 Mar 2021 10:49:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
Message-ID: <20210324094947.GA9252@lst.de>
References: <00000000000053da9405bd7d2644@google.com> <000000000000a17fb305be0b3f38@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a17fb305be0b3f38@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://git.infradead.org/users/hch/block.git part-iter-fix


On Sun, Mar 21, 2021 at 05:40:05AM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit a33df75c6328bf40078b35f2040d8e54d574c357
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Sun Jan 24 10:02:41 2021 +0000
> 
>     block: use an xarray for disk->part_tbl
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17989906d00000
> start commit:   1c273e10 Merge tag 'zonefs-5.12-rc4' of git://git.kernel.o..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14589906d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10589906d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
> dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dfe8bed00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155a117cd00000
> 
> Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
> Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
---end quoted text---
