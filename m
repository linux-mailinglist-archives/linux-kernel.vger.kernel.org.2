Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9D33B13E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCOLh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhCOLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:37:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02104C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:37:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a1so15764810ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iXyQ5uLBIQL0Ohz4oY8OpYihmmqLiQTm4jdm3uoravc=;
        b=dRPtWgBvIWeoaCmPztmKyFm5CjYlz6alSoMcVYp41t+L5GdZOmdjXxA9WiJrkhdvsG
         telcqa3jVXiHhvDOT2x5126NMG/uJVWYaJK6yRNp7dQWVmVaboGPh8OehP1eYzAfrlQk
         tfdj9HRh4WjIz6k3z1hCvISs7oJ1VybKH7N3HmAT+qjpO/tO/xKww4MNIRhRXSPN8K8S
         pTyr4w0PVhLaJssNLzzYozRfp6fsuLu3uHR9lfGttTlIWx5vbTBTVfXG7/ulgiknpjVi
         Eui8uYSyxZV7d7Rz9hZ6nBmAs8HXPuDWnTel66UiPXq1AVpatg3qcfWY2yTqU2bxE9P/
         jXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iXyQ5uLBIQL0Ohz4oY8OpYihmmqLiQTm4jdm3uoravc=;
        b=GYqxd8ak/SQ8sxZSiUSte/sabfdnmefK9iWF8QnuWMexFd1yKgcChRO1Qm1RiqY4A7
         zGTx+lRtoI1ZMZQEB+3ppQHga6rTwzQ8hug2Puzto4PWTmsmygMpPCS4RoewAFYm5yHj
         Wf97baFng5iwOYC6j94ICBKcYWM43BdQCgOEazl+U0WZz5EHGYg8tCH4Uywp4+Myz/L3
         tqZdyp1KAQticHcdGAdHfbe5m8W5+f1a4eDc68Z3nAhFI0C2RQurrP3BPcsD2FFbW4x5
         fTUZOTXj9Y/J3oP1xz9KU3bbtOf3CsqZPLYWSVZPhXEoBx+EFb5giAue4JSqNaYHYFnp
         hl5g==
X-Gm-Message-State: AOAM530rnDWjRcnGZfmx+TVvrFD+4BgGJO0I3nHofaQ1ch4aP2BxUHJU
        1eJqEkGCP0LMtTCdRXd5vp29O2QsY9LR9ZGQ
X-Google-Smtp-Source: ABdhPJycEH5h6oRqVsK08fMcRac8KL6vv0ODLk5w4mHbkb8jFh4XkKRq8OumBeqEPfsD9rSjoxRJMw==
X-Received: by 2002:a2e:a60a:: with SMTP id v10mr10686235ljp.267.1615808256341;
        Mon, 15 Mar 2021 04:37:36 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id w5sm2639274lfu.179.2021.03.15.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 04:37:35 -0700 (PDT)
Date:   Mon, 15 Mar 2021 12:37:33 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [GIT PULL] OP-TEE tracepoints for v5.13
Message-ID: <20210315113733.GA1944243@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this patch adding tracepoints around calls to OP-TEE in
secure world.

Thanks,
Jens

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-tracepoints-for-v5.13

for you to fetch changes up to 0101947dbcc3204f08fb5b69a21dbd4b1535cad6:

  tee: optee: add invoke_fn tracepoints (2021-03-15 12:04:01 +0100)

----------------------------------------------------------------
Add tracepoints around calls to secure world

----------------------------------------------------------------
Jisheng Zhang (1):
      tee: optee: add invoke_fn tracepoints

 drivers/tee/optee/call.c        |  4 +++
 drivers/tee/optee/optee_trace.h | 67 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 drivers/tee/optee/optee_trace.h
