Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF082345CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCWLau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCWLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:30:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07B4C061574;
        Tue, 23 Mar 2021 04:30:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so12065568pjh.1;
        Tue, 23 Mar 2021 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=2gp4ql9n4jQVSenDWOPjOPZjqFj8yu2LhSJxGvYy2yY=;
        b=cW+Qv7PL349RBez60NrHa8RRLByCQZ2McbAV3n2FDvJTcVfAdSMIBja9ZekJ+Kes52
         wc9OcOwk9EGF9fOo9EgltQQr9tbTUvbXN5BeFKPbcOr0o+dNM6hN5i7AQynbXKkiMwfn
         ELHhZzQGIG6bW2vbIyNX7t3eQDJsXylXZPkS3k5Zo6bavTTv1oHHK8s3qfI+n/vnK4/T
         k5D6zRb3Qa/dQqowuJTzsmaC6N1uuZpWmI7izScgOjh8fdJc55/VVSKjxXKDEiDFMN+9
         waNtOfRyLNhPt7nF+e2kC6DYFkt3ExN+O1ydO9T++KRrs5f6EchpsgLnIBJoyLzuKB70
         lNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2gp4ql9n4jQVSenDWOPjOPZjqFj8yu2LhSJxGvYy2yY=;
        b=FQp6hg+XZwla0NGr4rHE/fRXvJ1wcjXnFQtrdIZOR9pyz6fzElcjzHSZjuF+aXmHZD
         AB/vg0DGgQMN8vALW9WSqi9v/gf7Y9BxvlISja4lqKsfrn5u+LuPEYx7B5MJQA/B64dv
         HdxNXJb3vKDJe8JBqVWNFN1S7l1ynfajDfUPUtl2IO9iC8GwnXpb9aW01YKvO4eNQYIb
         774nzTagxSynbkagNjo3ItXbQFZKBztTFiQRVh2mXTUpMstPMY+ixJhowV/QVPlTlTbb
         x9zZz2SUTHcYOh0YpjqoY29Ww6A1DnDhwcjkKzqysY/W3zyxqQL0lqL0K/cbDT/ZOxU/
         J2yQ==
X-Gm-Message-State: AOAM531XpQeYsFKEb8YBxfnbzWjIPP4unxUciGcx0SVcs0Np7qOETDbO
        2zPlVOfv/mzEjPFniM3M7Bc=
X-Google-Smtp-Source: ABdhPJwCUp3kjgUr78mwQj5/VgS1Z47947/Nkog3/WRYVYUPAM6nnLRazzjq2RV9HjjF7+I6kvBXlA==
X-Received: by 2002:a17:90a:990a:: with SMTP id b10mr4067006pjp.178.1616499018959;
        Tue, 23 Mar 2021 04:30:18 -0700 (PDT)
Received: from localhost.localdomain ([101.95.133.222])
        by smtp.gmail.com with ESMTPSA id f23sm16281824pfa.85.2021.03.23.04.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Mar 2021 04:30:18 -0700 (PDT)
From:   Dongjiu Geng <gengdongjiu1@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gengdongjiu1@gmail.com
Subject: [PATCH v8 0/2] Enable Hi3559A SOC clock
Date:   Tue, 23 Mar 2021 19:29:31 +0800
Message-Id: <1616498973-47067-1-git-send-email-gengdongjiu1@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is separated  from this series: https://lore.kernel.org/patchwork/cover/1353321/

v7->v8:
Mainly address Stephen's comments
1. Add const for some function and variables
2. Remove the useless function and variables
3. Add a define for a mask width

Dongjiu Geng (2):
  dt-bindings: Document the hi3559a clock bindings
  clk: hisilicon: Add clock driver for hi3559A SoC

 .../clock/hisilicon,hi3559av100-clock.yaml         |  59 ++
 drivers/clk/hisilicon/Kconfig                      |   7 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/clk-hi3559a.c                | 847 +++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        |   2 +-
 drivers/clk/hisilicon/clk.h                        |   2 +-
 include/dt-bindings/clock/hi3559av100-clock.h      | 165 ++++
 7 files changed, 1081 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon,hi3559av100-clock.yaml
 create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
 create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h

-- 
2.7.4

