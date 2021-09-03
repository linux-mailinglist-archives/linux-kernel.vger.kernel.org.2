Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECE13FFFA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbhICMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:15:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:52875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348901AbhICMPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630671250;
        bh=mpR8KpUr1hhIZsSmXsUPPutFytc2e6nbQIu32Yhy9YU=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Z18HHp4dXJ/HMNRkXgQDJd+xZo0gXf0cHdPgtfAS8AKvtZaEV1LmCopeLWilX/d81
         nLMruFL9Fh/sYP42WX92HSvPuYOPfNLG/Bf7H4QYZZBuE7zO1zxYjHgW9bvYgQI1WB
         dxazdh18Rt5th6uIgc+0JcOH1Bo2eOtClhbNp7ho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.183.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1mKTee0FzS-008Kbn; Fri, 03
 Sep 2021 14:14:10 +0200
Date:   Fri, 3 Sep 2021 14:14:04 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] additional parisc architecture updates for kernel
 v5.15-rc1
Message-ID: <YTIRjOdjUHGgG1eQ@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:zXX5/GScOzz/bBAjdSXa5NqTbxH/vjkRt9rUV2CFJmW/t4JL5WJ
 mr/4aLEfvt5XbkVd2QLWXoi0UsKMJ3//Ze+Y/AXU9Eb4JldiD6r3bgPUBxWCKCVn/1bRy6t
 WbujA9/1+aQuUK8KHxwpA/TxfaiuY9BzWW8fWpCiNYK+9kpUlMSTp2aQfQ8pE/pCxsBNNNO
 Xqj1P/R5Nb/kWhfLqPojg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ezN+hYuNnb8=:xI2gTv950MFnUwLvkubMWk
 DNJkOJHA+Wb6Mh9UJ7jpUWtlNXLrJrUkau55rwlOSdwI0WDOYuEHsYQFcvkxoOGtqf3cgVzpr
 bFV3IVtoathPfhprG5aQFiDOzbwm1Qvhyiwfoc2RYt6XYwbUDuW/U19F8EpmgUGomdErfvzKz
 7sGnUxEFfcnBvKCXQGE+zyy9vqcftPwWCjTR2Ol9XDAOvNuYu0/aASTiNi2trMp5eUzwkJZKg
 o82pJoTrcbeK2qtyaa9RHYoTnMPuZzlhBHXnsx2NQL9GUmyyKR7gm9rz1mp9w2XnmesXGg7hs
 kMeZu7o6+qzu4ubFyzT1LPFWdf4quAtlts/gguDTf4SyLsTS3Aiev01iFmltcxPzwIWBCXz0t
 89ymw/y2ARobdTEauaJ8Rwab5+USLRpw9QgkNoEHDefi1bMgZEGj6kRZ+3JGWHrlxWGAYHCai
 A88cesniSYrDYdUtWIt5yu99Mm9l0wzGjO5YjCbXs1NQGaBsvsVVLVRdeWk+yF5TzKcMAgTjv
 g5Qpr8/y07dKm5ajtHRZ6UBkNBnH1SghdO2aFJ4WX2ya/uUbHq5FiLIxD2HRfKsG14u7uM97P
 /PKY2JdgFzddPv6+kNcZwPaQ+s3StyjRM4il5Vz5QDgHxofQiBRvePoyu9MNRSPd8xDw8pns6
 A99ge5EeTT6Lxl47dyQIO4ANVMSvxE3NuEcog0s/W3yvli4cvS/8TTEaF7b0EmSrzHC4D53bp
 XeFHaHSO3MlGaxHplZzTZUraik9v48HU7etQBALu9FR8Yc1u7+hm8btocWJntvY6BcmCoaUHv
 YMqn7NTHJB2S6JtIVamfLxSRf09yB+NffPR6dGm775cBt+9f318QYE1k3tqdb718Qu76r5rOw
 Jff1yH8TjOCGfjRnhsGVfQ2XI+9rIWWqOzvjpoFGQTbwrYGhOf1IWOE9Vju4iF+U188/LECo6
 vppY77iUBpyf/gqnFkYWLLKTmtKoidRtoq4WLUZ024juHhNFHKPryf4E8iz63Nvl06vKYjXXt
 JfXReA3sq8g7Dgm+oCBjX3tG5LsEDUQ+XYO9BhVuk0gAoI6SgknpSfkDRdPfKU+58KASnbgk4
 nJagR50xCHR0cR9lYKYcrNgSVDpO2GtPrIE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two more parisc architecture patches for kernel 5.15-rc1 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-2

Fix an unaligned-access crash in the bootloader and drop asm/swab.h.

Thanks,
Helge

----------------------------------------------------------------
The following changes since commit 7ba88a2a09f47e2e4f3e34215677a1d78a9e6a73:

  Merge tag 'platform-drivers-x86-v5.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2021-09-02 13:49:39 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.15-2

for you to fetch changes up to c42813b71a06a2ff4a155aa87ac609feeab76cf3:

  parisc: Fix unaligned-access crash in bootloader (2021-09-03 09:47:02 +0200)

----------------------------------------------------------------
Helge Deller (2):
      parisc: Drop __arch_swab16(), arch_swab24(), _arch_swab32() and __arch_swab64() functions
      parisc: Fix unaligned-access crash in bootloader

 arch/parisc/boot/compressed/misc.c  |  2 +-
 arch/parisc/include/uapi/asm/swab.h | 68 -------------------------------------
 2 files changed, 1 insertion(+), 69 deletions(-)
 delete mode 100644 arch/parisc/include/uapi/asm/swab.h
