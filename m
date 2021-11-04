Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8838F445578
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKDOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49184 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDOnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:24 -0400
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E52961EC0570;
        Thu,  4 Nov 2021 15:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=flesgqhWHfYV9V4KhqinypZm0sHGJG8/0h3X1Cjv9HE=;
        b=r0FldcXQhA46fGQzYTRIE9BOa49N8bgcDWdU0EZm6Yd5Fo1fFDnmvYp+HUYJfxnFkQfkCv
        N6qNomZ8jnmxqfoFr21dz0iI5YVxEVgFS0tkovO7ggJFEMEK6XxNvQsrlTKGVexc1Kmyp4
        4slYCYeURTkaz1DXBqVu+emRTwldz6E=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 00/12] x86/mce: Correct the noinstr annotation
Date:   Thu,  4 Nov 2021 15:40:23 +0100
Message-Id: <20211104144035.20107-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's a first preliminary (it is based on some random 5.16-rc0 commit
and is tested only in qemu) of the series which correct all the noinstr
annotation of the #MC handler.

Since it calls a bunch of external facilities, the strategy is to mark
mce-specific functions called by the #MC handler as noinstr and when
they "call out" so to speak, to do a begin/end sandwich around that
call.

Please have a look and let me know if it looks ok-ish.

Further testing will happen after -rc1 releases, thus the "v0" version
here.

Thx.

Borislav Petkov (12):
  x86/mce: Do not use memset to clear the banks bitmaps
  x86/mce: Remove function-local cpus variables
  x86/mce: Use mce_rdmsrl() in severity checking code
  x86/mce: Remove noinstr annotation from mce_setup()
  x86/mce: Allow instrumentation during task work queueing
  x86/mce: Prevent severity computation from being instrumented
  x86/mce: Mark mce_panic() noinstr
  x86/mce: Mark mce_end() noinstr
  x86/mce: Mark mce_read_aux() noinstr
  x86/mce: Move the tainting outside of the noinstr region
  x86/mce: Mark mce_timed_out() noinstr
  x86/mce: Mark mce_start() noinstr

 arch/x86/kernel/cpu/mce/core.c     | 108 +++++++++++++++++++----------
 arch/x86/kernel/cpu/mce/internal.h |   2 +
 arch/x86/kernel/cpu/mce/severity.c |  37 ++++++----
 3 files changed, 98 insertions(+), 49 deletions(-)

-- 
2.29.2

