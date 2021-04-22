Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6B367BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhDVINf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229938AbhDVINe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F30C5613C3;
        Thu, 22 Apr 2021 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619079178;
        bh=Glh9iUVy+WcwupgmrbggG4VgKVkK35/vdZYt99soogI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RC0NHoOl7D0rWPSYx/FNiNb1JrGdHXEA5pUIjfdPUHBJwNEJ9hdl6d7/zm+7BSWVq
         bLoYzl+iOuEPh27JkS7vK+OLrUdY+TkD0aWmoIhWwNL5/lytxK86XyOV+tmRAg2O/H
         BQknlBNsjCpkvs4K9PKmKrfx335pyP3MRIggl0ZQ=
Date:   Thu, 22 Apr 2021 10:12:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 039/190] Revert "iommu: Fix reference count leak in
 iommu_group_alloc."
Message-ID: <YIEwBx786rXWm4ah@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-40-gregkh@linuxfoundation.org>
 <YIErPGXVW1masuNW@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIErPGXVW1masuNW@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:52:28AM +0200, Joerg Roedel wrote:
> Hi Greg,
> 
> On Wed, Apr 21, 2021 at 02:58:34PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 7cc31613734c4870ae32f5265d576ef296621343.
> 
> I reviewed this fix again and it looks still valid and correct to me.
> There is no need for a revert.

Wonderful, thanks for the review, I appreciate it!

greg k-h
