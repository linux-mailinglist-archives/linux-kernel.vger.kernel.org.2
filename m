Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E135F441A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhKALAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:00:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhKALAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:00:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 955202171F;
        Mon,  1 Nov 2021 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635764259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eAOTBpuG8MXwpTkr3uHl35XhfRR6NTLoOVgXl8tmyik=;
        b=Lbr6rVzxZPKsQqNF0cDt4wzaZObBG1W3V3MWbjRXLrUeSYRuReHVyrEC2TMS2CGp5OJyA6
        gsyu5a/VxdS0NUOWtTgSUtWkD0EMxGE9FH/yjJj6++E01A5we8N2Ye5PO4YGUDQJelhy2J
        DMTyFrCrgB5sh6rdvB2tGgOYyjBdNkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635764259;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eAOTBpuG8MXwpTkr3uHl35XhfRR6NTLoOVgXl8tmyik=;
        b=n0+FKp7LiU7nXmnabSK7zoXrt/2MROb8dWpIEmFx0Yi3hURXiAdkGslMbu4yrnW98QEnBC
        Iye67lK8cXLRu8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EA3813AA8;
        Mon,  1 Nov 2021 10:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /pT0HCPIf2HKWAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 10:57:39 +0000
Date:   Mon, 1 Nov 2021 11:57:40 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sgx for v5.16
Message-ID: <YX/IJN+v6JMRrhMh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull x86/sgx updates for v5.16.

Thx.

---

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.16_rc1

for you to fetch changes up to ae095b16fc652f459e6c16a256834985c85ecc4d:

  x86/sgx/virt: implement SGX_IOC_VEPC_REMOVE ioctl (2021-10-22 08:32:12 -0700)

----------------------------------------------------------------
Add a SGX_IOC_VEPC_REMOVE ioctl to the /dev/sgx_vepc virt interface with
which EPC pages can be put back into their uninitialized state without
having to reopen /dev/sgx_vepc, which could not be possible anymore
after startup due to security policies.

----------------------------------------------------------------
Paolo Bonzini (2):
      x86/sgx/virt: extract sgx_vepc_remove_page
      x86/sgx/virt: implement SGX_IOC_VEPC_REMOVE ioctl

 Documentation/x86/sgx.rst       | 35 ++++++++++++++++++++++
 arch/x86/include/uapi/asm/sgx.h |  2 ++
 arch/x86/kernel/cpu/sgx/virt.c  | 65 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 97 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
