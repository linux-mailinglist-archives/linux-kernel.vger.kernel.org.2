Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7114354C01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhDFFEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 01:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhDFFEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 01:04:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3372D61399;
        Tue,  6 Apr 2021 05:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617685477;
        bh=XzoZv30BlKblLYhPRIq5CCAUuMxI2ItwFYZMrIJEY40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s6FEN7n7JZcjYoeGrYbB7SZNtbCjW+SU9lMr5dmngAiIbveboHo0cA+RhV50ULhy6
         v3T5Ske8EkG4rmC/mV/z9P+Nu+85S9289W8YOAlAm+AlgVx0iU1DGzNWf4NX7g80kn
         FL7V1WzZUgHSc+rWvhRcT2LJkyKdBYb3zUTb96d7uXlaE+s2hjiJ60xmSjzSozZx2A
         CvcDHmpklbz4JSbXvdiwRJxJjBQhj7PKHnW1s+0KX0SStXhWvkPo6kBZ3Pb9JjxPSi
         VsFOtSUISoAPi6nfCN04EPo5iCgjStfMO2rpZNgWqVW2t7f43n7plVdJV7mYVxeKAU
         vKdNpzUVBdeZA==
Date:   Tue, 6 Apr 2021 10:34:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Kostya Porotchkin <kostap@marvell.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH -next] phy: marvell: phy-mvebu-cp11i-utmi needs USB_COMMON
Message-ID: <YGvr4ZDWYNT2w/tf@vkoul-mobl.Dlink>
References: <20210401210045.23525-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401210045.23525-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-04-21, 14:00, Randy Dunlap wrote:
> When USB and USB_COMMON are not enabled, phy-mvebu-cp110-utmi
> suffers a build error due to a missing interface that is provided
> by CONFIG_USB_COMMON, so make the driver depend on USB_COMMON.
> 
> ld: drivers/phy/marvell/phy-mvebu-cp110-utmi.o: in function `mvebu_cp110_utmi_phy_probe':
> phy-mvebu-cp110-utmi.c:(.text+0x152): undefined reference to `of_usb_get_dr_mode_by_phy'

Applied, thanks

-- 
~Vinod
