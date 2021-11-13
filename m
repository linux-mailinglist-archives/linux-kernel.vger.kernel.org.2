Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD1644F08A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 02:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbhKMB0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 20:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbhKMBZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 20:25:55 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC5C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 17:23:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y18-20020a17090abd1200b001a4dcd1501cso5274081pjr.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 17:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q7GrWuTY0VLlfBXSVo/l1AbRU3c932xDVsXpIdGJOrQ=;
        b=Qmzc0naE2HLfLu5C2KfMiITU+UJiTaXnpCuFgySBcgb58yGhXt/fTDiojjVpCSj2E7
         jIYeXWI43Mlupul7TfFnith9qWXSb/JWu9NvAQq21lHSzusJ1WVCxxpLuI9ftGeD/FLj
         AXxNCkeI8yA+FJ+odDw+8Yx60MOcHICOIGSaETOI2q9GsL++lJUuG9X1BY5TNG/pRWYH
         TzP5x6ZXpeiyibR6glYKFyx+v7Sod8MrhMPNOwyOMc0ccYYcp8tKq8j7516kKiXGo+0e
         z02V/ThWb4O2kALL4Ayv6zetGqgPT1sQQW14SJ4i37TYo0VO6zNOyOnGm28ClqVuX/Nb
         fMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q7GrWuTY0VLlfBXSVo/l1AbRU3c932xDVsXpIdGJOrQ=;
        b=cH4GTQhUKNRxb/Yu5kzvNnd6LrZZnOh8f/wMVe8ielBjjawRc51w1OTwe7Cw4nM/aO
         JP9MhO304jat4Um3Ayv7Xt+zR1wFUa004mCDpIROCwTPpPHwaU55ahxEYKpqUgDUJlhA
         dHTo/OMCTy9iMFfjMK5fDbjByCsmAlDx041PDVLfRwM1V/F/n9UP+mmfDybmP13UeIRo
         M1Y0e3cZMjuKJHzeWVQAApxuEOqrU9XZ7DllfGELfGJVVn1+10nahr3Dewzq/mvZUIY7
         CeBBa5eOsZ2QPllIvTzTvEo0RGzrU6JfodeN0lKIH/i2dCrcn1gCWxS7xkSfEo1VIsNB
         aG4A==
X-Gm-Message-State: AOAM533TdyB9Z5LLP+evITUYdqi8OdjnXOFdbLk0/slSN9HPLCmDtITJ
        y4wcLcj1+VjLxUdo3uPqVgsDPZMkCb+n
X-Google-Smtp-Source: ABdhPJzq7F0HIvX+HNKivSfbV1x5ZTlVJPloR1co4VbUadyRLqRwx5DRYLGw8MvzuMhDYyd7Cv5Zq3lt07td
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:c643:b0:141:cf6b:6999 with SMTP id
 s3-20020a170902c64300b00141cf6b6999mr13246105pls.80.1636766583281; Fri, 12
 Nov 2021 17:23:03 -0800 (PST)
Date:   Sat, 13 Nov 2021 01:22:31 +0000
In-Reply-To: <20211113012234.1443009-1-rananta@google.com>
Message-Id: <20211113012234.1443009-9-rananta@google.com>
Mime-Version: 1.0
References: <20211113012234.1443009-1-rananta@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [RFC PATCH v2 08/11] Docs: KVM: Rename psci.rst to hypercalls.rst
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the doc now covers more of general hypercalls'
details, rather than just PSCI, rename the file to a
more appropriate name- hypercalls.rst.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 Documentation/virt/kvm/arm/{psci.rst => hypercalls.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/virt/kvm/arm/{psci.rst => hypercalls.rst} (100%)

diff --git a/Documentation/virt/kvm/arm/psci.rst b/Documentation/virt/kvm/arm/hypercalls.rst
similarity index 100%
rename from Documentation/virt/kvm/arm/psci.rst
rename to Documentation/virt/kvm/arm/hypercalls.rst
-- 
2.34.0.rc1.387.gb447b232ab-goog

