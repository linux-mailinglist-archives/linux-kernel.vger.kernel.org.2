Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B543FEF13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbhIBOEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhIBOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:04:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C44C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 07:03:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n11so3044481edv.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hUzWJcdfQhfud3uRFK51QwpcOlINZhZFuA16L2RdrPU=;
        b=Xm7VbLS3uRyMgm6cfXnFTU6GF2+JgMndFp5SVQ0GiiqN/21NF0J6oB2zEl31OOHMWZ
         bpD/jg+xUPhRl+7YSZJPa9VHJPEkFUoMkTsRBqRiESploEfxswi9cJ7/FZRmHbYF+06t
         skGA5/Zqm2oI4qC7hfHkIr0nqGAjLKhQbrEG6Tou0tSmxSNsxS1fomGSjgbzDMYisRPP
         3SeXZAyi9TtI8QxQ3nQQt3Rt67X6dryRQTzBu2EjEQ03eMABUDvPnLmM+OTia0UEfyzG
         61m0+cdnt4Vi6uUIW/IYQgCiTDrEHmmq3UlqzEdGRUjRvunzhoYFFISszvBBiv/s76NB
         0a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hUzWJcdfQhfud3uRFK51QwpcOlINZhZFuA16L2RdrPU=;
        b=MQ24Q2S7tTcVAkc4hNG5zlKVOFVDXXGJ+c87zA/scwsnlrfHkhZis49Zaf2msoj9sU
         lMsQtTv2MnEa5Ntmn5n4JJ+YWMvt3sBjGHYYkmYo4k1CpSriGhh3Q5ejQ3TVAWPPQagH
         pr8AgHFmHFA5yq+XOG6dUvpj7FpJnXHDU5KaHT0TswtQO1PYrFlsbkNzsMgyyVNkrewi
         T//7qlIDwIui4CjP7E5+Ug9MA25oGeLRqxRBFbKPPsHFuUP3K+qpQryp3jPUd1ncQfhR
         BAyp+VusnuaFiAGowNdqJx8WbJcgnIadG8xYRCHxVVTEz4GHRP9kr+9BpEsCqFQcR6Jv
         gB2w==
X-Gm-Message-State: AOAM53046xx07mUnHvQlr3Hn0pyU7Hb/BVttxPW+PnapOAEPtWln+zgu
        lW9VCv+S8anNVQujxyidAxZo96gkQmFgY8ujB+v7Dw==
X-Google-Smtp-Source: ABdhPJy/ahojUbN3NAhrTuVMSc+2NsB9Osb593CarCGmU0aJ7tJvqOD6jb+ZmwS15Y9NxsP5xYtUE/pTy++07bQOj7M=
X-Received: by 2002:a05:6402:1b02:: with SMTP id by2mr3707318edb.365.1630591386637;
 Thu, 02 Sep 2021 07:03:06 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Sep 2021 19:32:55 +0530
Message-ID: <CA+G9fYs=GY7eQSEc08PHdaT1WtzZtaxD3Fc8jpu1Dy4g=o5Xtg@mail.gmail.com>
Subject: ftruncate04: WARNING: the mand mount option is being deprecated and
 will be removed in v5.15!
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Roy Lee <roylee@andestech.com>, Jeff Layton <jlayton@kernel.org>,
        Robbie Williamson <robbiew@us.ibm.com>,
        chrubis <chrubis@suse.cz>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP syscalls test case ftruncate04 found this warning.

[  136.115071] loop0: detected capacity change from 0 to 524288
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:889: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.43.8 (1-Jan-2018)
[  136.250270] EXT4-fs (loop0): mounting ext2 file system using the
ext4 subsystem
[  136.255226] ext2 filesystem being mounted at
/tmp/ltp-GKVnWFZH5N/nTMmf9/mntpoint supports timestamps until 2038
(0x7fffffff)
[  136.258936] ======================================================
[  136.258936] WARNING: the mand mount option is being deprecated and
[  136.258936]          will be removed in v5.15!
[  136.258936] ======================================================
tst_test.c:1313: TINFO: Timeout per run is 0h 15m 00s
[  136.266703] EXT4-fs (loop0): re-mounted. Opts: (null). Quota mode: none.
[  136.267843] ext2 filesystem being remounted at
/tmp/ltp-GKVnWFZH5N/nTMmf9/mntpoint supports timestamps until 2038
(0x7fffffff)
ftruncate04.c:116: TINFO: Child locks file
ftruncate04.c:60: TPASS: ftruncate() offset before lock failed with EAGAIN
ftruncate04.c:60: TPASS: ftruncate() offset in lock failed with EAGAIN
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
ftruncate04.c:127: TINFO: Child unlocks file
ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Full test log link,
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.14.y/build/v5.14-rc6-389-g95dc72bb9c03/testrun/5607838/suite/linux-log-parser/test/check-kernel-warning-3410862/log

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ftruncate/ftruncate04.c

- Naresh
