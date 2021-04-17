Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9EB363232
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhDQUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 16:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbhDQUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 16:18:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC30C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8Uc7dhzIc/p5Iji54e1aRZ450Xs9Pb7y+6pkjxagzLA=; b=GZSLEoK2gynTCSRjWeTnq3bQeh
        Yh9OLJ4OibIw5oCLBjvsehNiN+S80FKnpFxPhpvu6I12wCe/TM8nob8DjN4oRtEcyQNbBO6hPH7u6
        tO2w/FdELtV770/4v7wwXZES+VALvUOfS4rtbGQ2evjkviQQVgkwWX5tCydtVazMZvRuxfeYvBzkM
        lT/vQjJYKxuBB4L8QEJMdnxsVSScogvk0g2tTny+Zxhp8Y59osuxdDtXnTacrKdSje1zmq8OQ8WSu
        zH72KWE5G4gVLxC4aZQ/XPyOTQTLzt6+CscuugQD39URHof95HKR1iXmFaBrERiSboZ+Y0MeCU5+3
        Y0QAjbYQ==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXrOG-006AUO-5D; Sat, 17 Apr 2021 20:18:04 +0000
To:     PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: PPC_FPU, ALTIVEC: enable_kernel_fp, put_vr, get_vr
Message-ID: <7107fcae-5c7a-ac94-8d89-326f2cd4cd33@infradead.org>
Date:   Sat, 17 Apr 2021 13:17:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot reports:

>> drivers/cpufreq/pmac32-cpufreq.c:262:2: error: implicit declaration of function 'enable_kernel_fp' [-Werror,-Wimplicit-function-declaration]
           enable_kernel_fp();
           ^

when
# CONFIG_PPC_FPU is not set
CONFIG_ALTIVEC=y

I see at least one other place that does not handle that
combination well, here:

../arch/powerpc/lib/sstep.c: In function 'do_vec_load':
../arch/powerpc/lib/sstep.c:637:3: error: implicit declaration of function 'put_vr' [-Werror=implicit-function-declaration]
  637 |   put_vr(rn, &u.v);
      |   ^~~~~~
../arch/powerpc/lib/sstep.c: In function 'do_vec_store':
../arch/powerpc/lib/sstep.c:660:3: error: implicit declaration of function 'get_vr'; did you mean 'get_oc'? [-Werror=implicit-function-declaration]
  660 |   get_vr(rn, &u.v);
      |   ^~~~~~


Should the code + Kconfigs/Makefiles handle that kind of
kernel config or should ALTIVEC always mean PPC_FPU as well?

I have patches to fix the build errors with the config as
reported but I don't know if that's the right thing to do...

thanks.
-- 
~Randy

