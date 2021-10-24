Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1F4387FB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhJXJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:41:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59698 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJXJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:41:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A53D5212C7;
        Sun, 24 Oct 2021 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635068369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vuTD4zIpXIIolvi1mvcxXKYMjEbUsTLc1K8pY5kmzJY=;
        b=w1pjHNmigA/zY3vnO+sjADo2HIZYS6YD+nihmmDp82N/vKhFxj6s+eeE/v1IY7QXPnLZML
        e4x4Ub7O+QDyphsPQmv4vpz/xz83vtwsQLHO/qemfj8Lw7W1Z4mFTxHQcOoGuWh7CHCguE
        8owR0Ug96eWrBqyv1UEB97Aoa1n9yk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635068369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vuTD4zIpXIIolvi1mvcxXKYMjEbUsTLc1K8pY5kmzJY=;
        b=cxVbIMeOWGxqiCKdIeLcNeSvelTk1PyRr8mnwBfZmcsJY7tGEDjFpwAjm4wNnCtz+VjRoF
        JUETGo/AStr6FtBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EFB313310;
        Sun, 24 Oct 2021 09:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T6uMItEpdWHqOwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 24 Oct 2021 09:39:29 +0000
Date:   Sun, 24 Oct 2021 11:39:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.15-rc7
Message-ID: <YXUpy05ML9v1enXe@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single change adding Dave Hansen to our maintainers team.

Thx.

---

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc7

for you to fetch changes up to 0a30896fc5025e71c350449760b240fba5581b42:

  MAINTAINERS: Add Dave Hansen to the x86 maintainer team (2021-10-21 13:55:42 +0200)

----------------------------------------------------------------
- Add Dave Hansen to the x86 maintainers team

----------------------------------------------------------------
Thomas Gleixner (1):
      MAINTAINERS: Add Dave Hansen to the x86 maintainer team

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
