Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725F7311F57
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhBFS30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBFS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:29:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9050CC06174A;
        Sat,  6 Feb 2021 10:28:43 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v15so11284812ljk.13;
        Sat, 06 Feb 2021 10:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BiidCW4wV5eXIdnRn47SAnhjV05lGSBSg2/37p5Knr0=;
        b=F6jKLPOSRFDOYdd9ZdBTcA2Xzz4rPVfLdR5PV/BcGk4AatlNUWxmr/U8lhBn60oau7
         m0iQkb+cF/mkpUjqesUlfstei5nGXE4EwuKYNwiPLE8mMGNRJSc1A7UpS+7sO7zhi6jp
         GsPcaj6xt3tOSHpBUTMnr6toRFFRZpFrtyLYCQGvcl1XqgYubmSewipo7IkAS1nS8Fg4
         7ODbZ145M9+HxdazJabirIOOCi6OEAJMmHXUoKo95IkETPR/GJNO2R3rRZFGk7jugMCf
         chGUmqXfzodOL0rr8yBUNPfXFCv7HZwlZ4Mi8le0TH3ta/wpYbf2fj2Qx9XV1sf79ses
         tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BiidCW4wV5eXIdnRn47SAnhjV05lGSBSg2/37p5Knr0=;
        b=Uxaax5JwLWVL8cccD8OPCR2pRQ1Q8wt1WTm/BVNburZgABRn5fU52cCU4UD4EZ2hnl
         Oa6o9Iivv7c7/6FPtPn5pMwsWBcm/xNR+55ynT6KIuZDwJnzn54xIdjjWRTPy/dPG+WX
         bYudENP+BSuMgAs+GLB3J+sHj3lcYVtTFn9fJ02T+UVHDX//DHnZgIGS8WRcMHf6fams
         FhEgfSSRgtG4uMeLDMS1vog09wHGwRQmamVvKo29c7sBp3D/HtPGk1APE8MUVt97F3iw
         1IpK6qjiLqifoiu/KKeZzNOS7EQO6GCcbf2SMeIwCdzkXU8aFvus3kaII8kpH81gcKQZ
         3DSg==
X-Gm-Message-State: AOAM533nsaNd4isOM8SVyajhg5AkkRf10h+81YCdOb2RvFT2dUEjrXiF
        nJLt4NK41Mlwyi5lvJ4E8KHqBE8kyAnhO/TVHxAsqE3ajUAf3g==
X-Google-Smtp-Source: ABdhPJyHoAF7MXWGPwJnnmKQ9xDlepPowSf2WMQcAm3hhG0dGh6eIhwoyDsxrM65L8+gV2bmGgGsZzHR0KGPJkbqoZM=
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr6299753ljj.477.1612636121872;
 Sat, 06 Feb 2021 10:28:41 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 6 Feb 2021 12:28:31 -0600
Message-ID: <CAH2r5ms+1ZYrkBJvd9kuN0-tv1PTLzrHUxeGrhVOcEtHXkbqYQ@mail.gmail.com>
Subject: [GIT PULL] cifs fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc6-smb3

for you to fetch changes up to 21b200d091826a83aafc95d847139b2b0582f6d1:

  cifs: report error instead of invalid when revalidating a dentry
fails (2021-02-05 13:17:48 -0600)

----------------------------------------------------------------
3 small smb3 bug fixes for stable

Test results: http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/491
----------------------------------------------------------------
Aurelien Aptel (1):
      cifs: report error instead of invalid when revalidating a dentry fails

Gustavo A. R. Silva (1):
      smb3: Fix out-of-bounds bug in SMB2_negotiate()

Pavel Shilovsky (1):
      smb3: fix crediting for compounding when only one request in flight

 fs/cifs/dir.c       | 22 ++++++++++++++++++++--
 fs/cifs/smb2pdu.h   |  2 +-
 fs/cifs/transport.c | 18 +++++++++++++++---
 3 files changed, 36 insertions(+), 6 deletions(-)

-- 
Thanks,

Steve
