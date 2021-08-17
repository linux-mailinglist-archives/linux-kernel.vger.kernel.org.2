Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240C53EF25B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhHQS6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhHQS6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:58:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DE7760F58;
        Tue, 17 Aug 2021 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629226700;
        bh=ybaZbjhb4qySD5Pozoo9NhCNuXsZVugnMPJsjSKrOCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0P3cKpuhO9EctIoSSNch6haKgcVwZt4U5J7EXvYDjh1v8s01YX/GyvJTlEHRkZrS
         aVAh7Louv167R4nOckHL0xgW4rxxGYwl8kwe6blRCTzl7BJuQmFZBIk9YjkRLjz31s
         hFXpkRxyjmWfbXnP232R6aiFkDWaghm544XLUl2cCBkkz/HnVAXX2/NGjka1BvSL1T
         W1lQGqn5qVIU0XTcjWD13027xeGTAqE9Kp9IiGz4VUIyCABLbykBg1vflsP4A6wg8h
         MJNKuvgYgBaKYL6vsKpjIA8GlN0rYlJDncWPxgjwAWF2FlglMzm7P9XGJZiE5gxb4f
         aUVi8j7kqyj9Q==
Date:   Tue, 17 Aug 2021 11:58:19 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Add missing inline to f2fs_sanity_check_cluster()
 stub
Message-ID: <YRwGyzZn+vxRoXTO@google.com>
References: <20210816234247.139528-1-nathan@kernel.org>
 <YRsD6P4x9v38oDWl@google.com>
 <1f2eff07-f003-03c8-b3c8-0e06f9bf9684@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f2eff07-f003-03c8-b3c8-0e06f9bf9684@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Nathan Chancellor wrote:
> On 8/16/2021 5:33 PM, Jaegeuk Kim wrote:
> > Hi Nathan,
> > 
> > On 08/16, Nathan Chancellor wrote:
> > > Without this, there is a warning in nearly every fs/f2fs/ file when
> > > F2FS_FS_COMPRESSION is not set:
> > > 
> > > In file included from fs/f2fs/super.c:31:
> > > fs/f2fs/f2fs.h:4251:13: warning: unused function 'f2fs_sanity_check_cluster' [-Wunused-function]
> > > static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
> > >              ^
> > > 1 warning generated.
> > > 
> > > Fixes: 1495870233e7 ("f2fs: compress: do sanity check on cluster")
> > 
> > This has not been merged yet, so if you don't mind, can I integrate your fix in
> > the original patch?
> 
> Sure thing!

Thanks~ :)

> 
> Cheers,
> Nathan
