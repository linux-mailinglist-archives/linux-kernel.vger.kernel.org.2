Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85DD36749F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbhDUVHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 17:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbhDUVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 17:07:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73826C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZM2ehOGr3Lw3U7fLtVZbH3jW2tFkDDiwHuTaEwECTJA=; b=W5BXQXsmoH3x4c7K1/YLKMLcrs
        DST56gERsOa4jPLxOyYtKmBYKyJvhtGU6vSMFuRLfsUcdJSu/Ib23nysrFK949La8dZ31kRzUn55E
        QiKOs3LCKvjMhQ6HkubWHkD7n9prAo5pBPviJXh3UervK71tNrauE75yhZBpgp6bLaLqdGb0o1nMh
        htRLDmM0dKkfNbvya5vVZLWhCNk0zUJc321NKxZ37b5X67Ds6NuXa73JY3m665nRLe7VRlPzKfCA6
        /VL+wrBLCarSlpmHUfHSKfBSB1E+r47Gj9/0Wooqr7N/b6ujybf41ex4iau+knabentgvcnQc9x11
        fC//4vyQ==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZK3f-00FCUo-Gl; Wed, 21 Apr 2021 21:06:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v3] powerpc: make ALTIVEC select PPC_FPU
Date:   Wed, 21 Apr 2021 14:06:47 -0700
Message-Id: <20210421210647.20836-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a kernel config with ALTIVEC=y and PPC_FPU not set/enabled,
there are build errors:

drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
           enable_kernel_fp();
../arch/powerpc/lib/sstep.c: In function 'do_vec_load':
../arch/powerpc/lib/sstep.c:637:3: error: implicit declaration of function 'put_vr' [-Werror=implicit-function-declaration]
  637 |   put_vr(rn, &u.v);
      |   ^~~~~~
../arch/powerpc/lib/sstep.c: In function 'do_vec_store':
../arch/powerpc/lib/sstep.c:660:3: error: implicit declaration of function 'get_vr'; did you mean 'get_oc'? [-Werror=implicit-function-declaration]
  660 |   get_vr(rn, &u.v);
      |   ^~~~~~

In theory ALTIVEC is independent of PPC_FPU but in practice nobody
is going to build such a machine, so make ALTIVEC require PPC_FPU
by selecting it.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: lkp@intel.com
---
v2: change ALTIVEC depends on PPC_FPU to select (Christophe and Michael)
v3: other platforms don't need to select PPC_FPU since they select ALTIVEC
    (Christophe; thanks)

 arch/powerpc/platforms/Kconfig.cputype |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210416.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-next-20210416/arch/powerpc/platforms/Kconfig.cputype
@@ -310,6 +310,7 @@ config PHYS_64BIT
 config ALTIVEC
 	bool "AltiVec Support"
 	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64 || (PPC_E500MC && PPC64)
+	select PPC_FPU
 	help
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
