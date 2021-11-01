Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7F441F21
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhKARYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhKARYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:24:05 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A9C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:21:31 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 2-20020aa79102000000b0044c216dd8ecso9671714pfh.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CoWFdMtEKYfjPZOD0vCpNP+OWRXL2lmJCe48NdmadTg=;
        b=gxe3023L4vM/f0BrrI+g4eczlr8eUSoK7OVP52Fd83Zx+/1xgnT7Xp760uYfL35mwZ
         eq1NLI0+GFpypCgLVs/5MwsEf3ic6o8mPUtoIdAmU9XkEtEF0FxGwo7bMi6ObOJSJ2pK
         9OHqcsWxwig7sc5WSRIjhTiEocMjG3MFxA31Mrpg47eiMWCB2/obzVQ7X5YbvqpX+zWD
         QMB8wqsR4PfopDPbFzdXKxnE+kV6EKNIyu7vw/aUgMPE477bdrT3sO6jJ1F8N2pzXtSA
         uuk8vvyvyBg9fIlp+VnqRk3aeSfGUSrXrq95lIkbVlX6aRWm8diqdRaApcsyEI+YEXBH
         6MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CoWFdMtEKYfjPZOD0vCpNP+OWRXL2lmJCe48NdmadTg=;
        b=nCEwz9kORzk7/XKWeZ7AqNrrkMsz2v+Bot7ob5vKD+GPLj9J15xf7QZaA+FBoJW7Y3
         lMPSeWbinACYekrPVjq8ouIVqa8ObZYjnIcpZIKroWZNgrjH93PLfPadZjgL34v76//8
         8AWPSE/0XcC4ZYlg2Q5XgvnEPhidIu+DFVOyksm7G6Uun1idUg1hNe2kq5JJGhWo76X5
         vKNAyc5gVoOPJUYfZwyB1oJBThFsltg2mpqtqXyWCIGO5e0q46yApwZsh60/qcwX2E/6
         RhSv1KGrSJupDrXO+f3rrippicQ7w+kc3hlU80J9WqBU3pU8iDj1wQUODW5ZFC9wK1xC
         5BDQ==
X-Gm-Message-State: AOAM530ZqHSMa3BncW7B0W1GSSY8LyYIvfVKkgp2yRFgdszQs3qsG1Km
        QygxNte17ayX56PU/brR/vAubqvXdM0=
X-Google-Smtp-Source: ABdhPJwiBZENM6vFRwunYr1hYmFWQMBC3FQyA36QdhSOCzEEo6BoTKMuuHCS5+xD5yA5aJNdefZJfisA9Yg=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:98c4:afe5:ed9f:d0db])
 (user=pgonda job=sendgmr) by 2002:a62:8484:0:b0:481:5ff:48d6 with SMTP id
 k126-20020a628484000000b0048105ff48d6mr9475591pfd.78.1635787290687; Mon, 01
 Nov 2021 10:21:30 -0700 (PDT)
Date:   Mon,  1 Nov 2021 10:21:23 -0700
Message-Id: <20211101172127.3060453-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH V2 0/4] Add SEV_INIT_EX support
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEV_INIT requires users to unlock their SPI bus for the PSP's non
volatile (NV) storage. Users may wish to lock their SPI bus for numerous
reasons, to support this the PSP firmware supports SEV_INIT_EX. INIT_EX
allows the firmware to use a region of memory for its NV storage leaving
the kernel responsible for actually storing the data in a persistent
way. This series adds a new module parameter to ccp allowing users to
specify a path to a file for use as the PSP's NV storage. The ccp driver
then reads the file into memory for the PSP to use and is responsible
for writing the file whenever the PSP modifies the memory region.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

David Rientjes (1):
  crypto: ccp - Add SEV_INIT_EX support

Peter Gonda (3):
  crypto: ccp - Fix SEV_INIT error logging on init
  crypto: ccp - Move SEV_INIT retry for corrupted data
  crypto: ccp - Refactor out sev_fw_alloc()

 .../virt/kvm/amd-memory-encryption.rst        |   4 +
 drivers/crypto/ccp/sev-dev.c                  | 230 +++++++++++++++---
 include/linux/psp-sev.h                       |  21 ++
 3 files changed, 222 insertions(+), 33 deletions(-)

-- 
2.33.1.1089.g2158813163f-goog

