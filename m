Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60D630F0C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhBDK3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235531AbhBDK2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:28:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52C8364DDE;
        Thu,  4 Feb 2021 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612434452;
        bh=XRH1UWEZTqhLyy25/WwW5h0FyhJIwo9GjMdZ3vSVVDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x3QhhfWGd/2APyylfT/FNXHf7InV8/KWv37rXICmrB9Q07Y3UwiGa23dixhcZv0ZZ
         +BN+FgrI7h2gD5dsSSyYbSDNeq+4CeivT1eyYc7GnVH+lD/q470pdVc+2DRFT9Cg0h
         qld1sISLOfUAxCJZLy/ZefR6O9+/F74ICQjZoROI=
Date:   Thu, 4 Feb 2021 11:27:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     peter.chen@nxp.com, dan.carpenter@oracle.com,
        colin.king@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        kurahul@cadence.com
Subject: Re: [PATCH] usb: cdnsp: Removes some useless trace events
Message-ID: <YBvMENpo3OTp5vrj@kroah.com>
References: <20210204092035.32424-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204092035.32424-1-pawell@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:20:35AM +0100, Pawel Laszczak wrote:
> Patch removes some useless trace events that can
> be replaced by ftrace.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-ep0.c    |  5 -----
>  drivers/usb/cdns3/cdnsp-gadget.c |  2 --
>  drivers/usb/cdns3/cdnsp-ring.c   |  1 -
>  drivers/usb/cdns3/cdnsp-trace.h  | 10 ----------
>  4 files changed, 18 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
