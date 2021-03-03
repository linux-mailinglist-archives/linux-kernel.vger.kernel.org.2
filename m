Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD632BFB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580051AbhCCSdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348044AbhCCRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A7hqiiwpzHCv9dcTIz5ZNKi8QEHjE+ALvxN3oPNlRwk=;
        b=D9SOTeDuuvUZ8r4EHT4ODQLqEAJTZ04tuIkEbQTuvVlM7bFf4WZTaD71ehUZvSrWPJ4qVR
        gz/99SX4s5T4oTKtntchQjRrUm7aCciuzbQ+vN1kD/Qgns0hyCktAOHVkMSxlMkDXC8w1X
        y/LzKB3xJHBMsw4HHYRDR08OL+sM6lw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-EJSuxWi9Pqans2zV125BAw-1; Wed, 03 Mar 2021 12:05:42 -0500
X-MC-Unique: EJSuxWi9Pqans2zV125BAw-1
Received: by mail-wr1-f69.google.com with SMTP id f3so6161622wrt.14
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A7hqiiwpzHCv9dcTIz5ZNKi8QEHjE+ALvxN3oPNlRwk=;
        b=rl901fTiGrgU5pXh64ErDc+qbtPydCnJqGEpYo6d9OoDRfMDCWsyjTrXVsezWAJ111
         pudyZJp8CdmQ+M+AmeNWmd2yn1jRuBv2wIpocowCyPYFyWE3fm3TT9GXdvtrDtFlo62S
         BI/HmFstSoeVr68St2TBWC6riyfKTyrnzh/m8FEAfxznxwd8E3L9P5Y6wVLBLbrVmS5V
         BVtheTmXXbTqgHpGfnmMFiBI8hUMNrI2y82Ws8Jr4eZgGz3CP9iaE2I1QR+SVuowlnR0
         w5WkUF9Y0lwR3TyzygBAgjjrE4MdXYAfjwKcXFbEs/CeJf83CBgNPtgwT1l/3wwAzOal
         n+Gg==
X-Gm-Message-State: AOAM533kodu2E+zpFHxtrj1YR1UvlZkSNkLvXtqUjxRkh5iLnxom4Z1X
        4sATAlNESvQaVyuQC3sbi2tnlDCrHTkqEQWqvDhFSrYEqEpaU3TKHCmJiHUsCS4VL4yicjzG7z+
        Lwdmpkn/rF0hz4OjLtbkXw/JHJWb3O/20FAz6qpMBBPy3Ni5RMOwDFzM1PUNoV/s+bRBM2GXOUD
        i0
X-Received: by 2002:adf:ed44:: with SMTP id u4mr27999050wro.35.1614791140556;
        Wed, 03 Mar 2021 09:05:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzNmPS+Nyc5thLw/E/w0nWRpQjgI2MvRdrlSRg18Nj3Ck6eZLBX+Y2xOLFNKfOZjcTebcU/g==
X-Received: by 2002:adf:ed44:: with SMTP id u4mr27999022wro.35.1614791140291;
        Wed, 03 Mar 2021 09:05:40 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id d29sm32957827wra.51.2021.03.03.09.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:05:39 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 0/8] arm64: Prepare instruction decoder for objtool
Date:   Wed,  3 Mar 2021 18:05:28 +0100
Message-Id: <20210303170536.1838032-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support arm64, objtool will need to be able to decode aarch64
instructions. This patch series adds some instruction definitions needed
by objtool and moves out encoding/decoding functionalities that do not
rely on kernel code in order.

Changes since v1[1]:
- Split the isolation of instruction encoder/decoder capabilities in
  several steps as suggested by Mark R.
- Exclude dsb encoding where CRm != 0b0x00
- Support dsb FEAT_XS encoding
- Support previously missing barriers

[1] https://lkml.org/lkml/2021/1/20/791

Thanks,

Julien

-->

Julien Thierry (8):
  arm64: Move patching utilities out of instruction encoding/decoding
  arm64: Move aarch32 condition check functions
  arm64: insn: Reduce header dependencies of instruction decoder
  arm64: Move instruction encoder/decoder under lib/
  arm64: insn: Add SVE instruction class
  arm64: insn: Add barrier encodings
  arm64: insn: Add some opcodes to instruction decoder
  arm64: insn: Add load/store decoding helpers

 arch/arm64/include/asm/alternative-macros.h |   3 -
 arch/arm64/include/asm/insn.h               |  70 +++++-
 arch/arm64/include/asm/patching.h           |  13 +
 arch/arm64/include/asm/probes.h             |   2 +-
 arch/arm64/include/asm/traps.h              |   3 +
 arch/arm64/kernel/Makefile                  |   4 +-
 arch/arm64/kernel/ftrace.c                  |   1 +
 arch/arm64/kernel/jump_label.c              |   1 +
 arch/arm64/kernel/patching.c                | 148 ++++++++++++
 arch/arm64/kernel/probes/simulate-insn.c    |   1 +
 arch/arm64/kernel/traps.c                   | 100 +++++++-
 arch/arm64/lib/Makefile                     |   6 +-
 arch/arm64/{kernel => lib}/insn.c           | 249 +-------------------
 13 files changed, 338 insertions(+), 263 deletions(-)
 create mode 100644 arch/arm64/include/asm/patching.h
 create mode 100644 arch/arm64/kernel/patching.c
 rename arch/arm64/{kernel => lib}/insn.c (86%)

--
2.25.4

