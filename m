Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15F935415E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhDELFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233399AbhDELFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAA30613AF;
        Mon,  5 Apr 2021 11:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617620701;
        bh=sGmmPmvyHW6SbGk/cIOPBMKd63jKhBXzou4B5BwrUjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNux+0W55wwb7ipWJIAZtwml+nsCZ6JiF28syTnkFEruOpdWDwvL/FCywWuvJqWSN
         hPLZmQHwYROHhLvzTl3nwNv4CCp25H8Rdc5tTepNslTHlmo09NMp4ReTdcxDo32Vm1
         94mmN2ZbolRSY9GrtCgOL3UTFRXKmQxkL3xxu06U=
Date:   Mon, 5 Apr 2021 13:04:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, corbet@lwn.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] w1: ds2438: support for writing to offset register
Message-ID: <YGru2+hI6fgE/v3J@kroah.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210405105009.420924-10-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405105009.420924-10-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 07:50:09AM -0300, Luiz Sampaio wrote:
> Added a sysfs entry to support writing to the offset register on page1.
> This register is used to calibrate the chip canceling offset errors in the
> current ADC. This means that, over time, reading the IAD register will not
> return the correct current measurement, it will have an offset. Writing to
> the offset register if the two's complement of the current register while
> passing zero current to the load will calibrate the measurements. This
> change was tested on real hardware and it was able to calibrate the chip
> correctly.
> 
> Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
> ---
>  Documentation/w1/slaves/w1_ds2438.rst | 11 +++++-
>  drivers/w1/slaves/w1_ds2438.c         | 49 +++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 1 deletion(-)

In this, and the previous patch, you added new sysfs files, but no
update to Documentation/ABI/ for them.  Please fix that up.

thanks,

greg k-h
