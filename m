Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B694331BC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBOPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229979AbhBOPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613401449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=v6KSsVad5fz+13MYpeONrGVE/Pn0gqQPvShBbeX2sbc=;
        b=XxwBwQc8pJddrVYT0eIsnNXWaVhT3+TWQuq+Y5encdSht6wYxMNpzlD2xuI6hDf/WWWpsr
        7v7yt8EOBDDa+CH3cLf9mQowTCg4x3yjMgZLloz+i6nxAf25wTw6Y4VPgShKQlYkMTDMFr
        oTDsh+D/k1Oct4rFpdcTj+N93eJAFig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-Shh2TTTbOAqew6VmOkYRtw-1; Mon, 15 Feb 2021 10:04:05 -0500
X-MC-Unique: Shh2TTTbOAqew6VmOkYRtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B770610CE782;
        Mon, 15 Feb 2021 15:04:02 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9F560C0F;
        Mon, 15 Feb 2021 15:04:00 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 11FF3xbh008633;
        Mon, 15 Feb 2021 10:03:59 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 11FF3sVY008629;
        Mon, 15 Feb 2021 10:03:55 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 15 Feb 2021 10:03:54 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Zhongwei Cai <sunrise_l@sjtu.edu.cn>,
        Mingkai Dong <mingkaidong@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        Rajesh Tadakamadla <rajesh.tadakamadla@hpe.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: [RFC v3] nvfs: a filesystem for persistent memory
Message-ID: <alpine.LRH.2.02.2102021307370.4109@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I announce a new version of NVFS - a filesystem for persistent memory.
        http://people.redhat.com/~mpatocka/nvfs/
        git://leontynka.twibright.com/nvfs.git

Changes since the last release:

I reworked file read/write handling:

* the functions nvfs_read and nvfs_write were deleted beacause it's 
  unlikely that the upstream kernel will allow them.

* the functions nvfs_read_iter and nvfs_write_iter have a fast path if 
  there is just one segment in iov_iter - they will call nvfs_read_locked 
  and nvfs_write_locked directly. This improves performance by 3% on the 
  read path and 1% on the write path.

* read_iter_locked uses copy_to_iter as suggested by Al Viro.

* write_iter_locked doesn't use copy_from_iter_flushcache, because we need 
  copy that doesn't advance the iter (the "copy" and "advance" must be two 
  separate operations). So, I added new operations "iov_iter_map" and 
  "iov_iter_unmap" - iov_iter_map will map the first segment of iov and 
  iov_iter_unmap will unmap it.

Do you think that introducing "iov_iter_map" and "iov_iter_unmap" is 
appropriate? Do you have some other idea how to handle it?

Mikukas

