Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84057311ACC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhBFEVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:21:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhBFDME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:12:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3957165016;
        Sat,  6 Feb 2021 00:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612569953;
        bh=UShNfZsoBlO05lAQRkPFldQn5CSrPHZ7sGnhQHHXTnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WgICwMkady18epyVATi4bMxlwDnjJGnkWlirkeeU6ddtzD4iYENFo+ABGWhYKmzHT
         W5bRqQ2r3qKjrmp+K2ltce9TZTz34jpR6v2pCmvkfHSSNW2Xth0N1LVn0VfJM0zrSp
         UJlrejTzImt9N4P+YRM+bQy3O15KMAriMEScCras=
Date:   Fri, 5 Feb 2021 16:05:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     Hugh Dickins <hughd@google.com>, Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Message-Id: <20210205160551.cf57c4293ba5ccb8eb648c11@linux-foundation.org>
In-Reply-To: <20210205230620.518245-1-seth.forshee@canonical.com>
References: <20210205230620.518245-1-seth.forshee@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Feb 2021 17:06:20 -0600 Seth Forshee <seth.forshee@canonical.com> wrote:

> This feature requires ino_t be 64-bits, which is true for every
> 64-bit architecture but s390, so prevent this option from being
> selected there.
> 

The previous patch nicely described the end-user impact of the bug. 
This is especially important when requesting a -stable backport.

Here's what I ended up with:


From: Seth Forshee <seth.forshee@canonical.com>
Subject: tmpfs: disallow CONFIG_TMPFS_INODE64 on s390

Currently there is an assumption in tmpfs that 64-bit architectures also
have a 64-bit ino_t.  This is not true on s390 which has a 32-bit ino_t. 
With CONFIG_TMPFS_INODE64=y tmpfs mounts will get 64-bit inode numbers and
display "inode64" in the mount options, but passing the "inode64" mount
option will fail.  This leads to the following behavior:

 # mkdir mnt
 # mount -t tmpfs nodev mnt
 # mount -o remount,rw mnt
 mount: /home/ubuntu/mnt: mount point not mounted or bad option.

As mount sees "inode64" in the mount options and thus passes it in the
options for the remount.


So prevent CONFIG_TMPFS_INODE64 from being selected on s390.

Link: https://lkml.kernel.org/r/20210205230620.518245-1-seth.forshee@canonical.com
Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Hugh Dickins <hughd@google.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: <stable@vger.kernel.org>	[5.9+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/Kconfig~tmpfs-disallow-config_tmpfs_inode64-on-s390
+++ a/fs/Kconfig
@@ -203,7 +203,7 @@ config TMPFS_XATTR
 
 config TMPFS_INODE64
 	bool "Use 64-bit ino_t by default in tmpfs"
-	depends on TMPFS && 64BIT
+	depends on TMPFS && 64BIT && !S390
 	default n
 	help
 	  tmpfs has historically used only inode numbers as wide as an unsigned
_

