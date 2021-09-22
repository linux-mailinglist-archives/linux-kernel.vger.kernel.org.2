Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E32414E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhIVQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:52:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39592 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhIVQwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:52:34 -0400
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31B751EC051E;
        Wed, 22 Sep 2021 18:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632329463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=YbFWxxaIHxCYwMa8gsMj2OvFISXpOSM0guJv5a/yP9g=;
        b=kjAiRycRf6Lyz4BPhE0G0jv5ttVzaIS6SnbHIQUT9q9tWnXUby/vpJRJTYL9ODN1tNIuby
        EVQ99rQ3d4s5+jrGQxiSLjkji1bRhp8SMVVQm0IzEjJKc4kkrCKKOBWU7b5EPycUS1LXor
        MpS4A78UxpOVVv7W9a0dtODrp0LIlJc=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/5] x86/mce: Remove indirect calls
Date:   Wed, 22 Sep 2021 18:50:56 +0200
Message-Id: <20210922165101.18951-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's v1 with all review comments addressed.

Changelog:
----------

v0:

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

Borislav Petkov (5):
  x86/mce: Get rid of the mce_severity function pointer
  x86/mce: Get rid of machine_check_vector
  x86/mce: Get rid of msr_ops
  x86/mce: Get rid of the ->quirk_no_way_out() indirect call
  x86/mce: Sort mca_config members to get rid of unnecessary padding

 arch/x86/include/asm/mce.h         |  12 --
 arch/x86/kernel/cpu/mce/amd.c      |  10 +-
 arch/x86/kernel/cpu/mce/core.c     | 217 ++++++++++++-----------------
 arch/x86/kernel/cpu/mce/internal.h |  59 +++++---
 arch/x86/kernel/cpu/mce/p5.c       |   6 +-
 arch/x86/kernel/cpu/mce/severity.c |  11 +-
 arch/x86/kernel/cpu/mce/winchip.c  |   6 +-
 7 files changed, 141 insertions(+), 180 deletions(-)

-- 
2.29.2
