Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E093E21FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 05:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbhHFDCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 23:02:00 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48803 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHFDB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 23:01:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ui5askT_1628218900;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Ui5askT_1628218900)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Aug 2021 11:01:40 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
        arnd@arndb.de, osandov@fb.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH v4 0/2] make hvc pass dma capable memory to its backend
Date:   Fri,  6 Aug 2021 11:01:36 +0800
Message-Id: <20210806030138.123479-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This patch series make hvc framework pass DMA capable memory to
put_chars() of hvc backend(eg, virtio-console), and revert commit
c4baad5029 ("virtio-console: avoid DMA from stack”)

V1
virtio-console: avoid DMA from vmalloc area
https://lkml.org/lkml/2021/7/27/494

For v1 patch, Arnd Bergmann suggests to fix the issue in the first
place:
Make hvc pass DMA capable memory to put_chars()
The fix suggestion is included in v2.

V2
[PATCH 1/2] tty: hvc: pass DMA capable memory to put_chars()
https://lkml.org/lkml/2021/8/1/8
[PATCH 2/2] virtio-console: remove unnecessary kmemdup()
https://lkml.org/lkml/2021/8/1/9

For v2 patch, Arnd Bergmann suggests to make new buf part of the
hvc_struct structure, and fix the compile issue.
The fix suggestion is included in v3.

V3
[PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
https://lkml.org/lkml/2021/8/3/1347
[PATCH v3 2/2] virtio-console: remove unnecessary kmemdup()
https://lkml.org/lkml/2021/8/3/1348

For v3 patch, Jiri Slaby suggests to make 'char c[N_OUTBUF]' part of
hvc_struct, and make 'hp->outbuf' aligned and use struct_size() to
calculate the size of hvc_struct. The fix suggestion is included in
v4.

drivers/char/virtio_console.c | 12 ++----------
drivers/tty/hvc/hvc_console.c | 33 ++++++++++++++++++---------------
drivers/tty/hvc/hvc_console.h | 16 ++++++++++++++--
3 file changed
