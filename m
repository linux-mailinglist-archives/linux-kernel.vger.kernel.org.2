Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273EA409794
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhIMPlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:41:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49740 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241053AbhIMPlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:41:12 -0400
Received: from zn.tnic (p200300ec2f097300886079c88d3e49d7.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7300:8860:79c8:8d3e:49d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C6161EC04E4;
        Mon, 13 Sep 2021 17:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631547591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=pnrt1EUjmKLmEf+gL8sd0mV3NQQlTbn2qPoOQ/HG2U8=;
        b=UjxHWCXs63MIBlOOIA6rXNiUq5p8kkBCLWQYOAJ8ulqtinq6aQA8K6PmDgz9Zd5xM2aomH
        0Q1VWFbxPEbgRufHcijTkxWLEk4YzZ8k17E/LDpuifVY1onvhTXSYdaDaVPrn1LyFdnHNO
        sAjLtJVEuBOwuiL1qav9Oqa2sGahjAc=
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     X86 ML <x86@kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] doc: Add tip maintainer's handbook
Date:   Mon, 13 Sep 2021 17:39:40 +0200
Message-Id: <20210913153942.15251-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi Jon,

here is the rest of the tip maintainer handbook "preachings" which are
not generic enough to go into the main documentation but are tip-tree
specific and are collected in a separate handbook.

Please apply,
Thx.


Thomas Gleixner (2):
  Documentation/process: Add maintainer handbooks section
  Documentation/process: Add tip tree handbook

 Documentation/process/index.rst               |   1 +
 .../process/maintainer-handbooks.rst          |  18 +
 Documentation/process/maintainer-tip.rst      | 785 ++++++++++++++++++
 Documentation/process/submitting-patches.rst  |   7 +
 4 files changed, 811 insertions(+)
 create mode 100644 Documentation/process/maintainer-handbooks.rst
 create mode 100644 Documentation/process/maintainer-tip.rst

-- 
2.29.2

