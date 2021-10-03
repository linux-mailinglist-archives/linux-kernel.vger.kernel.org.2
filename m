Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE141FF16
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 03:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhJCBbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 21:31:37 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40998 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhJCBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 21:31:36 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWqHq-009WBL-Mq; Sun, 03 Oct 2021 01:27:30 +0000
Date:   Sun, 3 Oct 2021 01:27:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: fs/buffer.c:2342:1: warning: the frame size of 2056 bytes is
 larger than 1024 bytes
Message-ID: <YVkHAlZrL/XycxXX@zeniv-ca.linux.org.uk>
References: <202110030821.xXVLBESU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110030821.xXVLBESU-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 08:48:34AM +0800, kernel test robot wrote:
> Hi Christophe,

>         # save the attached .config to linux build tree

>    fs/buffer.c: In function 'block_read_full_page':
> >> fs/buffer.c:2342:1: warning: the frame size of 2056 bytes is larger than 1024 bytes [-Wframe-larger-than=]

fs/buffer.c:2259:       struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];

Now,
include/linux/buffer_head.h:44:#define MAX_BUF_PER_PAGE (PAGE_SIZE / 512)

so 'arr' in the above is PAGE_SIZE/512 pointers.  From the attached .config,
CONFIG_32BIT=y
and
# CONFIG_PPC_4K_PAGES is not set
# CONFIG_PPC_16K_PAGES is not set
# CONFIG_PPC_64K_PAGES is not set
CONFIG_PPC_256K_PAGES=y
CONFIG_PPC_PAGE_SHIFT=18

IOW, we have 256K/512 pointers, 4 bytes each, which amounts to 2K.  Just in
that array.

The rest of affected functions have similar local arrays...
