Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE4045DEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356512AbhKYQwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356630AbhKYQue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:50:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA8036108B;
        Thu, 25 Nov 2021 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637858842;
        bh=7lDGoPA0mMSEjJe6DonC9KjW9vvxa0XRA2BJIcil1N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2KWtVjE+XsV0Gm0x6xgf/3ZaJoirbhkFQ1igkzVYs677QvIXPhj463eb9ui9Yya6Z
         d1q2c8O5p5t3wuFzRUZ0VyFShXFSyzJoCWDk7MfYCHZEfDTCEgfKKuyEg/mM9J2E3H
         vJubv+X2VMpQFxLw4LMmpOgGAyVyk6jFCvVmx220=
Date:   Thu, 25 Nov 2021 17:46:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     joe@perches.com, forest@alittletooquiet.net,
        karolinadrobnik@gmail.com, lucas.henneman@linaro.org,
        dan.carpenter@oracle.com, tomm.merciai@gmail.com,
        eantoranz@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v5] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <YZ+9yDiG1SoWrWED@kroah.com>
References: <20211118211128.GA156436@t470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118211128.GA156436@t470p>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:16:59PM +0100, Alberto Merciai wrote:
> Replace camelcase variable "uCurrRSSI" (current Received Signal Strength
> Indicator) into linux kernel coding style equivalent
> variable "current_rssi".
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
> 
> v4
> - rebase against the staging-next

Is this v4 or v5?

Subject says v5, but this says v4 and then you sent v4 two days later?

I'm totally lost, sorry.
Please resend this again and properly set the version number.

thanks,

greg k-h
