Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076CB40F64F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbhIQKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:55:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50632 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240684AbhIQKz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:55:29 -0400
Received: from zn.tnic (p200300ec2f127e008eb9261aa740485d.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:7e00:8eb9:261a:a740:485d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B22A1EC04D1;
        Fri, 17 Sep 2021 12:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631876046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=0+IO5MnTPCJg6XcVLb7+6dhhzBAU+wKq8lGQnjrTOTo=;
        b=GV6Qiw4UifykcpQTVc7S8sJy0hT85ibvLJnP0S3tBXVswIygSMLCpuDdOqh60Xo6Mf6iZI
        uYkIqzhkspOtQyUUqyPGg414hJvD+e8hrBryjYOIb/mO0qlbfpRjklzu9C5/Jwd4GsUZui
        xF6nT5ad5lz7DMV7O++KwBf99lgOBbo=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] x86/mce: Remove indirect calls
Date:   Fri, 17 Sep 2021 12:53:51 +0200
Message-Id: <20210917105355.2368-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi folks,

this is the first part of me trying to noinstr-ify the mce mess
properly. That one is dealing with making all indirect calls on the #MC
exception path, direct, to avoid the compiler from adding ratpoline
thunks which objtool doesn't like. And when you look at the changes, you
probably would go, gee, why did we ever did indirect calls - it is even
more readable with direct calls and there are practically no downsides.
So let's remove former.

There's another patch ontop which does the actual noinstr annotation but
that takes longer currently due to objtool changes in tip.

So for now, the first part.

As always, constructive review is welcome.

Thx.

Borislav Petkov (4):
  x86/mce: Get rid of the mce_severity function pointer
  x86/mce: Get rid of machine_check_vector
  x86/mce: Get rid of msr_ops
  x86/mce: Get rid of the ->quirk_no_way_out() indirect call

 arch/x86/include/asm/mce.h         |  12 --
 arch/x86/kernel/cpu/mce/amd.c      |  10 +-
 arch/x86/kernel/cpu/mce/core.c     | 217 ++++++++++++-----------------
 arch/x86/kernel/cpu/mce/internal.h |  47 +++++--
 arch/x86/kernel/cpu/mce/p5.c       |   6 +-
 arch/x86/kernel/cpu/mce/severity.c |  11 +-
 arch/x86/kernel/cpu/mce/winchip.c  |   6 +-
 7 files changed, 137 insertions(+), 172 deletions(-)

-- 
2.29.2

