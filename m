Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA6D37692B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbhEGRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbhEGRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:00:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D40C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 09:59:53 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s123-20020a3777810000b02902e9adec2313so6628314qkc.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=uGowWnX27OFq3X1gHuwjZTbUlKh4i8rvEkAnK10zYZE=;
        b=mnSStCy9NenGQ9//ObWsCgKQmNe7czVPdK7QhmoAJFZ7H/LYAa9AmCI99Q39bNSwzm
         wMCb0nAcQ/xgUJG/nSE0lqXCIni649ugapCTs6DEpVto8egto6V4nJXrw3Bk7FdEP4uz
         Lqo5yLB9lAo2KL2sAlNj5hvyWdOmkzxc1RTdayzCz1YQvt/sIuTFwwA3yuKFiK7DxBqh
         bzyCKol8nGb397q/Y5yz0m1nwvt+n2jeqfY/g751BFIEbuu5IZwoJ5ExXwAE1TxARvUK
         JOfclvETVaGiKMmizl6qxTkLLlGGoaPxEg1FOFobvWqX4EOY17u1i+OEioDZnBI3/y4E
         lmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=uGowWnX27OFq3X1gHuwjZTbUlKh4i8rvEkAnK10zYZE=;
        b=MeAxgGaewQ0CJTi2E0A+ihP2OrfGDV7XM/3vfl5PW/t79dkNy524mp4oEL9RhPyvNk
         b1uYqDkrQChNHjh5YZ1VKRL/PnBo8EbrjNeSCjYt0o2wRV0DT2dUo5B5ceKYc85JwYgF
         28Si8kwVxdoVAfysBmM6jHBdAiCw22N1V5yWtvymPl778xzt0wL74Q/eqGHIOCsIqORf
         7dMcCA/djW/vShG2EKDI7O4fN9CZ7HIQtEor6J9RJC2vC5w9SiueWqy6ijFJ2GZ/leRH
         fko7qrzKSPZ3jZtkS6pK4leDvEY6tO2vM36YdmGroFOtrY1jjrclPrIf7b3PJ/rFbD0k
         Tyeg==
X-Gm-Message-State: AOAM533o6X8te4a6T/ji5QOPGcyi6haLtKkK8Doo7Cy7PIvHAZYX3QaK
        XneAK8/Zk9j/TkbwHLAK/tovopeI7Ds=
X-Google-Smtp-Source: ABdhPJxFM635GyWiSG/BnziS1EI1yIDc1gHO1U+htrLY1MFsVNaVy0Dc2UGxrhy5kab0tvrOWUBR6geOiUU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7352:5279:7518:418f])
 (user=seanjc job=sendgmr) by 2002:a0c:bd13:: with SMTP id m19mr10783603qvg.29.1620406792652;
 Fri, 07 May 2021 09:59:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  7 May 2021 09:59:45 -0700
Message-Id: <20210507165947.2502412-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 0/2] KVM: x86: Fixes for SEV-ES state tracking
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SEV-ES guests, Ensure KVM's model of EFER is up-to-date after a CR0
load, and let userspace set tracked state via KVM_SET_SREGS, relying on
the vendor code to not propagate the changes to hardware (VMCB in this
case).

Peter, patch 02 is different than what I sent to you off list.  I'm still
100% convinced that the load_pdptrs() call is flawed, but Maxim has an
in-progress series that's tackling the PDPTR save/restore mess.

Sean Christopherson (2):
  KVM: SVM: Update EFER software model on CR0 trap for SEV-ES
  KVM: x86: Allow userspace to update tracked sregs for protected guests

 arch/x86/kvm/svm/svm.c |  8 +++--
 arch/x86/kvm/x86.c     | 73 ++++++++++++++++++++++++------------------
 2 files changed, 47 insertions(+), 34 deletions(-)

-- 
2.31.1.607.g51e8a6a459-goog

