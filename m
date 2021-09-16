Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88B840D474
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhIPI1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhIPI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:27:46 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38C8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:26:26 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a10so6478686qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7Rct0wxwR3oFXMND7vzY4QU1vkyKpfX925qIsFciJhk=;
        b=NOqInXBtppRbkqGyfjRBKjoqezYMjP9oqBCi2yd+xyxGpF0uPJR94CDRl+r/6Z9XkZ
         790DURD8mThd8ldC3RUYbWpAPSi1Au2a5ko6mg9YGo4AdF2yKsa1MQzu8te48acVNkjB
         VeR2nG3ecgbSgW5Y23lEW7N68l5PKr47ZmnXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7Rct0wxwR3oFXMND7vzY4QU1vkyKpfX925qIsFciJhk=;
        b=f1P6WlTlg8HzSQmbwFCsWhKc/siy3BlsSps6fPe1a2lAiA8PsQqNBaGF/uN3WpMBWq
         kgzK8b2gbWa2vAoSdVZFX2zbpI5PQ4yrRd1gRILaaoPmZJ/NvujenBNGZGoxxgpWzhgI
         YKdL9Ks/b/lkKrGItPjHVMmVMHJ7HvdlfeAywcHIVLeoSWrbhof8+cZ014HmlyuJTEaN
         WAd5OfDrZ3y9K5+H07LZg7ZjMlfLM0Y6OilyGxWsccoYmK3gbD3/UFe8bNGD4jJDfg9D
         29f/IrkHfliNUk4TE6mu5dXNQWCN871237e//ezTbYvkQ4hnWRp3SkyrcATdsm11miJI
         BT3Q==
X-Gm-Message-State: AOAM531ktok8libXsHiEM497sjEcxzHOHEOP/986uPHfg/fkjOb9PUOk
        sdGrcMF9kDMZavkL/i/SL5OJcrfAWobX4iKMTm+/aPFf29kbUw==
X-Google-Smtp-Source: ABdhPJxPp/BaYSMVCvnILhfHvZwrIcNJiTkW9EBfdo6RciEiPrlfODO+6UtmOaj/AMnqFq6VSVTBUTJhu9Q9007ySb4=
X-Received: by 2002:a05:620a:149c:: with SMTP id w28mr3970119qkj.292.1631780785804;
 Thu, 16 Sep 2021 01:26:25 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 16 Sep 2021 08:26:14 +0000
Message-ID: <CACPK8XfTHOOksA8q7MeHW=7ijP_49iOyq1pDj2SQnqSBTDUoaA@mail.gmail.com>
Subject: [GIT PULL] ARM: config: multi v7 defconfig cleanups
To:     SoC Team <soc@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello soc maintainers,

Arnd has taken a few of the series through the fixes tree. The rest
can probably wait for v5.16.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/multiv7-defconfig-5.16

for you to fetch changes up to 6c5faa6e07d3d42c5e6dd5a19ea1e1d9d097cf0f:

  ARM: config: multi v7: Regenerate defconifg (2021-09-16 17:06:38 +0930)

----------------------------------------------------------------
ARMv7 multiplatform defconfig updates

A cleanup of the mutliplatform defconfig to make it easier to maintian.

----------------------------------------------------------------
Joel Stanley (4):
      ARM: config: multi v7: Drop unavailable options
      ARM: config: multi v7: Clean up enabled by default options
      ARM: config: multi v7: Add renamed symbols
      ARM: config: multi v7: Regenerate defconifg

 arch/arm/configs/multi_v7_defconfig | 87 +++++++++++++------------------------
 1 file changed, 30 insertions(+), 57 deletions(-)
