Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C428444F763
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 11:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhKNKDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 05:03:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60034 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKNKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 05:03:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D50D218A9;
        Sun, 14 Nov 2021 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636884047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3VD8sw6FfAQ5n0pTqVtTcNZfTZvdEkilo5OGo04xFU4=;
        b=y/MZ4r3131xL2HyoS0nzgI467mABKxf1t/axFZa4YGNIDcHTne2pVI0KKNwmIgSAJ0QpNb
        pEidk+xiwSBoie2pNR7KrfJzQhkANZNvWkUZ7EG+aa1g/oxX1mIvnQJUYeYvOb/SmFly2u
        lky/olf92QWd2HrqZfXLtKVRLwwXR6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636884047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3VD8sw6FfAQ5n0pTqVtTcNZfTZvdEkilo5OGo04xFU4=;
        b=OTuP7TPTNJRT437g/oq/7rpNv5SYkUodnek1udgAIjU/5vjpAGKUtP1ALYqtcBham5WNAe
        v/3M4tHG7/gJ+lAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8614D13AAE;
        Sun, 14 Nov 2021 10:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HAlYIE/ekGGsIAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 14 Nov 2021 10:00:47 +0000
Date:   Sun, 14 Nov 2021 11:00:38 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.16-rc1
Message-ID: <YZDeRkX012h/ZJzR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of x86/urgent fixes which accumulated during the
merge window.

Thx.

---

The following changes since commit 879dbe9ffebc1328717cd66eab7e4918a3f499bd:

  Merge tag 'x86_sgx_for_v5.16_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2021-11-01 15:54:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.16_rc1

for you to fetch changes up to fbdb5e8f2926ae9636c9fa6f42c7426132ddeeb2:

  x86/cpu: Add Raptor Lake to Intel family (2021-11-12 11:46:06 -0800)

----------------------------------------------------------------
- Add the model number of a new, Raptor Lake CPU, to intel-family.h

- Do not log spurious corrected MCEs on SKL too, due to an erratum

- Clarify the path of paravirt ops patches upstream

- Add an optimization to avoid writing out AMX components to sigframes
when former are in init state

----------------------------------------------------------------
Dave Hansen (1):
      x86/fpu: Optimize out sigframe xfeatures when in init state

Dave Jones (1):
      x86/mce: Add errata workaround for Skylake SKX37

Juergen Gross (1):
      MAINTAINERS: Add some information to PARAVIRT_OPS entry

Tony Luck (1):
      x86/cpu: Add Raptor Lake to Intel family

 Documentation/x86/xstate.rst        |  9 +++++++++
 MAINTAINERS                         |  2 ++
 arch/x86/include/asm/fpu/xcr.h      | 12 ++++++++++++
 arch/x86/include/asm/fpu/xstate.h   |  7 +++++++
 arch/x86/include/asm/intel-family.h |  2 ++
 arch/x86/kernel/cpu/cpuid-deps.c    |  1 +
 arch/x86/kernel/cpu/mce/intel.c     |  5 +++--
 arch/x86/kernel/fpu/xstate.h        | 37 +++++++++++++++++++++++++++++++++++--
 8 files changed, 71 insertions(+), 4 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
