Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE5631F5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBSIPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:57520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhBSIPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:15:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A92664EBF;
        Fri, 19 Feb 2021 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613722465;
        bh=Sg/LmX0xgru7QZr+8/7sje3EDV8aKwgIztIGPvkrOA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fc8flGBUEQ1jUa4i4CBmCknlcdqj1QR+KjMIkGX6fjMR/wiPfPawzxOEayBOd1vfq
         MdD01/frONeQ+S1rVBpgG990GNhVluPklzn0ZJZflPEqSe7wiglSTGqE4RQU7/HdVA
         C6OEpmeH3wpJ+CCl8t71sXLleUhMeCQerVyYPCBg=
Date:   Fri, 19 Feb 2021 09:14:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nikolay Kyx <knv418@gmail.com>
Cc:     adawesomeguy222@gmail.com, dinghao.liu@zju.edu.cn,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fwserial: match alignment with open parenthesis
Message-ID: <YC9zX1aIgj/sVnQY@kroah.com>
References: <20210218194333.7115-1-knv418@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218194333.7115-1-knv418@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:43:33PM +0300, Nikolay Kyx wrote:
> fwserial.c:

Why is this here?

> fix CHECK: Alignment should match open parenthesis

What does this mean?

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for what is needed in order
to properly describe the change.

thanks,

greg k-h
