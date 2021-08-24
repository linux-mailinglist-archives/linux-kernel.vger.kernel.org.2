Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B69F3F6886
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbhHXSAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbhHXR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:59:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5D2C0E5699
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:40:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j187so19000175pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVSmC+WT/kr7wwlTX/VtwY34SNioRbV6Z4Iy5VnSa9E=;
        b=RJJYsM5BZfLxqLLHciKnioNOYAG8SPGSar3zWdzFlWIFK+ARrAosI8OFIWTroBY4J9
         Il89rUANAyAu0yooZzBwVMUftFHpeS93f6gv0n+0GYjZVsTxeg6zE8YVAPzSP2WPTIu8
         PMRYaSrScN0zaesYpiyMFE8deDZsSOaIaURXCy/2u0q2VoHkwR19djfTm71ZVgmGIDhy
         rHBg81qk5nDaSCm6cvtACARammEmywVfIRObiKNRNf+sOtHbk2kigrX3dRKvPBggNmsJ
         EGBoO82TQ51owZqDzAv+cI4PJqRF2VRBwwqRPBnFXoGpVyvuKZrNhxzZyOdUrBJ6Wte8
         keCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVSmC+WT/kr7wwlTX/VtwY34SNioRbV6Z4Iy5VnSa9E=;
        b=Dku74qzAXsK7n8w0dshec9nzvpi7mbtGGstUy78bm2ebfpjqbRfmJpC9i63TP8uv2W
         sx+apdepHTVGd5K1UnQg/YAUbrUDXqjI2KZ6zCFxM6QHRkf0NQeB4v0vWmqDYSZ5/Z9/
         aIJOCelRcJh1Mb/1xWoBqIJJ2GZezDZYktN6ytukLx5XYmQ3cLFInrbvlue9QiYbJvl/
         E+0RLF4Axr3mL45XnfIMTOLiEcdLXeb9zuLShhmrsvplF3jsvGsN4oSJw47mJiHI74g9
         cyl6vpYJY1KfvgGSdYZpfSNUAoVR666dlvW9g94FsuJbEhGaDI/64mfWlHF15RWx9qWv
         K0Kw==
X-Gm-Message-State: AOAM531wBkPR1iKbPhqxLIEw378lLIhb/OpGBaBhBtQVjowfgwodlfQ7
        84mqomGEswMcdrvJZAD3sDs/ZfKrP7M=
X-Google-Smtp-Source: ABdhPJzQiBEeFHjSOwdOpvagA/yHW+GSfBp0u0i9bSVuuDnM4JIoF/oJPPrSqCEyDgq4gopRUu2v+g==
X-Received: by 2002:aa7:864a:0:b0:3ee:a4f6:af02 with SMTP id a10-20020aa7864a000000b003eea4f6af02mr2144961pfo.23.1629826823114;
        Tue, 24 Aug 2021 10:40:23 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id u20sm22809075pgm.4.2021.08.24.10.40.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:40:22 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 0/7] KVM: X86: MMU: misc fixes and cleanups
Date:   Tue, 24 Aug 2021 15:55:16 +0800
Message-Id: <20210824075524.3354-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The first two patches fix two old possible defects.
And the others are just cleanups.

Lai Jiangshan (7):
  KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
  KVM: X86: Synchronize the shadow pagetable before link it
  KVM: X86: Zap the invalid list after remote tlb flushing
  KVM: X86: Remove FNAME(update_pte)
  KVM: X86: Don't unsync pagetables when speculative
  KVM: X86: Don't check unsync if the original spte is writible
  KVM: X86: Also prefetch the last range in __direct_pte_prefetch().

 arch/x86/kvm/mmu/mmu.c          | 50 +++++++++++++++++++++++++--------
 arch/x86/kvm/mmu/mmu_internal.h |  3 +-
 arch/x86/kvm/mmu/paging_tmpl.h  | 38 +++++++++++++++++--------
 arch/x86/kvm/mmu/spte.c         |  6 ++--
 4 files changed, 70 insertions(+), 27 deletions(-)

-- 
2.19.1.6.gb485710b

