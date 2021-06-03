Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3818539AD88
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFCWS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:18:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53114 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCWS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:18:56 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1loveH-0002Cx-Vv; Thu, 03 Jun 2021 22:17:10 +0000
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: dm: Forbid requeue of writes to zones
Message-ID: <7e7530a9-7939-2ad6-bfe1-d3aeeeed1f77@canonical.com>
Date:   Thu, 3 Jun 2021 23:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with Coverity on Linux next has found and issue in
drivers/md/dm.c with the following commit:

commit 2c243153d1d4be4e23735cd10984ac17c7a54531
Author: Damien Le Moal <damien.lemoal@wdc.com>
Date:   Wed May 26 06:24:58 2021 +0900

    dm: Forbid requeue of writes to zones

The analysis is as follows:

 828 static void dec_pending(struct dm_io *io, blk_status_t error)
 829 {
 830        unsigned long flags;
 831        blk_status_t io_error;

    1. var_decl: Declaring variable bio without initializer.

 832        struct bio *bio;
 833        struct mapped_device *md = io->md;
 834
 835        /* Push-back supersedes any I/O errors */

    2. Condition !!error, taking true branch.

 836        if (unlikely(error)) {
 837                spin_lock_irqsave(&io->endio_lock, flags);

    3. Condition io->status == 11 /* (blk_status_t)11 */, taking false
branch.

 838                if (!(io->status == BLK_STS_DM_REQUEUE &&
__noflush_suspending(md)))
 839                        io->status = error;
 840                spin_unlock_irqrestore(&io->endio_lock, flags);
 841        }
 842

    4. Condition atomic_dec_and_test(&io->io_count), taking true branch.

 843        if (atomic_dec_and_test(&io->io_count)) {

    5. Condition io->status == 11 /* (blk_status_t)11 */, taking true
branch.

 844                if (io->status == BLK_STS_DM_REQUEUE) {
 845                        /*
 846                         * Target requested pushing back the I/O.
 847                         */
 848                        spin_lock_irqsave(&md->deferred_lock, flags);

    6. Condition __noflush_suspending(md), taking true branch.

 849                        if (__noflush_suspending(md) &&

Uninitialized pointer read
    7. uninit_use_in_call: Using uninitialized value bio when calling
dm_is_zone_write.

 850                            !WARN_ON_ONCE(dm_is_zone_write(md, bio)))
 851                                /* NOTE early return due to
BLK_STS_DM_REQUEUE below */
 852                                bio_list_add_head(&md->deferred,
io->orig_bio);

The pointer bio is not initialized and yet is being used in the call to
function dm_is_zone_write where pointer bio is being accessed. I'm not
sure what the original intent was, but this looks incorrect.

Colin
