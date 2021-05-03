Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7414D37229B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhECVnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:43:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30607C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 14:42:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d14so8063632edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 14:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=T+XjJ3dALnd0wG0aJMGSCh1rng0ubFs/IjGWlTrspJM=;
        b=Ybd9vvSWTOAC080D7jgCAv7+YqxcwtOyKIBQn8P36iYgh5OsJbjamKtIFBMxKP6A0n
         E+JYycOY4SIFpNC1Uq2HVYATPhDy8mEk9QD9cCTRyWnJIqzj8yJLsJqHKv96rz3Hrp1H
         JYlnFcu3VGzWBqNAN7T+Ban4hA1BFWlkGncr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=T+XjJ3dALnd0wG0aJMGSCh1rng0ubFs/IjGWlTrspJM=;
        b=jjple+03WzChyGeuXhMtMzsNDEEy2f7qPzjJWKDKsEP6aHiLKFHREPo3nL7U+Udyvo
         bjd9osGbK6JxbHsGVUgR94sewvE+wyo4qqIYEOPb3YjFBZHQSE/uULBv4RPgruKGBr/X
         4vzgEgKecrmSvn/obVgmb5WQ2igjVdKxFFmIGR7VvrR2DFsBDjZbvqsql7p1EtrGWMaf
         5YG2prMvxQoLjvzjRJOPmiRGMMQcNMD8fY5pydyKporCfOGdtDoLggNxMsR2PCTPXM2U
         UysebQ5I9NqdxJY0u7cccemr6BfTIrKN3Br7/zG3k4aqLdHBGVTyh8YEFdVGw0e/crUP
         eS2w==
X-Gm-Message-State: AOAM530eT0pEwaNE91K0PotcD8MNwjijA59J6lZgjr70GMd+ASS00WWS
        9a9tg+TFsutcv6AgBMfRqWw+gsOn9SnG2gEwaxOCNw==
X-Google-Smtp-Source: ABdhPJyveRS3brIE3ehtHcriSX7MMFHgnM2+onNaMlB5JadrRCdNkKRzvACmNxg2rvC7wz9F4XEGv3gRsAYEnvlZq3s=
X-Received: by 2002:aa7:c150:: with SMTP id r16mr22009605edp.82.1620078144962;
 Mon, 03 May 2021 14:42:24 -0700 (PDT)
MIME-Version: 1.0
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 3 May 2021 11:42:13 -1000
Message-ID: <CAJ-EccOdLW1+8xx8=PRHzSjy4kVaVOUave0pAXF5b=cD4w3=pg@mail.gmail.com>
Subject: [GIT PULL] SafeSetID changes for v5.13
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  https://github.com/micah-morton/linux.git tags/safesetid-5.13

for you to fetch changes up to 1ca86ac1ec8d201478e9616565d4df5d51595cfc:

  LSM: SafeSetID: Fix code specification by scripts/checkpatch.pl
(2021-04-26 16:36:50 -0700)

----------------------------------------------------------------
Simple code cleanup

This pull request just has a single 3-line code cleanup commit to eliminate
some unreachable 'break' statements that come after 'return's. No
other work was done on SafeSetID for the 5.13 merge window.

The commit has been in linux-next since 4-26-2021. I forgot to add the commit
to linux-next until after the 5.13 merge window started, which is why the commit
is on top of the 5.12 release. I'm not really sure which
release/commit the patch author based the commit on, but doesn't seem
to matter in this case since the commit is obviously correct from
looking at the code and the commit applied cleanly on top of 5.12 --
so I don't see applying this on top of 5.12 as a case of losing any of
the testing/development history of the commit.

----------------------------------------------------------------
Yanwei Gao (1):
      LSM: SafeSetID: Fix code specification by scripts/checkpatch.pl

 security/safesetid/lsm.c | 3 ---
 1 file changed, 3 deletions(-)
