Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE6373294
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEDW5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhEDW5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:57:36 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CFEC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:56:40 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t14-20020ac8588e0000b02901bc2b5853b1so4614191qta.16
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=ACElvN5lUKw6MrNQxWo1f87hr0r+T/WqUWqS4YQIThs=;
        b=ID23jFYh0QCMYJnOdNwKHmp6PPNzGP91nGuNZWtBveZ979t80onvdBUKK8tr4RNlTJ
         VvYAzeBcCvyaIYNewFOUvSKYZJqe3a3iQe3jyE3Ldilsbo9yOmZLga7K9bIoDX3q67+y
         M5XzUKmvS7PzRgN7mBISEjqk4A042F/+Yp2Re+GA+WWpqA/cdqQRhNNufni8Lz0sfgFC
         kLu6Ga6Q68z5FqP3lvkClbWr5eN+FNai5q8MxHTmCtKS3XcaDe6l4TBi85cZWsINTQ7X
         FNONWw7fH6ofVoYqbGdvgbu1aMERN+24w/0d8JV438+xWP7vFLsBDJJjPjTUnJfJXln4
         NoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=ACElvN5lUKw6MrNQxWo1f87hr0r+T/WqUWqS4YQIThs=;
        b=hWayBFTDBziOoitLDm0vcrJG7YbY3WPA1CnTw2a4UDo8WZ2UuiLa9/57GdhNbcdEv5
         y3DjFo3e1ZxucGkHGi3f+3QevzZdPkcIkSetItM6JVDkNblkN2uEUNXR78ELTKDVI73S
         t0C3PtFttM79VpIBnsQKk+Ee0eBT81OwWpPVxswAu2OsanA8hlDK2CK5PqcV2lWjjfl2
         fm+h3sb3r2H248ldqeOAUy2bZWW05XTda4TFpztUiD9laiihCH/IpOa4i1lZUtOoxye7
         pxySi1FRDocCaPbWuh1g4QZT8JPFCrVFOuUv0nKa9Xx+/qi2zlohvKaVHzgrdSz9TuHc
         +I7Q==
X-Gm-Message-State: AOAM531vmlpiiAF4gjP/aFNfp54bE9CAVyrHQgqx8Jfsdeo1ikr67TbZ
        wW1vLdrw3pYzEcyJ7SQcbzguz4FdUxc=
X-Google-Smtp-Source: ABdhPJwMzPwBVZynUzlCF5cH09lzr/NPmKHdmOUQFgaUmvsV47oCYFbGqrkA7GPEQrQaa5+fWgDGz6KhKUU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a0c:e601:: with SMTP id z1mr28277818qvm.62.1620168999825;
 Tue, 04 May 2021 15:56:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 15:56:30 -0700
Message-Id: <20210504225632.1532621-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 0/2] x86/cpu: RDPID+MSR_TSC_AUX fix and a cleanup
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where MSR_TSC_AUX is left uninitialized in the theoretically
possible scenario where RDPID is supported by RDTSCP is not.  AFAIK, no
such CPUs exits, but both Intel and AMD architecturally allow RDPID and
MSR_TSC_AUX to exist without RDTSCP.

Found by inspection when cleaning up a similar mess in KVM.  Confirmed
the bug and verified the fix by running the problematic CPU model under
KVM (once KVM's even bigger trainwreck was fixed).

Sean Christopherson (2):
  x86/cpu: Initialize MSR_TSC_AUX if RDTSCP *or* RDPID is supported
  x86/cpu: Remove write_tsc() and write_rdtscp_aux() wrappers

 arch/x86/include/asm/msr.h   | 4 ----
 arch/x86/kernel/cpu/common.c | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.31.1.527.g47e6f16901-goog

