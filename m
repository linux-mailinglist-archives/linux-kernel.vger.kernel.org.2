Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FB3DAF88
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhG2WvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233516AbhG2WvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:51:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 450736023E;
        Thu, 29 Jul 2021 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627599078;
        bh=CcoVvdaUEJ4hNSxZtFmgxQoFCn0/MeIH+Fu9CTIgsNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKHxuMjyM2ZpOaccpg6ZB98aZBJp1UM6Nfbjpj1eRXzWblrrUFZvyloRMtE4XGn2N
         cnU8jIcI1R9y43wuVi4i8UoCZTu8U6R65oAymG/ENh+sySgB3oyj+IFg7URi9kqphD
         nUoBqwQzw5vTcivqTq6/QovmmAO962Tv7aszRxJ4uRV8+MSHXJHaP9SV4qOYrezHno
         Gyqr3UbrYAi0wb5F5f/bMByQfKmusPCrNGoy4i+LK8H9Po+SbYFX5oNy6sutJ5CFKh
         8rarVuzoc6HXiOGjZCAepMLVc3icq1bpDzaTodKzXbZhbltvfPxAPeNinaYB03aJXf
         OACP3vUkDmfAA==
Date:   Thu, 29 Jul 2021 15:51:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: change fiemap way in printing
 compression chunk
Message-ID: <YQMw5BjrJttrnOLR@google.com>
References: <20210726041819.2059593-1-daeho43@gmail.com>
 <f9555521-8878-2d46-36f1-3032bb8bbc0a@kernel.org>
 <YQA/orZ5wXjwWeyy@google.com>
 <8c0d05d2-3988-a8a4-5403-1173f25b822b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0d05d2-3988-a8a4-5403-1173f25b822b@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29, Chao Yu wrote:
> On 2021/7/28 1:17, Jaegeuk Kim wrote:
> > Do we really need to catch this in fiemap? What about giving the current
> 
> Yes, I think so.
> 
> > layout with warning message and setting NEED_FSCK?
> 
> Sure,
> 
> How about doing sanity check on cluster metadata whenever it is going to
> be accessed, like we did for single blkaddr with f2fs_is_valid_blkaddr()?

I think that'd be viable.

> 
> Thanks,
