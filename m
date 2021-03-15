Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F6733BEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhCOOu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231644AbhCOO0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:26:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 591B764FF9;
        Mon, 15 Mar 2021 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615818410;
        bh=jAs0nXJym2Mi0R0qV76FK5EUuMU+K5jr65qJca1NBmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02fIKgYvHZsKRARQ/8yQhfyCndxzs8bQm1LFl0auRaeQ940jx6ISBz++DXEpzCnVG
         yJlZ7+1Q8KxblN9HnRVTjLf92zUBXbNgi0zTVmSjk0lLr5ipNk+h3gCL8uEkxymx5R
         zJ7wix8QioqS4WLLwa1bgil6gUs1vDqQoMjNFuuQ=
Date:   Mon, 15 Mar 2021 15:26:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Hongren Zheng (Zenithal)" <i@zenithal.me>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usbip: tools: add options and examples in man
 page related to device mode
Message-ID: <YE9uqOqPf3SNsIgc@kroah.com>
References: <YE9Vyrs+Z8MusjDM@Sun>
 <YE9Wo8QZ/0XU8Mzq@Sun>
 <YE9dbrWjL5DZ8Hm8@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9dbrWjL5DZ8Hm8@Sun>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:13:18PM +0800, Hongren Zheng (Zenithal) wrote:
> The commit e0546fd8b748b19d8edd1550530da8ebad6e4b31 implemented device
> mode for user space tools, however the corresponding options are not
> documented in man page.
> 
> This commit documents the options and provides examples on device mode.
> 
> PATCH v2:
> Add signed-off-by line

This needs to go below the --- line, as the Documentation asks for.
Please fix it up and try it again.

> Signed-off-by: "Hongren Zheng (Zenithal)" <i@zenithal.me>

Do you sign legal documents with "(Zenithal)"?

thanks,

greg k-h
