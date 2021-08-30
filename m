Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF443FB7B7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhH3ORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhH3ORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:17:43 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42223C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:16:49 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h29so16234253ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Jv2dMJasxuVarJM8DXCg6aCG0xWa/y1ACMErKtUvVqk=;
        b=XV+43rB3uSRXKxDcsiD0QGFQ5Wy06fEz++9dUvp4tVXt1ZbNKZiV7w0LT8rRaYJeG0
         B0J2Ed9dLeW7I3q360wX51RosAOfJGat241EJKpdvrAhLWtrpo9M6OydjSr6CatqVBX3
         2/ULg7X7K1gRXmj6Q++qsod6VERhKLlvIXNA4HBj7EmCRxK9//HqI3vfRSH+ieeEwavz
         1HVfigLTxbnAqzGBqoFAEqudRBi6HwrctrQP32Eizl3VwX3Mjc9hTkZXlxW0K4psqR/V
         cCoF868nTvztLzJYXfaQ+I5xiNgiwg+2uaEv8gFNfHpPr/NE6Up4SiwZvJ7eY3Qide97
         UOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Jv2dMJasxuVarJM8DXCg6aCG0xWa/y1ACMErKtUvVqk=;
        b=Ha2pbEntcLiaEpCFngCBhIwnpgnmg4DJf4qLfrpU7vdrv1Q/BN/pWcYfJir6V+r15Y
         LE6cUhyl9+WYlnJdlvfsKaOWenI5YSfNDDP4RPlZ1T0kZrodP4AAiaGu28TaCKMdtkJP
         YOkNu4L5Shi+QJapgZTEiW6cXmtvub/vBldWe0wECs9egOs8uzSHJWJQAUBxYhpPPtDL
         hMd4WNa8QUhjJQV6iKXKpxl3SeopkAQohqA1u0zmASTpOk1pSSt5n6Wjbkd/0ylJoRsW
         UOC/pVjrFHngCBcLwkLtxlbIhZsN5KJ+7kszuzt4zqQmlgmIgYzN4/cZHQYnOBueHmQP
         ULBw==
X-Gm-Message-State: AOAM530ttbeA6+9jS36TzIsXHWhcCDtVC6Thrj2vIjNt8J8z063GQRNt
        KfY3aYKScDPpOMbBCUwPFEFOLSIWP9763IxpwQDt5Mkj8lM=
X-Google-Smtp-Source: ABdhPJzOPUvagiuHz9sgl6N50vtNJfYSPFVTyKC3oE2+ik264BVMYqeJFBYSz5xInNwrSazM1Mbqy/T9FZQMc4WXIKg=
X-Received: by 2002:a05:6e02:130e:: with SMTP id g14mr16709954ilr.81.1630333008614;
 Mon, 30 Aug 2021 07:16:48 -0700 (PDT)
MIME-Version: 1.0
From:   Etienne Martineau <etmartin101@gmail.com>
Date:   Mon, 30 Aug 2021 10:16:37 -0400
Message-ID: <CAK+bU8e_mue_-a4cm85THkg=MyNOf6O2so4D+22wzG_LPu=4LA@mail.gmail.com>
Subject: Question related to ( commit 9f691549f76d "bpf: fix struct htab_elem
 layout" )
To:     ast@fb.com, jonperry@fb.com, daniel@iogearbox.net,
        fengc@google.com, sashal@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Etienne Martineau <etmartin101@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been staring at this commit for some time and I wonder what were the
symptoms when the issue was reproduced?
  "The bug was discovered by manual code analysis and reproducible
    only with explicit udelay() in lookup_elem_raw()."

I tried various stress test + timing combinations in lookup_elem_raw() but no
luck.

I believe that one of our production boxes ran into that issue lately with a GPF
in the area of htab_map_lookup_elem(). The crash was seen on an outdated
4.9 stable.

Please CC me as I'm not on the list.

thanks in advance,
Etienne
