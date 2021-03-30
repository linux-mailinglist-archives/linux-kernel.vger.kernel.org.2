Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2D34EB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhC3Ouj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232101AbhC3OuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:50:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43A8961957;
        Tue, 30 Mar 2021 14:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617115805;
        bh=7uCp9BC5awlAA67PRk9uULHZvuzbXdLQygQjdIMZD/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCLLMu+klUSq9plxt2yVcEMGi8GNAzS6719w6rToCD6D0NJu+mivBWNpKfyW/4xvh
         oW/zOKfSlSNV4RyyWpOG610cbK5H4pDV4I4FiQBFk/r4VmaAuxVFOpGPnBP89/av/f
         TJWIi8XCNXFuMuG9zqkkoRfWBj9lhWD3uQq/6CMo=
Date:   Tue, 30 Mar 2021 16:50:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] USB: serial: add support for multi-interface
 functions
Message-ID: <YGM6mhvDrFkqHe70@kroah.com>
References: <20210330143820.9103-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330143820.9103-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:38:16PM +0200, Johan Hovold wrote:
> A single USB function can be implemented using a group of interfaces and
> this is for example commonly used for Communication Class devices.
>     
> This series adds support for multi-interface functions to USB serial
> core and exports an interface that allows drivers to claim a second
> sibling interface. The interface could easily be extended to allow
> claiming further interfaces if ever needed.
> 
> The final patch uses the new interface to properly claim both the
> control and data interface of Maxlinear/Exar devices.

Looks good, thanks for adding this:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
