Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22568412926
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhITXBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232016AbhITW7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 18:59:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D02C0610A0;
        Mon, 20 Sep 2021 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632178677;
        bh=t32r/UNDAKqQ2H+2kaeKxyON17il0qBt5QdF2iYLzZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhosC+o0YPt67CpA3fw8kRB1RXniPzCZesIhuvdeBL+wpXNT4Sl12rr1CFkS9nmbI
         d/EANN9Fmgkf2bjeqEoaQ69Lk0rCKQZ7sBupWl+xvyoBVt5iKUeXYX8MqrTGnpXV0l
         Nm9MHTFMVrSLlj/twxw+Mm+bfJBRjYa3T1MV6IWH9SspASg2DiupGjmxNgTjQnH6jA
         skrE0+DL6T4dB3xXfOwTYXnZn03oHmUQeZjsPN/O0FKqhUIxTToRusKwhCLiP73ljK
         xa3YK3ozMBh78upKlfKDacQOxd2u8gi6mrSjGRvMNUaKyEGrP5Apo51dDt9/duXUEb
         0aRaK/ac7MQ2w==
Date:   Mon, 20 Sep 2021 15:57:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
Message-ID: <YUkR84sklj0SgosC@google.com>
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <YTvmhVhLlBPeASHT@google.com>
 <9f4a2954-e8c9-abc5-5df4-a7cec53433a3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f4a2954-e8c9-abc5-5df4-a7cec53433a3@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12, Chao Yu wrote:
> On 2021/9/11 7:13, Jaegeuk Kim wrote:
> > Wait. Why do we need to add so many options here? I was expecting to see
> > performance difference when getting random segments or random blocks as
> > an extreme case. I don't get the point why we need the middle of those cases.
> 
> I guess we can simply the aging test procedure of filesystem by changing a bit
> based on this patch.

My question was on "fragment:fixed_block".

> 
> See comments in below thread.
> 
> https://lore.kernel.org/lkml/425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org/
> 
> Thanks,
