Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C5307DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhA1SQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhA1SCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:02:36 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61EC061793
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:01:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 8E9833B8;
        Thu, 28 Jan 2021 19:01:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kqo18ME5LPhM; Thu, 28 Jan 2021 19:01:18 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id C60D222;
        Thu, 28 Jan 2021 19:01:18 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1l5BbZ-007kn7-AP; Thu, 28 Jan 2021 19:01:17 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     libc-alpha@sourceware.org, gregkh@linuxfoundation.org
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH 0/2] speakup update
Date:   Thu, 28 Jan 2021 19:01:14 +0100
Message-Id: <20210128180116.1848120-1-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Queue-Id: 8E9833B8
X-Spamd-Result: default: False [5.00 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[5];
         RCVD_COUNT_THREE(0.00)[3];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault (2):
  speakup ABI: Advertise synth parameters for all synths
  speakup: Make dectlk flush timeout configurable

 Documentation/ABI/stable/sysfs-driver-speakup | 37 +++++++++++--------
 .../accessibility/speakup/speakup_dectlk.c    | 11 +++++-
 drivers/accessibility/speakup/spk_types.h     |  3 +-
 drivers/accessibility/speakup/synth.c         |  3 ++
 drivers/accessibility/speakup/varhandlers.c   |  1 +
 5 files changed, 38 insertions(+), 17 deletions(-)

-- 
2.20.1

