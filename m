Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7EF379B60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhEKAWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhEKAWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:22:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F28A61076;
        Tue, 11 May 2021 00:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620692494;
        bh=D7+FwB6wNN0y7dvFP+IevrpYhvlfmJwLrmX2r+rCwDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCXWIZy4TrRnCP1EkRT4CWaXC+/SMGJWlqplUeXY8l1cA9TOUxiP68X7bOE/vDGYR
         o/W+bl9Y+919fZU+OUi+73a4GjLMt6iSwefA6Gi1Ng+k/H5xGRtvLLW/pAHodXnh/p
         0ZteAzCxRFkdWvT4ECp30MtuT2cAqQv8nX+FN+sHQpoaTjNgByqSmJXrw85MtdzQha
         Pa32btRkDKsWq7ru/sAJXiW0Kb9eWsar9Po7c+y5vDT8gNb+tNwZ9O27xtXJ+JcNw0
         2HmAj0KklstW+SqSGjyHnp6zw1sgGPfOOywb5k+LUgow8sljxscNyq3qOdexKtlsy5
         yUnmYDzdDw+iw==
Date:   Mon, 10 May 2021 17:21:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support iflag change given the mask
Message-ID: <YJnODYIke6E5i5TY@google.com>
References: <20210506191347.1242802-1-jaegeuk@kernel.org>
 <YJlGU+STYD5geyIc@google.com>
 <YJmznEhGCZTaER0+@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJmznEhGCZTaER0+@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10, Eric Biggers wrote:
> On Mon, May 10, 2021 at 07:42:27AM -0700, Jaegeuk Kim wrote:
> > In f2fs_fileattr_set(),
> > 
> > 	if (!fa->flags_valid)
> > 		mask &= FS_COMMON_FL;
> > 
> > In this case, we can set supported flags by mask only instead of BUG_ON.
> > 
> > /* Flags shared betwen flags/xflags */
> > 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> > 	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
> > 	 FS_PROJINHERIT_FL)
> > 
> > Fixes: 4c5b47997521 ("vfs: add fileattr ops")
> 
> Shouldn't it be:
> 
> Fixes: 9b1bb01c8ae7 ("f2fs: convert to fileattr")

Heh, thank you. I applied this change in the git. :)
