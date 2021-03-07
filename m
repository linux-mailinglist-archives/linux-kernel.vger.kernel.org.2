Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439DF3304A6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 21:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhCGUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 15:43:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:60215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232951AbhCGUnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 15:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615149762;
        bh=gGrRmv3X1rwP7xJKEMKnOrcfUi2uXofg0iyVikfdkL4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=Xho5klNPvBx72PZQ9fLwHp0pClJc5rZMwwgB7a/Wa0GkWSIXhdgGuaICfinW16/2o
         kFLhCm2zpPrw3yOd3GMdG47mTdgLiAhPiv7dHvl6iZFGg78Xmg/S1tIBzlzTEw6w4G
         S8GY32uwIf22dtTRuo8ZQ2aIYn2TlEzUDOhUOmjs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.159.1]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1l82vp46QK-00OFQZ; Sun, 07
 Mar 2021 21:42:42 +0100
Date:   Sun, 7 Mar 2021 21:42:20 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Zhang Yunkai <zhang.yunkai@zte.com.cn>, menglong8.dong@gmail.com
Subject: [GIT PULL] parisc architecture fixes for kernel v5.12-rc333
Message-ID: <YEU6nUd2P8ud4fGU@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:SzPQW6ZZE7DPFdnqrmiYeqFkUlpb8N32mOapve3vE66zHKf0hiA
 jqdO1/e+qQ9Elr4Cb7HrV3l1oH+u9ucfeE0HA+/48OCj7/7XARDwrq1CUfevMBuCNeh6PWJ
 gDi5FWJO6hlgx3qX8hbD9KWKMZtP8gbJ8+GhS+v3/HK7alDGRABQlIq94xRNUWQSXPBjXes
 khyqhxgd1mdrBG/Al5Rgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LI9wK22I83s=:u4wwniUjS0/WYU++FqJNBT
 W8GUWiaBe6YONkZKM/0Fs3/815WoSW6gYF7XrQia2jKM3ANIJ7whBR7XGYFSV+LQqD+deQ5WQ
 qi/yh2K0jTDTETGqdj1C/j/BZfot7uxb8DtogpeXjehxboKd6MtRWTEQpvHDIuvFJOMODjnf/
 ClC7A0Sxu7LBe8jqbxly4ME84DYaBFcCBRFaj58YwUs4/rt4vXsAyS/eaUI57v5YGtV7UgjWl
 PLL2l204JyFtXy2cA3ULsG9G1eqL+XHP0aPkUqwbq1xSaCg0DfaWYvokrhUhDvc2/YqloHNtG
 i7p4sYcCpsilZxFwmVl7fJ++rdOOPc2SG8VyNrN32onsa/uj0PpqH4Ky53T+XNsqQvCI4BGuI
 31Ch5YVsR4ENSzVRta+Ck+AH/2fbW9i4ZRGHW9WeGXBJkF8jcxgXCBkkriEi4Be3dG3EMFAH3
 4BuiLtZrL8miwiMkB9hu7hmToSAvu6Uct55cbecm1t3uWWIX8DOEsk+HwsnCE67uJwE9nS/Nt
 W3lsccw+ybAQw2hpsoGKw7pSZ8SFFMcR35dBQzop/sMezjXIY9sEv/d3hoKMxqXTjvpbJ248r
 7zEGPwAb1r+TqWvQAA9hRxRRQrwA+4INqgGPUTo82umPJtqHWBK10WWGPtpATKBnkExrKfJIb
 4mU/Nbu0lcG8fmNWFBcck+LqpUO1FmMda00Uol6BkAo0fRGJ+GMFrNp8dE8MGm5b612Dvt8Sh
 /fXOkRmbjGe+pMJenE6zTns8IZZpnGB7GiebuEqdGf+2TtDgvkAMUuLjWs1hBPgX7i97TYBJ0
 ptTbkkqrjFGzHIv4PaUmQLDygQ5pyWwaDOCjMwqQdmfQTr/eGZUkjK0qU+PbbX1LDunMZ9w3/
 +khx9U5KhiB78y7nVOOA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two small parisc architecture fixes for kernel 5.12-rc3 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-2

Fix a linking failure reported by the kernel test robot and remove a duplicate include.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Enable -mlong-calls gcc option with CONFIG_COMPILE_TEST

Zhang Yunkai (1):
      arch/parisc/kernel: remove duplicate include in ptrace

 arch/parisc/Kconfig         | 7 +++++--
 arch/parisc/kernel/ptrace.c | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)
