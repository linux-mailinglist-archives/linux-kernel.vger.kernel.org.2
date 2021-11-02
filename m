Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFED443043
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhKBO0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhKBO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:26:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCEC0613F5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:23:33 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 134-20020a62198c000000b0047bf0981003so12012972pfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=63IOB9jRdXUGAooHjzUqMr+AM+45Pd5GmDjRByI/XbI=;
        b=qi4MgoYmDEaLYqbeJbKBcxSIcp/8i0isps5OLMCXixb4n3H16s6alormsch+ATl6Kn
         Z2pkLw95tCm6HK96SFLKo6IDh6coBNXhl8VIXccM2QK8YNpIEOuTbNAB4aHtklBylK3d
         gn1U3F0peJ3bvludQKGt5QJLvD3m/LZJ0ZFEb9MjS0c2YZONBgXLORkNxZYWZBIBJZfB
         dqPL+JovaI2bQMp9ya9sldwT3NZgFnXGiaZzZOiJB/aNLCoBbNWHLdfo0XIomiebZOet
         aP7TIGzfmU43Ozh/kfwl9b0hkofWDt3F+qowWRMQ4J5ecqDVkfCxKb9J2pfMJJQR/wFB
         OnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=63IOB9jRdXUGAooHjzUqMr+AM+45Pd5GmDjRByI/XbI=;
        b=eHNqx/j9j2FfdPGyvICo1eNcPYRqQorTPnbUeClbVoOHQ137DCPgbzq9uKoxWxajCM
         Lzo2JSwS0/E45HavCU8lO5UOSD00FWdf0yFP9RwwcDtsuaOyvrhS5be6aDTfktUaGogK
         Jp7EiKNUUfZ6L3K8k+GmQvk0nkLiFdabnHoOLtJclnTOGr4esnGtKh90SshKld0qrFYK
         t/Bt+8p/D4YDRjyiuXwF+v4qlMKCSqVCkE6HpGARVSa2SGlhd29lS/DiIa3X2gs2oXUS
         QBhdRUB8K1q2qoVO/rL+HB1zzxEPFIMrMvjgEA4y9amZQ5d6rLS9cCjqdLSx4v7hgyL+
         dmXw==
X-Gm-Message-State: AOAM530UtOj8vQFH+j24V7UDsKAIWOdsv9b15vL31gCCBjqztm3tHwa7
        3RW1utW8X12g7Xt2ceX9o7jMpNSYLew=
X-Google-Smtp-Source: ABdhPJxe+qQNjAW37tdJRSoe4g4rocE0eurn9JS1ToQLbTqzN1qZBg1QLEj/XudtcfFmmoI5SRruPmxqbt0=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:3109:8497:f59d:9150])
 (user=pgonda job=sendgmr) by 2002:a63:83c6:: with SMTP id h189mr13190826pge.126.1635863013160;
 Tue, 02 Nov 2021 07:23:33 -0700 (PDT)
Date:   Tue,  2 Nov 2021 07:23:27 -0700
Message-Id: <20211102142331.3753798-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH V3 0/4] Add SEV_INIT_EX support
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

 .../virt/kvm/amd-memory-encryption.rst        |   6 +
 drivers/crypto/ccp/sev-dev.c                  | 226 +++++++++++++++---
 include/linux/psp-sev.h                       |  21 ++
 3 files changed, 221 insertions(+), 32 deletions(-)

-- 
2.33.1.1089.g2158813163f-goog

