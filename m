Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5E319614
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhBKWyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBKWyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:54:32 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D80C061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:53:52 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id g23so5439379pfu.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jgTl8HOP9GM18XfRYz277pGhBjYc+zv87YQb2bimXpw=;
        b=p2T3A4Da3KQOdUROBiBifIStd+F5qBc2/oCKY833PEG5+a+dpbw4vjOTA0v1/Yn9OV
         WE/7y4XO2RpHdJI+30h7tVq3yOZAmOSkE2ncW81BsMu1mmdNihKDYovbop5biy9zLa7z
         oUmakWoh9GymMII1aa3NRKm6nNMPJ/cdEYIB/UktFT+wJAojvlEn1qfFL36yno/I3Mtd
         WSkjFZs79ZxrRGIj0vxUfYIrO4oy/XGcYEg4QgVmHZb3Pi3qGc/NQCk5iTJA60hJPO5O
         +T9bC/BR0Rrhu7Cd6rd8+60UfwFHiF81FTA1T8yYHodz7DXGZHCgbTZFKuzUk3LYq8KM
         7NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jgTl8HOP9GM18XfRYz277pGhBjYc+zv87YQb2bimXpw=;
        b=Tv8MSBgPp1WWzD7kXDfzsWIV1amGufWjgBRq1SsrDQRKmhRsq3QhrmAMoJR85a1ehs
         qmXmTMuSheGHs50v0+wczJt9UCsM/lKkUvRHK2amMRy38LW2zLvGZFMMyFw8V2jv8swh
         UtiZjJJn3PlB6DXkxypaHpqBLmgmmew7+hrDW4baxL1VQkFQOKcXWE2lOlrkBz4MXhcG
         aG+kcD8GdlXLHbdLsAbVIiXWQmFs7sUFYWYRZRF6BhiYDxzyxsBCGYXP+9yO4l5U6NzS
         ojvce/V4G/RZc2TwxMKxL89lY/v5PcmuQ7GDGsj+5T5WZDC2GS54Hkp2lNF6EEajXwDW
         VlEg==
X-Gm-Message-State: AOAM532kFxvAiEWWkBMMMHh4fodMRfYpck21F9ZHHKbVR1CCOJxK+GKl
        vWS9h2zfSf+EF7XCt1stO1CvU51SmTU=
X-Google-Smtp-Source: ABdhPJzfwo/8a/bSVuYIMnlpx1GGcdii3CgTj7ldLWLqnoYJfWs4kYT7l1Ch0bCELfnR/kssZ4Swk8K8kyI=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:903:2292:b029:de:45c0:7005 with SMTP id
 b18-20020a1709032292b02900de45c07005mr238153plh.75.1613084028970; Thu, 11 Feb
 2021 14:53:48 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:53:38 +0000
Message-Id: <20210211225343.3145732-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 0/5] add support for inline encryption to device mapper
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for inline encryption to the device mapper.

Patch 1 introduces the "passthrough" keyslot manager.

The regular keyslot manager is designed for inline encryption hardware that
have only a small fixed number of keyslots. A DM device itself does not
actually have only a small fixed number of keyslots - it doesn't actually
have any keyslots in the first place, and programming an encryption context
into a DM device doesn't make much semantic sense. It is possible for a DM
device to set up a keyslot manager with some "sufficiently large" number of
keyslots in its request queue, so that upper layers can use the inline
encryption capabilities of the DM device's underlying devices, but the
memory being allocated for the DM device's keyslots is a waste since they
won't actually be used by the DM device.

The passthrough keyslot manager solves this issue - when the block layer
sees that a request queue has a passthrough keyslot manager, it doesn't
attempt to program any encryption context into the keyslot manager. The
passthrough keyslot manager only allows the device to expose its inline
encryption capabilities, and a way for upper layers to evict keys if
necessary.

There also exist inline encryption hardware that can handle encryption
contexts directly, and allow users to pass them a data request along with
the encryption context (as opposed to inline encryption hardware that
require users to first program a keyslot with an encryption context, and
then require the users to pass the keyslot index with the data request).
Such devices can also make use of the passthrough keyslot manager.

Patch 2 introduces some keyslot manager functions useful for the device
mapper.

