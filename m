Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA6397409
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhFANZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:25:02 -0400
Received: from smtp2.axis.com ([195.60.68.18]:13680 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233584AbhFANZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1622553799;
  x=1654089799;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4+P5vP/IMM0ahXtkgFF2oW6amPennmZbptYSDq3P2S0=;
  b=VpNSD4EwPm4Fk59GveFo50zmjrsyVYt5QwANdlGzplOm/MyVrjyDRBtv
   mNNSdWH7zBoAkD10k9DzeM2WkpjBU6cw9WoImmsXzdEuJOXDgN7FmUUWJ
   vQ8y4mhvN9cO2DpgDepbNq0phXsRnEvu4ZD9zlH7fJzmLrYFuxO/FLvrA
   +iIlpQQp05kq9Kx2zY9RddCDW9Hm9bgy0M3vP8Kb4juixth5yuRO68Wgq
   MUFxhEZpdXtbiVg8qhuN4zWg1DKXTAbB6CD0SNKzwQEnCe5bcM1sb/kIU
   Xra6v90Z4cxMruHwD+FdBXD6KTOcWQU4OM/r25w0TH0lrBx9NRvNc5oC3
   A==;
Date:   Tue, 1 Jun 2021 15:23:17 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jack@suse.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: __buffer_migrate_page() vs ll_rw_block()
Message-ID: <20210601132316.GA27976@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing occasional squashfs read failures ("squashfs_read_data failed
to read block") when compaction is run at the same time as reading from
squashfs, with something like the commands below.  The kernel version is
the latest stable/v5.4 kernel, v5.4.123.

 while :; do echo 1 > /proc/sys/vm/compact_memory; done &
 while :; do echo 3 > /proc/sys/vm/drop_caches; find fs/ > /dev/null; done &

On this kernel, squashfs uses ll_rw_block().  The problem is that
ll_rw_block() ignores BHs which it can't get a lock on, but
__buffer_migrate_page() can take the lock on the BHs in order to check
if they can be migrated.  If __buffer_migrate_page() holds the lock at
the same time that ll_rw_block() wants it, the BH is skipped and I/O is
not issued for these blocks, and squashfs ends up seeing
!buffer_uptodate() and erroring out.

On newer kernels, squashfs doesn't use ll_rw_block() anymore, but I
still see other users of that function in other filesystems, and AFAICS
the underlying problem of the race with __buffer_migrate_page() has not
yet been fixed.

I'd be happy to receive any suggestions about the right way to fix this.

Thank you.
