Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0634C2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhC2FQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhC2FPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:15:52 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F201DC061574;
        Sun, 28 Mar 2021 22:15:51 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q12so5896383qvc.8;
        Sun, 28 Mar 2021 22:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyzRIfy4lQ1Fg7+r4gmKZCNIPyLg4oFnaTvQHNKd/Yc=;
        b=gLI7ExzTHy8h6Si0YRN9XxBPxx5gEqUWnX780eAfydfwUX4jRSQXCRaK+tu7/T7w3b
         MoCwX4tYXwDvtfYydJlgyDb45EO+3yOFO7AsGKUSkywtq78kuPokFA36SabhPndn0REO
         zvUP081PNXLvGyCY8b3KhIfpvB6pDPxU3ceK5k08iWX3O0G/aSY7+GhjbT80cnIP6iVZ
         r+MV/TJ9D6Ln2+5B8Heq8RxrKcgYWNH5HwHgbKsn7pY/XjDt2CQa5wq4mFcoftB5165C
         fuocvWQHB3TAaYdD27gMkapL53XOyqrJwmJhNnhSxqYptb1aJvCnWfjH7o3kdKcOfBQr
         w2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyzRIfy4lQ1Fg7+r4gmKZCNIPyLg4oFnaTvQHNKd/Yc=;
        b=NpUzm9Zkhp1CaWM+xTkoBZl1clW5PrDiLp5uiiLLMb7SnwQaEubeHg+qsfhNbfC8T4
         9puuPMyn5ESS1dduBVoRld9zn29RKtIlwRe7LoqufIAV8M9jKCzhm49n6PoNWubO9d1h
         hnAimbu0XyEWcxadh9gLoHjM/EsV6folPmDrONK5Zj+UFrDB1a7hJmaxOTxOksnqu0MX
         1lL1JIWCXQxrvGC0kR+ecwT5gGHWPeeyORQVSJK5pTipICofV/t8aRh1zc3hrlknjgQy
         iYzgUfBpwjIgADtkIyeVSV50RUWJ+a+RqyG+kn2E2fnHLTgQNqc02REY5092RQHIkw5w
         LTXg==
X-Gm-Message-State: AOAM531xCIYLtep93v2L2Z50EVfT9ve4giJF25n0e4kbu7iKitdLvxf3
        HPlG16k/1FPFidTrcNYRUM8=
X-Google-Smtp-Source: ABdhPJyoTKAjkWMb+qa56Z84yne+rqqYqwe9OvTsfKKphZrwhmrXcGSE4zTfSp9YAsfHWWMHSNbbmA==
X-Received: by 2002:a0c:9b82:: with SMTP id o2mr21246867qve.47.1616994951341;
        Sun, 28 Mar 2021 22:15:51 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:15:50 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/23] virt: kvm: vm.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:44 +0530
Message-Id: <6e639e834c594c2079b7490e27ea3c69fd476b2b.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/imlemented/implemented/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/virt/kvm/devices/vm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/kvm/devices/vm.rst
index 0aa5b1cfd700..3eb1abf505c9 100644
--- a/Documentation/virt/kvm/devices/vm.rst
+++ b/Documentation/virt/kvm/devices/vm.rst
@@ -92,7 +92,7 @@ Allows user space to retrieve or request to change cpu related information for a
 KVM does not enforce or limit the cpu model data in any form. Take the information
 retrieved by means of KVM_S390_VM_CPU_MACHINE as hint for reasonable configuration
 setups. Instruction interceptions triggered by additionally set facility bits that
-are not handled by KVM need to by imlemented in the VM driver code.
+are not handled by KVM need to by implemented in the VM driver code.

 :Parameters: address of buffer to store/set the processor related cpu
 	     data of type struct kvm_s390_vm_cpu_processor*.
--
2.26.3

