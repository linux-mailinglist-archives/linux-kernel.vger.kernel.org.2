Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2325244E853
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhKLOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:19:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49372 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhKLOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:19:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8371021981;
        Fri, 12 Nov 2021 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636726590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GbSzca/IRUTHVcXzLF29dXcn2Fz8UnKuCr1ydiC3fTw=;
        b=17owjxK+oz54WTvGLdQk7vxqviv29d7dUUDvGRXXCZ5/p5AkaTySb7Qz4bQu72sciyZBRF
        PFvDbMbN8yVxLN8p9Tt+ySlhMLRV5iw0nQvQPHhO/d7Urd0LRAnjS83jBqRBqsDKMnnK3K
        rpqepOEbqfBSfmD/f6IpU4w5g3SxjcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636726590;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GbSzca/IRUTHVcXzLF29dXcn2Fz8UnKuCr1ydiC3fTw=;
        b=fOsRSnNI12tCfbR6zsg9X66itpDvw8LmwORxx+V4sVj3kTECcCWwrWPc3/yVFThkUFtAMM
        44pOMitEDhM6f2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41E9613C7C;
        Fri, 12 Nov 2021 14:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JsoMDz53jmHhPAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 12 Nov 2021 14:16:30 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     airlied@linux.ie, daniel.vetter@ffwll.ch, arnd@arndb.de,
        gregkh@linuxfoundation.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/7] agp: Various minor fixes
Date:   Fri, 12 Nov 2021 15:16:21 +0100
Message-Id: <20211112141628.12904-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a number of compiler warnings in the AGP drivers. No functional
changes.

Thomas Zimmermann (7):
  agp: Remove trailing whitespaces
  agp: Include "compat_ioctl.h" where necessary
  agp: Documentation fixes
  agp/ati: Return error from ati_create_page_map()
  agp/nvidia: Ignore value returned by readl()
  agp/sworks: Remove unused variable 'current_size'
  agp/via: Remove unused variable 'current_size'

 drivers/char/agp/ati-agp.c    | 10 ++++++++--
 drivers/char/agp/backend.c    |  2 ++
 drivers/char/agp/frontend.c   |  4 +++-
 drivers/char/agp/nvidia-agp.c |  6 +++---
 drivers/char/agp/sworks-agp.c |  5 +----
 drivers/char/agp/via-agp.c    |  3 ---
 6 files changed, 17 insertions(+), 13 deletions(-)

--
2.33.1

