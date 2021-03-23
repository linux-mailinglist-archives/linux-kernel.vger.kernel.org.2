Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB698345E29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhCWM3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:29:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhCWM3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:29:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FA2D61931;
        Tue, 23 Mar 2021 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616502547;
        bh=afEw5y8ZIUORMbnuRr1rExjsMs7f6XInz5bFs4zNxZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMw+OIF5fnt72yaWF4Y9ZxmaCZRLKiNAH8AAXM8pgi9dpWgmDQU9y8ZWeehCjTiaL
         0NApS562xcXw1HD7XqpImblhiINdsFZftUM3bPqC3IiMvp5EsarDNkMPXa0+7W3SYz
         NaL7V0oSqREsxOYZDRKTFMtktVRgxZ1UTTyO0oiM=
Date:   Tue, 23 Mar 2021 13:29:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     caizhichao <tomstomsczc@163.com>
Cc:     matthias.bgg@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        caizhichao <caizhichao@yulong.com>
Subject: Re: [PATCH v3] tty:serial: fix spelling typo of values
Message-ID: <YFnfEaaM8R5vlUhy@kroah.com>
References: <20210323115327.1199-1-tomstomsczc@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323115327.1199-1-tomstomsczc@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 07:53:27PM +0800, caizhichao wrote:
> From: caizhichao <caizhichao@yulong.com>
> 
> vaules -> values
> 
> Signed-off-by: Zhichao Cai <caizhichao@yulong.com>
> ---
> v3: use full name and capitalize personal name.

But now your From: and Signed-off-by: lines do not match :(

Trivial patches are best learned in the drivers/staging/ area, please
try working there before going out into the "real" part of the kernel.

thanks,

greg k-h
