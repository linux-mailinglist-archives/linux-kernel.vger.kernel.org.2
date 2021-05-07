Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35D637606C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhEGGep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:34:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234791AbhEGGe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:34:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B98C6112F;
        Fri,  7 May 2021 06:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620369207;
        bh=BpAPmiejLFpAyTHujOzMNbWbBmKEXC5DKEs1SQmHxIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ca3dThI7CoAz/6b6jxiTn3EDabPzD3RPFff82F5AJAVgQdK+S9HWXEDWFgdF4R0yE
         e4FUDEpNcWPsqSd9OBXNPV9BWHNMIoVzGY3WO29tfL1zTS1GFiVL+JGxVoJqJTx+yv
         qk16Hoc9sRgy5CtFKbmPo7yElKP9Bs52lGanr17GfkSur7LQ6R3VaoMjhLxFLHcCdF
         yzuei+YcuyYw3R/VSgtq47qeHQ/CKczYCvvAgfTxuWUb2C5XiQggDH3ciGP3WOCwvH
         2BbwKygdZm2D2nEQZl8QuuxLBiCaH+w+PZzW4WGdHY4g3q3ZRIxB2MdrDHkxApxbxo
         SfjZ270CPe95A==
Date:   Thu, 6 May 2021 23:33:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: reduce expensive checkpoint trigger
 frequency
Message-ID: <YJTfNeYeDT65GslB@sol.localdomain>
References: <20210425011053.44436-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425011053.44436-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 09:10:53AM +0800, Chao Yu wrote:
> +	if (!error && S_ISDIR(inode->i_mode) && f2fs_encrypted_file(inode) &&
> +			f2fs_is_checkpointed_node(sbi, inode->i_ino))
> +		f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);

This will never be true, since S_ISDIR() and f2fs_encrypted_file() are logically
contradictory (as f2fs_encrypted_file() only returns true when S_ISREG()).

How did you test this change?

- Eric
