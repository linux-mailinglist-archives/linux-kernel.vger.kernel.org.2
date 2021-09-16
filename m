Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3A40DDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhIPPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:31:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:40777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238967AbhIPPbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631806192;
        bh=9S4rziGDk/XnX1ilrM487cBPhExkLOTdPPxWzVzXfhc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=VeLi6F1wKxncsX5OZsTz0GaS3jU+uPGqSYPbUTocatNOI+BbM5NeQ0lrsWZuGT0hv
         Lomh3YlCAZLNsKjkDCzjPAjAdDJZXAPn/n4apfjFDKOEL+mb/5OUPYgFUF66a9vHhS
         MrY67HYeaKFiB70f8SET8PbV2QbftSulQzthyIHQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.154.218]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnakR-1n9ozK31qX-00jdGQ; Thu, 16
 Sep 2021 17:29:51 +0200
Date:   Thu, 16 Sep 2021 17:29:46 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] parisc architecture warning fix for kernel v5.15-rc2
Message-ID: <YUNi6hTcS8nUrrpF@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:320d/I+FgMCCu5pnyCi58+GJ49VX+EP+MegT1c1/k/t1giePYLe
 0E1iwiDOY9MCoTfZPXRDNNSLXdBbcJL4EfN1ku2KCLa/Z9sekCcPa0yahYsI5re9GPco4iK
 IthxUjYdKLkgHEbXTk8ofiwt07LEZW0nZkTZK7bJIQTpaWfB/xy48njeLTpW00R0EzHsXF0
 ZnOyz7bqtiGJva98R85hQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vxg8q6NxpDE=:ryXUBfHW0Y6bcDm2pQAfPs
 jKm+OPBrjlx3ddAhCg8egp+E67jKovPpHcUtV0sQHITOliKbzOBjHtvHXG67kcG80rMIVQBJR
 PWZo7ISVKvAsoQtjo6CVmG+56Nh2xnOHyNc8SWOgx9bGf1O673Ei5si8Nm8yJbjatqd0lKMJL
 b1ic0Sjzopb9cP2SVtjFx5772gBze9nLREodnJDtSrfS/DLx92SnIXXyyqVfO4FRt/FtYMLSA
 RCbRdXXwA321DliSd3Cq6gL+ishZjhAFW4FznUPGjERYhKjJs3aGzCrGQ0y3NH4xLvbj854w4
 DBHZvWK1Xg4LC7MRup0IhxAO3btLiljjDqhCYl/SEqr+c6KhQvCQZHNLWClSoTQ5h/3T0C/jW
 QQB+jaHowBRfH0WfVAILXpzBKK+cm72IcG9/CICqiHWgrUstLpBm6MVWeqn2iwX99JLMTYl/e
 0vHZ0p6r3xeZ+OPXcWOh5BapNkPWxrpfC0IUmON/aM5v4gmAXDHfbpcziIXh9RCt8wjXdbZ29
 7g23fQPm61z2MoM7Mqw6negT0VtVDhfbpP0xxfcgdOTsRwz6UuJoZ+S4+SUm/8w0SlIp1I2gz
 dCicheNBTvTTlw56Uh6rw2dr/u/f0L8CnHyIN5ZvcDZJil6rTb+XthJ2s+genRcCnd3Cb0Z41
 ZZvk0sef+h44VTCmKOTO45W5ZmumGEP2hlsY/m8q6+d1wPpLzCTwdOl2sDsQiHHMaDfuVT+EZ
 jEYDFz+kImSEZFZJo1TSdsxCS+faC/q+98LaBk1lMGeOc9wlFs5evboWjJjS/OoZH2zElBifJ
 YKyBolXxE9e23hY5djCva1xYQsEgCcjQal70KatRGkFk1yEzLdXEvrEKYTb6gnLLXYIdfO6N7
 iSx5G4dl2HMAeAbumFO4TYFxjuvrW2o6Ui41d2iJDTJ/XzDF3Ic0UKkgzaGlmMX3jQ+wz7Laf
 DVjv6xl8iXbHtgh77FwPb9Pa/N4hRUs8vEr1rrx3XiUC6hgPUu/LeDDAruDOBLqhIq6FsHHyn
 P0gpnMVBxqUfX9GrtyzaSjTaO8AKSCLxEsoMGPk7I+O+Jf3bXrYiyBeX9aXsj4ttXr3oAt2GZ
 N2PMuCevvgg3fM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one parisc architecture warning fix for kernel 5.15-rc2 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-4

One patch which fixes a build warning when using the PAGE0 pointer.

Thanks,
Helge

------------
The following changes since commit ff1ffd71d5f0612cf194f5705c671d6b64bf5f91:

  Merge tag 'hyperv-fixes-signed-20210915' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux (2021-09-15 17:18:56 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.15-4

for you to fetch changes up to 90cc7bed1ed19f869ae7221a6b41887fe762a6a3:

  parisc: Use absolute_pointer() to define PAGE0 (2021-09-16 08:35:42 +0200)

----------------------------------------------------------------
Helge Deller (1):
      parisc: Use absolute_pointer() to define PAGE0

 arch/parisc/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
