Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA0312B67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhBHICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:02:53 -0500
Received: from outbound-gw.openxchange.ahost.me ([94.136.40.163]:40200 "EHLO
        outbound-gw.openxchange.ahost.me" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229865AbhBHICb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:02:31 -0500
Received: from localhost ([127.0.0.1] helo=outbound-gw.openxchange.ahost.me)
        by outbound-gw.openxchange.ahost.me with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1l911d-000486-3H; Mon, 08 Feb 2021 07:32:01 +0000
Date:   Mon, 8 Feb 2021 07:32:00 +0000 (GMT)
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <1932848714.754502.1612769521044@webmail.123-reg.co.uk>
Subject: [PATCH V2 0/4] Squashfs: fix BIO migration regression and add
 sanity checks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.3-Rev30
X-Originating-IP: 82.69.79.175
X-Originating-Client: com.openexchange.ox.gui.dhtml
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Patch [1/4] fixes a regression introduced by the "migrate from ll_rw_block
usage to BIO" patch, which has produced a number of Sysbot/Syzkaller reports.

Patches [2/4], [3/4], and [4/4] fix a number of filesystem corruption
issues which have produced Sysbot reports in the id, inode and xattr
lookup code.

Each patch has been tested against the Sysbot reproducers using the given
kernel configuration.  They have the appropriate "Reported-by:" lines
added.

Additionally, all of the reproducer filesystems are indirectly fixed by
patch [4/4] due to the fact they all have xattr corruption which is now
detected there.

Additional testing with other configurations and architectures (32bit,
big endian), and normal filesystems has also been done to trap any inadvertent
regressions caused by the additional sanity checks.

V2: Fix two checkpatch.pl errors.

Phillip
