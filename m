Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB62331CC67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBPOuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhBPOuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:50:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA59164DF5;
        Tue, 16 Feb 2021 14:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613486970;
        bh=hl40OB93a+qG012lfI+kfbv0ElATlR6UuVxNEuYcHiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgiExrLg2BpgT4SDikEYdFN0UahyHSV1LbPtKRoPNVfSjocakFsQVzntt/kE7g9J2
         ibaKLKLW8RrC7waiTf9pRugBJrj8GeTP6I6x1umQxsyPJXIHDrlMxRcz4n2BljvfYq
         eMhkAlFBOfmcVFjp/qaWHgeFWNaHBmSRWbAcpZd4=
Date:   Tue, 16 Feb 2021 15:49:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Karan Singhal <karan.singhal@acuitybrands.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: add IDs for nLight Air Adapter,
 Acuity Brands, Inc.
Message-ID: <YCvbd/XTECsUEzIB@kroah.com>
References: <20210216144333.29262-1-karan.singhal@acuitybrands.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216144333.29262-1-karan.singhal@acuitybrands.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:43:33AM -0500, Karan Singhal wrote:
> Signed-off-by: Karan Singhal <karan.singhal@acuitybrands.com>

I know I can't take patches without any changelog text, maybe Johan is a
bit nicer, but I hope not :)

Please fi xup and at least say something here, perhaps the output of
'lsusb -v' for the device?

thanks,

greg k-h
