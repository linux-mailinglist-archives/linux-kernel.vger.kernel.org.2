Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9836A306039
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhA0Pvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:51:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:50340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235991AbhA0PuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:50:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD44EADE0;
        Wed, 27 Jan 2021 15:49:40 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/4] firmware: Add ZSTD-compressed file support
Date:   Wed, 27 Jan 2021 16:49:35 +0100
Message-Id: <20210127154939.13288-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems that ZSTD format is getting popular, and I've been asked
about the firmware loader support.  So I took a quick glance, and it
turned out that it's fairly easy thanks to the existing ZSTD API.
Now high time to submit something.

The first patch adds a new Kconfig CONFIG_FW_LOADER_COMPRESS_ZSTD and
the corresponding decompression function to the firmware loader code.
For the already supported XZ-compression, CONFIG_FW_LOADER_COMPRESS_XZ
is added to make it selectable explicitly, too.

The rest three patches are for selftest: a cleanup, a fix and the
additional support of ZSTD format.

Currently, I have no idea whether any distro would use ZSTD files for
firmware files in near future, though.  That's the reason of this
patch set being an RFC for now.


thanks,

Takashi

===

Takashi Iwai (4):
  firmware: Add the support for ZSTD-compressed firmware files
  selftests: firmware: Simplify test patterns
  selftest: firmware: Fix the request_firmware_into_buf() test for XZ
    format
  selftest: firmware: Add ZSTD compressed file tests

 drivers/base/firmware_loader/Kconfig          |  21 ++-
 drivers/base/firmware_loader/main.c           |  74 +++++++-
 .../selftests/firmware/fw_filesystem.sh       | 167 +++++++++---------
 tools/testing/selftests/firmware/fw_lib.sh    |  12 +-
 4 files changed, 175 insertions(+), 99 deletions(-)

-- 
2.26.2

