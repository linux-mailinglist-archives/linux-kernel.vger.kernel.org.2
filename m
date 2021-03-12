Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43666339050
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhCLOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231557AbhCLOtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:49:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 081A864FB3;
        Fri, 12 Mar 2021 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615560560;
        bh=cT289FKV3xsUZY63Dur1xgCbw90X01pELCM4fumbr9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyaTRgv+DMJOZFnymtjHoYQMgk2pX6AO8NSQY0vdION0nZOr8cyRC749jvLp05w0x
         xTABbuDrQBLOgyhsEyu9iKwvDd7D0V+lqMELqd245tPlB7Pp71BOpFp40B3DBHK1Mh
         fd6EI/z2R348qL8yYtJz51CSlLXj5OVIL8crAgkE=
Date:   Fri, 12 Mar 2021 15:49:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v4] f2fs: add sysfs nodes to get runtime compression stat
Message-ID: <YEt/bvY5JEnNIYsR@kroah.com>
References: <20210312122531.2717093-1-daeho43@gmail.com>
 <YEtg8U7whCVV2tQt@kroah.com>
 <CACOAw_zhZ0OgT-KCBmD_H6_U=CZCNY44D-ojH2AZah2cbAvdAQ@mail.gmail.com>
 <YEt00vJ6oVfoRjSJ@kroah.com>
 <CACOAw_yjyy+58B=RawAaQO98NQB43roZOv4sq5313sFHN1myXQ@mail.gmail.com>
 <CACOAw_wipL_SHyKp+56SOx99LnBZsrWq2eRmLm7Bz16jEYM8zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_wipL_SHyKp+56SOx99LnBZsrWq2eRmLm7Bz16jEYM8zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:42:04PM +0900, Daeho Jeong wrote:
> So, do you want we protect the values here with spin_lock and just
> read without spin_lock in sysfs read part?

I would not use any lock at all if this were my code.  Remember, this is
for debugging/information only, right?  And the data is always "stale"
so what is it going to be used for?

thanks,

greg k-h
