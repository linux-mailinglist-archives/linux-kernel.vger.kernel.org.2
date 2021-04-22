Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD51C367BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhDVIOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235004AbhDVIOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:14:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84069613C3;
        Thu, 22 Apr 2021 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619079212;
        bh=rSQ9Upu9BoP/whD4fF5mnOc4VcFU2W0VWOHMc9fHiq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEKbF6cDdurWC7e0dutGeYoymKMrW9KJfyNW8JIMfJS8crW8GYdkv+Znv+jD2JzlJ
         OWxHmeAJs2PyRVTnmU4A/YYmpSxrx82M9gTMmH04/tWUDSdcb8z62cgxmyU0h0g/9Q
         BxVVRGDC3HovR3KiCJr12Sw2b4IEujJ2RRkRoqNw=
Date:   Thu, 22 Apr 2021 10:13:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 002/190] Revert "media: st-delta: Fix reference count
 leak in delta_run_work"
Message-ID: <YIEwKeINI8VOG+S4@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-3-gregkh@linuxfoundation.org>
 <b6e00864-f28a-ee9a-ea53-d1a8aa8c42fb@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e00864-f28a-ee9a-ea53-d1a8aa8c42fb@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:02:32AM +0200, Hans Verkuil wrote:
> Hi Greg,
> 
> I re-reviewed all the patches in this series where I was CCed.
> 
> These are all good and fix real bugs and should be re-reverted:
> 
> [PATCH 002/190] Revert "media: st-delta: Fix reference count leak in delta_run_work"
> [PATCH 003/190] Revert "media: sti: Fix reference count leaks"
> [PATCH 004/190] Revert "media: exynos4-is: Fix several reference count leaks due to pm_runtime_get_sync"
> [PATCH 005/190] Revert "media: exynos4-is: Fix a reference count leak due to pm_runtime_get_sync"
> [PATCH 006/190] Revert "media: exynos4-is: Fix a reference count leak"
> [PATCH 008/190] Revert "media: stm32-dcmi: Fix a reference count leak"
> [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count leak"
> [PATCH 010/190] Revert "media: camss: Fix a reference count leak."
> [PATCH 011/190] Revert "media: platform: fcp: Fix a reference count leak."
> [PATCH 012/190] Revert "media: rockchip/rga: Fix a reference count leak."
> [PATCH 013/190] Revert "media: rcar-vin: Fix a reference count leak."
> [PATCH 014/190] Revert "media: rcar-vin: Fix a reference count leak."
> [PATCH 052/190] Revert "media: media/saa7146: fix incorrect assertion in saa7146_buffer_finish"
> [PATCH 056/190] Revert "media: davinci/vpfe_capture.c: Avoid BUG_ON for register failure"
> [PATCH 057/190] Revert "media: saa7146: Avoid using BUG_ON as an assertion"
> [PATCH 058/190] Revert "media: cx231xx: replace BUG_ON with recovery code"
> [PATCH 102/190] Revert "media: video-mux: fix null pointer dereferences"
> [PATCH 183/190] Revert "media: isif: fix a NULL pointer dereference bug"
> 
> This one can be dropped since it actually contains a bug, I'm fairly certain
> that was unintentional:
> 
> [PATCH 007/190] Revert "media: ti-vpe: Fix a missing check and reference count leak"
> 
> I'll reply to that one separately.
> 
> This one can be dropped since it is not necessary:
> 
> [PATCH 073/190] Revert "media: rcar_drif: fix a memory disclosure"
> 
> The V4L2 core already zeroes this. Other drivers that use fmt.sdr also
> memset this, but that should be dropped in those drivers as well. I'll
> make a patch for that.

Wonderful, many thanks for doing this review, I'll be dropping these
from the series.

greg k-h
