Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED7136B1CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhDZKpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:45:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232194AbhDZKpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:45:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8047AE95;
        Mon, 26 Apr 2021 10:44:48 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:44:47 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmi update for v5.13
Message-ID: <20210426124447.228ee938@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem updates for Linux v5.13 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

 MAINTAINERS               | 2 +-
 drivers/firmware/dmi-id.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

---------------

Jean Delvare (1):
      MAINTAINERS: The DMI/SMBIOS tree has moved

Kai-Chuan Hsieh (1):
      firmware/dmi: Include product_sku info to modalias

Thanks,
-- 
Jean Delvare
SUSE L3 Support
