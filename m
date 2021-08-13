Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1C13EBC05
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhHMS00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:26:26 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21383 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhHMS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:26:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1628879154; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bYgkrCYH3zK1URagQJNPlg4+VcLfq0KJccQfLnwyZnjlV/3AxyRI7q+UsEXfBin2Hag2ZroytsC6rPWr9Yd9fKDiSIFaMMpxHO6Ndd9x/lI0r0x9KFm2xFpCNqkfHlTcAKOLSu5t+P4wDBB73ZtZwXLSipse67u10y9SUtDs9F8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1628879154; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=rkqSpWHxcNT/08FBNlrWnc/fZ2fr1FYNDLTrn31DMZQ=; 
        b=hqIJ9XxypZJEx9jiCqkUHEUszFzD7XeBfBlH21R79cM39tUBibHAPS3XxSdXqOWdXAPmAkkEow/W8j957jn2YB/QAoOFezIQ+IcEVrjs2TFZYwm9fvzSaN8y6CXqeLVKVjyteHwpDxLVAI8amggPaZTfJIqAAx/depfeuH06AsQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1628879154;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=rkqSpWHxcNT/08FBNlrWnc/fZ2fr1FYNDLTrn31DMZQ=;
        b=c1aVd0NrxSmSMveT+CySdY+OEKffw4HIGfQ1rJdrgqMjgwXsMWQKiaYnAH9oaBeh
        CG5pyDBhf7DqR8nrzA2X1fO0PoB2ymU6h/nvs1fCFyKAIVjYFBifZboD2Zel5wb7zY2
        v5mipADKXImlrYTwxdhYvX3pbkUzrxd9/9tkuLvk=
Received: from localhost.localdomain (49.207.58.140 [49.207.58.140]) by mx.zohomail.com
        with SMTPS id 1628879151987781.9431947578596; Fri, 13 Aug 2021 11:25:51 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 0/2] Fix syzkaller bug: hung task in hub_port_init
Date:   Fri, 13 Aug 2021 23:55:06 +0530
Message-Id: <20210813182508.28127-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the hung task bug in hub_port_init reported by
syzkaller at:

https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76

The first patch in the series fixes the issue and the second patch does
some refactoring to avoid duplicate code.

Changes in v3:
- Split the patch into two patches
- Remove the convenience wrappers as suggested by Shuah
- Remove the WARN as suggested by Greg

Changes in v2:
Use WARN_ON() instead of BUG() when unlink_list is neither unlink_tx nor
unlink_rx.
v2: https://lore.kernel.org/lkml/20210806181335.2078-1-mail@anirudhrb.com/

v1: https://lore.kernel.org/lkml/20210806164015.25263-1-mail@anirudhrb.com/

Anirudh Rayabharam (2):
  usbip: give back URBs for unsent unlink requests during cleanup
  usbip: eliminate duplicate code in vhci_device_unlink_cleanup

 drivers/usb/usbip/vhci_hcd.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

-- 
2.26.2

