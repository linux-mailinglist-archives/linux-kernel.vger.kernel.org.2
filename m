Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34C63567BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349979AbhDGJKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:10:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:51413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349965AbhDGJKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617786591;
        bh=odbMq1QkA2+jkrNnf2C3WSIOA2ISmQMSizqtiktlTBU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=QQhapKYluwjps+VHKiPHnQ9NYCqq4hBNW/lMQIE9FDzjpBQoxPGCLzmxrvXY0inYi
         B/xL7MSwBTWH19kOV0c29g8h+cyZWrdd9o8pKBQFMSfqARgbCFy72TlG+OECC2T2sO
         pz0QnRl13hSLOyVutbHPEcWvcROcksplEjP6UvCA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.167.102]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1lFx1B4Akh-00Nxca; Wed, 07
 Apr 2021 11:09:47 +0200
Date:   Wed, 7 Apr 2021 11:09:09 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Gao Xiang <hsiangkao@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.12-rc7
Message-ID: <YG12tezhGsQ5R/lG@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:MlnCGZyT1GWzXv3G1cJVLTYtm35jYDanEuyl8ALG52fIEfLz0CY
 9wjubHfR8rl8/sVaULwceZE9UgjYygwiJIH9vncy+PfPHpFtY9D9xprRmmvG8se6292sA6b
 8hZzXEOfC+YbhPV5HQ2lURKw8dw1rqWlx9BZhFwtk+yQeD/rduvRI/dvGvsoyLC0QEzRMtt
 5Cr5KW8YcbhlJSJvcwBBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nLkqkVBVmGY=:wJeN/XRNkomy0NWKVwc13a
 nxytWDYGPyFqP2Kq8keaTPU1Sens/v1nhRhXpPDy2eN5fuD6yKBGiBJs1gzCpHFETZ4QZKqFW
 0es6B7ZL3AVsMCT8p8/qi3QTJEx+FPoAYT82dKWsuh6aKB4/A9PYyghQ04UrAm3XidqWZhxPr
 Mns8THQpcNO05tFXvwDaKoDJpKD48QKDhWEOOanwLineoYA/rzN5xso3mFH59i9MIXbC+5z6X
 /J3Y5l4R/HWb97zsuYiP86ImT6Ptex2htpcHQShNfus2yCv+e988uD74w4YDUi9YQHZl/5Wmm
 ki+JAvjtez617SFWw6A+Y7ll/EOcEysBUuS/4hUP5wMoEX1QUmFXAp2NrZBC4ZPp781QHWOwx
 Ozu6fwWVNPZnoIn+lM9CnfDgDmjyTOB7vWQlu0EDo6BjMbpBIC/57Oc7q995U88woTfE63oUG
 fDMy7O08TyzWazMhtO0eYMylN2uIQnQE8bYr2zZk28TCt/TKtQhT+q1Bl9sCtdFjcD4nCm1/+
 lcCYjcFYBNjczs1xSLcuqK3qJ8CAfLgTKtSQlKuU+ql2hGD1GPRyVAIdt9nU1ofGg+gV/sVlh
 Nxdg96xM36kkDy4BzjGZMMMjCL/t6eTnNvhqDW+pFeaEOxMhfzBkC2TilejjJX8eouxld1dCO
 RRvKE0nTvUVivTgqFGy5qmiyObziOWbL8+UYltqc+P11Sa5EHTu+zLtUtkiNvLVojj0zrKhVT
 OGRZ3qFJUKnXicRUuOPv6qrcrwSDzyZC4gii6hIRfFdVrOvnj8eI+K7tL1b51qPtENdEq3Vv2
 cj1GC9QJJdOwz6uLs/BLCaVz9AyoyVRoU40beJJisHGYf369pBVeFWzDZnau+o2Y0jRQp2kz5
 Hz4aHAnvc0fdufoJZYH0bBZYGJwBDk+KPS5qsHvDRbJ/FVbOdDQrJfdvKNd8dt9qO9NY0N5CA
 a5SkL1v20IYnXHPzEcD3swncNk2eDOZIy1p2HhQen64mKSG1HxVWxj6gsaA6elyPtbfts0L4o
 RpkTMioL/5FKbjj5RiK1C0n9Tb17UCAOfaRlrL7kz0Kr61KJzZ1e2iBYtTGNcYtMbPPV1h7Gh
 /O/l4iUNH0+Efbk0kv4TYgmTmmLzqZESMtxREQHKhV0lmaOn8FVulN08u8eqhMSYQo0UD54yf
 XsJBHRvVZzKJZx3f9TulRNtnHHDCmwGDJYw4xcjZmvZk4QfwVR3cF5KRM+iwPFz5thH18=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull four small parisc architecture fixes for kernel 5.12-rc7 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-3

One link error fix found by the kernel test robot, one sparse warning fix,
remove a duplicate declaration and some spelling fixes.

Thanks,
Helge

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      parisc: math-emu: Few spelling fixes in the file fpu.h

Gao Xiang (1):
      parisc: avoid a warning on u8 cast for cmpxchg on u8 pointers

Helge Deller (1):
      parisc: parisc-agp requires SBA IOMMU driver

Wan Jiabing (1):
      parisc: Remove duplicate struct task_struct declaration

 arch/parisc/include/asm/cmpxchg.h   |  2 +-
 arch/parisc/include/asm/processor.h |  1 -
 arch/parisc/math-emu/fpu.h          | 32 +++-----------------------------
 drivers/char/agp/Kconfig            |  2 +-
 4 files changed, 5 insertions(+), 32 deletions(-)
