Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6E4331FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhJSJRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhJSJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:17:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8984DC061749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:15:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v127so11197985wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0f7VPukRkZIBsfRCvCvLe+2F66E/vPzHD9lqr8pAOk=;
        b=A1fB9hSx5Q9cZwTnKvupCkEt9KB9SAEG6/bJ2s2BqmlU/PZoHjsRY4IvM5prCgSd4e
         9Y+5iELwQcyOpx7Q58RXhqWlVF18uPBt/CR7nfoQ6TR7y8R1qy5vYB/oMK9FKeOedFe2
         79Vy6TUyFwilSh/QC3rWQfZBXP7jcAgSGIEk8XAsWFFKwQzfEXKiMLqVaAVHn95jKYSM
         aJawMzMwjciggxo5y+1ICYTww38sVG6c/lEUW/+B7wwxRgANU9skSAWH5+NhrQMQXaTZ
         TOmWc/kMRFGS3qStCvZX5gViLOBKigCwU7fj+Q+FeJHsZoJEUmnjTs7RfFjMAIjhg7Ux
         GCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0f7VPukRkZIBsfRCvCvLe+2F66E/vPzHD9lqr8pAOk=;
        b=rsMdlGTJff+oepghWg9QaU9hyxPOMZjutDViIshaH3om/N76y6QOZH2a1CIltm26dN
         qTInFL7DGrJ4XEZobNIiFBg39te1C38ZddTW1Y4r2TGwaAW51nzXQlODRDGWuHCK4ntG
         MBReRuWCfCw+w/wtieuYcKHGZiTVQcaWV9D9W95DP64Hn2F41b7Nx5BtiUuS/C+2qpIz
         Da1NYyfoOSI0ZqG4My86r6anWBFLLg3gdfUm31rJIYQxF0qq157EUMbYErxtb10IMtiT
         VyNvUA0qC7a0dcbEMV/D+zE3LKcdUQuGiGQpCoh9LNPbppw2jMVcyHFC6Iup2bK8iGEL
         cOJw==
X-Gm-Message-State: AOAM531zzRXQve2j9qNRpbC2Pz3JvMXIPsX7flUqhhnyMvWC4UrFAgnn
        bVEr0uBtaEf7W6YtflUYVq8=
X-Google-Smtp-Source: ABdhPJx1LJ5NUIEUpmNsZPV4CNi0nXxaQpLbP1WOt7AYg3SuOTkXQcMm6c6EkhqN2zw2LQztd8LT6Q==
X-Received: by 2002:a1c:a302:: with SMTP id m2mr4799673wme.111.1634634935112;
        Tue, 19 Oct 2021 02:15:35 -0700 (PDT)
Received: from precision.. (aftr-62-216-202-35.dynamic.mnet-online.de. [62.216.202.35])
        by smtp.gmail.com with ESMTPSA id y191sm2029281wmc.36.2021.10.19.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:15:14 -0700 (PDT)
From:   Mete Polat <metepolat2000@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Mete Polat <metepolat2000@gmail.com>
Subject: [PATCH 0/2] rbtree: Test against a verified oracle
Date:   Tue, 19 Oct 2021 11:13:47 +0200
Message-Id: <20211019091349.39788-1-metepolat2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series provides a pipeline for testing the kernel Red-Black
tree implementation against a verified oracle and is based on the work
which we presented on the LPC [1]. A verified oracle is an equivalent
algorithm that is proven to be mathematically correct. The testing
pipeline consists of a kernel module that exposes the core rbtree
functions to userspace using debugfs, and a testing harness that
implements two strategies to generate test cases which are then applied
on the kernel rbtree and the verified rbtree (the oracle). After
executing an operation on both versions, the harness checks if the
kernel rbtree is valid by partially comparing it to the verified oracle.

See the second patch for a description of how to use the harness.

Some notes:

The verified rbtree was verified in the proof assistant Isabelle [2] and
is written in a functional programming language. That's why I also wrote
the testing harness in the functional programming Haskell.

I decided to not try to integrate this work into kselftests because
(1) Haskell (obviously) has another build system
(2) The tests can run several minutes and would just slow down the
    execution of all kselftests

There already is a decent rbtree testing module in the kernel. This work
tries to address the issue of functional correctness using a more formal
method and can be seen as an baseline for future (more complex) testing
against verified oracles.

Regards,

Mete

[1] https://linuxplumbersconf.org/event/11/contributions/1036/
[2] https://isabelle.in.tum.de/

Mete Polat (2):
  rbtree: Expose a test tree to userspace
  rbtree: add verified oracle with testing harness

 lib/Kconfig.debug                             |  19 ++
 lib/Makefile                                  |   1 +
 lib/test_rbtree_interface.c                   | 161 +++++++++++
 tools/testing/rbtree_oracle/.gitignore        |   1 +
 tools/testing/rbtree_oracle/Main.hs           | 128 +++++++++
 tools/testing/rbtree_oracle/RBT/Kernel.hs     |  64 +++++
 tools/testing/rbtree_oracle/RBT/Verified.hs   | 253 ++++++++++++++++++
 tools/testing/rbtree_oracle/RBT_export.thy    |  41 +++
 tools/testing/rbtree_oracle/Setup.hs          |   2 +
 tools/testing/rbtree_oracle/Strategy.hs       |  72 +++++
 .../rbtree_oracle/rbtTestHarness.cabal        |  15 ++
 11 files changed, 757 insertions(+)
 create mode 100644 lib/test_rbtree_interface.c
 create mode 100644 tools/testing/rbtree_oracle/.gitignore
 create mode 100644 tools/testing/rbtree_oracle/Main.hs
 create mode 100644 tools/testing/rbtree_oracle/RBT/Kernel.hs
 create mode 100644 tools/testing/rbtree_oracle/RBT/Verified.hs
 create mode 100644 tools/testing/rbtree_oracle/RBT_export.thy
 create mode 100644 tools/testing/rbtree_oracle/Setup.hs
 create mode 100644 tools/testing/rbtree_oracle/Strategy.hs
 create mode 100644 tools/testing/rbtree_oracle/rbtTestHarness.cabal

-- 
2.33.1

