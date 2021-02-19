Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1BA31F5A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBSII3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBSIIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:08:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C32564EB8;
        Fri, 19 Feb 2021 08:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613722064;
        bh=+AW7VXLLqQMGU9QuzS9RaFCI0OCcTFUIvbPMynhfYxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFEHEh2y7+nZkh8qCL8BDfObkF0S/izVKMODwF/yjyQUf/802OVaunNbom8g+o0rG
         dmMtlGJJTQVP5En7F9dmK3VVV7kBKGNslCKpQu+tB7xMEH1nhBdOiyd7aJXyak3AUn
         jXalUwRsL7NQSk734JX4QTC2MbzvUfDs/lEf51VU=
Date:   Fri, 19 Feb 2021 09:07:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ashish Vara <ashishvara89@yahoo.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: removed unnecessary debug message to fix coding
 style warning
Message-ID: <YC9xzlAFoTr/sjsX@kroah.com>
References: <9a866392-332a-8c0b-eb9b-08931adf316c.ref@yahoo.com>
 <9a866392-332a-8c0b-eb9b-08931adf316c@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a866392-332a-8c0b-eb9b-08931adf316c@yahoo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 07:44:52PM +0530, Ashish Vara wrote:
> From: Ashish Vara <ashishvara89@yahoo.com>
> 
> removed unnecessary out of memory message to fix coding style warning.
> 
> Signed-off-by: Ashish Vara <ashishvara89@yahoo.com>
> ---
>  drivers/staging/gasket/gasket_page_table.c | 2 --
>  1 file changed, 2 deletions(-)

Your subject line should mention the driver name that you are modifying,
right?  Look at how other commits have been done for this file, and copy
that format.

Please fix up and resend.

thanks,

greg k-h
