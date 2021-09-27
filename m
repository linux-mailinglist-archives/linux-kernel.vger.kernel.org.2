Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36553419802
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhI0Pgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234622AbhI0Pgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:36:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4579360EE0;
        Mon, 27 Sep 2021 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632756910;
        bh=LBNb1z5QaCJTM2OuTGM0Hcf47QA9DIsNFaN3K8X3lTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zswsIbzjQWilZ3pgfKg8+ji4buPHogYuGj/UHtkk87UWAXLCZMvIMWWCcAlxrvkcF
         41qD7JQU6geYMGsqL+hCeep/AZGAKx+UPhatJRToT+TIG4WHfA4LAUmhHvxHHQv5a4
         Kh+hlU/F8phGiO6vxmApCR9+Z1w5X5yt6QQrqcg4=
Date:   Mon, 27 Sep 2021 17:35:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     nsaenz@kernel.org, peterz@infradead.org, maz@kernel.org,
        bsegall@google.com, rdunlap@infradead.org, airlied@redhat.com,
        kan.liang@linux.intel.com, odin@uged.al,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vchip_arm: Fix misuse of %x
Message-ID: <YVHkq1bLrz365ZwE@kroah.com>
References: <20210923035554.669434-1-qtxuning1999@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923035554.669434-1-qtxuning1999@sjtu.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:55:54AM +0800, Guo Zhi wrote:
> Pointers should be printed with %p or %px rather than
> cast to (unsigned long) and printed with %lx.
> Change %lx to %pK to print the pointers.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Does not apply to my tree :(

Please rebase and resend.

thanks,

greg k-h
