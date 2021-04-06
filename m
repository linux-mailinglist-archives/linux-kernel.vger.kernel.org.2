Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24435504A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhDFJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:44:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:53393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237649AbhDFJoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617702242;
        bh=2bD/fm4nw5EI9PLgefWYslB+Hj9bP6U0G2PbneEtwZ4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=alCnt92833zZr/5MKhm9zvTUnsNMh9k2NUtiu0dW4qc84L+petMRJPXN9hNIBMDIg
         abh4jySlbfJluvxxRx48xup6zQNKfJ/Pm97lqIWA43QS0CAzYrIOm43SN3saWVRdyv
         V4bwpfFqRlsyIHX4bLmad9Vf5FQt9E0UMaGTxmMA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.164.142]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1lPqd61euA-00Dl30; Tue, 06
 Apr 2021 11:44:02 +0200
Date:   Tue, 6 Apr 2021 11:43:27 +0200
From:   Helge Deller <deller@gmx.de>
To:     kernel test robot <lkp@intel.com>, linux-parisc@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: ERROR: modpost: "sba_list" [drivers/char/agp/parisc-agp.ko]
 undefined!
Message-ID: <YGwtP0tXVzOj/cqc@ls3530>
References: <202104061234.XBEOEjdn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104061234.XBEOEjdn-lkp@intel.com>
X-Provags-ID: V03:K1:N3yHJoBPUwLeSupAMWWGFSRSLweiGX76L0OD0XfzblqBRt+ux/K
 YHv5XgdAovEVX3tSP5e8v7NbdoApTnFO39rLhqIGJTWBKfcIJVKZM1FSy1ot3HxIEDXdFtr
 1/r970WmC3oKNu/s+rglHjVVBC9FbU6Hi6/wVacwXdl0lqzJ3SWOkaiDcfQOFQ65/4sopUz
 rWZOfTQZCulpxrEti59bQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cuuxcN0Qhxo=:B28GtO1LJ86oP8QInpdOyl
 Ys1ovieAlJjtTEJpwKwZtsfTdbodcbH0wwcb7Q8eyiUJp6CEP0R7LTYgjU+FIYxwdntS7NaKP
 M0qAccN0UgB4o1+Nn0G+8OaJb2UnCSV/9Rozb+M+9Pu9Nzx9Yrb5kAaSfYDSMzTWAWqVmd0ka
 6+7Ntr7XklGJGTplSyz6ypvw1pRv9088oUBCoPZyl8WLrwEwpxVjTBd84+s1FBK4Ylse+IDNa
 aI2KcXmhzIjWz6eZ8pazFRdw3iwR5f3kj92z06fBOuh8ue/yQGxnU9Ok5/ypHw7R6refTsrdB
 wPBfvACbDT2u/VGXcAJ7NDs5Z5W7ubM0V9ZUmRfWL9iDGM+P11J+6Nx0RuBceQRbKstvBzGKE
 oBGYYGPCnI7Q0EXZuYUABRLZacMcceyvSySi0Ew6WpVwIfbrTEYhNwNj0wncEgDHD267mw+fJ
 StAl/+K8S8sny7+Ey6q9cHeC1FC7k2pc4uj2KNzktx5FRqkV1+jZe94pROUxpisUW8GwmPViY
 gqhf271HeHjqnbVSl5JV2vj9U9PmKfXSmPv1maULk5tE2rBU+xisUu3to3Z9tibu8q8hXlPUW
 ZUNwzBYLgIC+K+J2fJP3sc8HZ1GJaqYVw+V/L8gJu+0p89H9otFaO8KHMVccupEtMAM1bWNQu
 /67THbiN5PkEYbO9MTX7LKmxX7c9ruK8VbYkt8Zz9cXd1Xnjw1KmxQBYcQqZFErJ6KwsBPs06
 fXPd72kidbWNQO+j60tsAg/IfQsSWcjLEAl+kbvA11trYmlHtuFUW+igMF5kVhfKerUYrFs2J
 rHU4wUBun1kOy10pXb29uBkEx6zkJhWFIqHK1DO/+JB76519CKQnS9gKf2HfIdoePpufb5JQJ
 Ecy0mvs25Etz/MvBhhVg3rWxEGbeqG+FjveQAvfwhoMeIsG8CPbyLxcsVDuhodvAO37ItYEqN
 ebPWKFWQQaUbJqvwEOkeUyJORnyDU3Pb4/Jr6By7XNntXrVFj9BXOPufPlbBmBNzYIMJeRAgA
 a+gGSx1qIPlq86glyfeXlpZanyuWrHdXqL81BY+tbouBCb33Yq8ESCjMepy+fvbYyjAKUahD8
 WLHRBGNOVwZr0FIh/tRMhYMl0yrbv4jkFneC4XCbNrcgwbpat8kQKwlEgXk57jOxB69TAOi9B
 Gc0KS8EOZK6q62F3BNVhaOoaGQJiv4boPyUp8tzGYHA+0D7FzEEv77UHA5SxQOY7UtO+w=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com>:
> Hi Helge,
>
> First bad commit (maybe !=3D root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
> head:   0a50438c84363bd37fe18fe432888ae9a074dcab
> commit: 00e35f2b0e8acb88d4e1aa96ff0490e3bfe46580 parisc: Enable -mlong-c=
alls gcc option by default when !CONFIG_MODULES
> date:   10 weeks ago
> config: parisc-randconfig-r035-20210406 (attached as .config)
> compiler: hppa64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3D00e35f2b0e8acb88d4e1aa96ff0490e3bfe46580
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel=
/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 00e35f2b0e8acb88d4e1aa96ff0490e3bfe46580
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cro=
ss ARCH=3Dparisc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "sba_list" [drivers/char/agp/parisc-agp.ko] undefined=
!

The following patch should fix it.
I'll apply it to the parisc for-next git tree.

Thanks!
Helge

-

From: Helge Deller <deller@gmx.de>
Date: Tue, 6 Apr 2021 11:32:52 +0200
Subject: [PATCH] parisc: parisc-agp requires SBA IOMMU driver

Add a dependency to the SBA IOMMU driver to avoid:
ERROR: modpost: "sba_list" [drivers/char/agp/parisc-agp.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
index a086dd34f932..4f501e4842ab 100644
=2D-- a/drivers/char/agp/Kconfig
+++ b/drivers/char/agp/Kconfig
@@ -125,7 +125,7 @@ config AGP_HP_ZX1

 config AGP_PARISC
 	tristate "HP Quicksilver AGP support"
-	depends on AGP && PARISC && 64BIT
+	depends on AGP && PARISC && 64BIT && IOMMU_SBA
 	help
 	  This option gives you AGP GART support for the HP Quicksilver
 	  AGP bus adapter on HP PA-RISC machines (Ok, just on the C8000


