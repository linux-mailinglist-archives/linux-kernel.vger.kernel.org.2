Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BFE3D4C96
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 09:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhGYHM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 03:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhGYHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 03:12:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21AAC061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 00:53:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p5so1991842wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=rcFxyf9rygYnlVwvu5Lee09asJ+7L62CPIY//nSoy48=;
        b=Sr6+l3mTEHnoSVtEcuIdQfNHnSLANThzCRCl7V2o0PvkmDRDgcS+Dwee1tugvqp1Wz
         37+6YB6fRO/eaQZkHCGvr7G7s7KMKAmB7BS8zVVQQkQilIkiQV9ZZW1vbPOnfhKDKqT7
         vm2wSNHFqOS2DLNAqv7W7R81gkjUb+zg0tEF4U64hCqZ2bJfZfe3Pg6SKqLGxwAECO6W
         i7kLD+WzZ8AP8qWXEUiA9xREt/5xTKju9jNt2spA2fqDncx0XJh7x6VysuiThh6Aeerl
         pbjZQRU3fuQ3cy1P1R3oeammKucgPoZ8wXsGLUJfNDZtT+Skms07ANOpxnNIRW/IJdaN
         ezHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=rcFxyf9rygYnlVwvu5Lee09asJ+7L62CPIY//nSoy48=;
        b=MsxKjqqKGL7PFiw/29Tg68olCMFAw1cxGzh1b44cNs/G10ceiX3KJae+poCklQ+IZl
         o+gL4uJPQgahAGxhYw9u+pun4hpay+/CnY24ifF4V7pq+PaqjbJ9SjkMCCmr5Tb80G4u
         7diwAD2DWyLMzWcSylFuLZEmVOoC+yjzwBDXQ/C43hGIjS+SuYReDFMWy25ahJa7xqxh
         Sh/kZCSqboFayj6Fws8vsn6XschAtjff7UEstXX5MvLSBe/CbOHemG1RjMNP5yv6QCPA
         E9GDXSw/AGKlGoz+Gz/MqEzd3mUZBAGZ7B9NLkVF2gszSDkdreKQpigOjZ7qezy91Hpx
         o9uA==
X-Gm-Message-State: AOAM530E8Jrz5CG+5O0RVy9RVSGVAAHj7c9nnTH9bgeh0UN88oUviei8
        AuYSAXichA+O3fHDfJBcMsylztP9hHQ=
X-Google-Smtp-Source: ABdhPJxW+exJuqCAA8TNP+aYGsrNSmy91Kx+usLyKErmiSV7t5OwpdL+Y6kZTD4NvIz4Dw5bubIN7w==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr13256357wrs.187.1627199602357;
        Sun, 25 Jul 2021 00:53:22 -0700 (PDT)
Received: from [10.11.12.1] ([62.210.13.222])
        by smtp.gmail.com with ESMTPSA id c10sm32157358wmb.40.2021.07.25.00.53.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jul 2021 00:53:22 -0700 (PDT)
From:   Adrien G <adrien.ml.list@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Kernel NULL pointer dereference (UAF) with kblockd
 blk_mq_timeout_work
Message-Id: <4929185C-F2F9-41E5-95A1-9225AF36A6A2@gmail.com>
Date:   Sun, 25 Jul 2021 09:53:19 +0200
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I upgraded from 5.11.17 to 5.13.2 kernel few days ago.
Today I got this bug:

```
BUG: kernel NULL pointer dereference, address: 00000000000000d8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 21 PID: 6427 Comm: kworker/21:1H Not tainted 5.13.2-stackhero #1
Hardware name: Dell Inc. PowerEdge R720/0020HJ, BIOS 2.9.0 12/06/2019
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:blk_mq_put_rq_ref+0xd/0x4b
Code: 44 24 07 48 8b 4c 24 08 65 48 2b 0c 25 28 00 00 00 74 05 e8 79 65 =
9e 00 48 83 c4 10 c3 0f 1f 44 00 00 55 48 8b 47 10 48 89 fd <48> 8b 80 =
d8 00 00 00 48 3b 78 40 75 0f 48 8b 87 00 01 00 00 31 f6
RSP: 0018:ffffb1dd98b07d80 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffffb1dd98b07e10 RCX: ffff89a55330adc0
RDX: 0000000000000001 RSI: 0000000000000202 RDI: ffff89bcc1432400
RBP: ffff89bcc1432400 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000b R11: fefefefefefefeff R12: 00000000000003e4
R13: ffff89bcc1bbd000 R14: ffffb1dd98b07e00 R15: ffff89a54dea0118
FS:  0000000000000000(0000) GS:ffff89d45fa80000(0000) =
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000d8 CR3: 000000270be0c002 CR4: 00000000001726e0
Call Trace:
 bt_iter+0x6a/0x76
 __sbitmap_for_each_set.constprop.0+0xa4/0xe2
 ? bt_tags_iter+0x8a/0x8a
```

Following this bug, the server disk activity stopped and I had to hard =
reboot the server.

I have found this patch, not published yet, that could be related but =
not sure at all:
=
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?i=
d=3Db407bf68af325786b5f572a5e38d51206914f91b

I have filled an issue here: =
https://bugzilla.kernel.org/show_bug.cgi?id=3D213841=
