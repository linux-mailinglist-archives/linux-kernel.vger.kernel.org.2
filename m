Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5761D4546B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhKQM4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhKQM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:56:31 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B72C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:53:32 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so10943546edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tjd4VyoW9NW6T5kIQb4to2GeaeVYYi1HCWWk5+jRO3M=;
        b=T/DR0eApHoS5O42B29slErSGs5yTs2iQzaCUVmiCL/MWeqEVL7fyOsFw0l9EXHHStX
         hLaephQYrbBA8oTTa2c2VYJwFWiMzlcq0J03ITv1MxKB6doDtNnZbzDay6VCgMneZ/db
         YZDm+i94S/Wj3WFeikFghU+LGjmct8tzx4+nv86BcvGwSQW7mNmaVEsmb0qpBAsrb0Io
         Ei9vlcMcKla9LnHKhj2Um0JP4y+vggE/9tIl/TfqFC3vg7JycNj4DXhczsilq916cAd8
         sqGXOmabkyjTlCrPS/giHyrl6bYjmaWZwv09lW2ZKvpo1jaNDCe+TC+d9UWrzRjegP6a
         B4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tjd4VyoW9NW6T5kIQb4to2GeaeVYYi1HCWWk5+jRO3M=;
        b=HvTCw65XWH7XIdN5M0PkGXRmRH1S9ay8qpZMakEjRhgTj8WJQQ5dTM8JBziRV23h3y
         yrmNTOFxfgBxgUj/w2oFPB9EAG2Hzr/XpRIQyjQ6cw2ZSYVbWYTHIrKAyD6BxG4GrEo3
         9Qn5lGEfbmeTuENqNrAsHcQzfbfHqhwsmL5ClMsZ/z2uZjmsZbP1qKqVURFogtqgXOMw
         21SAVmOjWYB0BtmTXROMjWNo0/E+Y6t5I+f7bDfWs9MfeR6AP4OBJBZv57R5idg2lXuM
         bi97A0WBAvg4x3FduR4gakxXRyyElKc+yYv7qYxAnK6ABSOdFM+RTG6Gl/yAff2jwYDQ
         KQjA==
X-Gm-Message-State: AOAM531zft9APOun1zF3caEt6cxDLAyC3/KhW6fIRLtx7DaxI1TxVP+v
        bOtw5PD4qMjdDivXKfO4LkIpGsMfKCxx6s+BGlWoFg==
X-Google-Smtp-Source: ABdhPJyIPEvbpOSChRQrCUjBOzpZmybNAiQj96Lak7bYQSEl8ibPONfgBVQLGabi/9CTgkfEQ7Yh7eovvoGjPSM3f9k=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr21036403ejb.69.1637153611322;
 Wed, 17 Nov 2021 04:53:31 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Nov 2021 18:23:20 +0530
Message-ID: <CA+G9fYtgOTFJKhAeBJvo3TnmLeNKyrP6R=d3gW1CoSnr7xhyjQ@mail.gmail.com>
Subject: powerpc: pervasive.c:: error: unannotated fall-through between switch labels
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression found on ppc clang-nightly build.
Following build warnings / errors reported on linux next 20211117.

metadata:
    git_describe: next-20211117
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: fd96a4057bd0 (\"Add linux-next specific files for 20211117\")
    target_arch: ppc
    toolchain: clang-nightly

build error :
--------------
<stdin>:1559:2: warning: syscall futex_waitv not implemented [-W#warnings]
#warning syscall futex_waitv not implemented
 ^
1 warning generated.
arch/powerpc/platforms/cell/pervasive.c:81:2: error: unannotated
fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
        case SRR1_WAKEEE:
        ^
arch/powerpc/platforms/cell/pervasive.c:81:2: note: insert 'break;' to
avoid fall-through
        case SRR1_WAKEEE:
        ^
        break;
1 error generated.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
-----------
https://builds.tuxbuild.com/211sfsuxt3flikHFzRts8cFUwqe/build.log

build config:
-------------
https://builds.tuxbuild.com/211sfsuxt3flikHFzRts8cFUwqe/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch powerpc --toolchain
clang-nightly --kconfig defconfig LLVM_IAS=0

-- 
Linaro LKFT
https://lkft.linaro.org
