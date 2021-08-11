Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9C3E9651
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhHKQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 12:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhHKQqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:46:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E05E60C3E;
        Wed, 11 Aug 2021 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628700357;
        bh=0qa35o8A8qS98BltBIjIrqKNdNXst0gyYDOnjg1L0MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWMZhOAJtyjVmUWJ4nr8QhZIPUr3C+1yX8AnBfP2DVVyF+JDIj88ZGb3bLWrcAo2A
         F/veC0RK+y1KdxDLf3WmmSfPe3uxRXXHwr8Cr4sNibFZMKsv4A2vsa4LEQ3f1JOfyx
         75zUmFX4/rwv0XUYH0duNMLwIxgBUGOhFk3az9bk=
Date:   Wed, 11 Aug 2021 18:45:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] staging: r8188eu: Remove wrapper around vfree
Message-ID: <YRP+wz05avsLx3EN@kroah.com>
References: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
 <20210802192721.23110-3-Larry.Finger@lwfinger.net>
 <20210811154412.GA1005754@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811154412.GA1005754@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 08:44:12AM -0700, Guenter Roeck wrote:
> On Mon, Aug 02, 2021 at 02:27:17PM -0500, Larry Finger wrote:
> > This call is so simple that there is no need, or use, for a wrapper.
> > 
> 
> Except the wrapper was presumably there to map generic code to Linux
> code, and the patch doesn't add an include <linux/vmalloc.h> anywhere.
> This results in widespread build errrors such as
> 
> drivers/staging/r8188eu/core/rtw_mlme.c: In function '_rtw_free_mlme_priv':
> drivers/staging/r8188eu/core/rtw_mlme.c:129:17: error: implicit declaration of function 'vfree'
> 
> for all architectures where <linux/vmalloc.h> isn't included indirectly.

Has now been fixed up in my tree and will show up in the next
linux-next.

sorry about that,

greg k-h
