Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0698839C0E4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFDUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:00:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9379C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 12:59:09 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j19-20020a62b6130000b02902e93e6ca980so5912032pff.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/04tQF1Bnfn2Yc8uCL4+PnvsgVsKHdmSFWQrGNAAQTo=;
        b=OdotDs3ViB0pZgE6DEc+6edU7n+2pew1IMH9sobDI7oCvsmNkS1U0u0qDa1WS3UOdn
         ohrkEo/LbInEpIwhhc1Mpick65/30Z2BUvRuBFslZC9l/zKchwqxzfjLTY+xsqqi7UY7
         +6PgMCJuB5M3eulB08ixhiIZaumXfwcinlZyLzSz4bp8VKYT9G7UjuH8B6ztKs47M3BE
         JssOkek6pXCCqezZE7Sd8HoNcTp23P1BtwyQBujSi4/EOqZC90Zc13jrq3FelamPVUPb
         NWUD7sMK+zOfrpuR0BYOBz5hXcEz0LOa+usGqdMqOXFaQlQLhwvuOQj2zyyTn0F5OZbg
         FsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/04tQF1Bnfn2Yc8uCL4+PnvsgVsKHdmSFWQrGNAAQTo=;
        b=MaouDCJAtXgkpwPirpC1VduZZuILmRxnTYIQK7/TjDkKwNPyVtHlLTfJF6VDMGkfUA
         um70FwjTELgoYjxPnmrbokcVt4K+xNIgeieN9MjuB/Gm3x4tGDa66jO3dkxPdsWwzcNV
         AYYhdmi3uuFZ7NfNlQGGjovXlPJbh3xjzyQClmUbkgGN+rcJeELTkf6TtnsbfOyOzTe9
         s5F+UB5QXLTCdnKXsY6eQXMM7ggpCBCcjeAP9QwSygD+WGE/KET1lvqJHU5Aco0T+fyT
         aEQJh4v5WEqEbyNI+IKwNTuwygT950/LQ0KAuZg9DyUtHem7AAH+wgVatwXKX5gbxsOP
         2Uaw==
X-Gm-Message-State: AOAM531kxk5dWb22gq+l651dHYTUFYDonanUxN1VGYp60rBiu4KTeeKl
        K9MWJledmIRGIU3NzZc6Ed+RnpynuIo=
X-Google-Smtp-Source: ABdhPJxnrz3xZhzV6FeOMd1wzAG31DcRHzsGjcwsuZKTpzCJkEIRznGRbNoCzAYyAxLCtGWco/g1FiuJrOk=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:902:6546:b029:101:abf0:d882 with SMTP
 id d6-20020a1709026546b0290101abf0d882mr6045293pln.73.1622836749269; Fri, 04
 Jun 2021 12:59:09 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:58:50 +0000
Message-Id: <20210604195900.2096121-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 00/10] ensure bios aren't split in middle of crypto data unit
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a bio has an encryption context, its size must be aligned to its
crypto data unit size. A bio must not be split in the middle of a data
unit. Currently, bios are split at logical block boundaries, but a crypto
data unit size might be larger than the logical block size - e.g. a machine
could be using fscrypt (which uses 4K crypto data units) with an eMMC block
device with inline encryption hardware that has a logical block size of 512
bytes. So we need to support cases where the data unit size is larger than
the logical block size.

Patch 1 introduces blk_ksm_is_empty() that checks whether a keyslot manager
advertises a non-zero number of crypto capabilities. This function helps
clean up code a little.

Patch 2 and 3 introduce blk_crypto_bio_sectors_alignment() and
bio_required_sector_alignment() respectively. The former returns the
required sector alignment due to any crypto requirements the bio has.  The
latter returns the required sector alignment due to any reason.  The number
of sectors in any bio (and in particular, the number of sectors passed to
bio_split) *must* be aligned to the value returned by the latter function
(which, of course, calls the former function to decide what to return).

Patch 4 updates blk-crypto-fallback.c to respect
bio_required_sector_alignment() when calling bio_split(), so that any split
bio's size has the required alignment.

Patch 5 introduces restrictions on the data unit sizes advertised by a
keyslot manager. These restrictions come about due to the request_queue's
queue_limits, and are required to ensure that blk_bio_segment_split() can
always split a bio so that it has a limited number of sectors and segments,
and that the number of sectors it has is non-zero and aligned to
bio_required_sector_alignment().

Patch 6, 7 and 8 handle the error code from blk_ksm_register() in all
callers.  This return code was previously ignored by all callers because
the function could only fail if the request_queue had integrity support,
which the callers ensured would not be the case. But the patches in this
series add more cases where this function might fail, so it's better to
just handle the return code properly in all the callers.

Patch 9 updates get_max_io_size() and blk_bio_segment_split() to respect
bio_required_sector_alignment(). get_max_io_size() always returns a
value that is aligned to bio_required_sector_alignment(), and together
with Patch 5, this is enough to ensure that if the bio is split, it is
split at a crypto data unit size boundary.

Since all callers to bio_split() should have been updated by the previous
patches, Patch 10 adds a WARN_ON() to bio_split() when sectors isn't aligned
to bio_required_sector_alignment() (the one exception is bounce.c which is
legacy code and won't interact with inline encryption).

This patch series was tested by running android xfstests on the SDM630
chipset (which has eMMC inline encryption hardware with logical block size
512 bytes) with test_dummy_encryption with and without the 'inlinecrypt'
mount option.

Satya Tangirala (10):
  block: introduce blk_ksm_is_empty()
  block: blk-crypto: introduce blk_crypto_bio_sectors_alignment()
  block: introduce bio_required_sector_alignment()
  block: respect bio_required_sector_alignment() in blk-crypto-fallback
  block: keyslot-manager: introduce
    blk_ksm_restrict_dus_to_queue_limits()
  ufshcd: handle error from blk_ksm_register()
  mmc: handle error from blk_ksm_register()
  dm: handle error from blk_ksm_register()
  blk-merge: Ensure bios aren't split in middle of a crypto data unit
  block: add WARN_ON_ONCE() to bio_split() for sector alignment

 block/bio.c                      |   1 +
 block/blk-crypto-fallback.c      |   3 +
 block/blk-crypto-internal.h      |  20 ++++++
 block/blk-merge.c                |  49 +++++++++-----
 block/blk.h                      |  14 ++++
 block/keyslot-manager.c          | 112 +++++++++++++++++++++++++++++++
 drivers/md/dm-table.c            |  27 +++++---
 drivers/mmc/core/crypto.c        |  13 +++-
 drivers/scsi/ufs/ufshcd-crypto.c |  13 +++-
 include/linux/keyslot-manager.h  |   2 +
 10 files changed, 221 insertions(+), 33 deletions(-)

-- 
2.32.0.rc1.229.g3e70b5a671-goog