Patch 3 introduces the changes for inline encryption support for the device
mapper. A DM device only exposes the intersection of the crypto
capabilities of its underlying devices. This is so that in case a bio with
an encryption context is eventually mapped to an underlying device that
doesn't support that encryption context, the blk-crypto-fallback's cipher
tfms are allocated ahead of time by the call to blk_crypto_start_using_key.

Each DM target can now also specify the "DM_TARGET_PASSES_CRYPTO" flag in
the target type features to opt-in to supporting passing through the
underlying inline encryption capabilities.  This flag is needed because it
doesn't make much semantic sense for certain targets like dm-crypt to
expose the underlying inline encryption capabilities to the upper layers.
Again, the DM exposes inline encryption capabilities of the underlying
devices only if all of them opt-in to passing through inline encryption
support.

A keyslot manager is created for a table when it is loaded. However, the
mapped device's exposed capabilities *only* updated once the table is
swapped in (until the new table is swapped in, the mapped device continues
to expose the old table's crypto capabilities).

This patch only allows the keyslot manager's capabilities to *expand*
because of table changes. Any attempt to load a new table that doesn't
support a crypto capability that the old table did is rejected.

This patch also only exposes the intersection of the underlying device's
capabilities, which has the effect of causing en/decryption of a bio to
fall back to the kernel crypto API (if the fallback is enabled) whenever
any of the underlying devices doesn't support the encryption context of the
bio - it might be possible to make the bio only fall back to the kernel
crypto API if the bio's target underlying device doesn't support the bio's
encryption context, but the use case may be uncommon enough in the first
place not to warrant worrying about it right now.

Patch 4 makes DM evict a key from all its underlying devices when asked to
evict a key.

Patch 5 makes some DM targets opt-in to passing through inline encryption
support. It does not (yet) try to enable this option with dm-raid, since
users can "hot add" disks to a raid device, which makes this not completely
straightforward (we'll need to ensure that any "hot added" disks must have
a superset of the inline encryption capabilities of the rest of the disks
in the raid device, due to the way Patch 2 of this series works).

Changes v4 => v5:
 - Fixup/improve comments as suggested by Eric
 - add Acked-bys and Reviewed-bys

Changes v3 => v4:
 - Allocate the memory for the ksm of the mapped device in
   dm_table_complete(), and install the ksm in the md queue in __bind()
   (as suggested by Mike). Also drop patch 5 from v3 since it's no longer
   needed.
 - Some cleanups

Changes v2 => v3:
 - Split up the main DM patch into 4 separate patches
 - Removed the priv variable added to struct keyslot manager in v2
 - Use a flag in target type features for opting-in to inline encryption
   support, instead of using "may_passthrough_inline_crypto"
 - cleanups, improve docs and restructure code

Changes v1 => v2:
 - Introduce private field to struct blk_keyslot_manager
 - Allow the DM keyslot manager to expand its crypto capabilities if the
   table is changed.
 - Make DM reject table changes that would otherwise cause crypto
   capabilities to be dropped.
 - Allocate the DM device's keyslot manager only when at least one crypto
   capability is supported (since a NULL value for q->ksm represents "no
   crypto support" anyway).
 - Remove the struct blk_keyslot_manager field from struct mapped_device.
   This patch now relies on just directly setting up the keyslot manager in
   the request queue, since each DM device is tied to only 1 queue.

Satya Tangirala (5):
  block: keyslot-manager: Introduce passthrough keyslot manager
  block: keyslot-manager: Introduce functions for device mapper support
  dm: add support for passing through inline crypto support
  dm: support key eviction from keyslot managers of underlying devices
  dm: set DM_TARGET_PASSES_CRYPTO feature for some targets

 block/blk-crypto.c              |   1 +
 block/keyslot-manager.c         | 146 ++++++++++++++++++++++
 drivers/md/dm-core.h            |  12 ++
 drivers/md/dm-flakey.c          |   4 +-
 drivers/md/dm-linear.c          |   5 +-
 drivers/md/dm-table.c           | 212 ++++++++++++++++++++++++++++++++
 drivers/md/dm.c                 |  18 ++-
 include/linux/device-mapper.h   |  12 ++
 include/linux/keyslot-manager.h |  11 ++
 9 files changed, 417 insertions(+), 4 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

