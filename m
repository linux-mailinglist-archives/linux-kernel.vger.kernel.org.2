Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E013E3EC822
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 10:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhHOIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 04:20:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42044 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbhHOIUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 04:20:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A554221FA9;
        Sun, 15 Aug 2021 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629015601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4Tdriq/35b3uaxYvyvcC9d4/h3tCij4GOIS0JBGQ4oQ=;
        b=D1KIxsqJ6qbIdzkykVSAcgzIrYDoTT0fqLK36SIIn77lSRa0qaODaB+9I4K3N3nbauYLYJ
        s8W+5PEnRtKqRyg5tfv69s9OxmYXk/F76K7/XCMH5M0OqNFciwsy/NeICo64iu8eLICMFd
        psrCPOqDPdhszDzYdMJ1FBOXEl0jOZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629015601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4Tdriq/35b3uaxYvyvcC9d4/h3tCij4GOIS0JBGQ4oQ=;
        b=w3dpyfCEy4jp8EHrpOQDTfUozhXCrakfjReTCVvw3ZGWntNsPpsz8vZoJUDREXnxLUrEpA
        Qr1l5fgjPdKXx+Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8DA2513668;
        Sun, 15 Aug 2021 08:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id U0IxIjHOGGEsQQAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 15 Aug 2021 08:20:01 +0000
Date:   Sun, 15 Aug 2021 10:20:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v5.14-rc6
Message-ID: <YRjOWSXeGTyNiZxv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single locking/urgent fix for 5.14.

Thx.

---

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.14_rc6

for you to fetch changes up to 07d25971b220e477eb019fcb520a9f2e3ac966af:

  locking/rtmutex: Use the correct rtmutex debugging config option (2021-08-10 08:21:52 +0200)

----------------------------------------------------------------
- Fix a CONFIG symbol's spelling

----------------------------------------------------------------
Zhen Lei (1):
      locking/rtmutex: Use the correct rtmutex debugging config option

 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
