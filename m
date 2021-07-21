Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAEF3D16C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbhGUSUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 14:20:35 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21334 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbhGUSUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:20:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1626894065; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IeqjzCH2fWb7xTMiUO+ltVw2DV+OGPgGEQw5OnjbvKgMdAMVqeegh0yKvtjNRvnOiU3f7BQ2P3N4h/CX2fM8yGXcPYW/jczQG0/V4YsW2hAiHX0p4IWJKgo10SydbWlVfdCArl6kzmfGNJ8AOkb87yHKfRcfSGu2Yzg5NtqvD0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1626894065; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=YZ+0xBQiT2YqVqaTIOyvcIPlM9IVeqF2p2qLfS1wCRc=; 
        b=RzOWvM+soCylehXLbaGvdAZ4jTDhYXV/AgGBM4yfBiWSIdHTXJ4cLfk3JOvmiZ9g5YspR4KuHwkgkx4aJ1cy+iw2KdK61MCND79eacawY3P5Eb5E4ba8QtYjVsDjzxDF35wzdNre4drbXOVGHProZVxM4+aZYF/IEd9QwJR7jGE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1626894065;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=YZ+0xBQiT2YqVqaTIOyvcIPlM9IVeqF2p2qLfS1wCRc=;
        b=XOXNjuwZQcrrxbd5T4ZMFLA2oQ/EvJRk7laWLHkKQqOmL3oe0NMQ8m1gIyZ5m+Lx
        4wE5iJKwJ54Xv69krLI9VsRC46wUsjvZ4jymC4JYfRAl2zQ5R3wwCqczmsSnANAbMar
        VHw8Ycdz6U0kSTgplpyJrLh3RJZDg18h+P+0pWOY=
Received: from localhost.localdomain (106.51.105.64 [106.51.105.64]) by mx.zohomail.com
        with SMTPS id 162689406018769.35784157705382; Wed, 21 Jul 2021 12:01:00 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v5 0/2] firmware_loader: fix uaf in firmware_fallback_sysfs 
Date:   Thu, 22 Jul 2021 00:30:12 +0530
Message-Id: <20210721190014.2313-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the use after free in firmware_fallback_sysfs reported
by syzbot at:

https://syzkaller.appspot.com/bug?extid=de271708674e2093097b

The first patch does some cleanup of the error codes and documents
them properly. The second patch goes on to actually fix the bug.

Changes in v5:
1. Split the patch into two patches as discussed here:
   https://lore.kernel.org/lkml/20210715232105.am4wsxfclj2ufjdw@garbanzo/

Changes in v4:
Documented the reasons behind the error codes returned from
fw_sysfs_wait_timeout() as suggested by Luis Chamberlain.

Changes in v3:
Modified the patch to incorporate suggestions by Luis Chamberlain in
order to fix the root cause instead of applying a "band-aid" kind of
fix.
https://lore.kernel.org/lkml/20210403013143.GV4332@42.do-not-panic.com/

Changes in v2:
1. Fixed 1 error and 1 warning (in the commit message) reported by
checkpatch.pl. The error was regarding the format for referring to
another commit "commit <sha> ("oneline")". The warning was for line
longer than 75 chars. 

Anirudh Rayabharam (2):
  firmware_loader: use -ETIMEDOUT instead of -EAGAIN in
    fw_load_sysfs_fallback
  firmware_loader: fix use-after-free in firmware_fallback_sysfs

 drivers/base/firmware_loader/fallback.c | 46 ++++++++++++++++++-------
 drivers/base/firmware_loader/firmware.h |  6 +++-
 drivers/base/firmware_loader/main.c     |  2 ++
 3 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.26.2

