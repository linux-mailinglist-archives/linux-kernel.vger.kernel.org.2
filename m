Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48F2379A10
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhEJW37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhEJW3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96BD561581;
        Mon, 10 May 2021 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620685727;
        bh=3C3Zjb9pNSFpD04fv+dCc1YcggEBha54szgnBBnl+sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVu+bRWUCCiGCkhtEwhjniehelzKgsO5DO9wTktyaKAaB6ZGZlG6ZMUk5FHazKbBu
         QzRQ1J+TxhAjZS9/XYTDZDcKuctPcJqOQzlBwtHOMg9EpTE/YAu1RGC4Lx88UW+3mf
         6jXkdU7ocwMyPDdbIR7kb1aAtUflbosTqrRZxU6pc6+COgxU0TgV32khFfxo8WRyQ8
         iHiKY3sx7ItIslpie4C9LkCXPxGRtCR/vvFG70Bt1nf86KbK0INzc/Va9J/+GqWUqA
         1RpqgtryD+MDg3ZS1rykyjvATjKpfNMeWbl/hBBMq1j/mLnS6MMF3U3OhQhhROIZVY
         g0E/xiU+jw+GA==
Date:   Mon, 10 May 2021 15:28:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support iflag change given the mask
Message-ID: <YJmznEhGCZTaER0+@gmail.com>
References: <20210506191347.1242802-1-jaegeuk@kernel.org>
 <YJlGU+STYD5geyIc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJlGU+STYD5geyIc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 07:42:27AM -0700, Jaegeuk Kim wrote:
> In f2fs_fileattr_set(),
> 
> 	if (!fa->flags_valid)
> 		mask &= FS_COMMON_FL;
> 
> In this case, we can set supported flags by mask only instead of BUG_ON.
> 
> /* Flags shared betwen flags/xflags */
> 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> 	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
> 	 FS_PROJINHERIT_FL)
> 
> Fixes: 4c5b47997521 ("vfs: add fileattr ops")

Shouldn't it be:

Fixes: 9b1bb01c8ae7 ("f2fs: convert to fileattr")
