Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECF37503F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhEFHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233281AbhEFHiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B981611CB;
        Thu,  6 May 2021 07:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620286637;
        bh=iXe3DLUvgiP5Cycf6dDSuZIym/h/K9iMDajCibIIC1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqYakRsyddaITLilOvv5y0/bv03pi4+7eoLXGgnKAPgFbtwYGecSdJgXFUwI1RFpS
         4qdBvj+jbXeQe9ihX1Pt15i6iEy94ML7knOu59h2WzqtcVinvtZ/72LEraJmO15s5x
         u/Zn54eu9N/CZMPgN7tz7p7TP1RtYPiIdKXmEc3M=
Date:   Thu, 6 May 2021 09:37:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v2 1/3] usb: xhci-mtk: use bitfield instead of bool
Message-ID: <YJOcq+Pq5omZz3p1@kroah.com>
References: <20210506063116.41757-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506063116.41757-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 02:31:14PM +0800, Chunfeng Yun wrote:
> Use bitfield instead of bool in struct
> 
> Refer to coding-style.rst 17) Using bool:
> "If a structure has many true/false values, consider consolidating
> them into a bitfield with 1 bit members, or using an appropriate
> fixed width type, such as u8."
> 
> Due to @has_ippc's default vaule is 0, no need set it again if fail
> to get ippc base address

Please split this change out into a separate patch, as it has nothing to
do with the "change to bitfield" change.

thanks,

greg k-h
