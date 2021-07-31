Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925E43DC218
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhGaAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234326AbhGaAoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:44:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 215BC60FED;
        Sat, 31 Jul 2021 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627692254;
        bh=paN8p7t9akgL6K/U2ftqUCAJXEoYEwWcAUhQmb/DS6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l52iEZfuhNIKrBeWevCew1f49Z07XM9/JWSVq1bydQ/O3IzOCCu4M3DUcTFku5cJE
         qXzs4QdFV5AzFG4q9u4/BLNHeJFprV4BGoYkjHmZjqyiLkvJGxK4Hhqs7B5c3NDPXy
         5C/e3kH/nPp9tjdsoHdFcWk2O8miai+YSxj0dUagwTkiLHXi78+4BTMQ006qKSLbBJ
         /WiRUTWBES0ie12B6illKaqMiEcq+8nlCJzdx0QF15YURDF+MSEPrET9yHO+OwN2I0
         tW8n55l+WDlFVv5TjnpWxCocqU2doxKeTb4Dai78x/GyFrGPIFEpwtgt7xVS2f9NZR
         Lxao7eBBGletw==
Date:   Fri, 30 Jul 2021 17:44:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: show sbi status in debugfs/f2f/sstatus
Message-ID: <YQSc3GEv/jQdcku8@google.com>
References: <20210730190907.2072122-1-jaegeuk@kernel.org>
 <f3331e35-9cfb-eb7b-8867-fb39f468c49d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3331e35-9cfb-eb7b-8867-fb39f468c49d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31, Chao Yu wrote:
> On 2021/7/31 3:09, Jaegeuk Kim wrote:
> > We need to get sbi->s_flag to understand the current f2fs status as well.
> > One example is SBI_NEED_FSCK.
> 
> Typo in patch title: "f2f/sstatus".
> 
> Please note that there is a sysfs entry /sys/fs/f2fs/<devname/stat/sb_status.

Sure. Thanks.

> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
