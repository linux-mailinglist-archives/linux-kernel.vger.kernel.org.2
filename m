Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672938843F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhESBO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhESBOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:14:23 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3BC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 18:13:05 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a8so3275201ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 18:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MyCbwTGR8WdlGYqZSeyMLC4GasAvLbJRPHlzJQ1aEME=;
        b=fu+9+8Y4D4ClEazUIUDeR2QSt7GI/XvCYQSlFePLMRMVqpdTQZxSXeFPmvi+UpnV7D
         GMRWxTy71L0CW6BM0ZNm3LqIyi+ZsKLT+0skU43D62NYgGzUQSHdNbMYuJwALn+o371G
         8t5o7zsaIVXyatse8pUJ+1AHym+5sbw0NmrPBCH3Iz4pSYMn1ptuV/JrDtSZLhtL8na3
         Q+kOFWhOBhn3tT1npj0u93iJsiy/q4v1aIzgOF33kT86m2kuOtj3sZ+YJ+i/uUdkiZcg
         xbD9RehveokoppY5+GO27j80YVXtEoQDYOMF8ZDdfaW8VZgZMYHktsRf5KVQNsEBEndu
         /UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=MyCbwTGR8WdlGYqZSeyMLC4GasAvLbJRPHlzJQ1aEME=;
        b=oGKPYR2zhp5bjAZclUyc5Q2AawL1OdI1wKD/NE8dHvHSSiNy3Ckg5kCIUO8A4IX/AE
         81UfqJB7zQjO9wyIAfRUYp5twseRCDcMrR+S4VXcezUEvGZuq73yS05uHPF8hNSPY/oF
         TnmxIanTKz1J7mmcByNutOAt6ls7x9IYGxsQL3PteejiJiTg42nWFLThYxQFA5WdduLe
         MuIK7/lTQgy2cgS1bHanYxA4vh8Nx+TywFbqTYtiLQKlo+HX27nfXnsuItQMgsvhs8lm
         NqZp7erxi8D7X9RindfONLoznbImHavUDHoMXVUW2r2pJsC+tUMbPet+1bJCfNcZX5OU
         KJ3Q==
X-Gm-Message-State: AOAM533EUnnE4QV2eqeGTzfnRXMV7WRFijW220cg4puV+mbEIv6N0ZC8
        cTzJ8/uzfMAlUHUCV4C7KDIgxJE5GNq9fE4G6V9jdEzUMJk66g==
X-Google-Smtp-Source: ABdhPJy01gJC6yg2XrDYiX2cXdlb7cKXwmCHEGlIAKPxesU88ATjME9LjZMCb8Yj7PluaFxdxgvA5cONz4WuCyTTY5k=
X-Received: by 2002:a02:91c1:: with SMTP id s1mr9325015jag.61.1621386784477;
 Tue, 18 May 2021 18:13:04 -0700 (PDT)
MIME-Version: 1.0
From:   Ammar Faizi <ammarfaizi2@gmail.com>
Date:   Wed, 19 May 2021 08:12:47 +0700
Message-ID: <CAFBCWQLBfBCe2SnQi7kOUPbGfj7xeP9vzgYqOKT6bRSFUwdKvw@mail.gmail.com>
Subject: =?UTF-8?Q?fs=2Fqnx4=2Fdir=2Ec=3A51=3A32=3A_warning=3A_=E2=80=98strnlen=E2=80=99_specifie?=
        =?UTF-8?Q?d_bound_48_exceeds_source_size_16_=5B=2DWstringop=2Doverread=5D?=
To:     al@alarsen.net
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Anders Larsen

I found that you're a maintainer:QNX4 FILESYSTEM. So I am reporting this to=
 you.
GCC 11 warns =E2=80=98strnlen=E2=80=99 specified bound 48 exceeds source si=
ze 16.

  fs/qnx4/dir.c: In function =E2=80=98qnx4_readdir=E2=80=99:
  fs/qnx4/dir.c:51:32: warning: =E2=80=98strnlen=E2=80=99 specified bound 4=
8 exceeds
source size 16 [-Wstringop-overread]
     51 |                         size =3D strnlen(de->di_fname, size);
        |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from fs/qnx4/qnx4.h:3,
                   from fs/qnx4/dir.c:16:
  ./include/uapi/linux/qnx4_fs.h:45:25: note: source object declared here
     45 |         char            di_fname[QNX4_SHORT_NAME_MAX];
        |                         ^~~~~~~~

I found this warning in commit 8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/

  commit 8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
  Merge: d07f6ca923ea 54a40fc3a1da
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   Mon May 17 09:55:10 2021 -0700

GCC version detail:
  ammarfaizi2@integral:~/project/now/linux$ gcc --version
  gcc (Ubuntu 11.1.0-1ubuntu1~21.04) 11.1.0
  Copyright (C) 2021 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is N=
O
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

Regards,
Ammar Faizi
