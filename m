Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D39F42219B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhJEJEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhJEJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:04:40 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD2C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:02:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ey7-20020a0562140b6700b00382cf3eb480so6939047qvb.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BRCd6xIpsgQc9eCz6F1JrzlncYMqd0ZDK8+iJvlZVJo=;
        b=eoms1aGPDoZgsVnFaKlK88PDymci86vDBDF+xpLuhD4qRv4yjbK6MS+XMDcxmX2mhT
         fgbaP9dV4z9gdlvq+7Qnj7zD1fNCJvMC5gBV1BQ5bQj+CJg/A5BDHLJfzKr7juldFle5
         tqsKSX4WAyBid12mJRJ5+InxIOS9kOaooUAC7ZFDWD6MaU/IdxKsjHTHteTc/0qdf7CF
         yDapp7qFLhC2XJRz2ybl+Gu9J1TAiKjekb85hy6ruk7XqutZ/OFku32TSh39dY0ycTpk
         nrfZWm0ri8fofKVYDANqtE9KNlYx3xv7i4BOgCgUTMMSdNZYhGPd5rXVs+GA4fnKlIUG
         1Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BRCd6xIpsgQc9eCz6F1JrzlncYMqd0ZDK8+iJvlZVJo=;
        b=p3134JrCW2F2fNMPwNmMZdDdo6+8xuXCLDNyGnoyum3YXy2B9AxPfgnTOlKM7M6f5l
         e9yT403e+cOqCVAk1gA6E+9WqCV+tDyvPsBzQJQAdaj3mQisMH81ZR2sPY60BQBsSd2F
         wTG7aMqRdHMHggfBJVsTNdvIllp8htp2FXyQE4tdjaa0n+2tgQ7F+zSFuhMK3ARZVUol
         bZrtUGkLs42LWJA5V0ejssx2IlhQAr/ZANEdaQr16SRJuam5ZjPeOTDKrBFstcD0BPRx
         aURRkXCQxSB+Gl65TkzHNfAZBVrzOKRtA/lsMfdq+J/pZ5/ufwL7Z72X/ExolpxBdIgE
         f7Sw==
X-Gm-Message-State: AOAM531+wU1Gd0kj6Yd84cWtQ1F+UH9pwGSAPDpQLD7sIblcJgyITsFn
        J7bYJkVpoRAfPwNgfw1vuCfx7G5p1Apl
X-Google-Smtp-Source: ABdhPJxxbyIyPiVtJmWA8AbltOJZ3/N/M8K+WP9ITkiGix8jD8rU+MjhGEj3spZgJYPGfDeZ5XI8MbtDYdpe
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:5700:9128:3106:b389])
 (user=qperret job=sendgmr) by 2002:a05:6214:11a5:: with SMTP id
 u5mr6027804qvv.39.1633424569158; Tue, 05 Oct 2021 02:02:49 -0700 (PDT)
Date:   Tue,  5 Oct 2021 10:01:40 +0100
In-Reply-To: <20211005090155.734578-1-qperret@google.com>
Message-Id: <20211005090155.734578-4-qperret@google.com>
Mime-Version: 1.0
References: <20211005090155.734578-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 0/2] A couple of EL2 refcounts fixes
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v2 of the series previously posted here:

https://lore.kernel.org/kvmarm/20211004090328.540941-1-qperret@google.com/

This addresses a couple of issues Will has found with the refcounting of
page-tables at EL2. Patch 01 fixes a nasty bug, and probably wants to go
in -stable. Patch 02 fixes a small inconsistency which made it harder to
find refcount-related bugs at EL2.

Changes since v1:
 - applied Acked-by from Will;
 - better comment + commit message for patch 01 (Marc).

Thanks!
Quentin

Quentin Perret (2):
  KVM: arm64: Fix host stage-2 PGD refcount
  KVM: arm64: Report corrupted refcount at EL2

 arch/arm64/kvm/hyp/include/nvhe/gfp.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 13 ++++++++++++-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 15 +++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.33.0.800.g4c38ced690-goog

