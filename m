Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC8B30500F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhA0Dn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:43:27 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:51466 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbhAZWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:22:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id E393E4F;
        Tue, 26 Jan 2021 23:21:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MWx_iyQuSjES; Tue, 26 Jan 2021 23:21:50 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 6BEC4357;
        Tue, 26 Jan 2021 23:21:49 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1l4WiZ-00G98E-RD; Tue, 26 Jan 2021 23:21:47 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 0/4] speakup update
Date:   Tue, 26 Jan 2021 23:21:43 +0100
Message-Id: <20210126222147.3848175-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Queue-Id: E393E4F
X-Spamd-Result: default: False [5.00 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault (4):
  speakup: add the missing synth parameter to all io functions
  speakup: Reference synth from tty and tty from synth
  speakup: Simplify spk_ttyio_out error handling.
  speakup: Add documentation on changing the speakup messages language

 Documentation/admin-guide/spkguide.txt        |  48 ++++-
 drivers/accessibility/speakup/serialio.c      |  22 +--
 .../accessibility/speakup/speakup_acntpc.c    |   4 +-
 .../accessibility/speakup/speakup_apollo.c    |   4 +-
 .../accessibility/speakup/speakup_audptr.c    |   8 +-
 .../accessibility/speakup/speakup_decext.c    |   2 +-
 drivers/accessibility/speakup/speakup_decpc.c |   4 +-
 .../accessibility/speakup/speakup_dectlk.c    |   2 +-
 drivers/accessibility/speakup/speakup_dtlk.c  |   4 +-
 drivers/accessibility/speakup/speakup_keypc.c |   4 +-
 drivers/accessibility/speakup/speakup_ltlk.c  |   2 +-
 drivers/accessibility/speakup/speakup_soft.c  |   4 +-
 .../accessibility/speakup/speakup_spkout.c    |   4 +-
 drivers/accessibility/speakup/spk_priv.h      |   4 +-
 drivers/accessibility/speakup/spk_ttyio.c     | 185 ++++++++----------
 drivers/accessibility/speakup/spk_types.h     |  14 +-
 drivers/accessibility/speakup/synth.c         |   6 +-
 17 files changed, 170 insertions(+), 151 deletions(-)

-- 
2.20.1

