Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472A045166D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 22:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhKOVYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 16:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241202AbhKOSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:18:46 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14537C03D782
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:41:06 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 134-20020a62198c000000b0047bf0981003so10346434pfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Eg6f2WJu5krQnu/y0o//GpBJ3T4ZfGNyV5od0jKQbGY=;
        b=X8N5SMfdAZTxXEeXWUHlFBXvvNmxy+tr/4oO/d8XIBKoypX8VrHqI9I7lBpZhPooCY
         X1yKjF1gENzLdSKgmRraBh0KneT8A5C3WhiKQ2oNXDaN0ux9UFNPuXYpqtEiKsY2cMvb
         ZorSjNq/UD6BbT5UrdlUMUJ5Eq12rIxJJ//Nq7/BluMjGIvwxIB5bRbZoWTJsIGBb9Vi
         93AVdF7MT2Cvr9rhi1Hy32k+vdE/8fImgZcUqN3GFM6RnF5n+9EvodtG7SGrlQAE7azX
         Yvm+eyGxlF3bFHOQbYZSDH+tNDqZZaDj9TtnJlkCd0/Vzh5lLZjqNL4nRtzZavEUx2Hb
         omIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Eg6f2WJu5krQnu/y0o//GpBJ3T4ZfGNyV5od0jKQbGY=;
        b=GhNSe+Y1J/LyUBPN2YS32ruoQUhJUfaW/YDhKDy12Fov0c+m2zPQQN0lZMeBPI+q2P
         pQiu6ogyfsG2yIeqXE8Hvv/MdckEWnQwksk3FoV3eUrjiabu1eLklGURzk+oqD377Hff
         43tkmIbPfGoH1FWCMWgyaBPIdU/oMY8eg37Hqt5tYV72h8+Euay1BrE8vURFRJ53o9Lz
         ICg/v6BJ5+KnMTfXLmdKvLARuhoirZjSDrbzDoln6CDCnb7KHz7tWre6RhU8Fn+roOBx
         25JiNvTuoTUnLOY1iXTsTzDCvlBLlm1pvTorIk8Q5Ox3lg2w2bp2SovPmosHER0qzXph
         7BOA==
X-Gm-Message-State: AOAM531QgfFmlnckIx/G+0tKlWsg3v1w7IPXdmmCaMOKBL4qqzOwq+IF
        lFcerGDLLQcbpMW3YW5fqDCYQjieOFU=
X-Google-Smtp-Source: ABdhPJz01E3rKYXQjaNe7gZpXqIOO3AD/+sHmr0XbWwZUjglzjAtmWpn6m82EpyoTVOfxAnk/2mjc2FpRqk=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:9fb:192e:3671:218c])
 (user=pgonda job=sendgmr) by 2002:aa7:9903:0:b0:49f:e368:4fc3 with SMTP id
 z3-20020aa79903000000b0049fe3684fc3mr35029520pff.1.1636998065416; Mon, 15 Nov
 2021 09:41:05 -0800 (PST)
Date:   Mon, 15 Nov 2021 09:40:57 -0800
Message-Id: <20211115174102.2211126-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH V4 0/5] Add SEV_INIT_EX support
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

V3
* Add another module parameter 'psp_init_on_probe' to allow for skipping
  PSP init on module init.
* Fixes review comments from Sean.
* Fixes missing error checking with file reading.
* Removed setting 'error' to a set value in patch 1.

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

Peter Gonda (4):
  crypto: ccp - Add SEV_INIT rc error logging on init
  crypto: ccp - Move SEV_INIT retry for corrupted data
  crypto: ccp - Refactor out sev_fw_alloc()
  crypto: ccp - Add psp_init_on_probe module parameter

 .../virt/kvm/amd-memory-encryption.rst        |   6 +
 drivers/crypto/ccp/sev-dev.c                  | 258 +++++++++++++++---
 include/linux/psp-sev.h                       |  21 ++
 3 files changed, 245 insertions(+), 40 deletions(-)

-- 
2.34.0.rc1.387.gb447b232ab-goog

