Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923CF377F32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhEJJRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhEJJRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:17:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D13161285;
        Mon, 10 May 2021 09:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620638157;
        bh=k7AnJcdGIxioEKX2oUxQktkdEzeSCWpYu+NG7XWAoJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBvlJsRI8XQGzrB9Zu9IhFuXEFeaLVt57yNJGTebOkgP2jjgCufV9PxaKedrMM6Xi
         5gGvdmiKwYmoUreJuSB4rFebHfEOYrmAOqGG6PKmFfAXFUusbtUPrO2TnWulm4vke+
         Hwzc1+keDxJsXl5OA0HIHADnlysa/ikFMPLxsey/k1p+z6tbwMufvCMu+Akc1Ox0ep
         nyM4KaV15Imri8KoMuHY4plPFpMWMbxaX+GR0tELHiGSLFD6gVzF9CXFjMLMphU3lm
         3RYdyGWA+2CSLP9OXNtMyv5qpMAW7+UefKIriRqGXW5DUl6iOpuYi5ziEuhBl/MAZS
         m6qERZJDpZIWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lg21A-0001xw-1Z; Mon, 10 May 2021 11:16:00 +0200
Date:   Mon, 10 May 2021 11:16:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Zolton Jheng <s6668c2t@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: add device id for ADLINK ND-6530 GC
 device
Message-ID: <YJj50LtDt7pxMP2T@hovoldconsulting.com>
References: <1620613920-3968-1-git-send-email-s6668c2t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620613920-3968-1-git-send-email-s6668c2t@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:32:00AM +0800, Zolton Jheng wrote:
> This is adds the device id for the ADLINK ND-6530 which is a
> pl2303gc based device
> 
> Signed-off-by: Zolton Jheng <s6668c2t@gmail.com>

Applied, thanks.

Johan
