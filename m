Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1584C3D07C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 06:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhGUDvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 23:51:43 -0400
Received: from verein.lst.de ([213.95.11.211]:57234 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhGUDuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 23:50:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B215D6736F; Wed, 21 Jul 2021 06:30:34 +0200 (CEST)
Date:   Wed, 21 Jul 2021 06:30:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        syzkaller-bugs@googlegroups.com, Eric Sandeen <sandeen@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] WARNING in internal_create_group
Message-ID: <20210721043034.GB7444@lst.de>
References: <000000000000bd7c8a05c719ecf2@google.com> <20210721033703.949-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721033703.949-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:37:03AM +0800, Hillf Danton wrote:
> On Tue, 20 Jul 2021 11:53:27 -0700
> >syzbot has found a reproducer for the following issue on:
> >
> >HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
> >git tree:       upstream
> >console output: https://syzkaller.appspot.com/x/log.txt?x=116f92ec300000
> >kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
> >dashboard link: https://syzkaller.appspot.com/bug?extid=9937dc42271cd87d4b98
> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fc287c300000
> >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178cbf6a300000

<snip>

> >WARNING: CPU: 0 PID: 8435 at fs/sysfs/group.c:116 internal_create_group+0x911/0xb20 fs/sysfs/group.c:116

<snip>

> The device_add(ddev) in register_disk() may fail but it proceeds to register
> block queue even at the failure ... this falls in the class of known issue
> given the comment line.
> 
>  * FIXME: error handling
>  */
> static void __device_add_disk(struct device *parent, struct gendisk *disk,

Yes, Luis is working on actually fixing this - but it requires changes
to every single block driver.  How does a cap on the seq_buf size
propagate here, though?
