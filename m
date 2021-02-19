Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3974231F5B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBSIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 03:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBSIMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 03:12:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70CF264EBD;
        Fri, 19 Feb 2021 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613722302;
        bh=EwTC9tC7yHKIbAicSsPxDq3xGvNVTspmTrJcExiOpVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWW1QIfS/Ebz56dRe4M5R1jmpuGnSj75KXXk4Cehdx2kmxYtDfTKrnSIW3LZ0ZYjH
         V05uYp0SjJO32hJViLlYWzxgupMAIOXuISKRis892OcVwDJe119c7VaqLYPmYBLnRy
         zx7rrh7kriouzpBrdf/v9KGI7yRDZPOmnR/snJBw=
Date:   Fri, 19 Feb 2021 09:11:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Emad <alaaemadhossney.ae@gmail.com>
Cc:     mchehab+huawei@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: hikey9xx: fix styling issues
Message-ID: <YC9yu31kKb+DROMH@kroah.com>
References: <20210216124255.9353-1-alaaemadhossney.ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216124255.9353-1-alaaemadhossney.ae@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 02:42:55PM +0200, Alaa Emad wrote:
> In hi6421-spmi-pmic.c, there are some warnings and Check:
> 
> "WARNING: please, no space before tabs" in lines 51,52,53 and 69.
> "CHECK: Alignment should match open parenthesis" in lines 180 and 238.
> 
> Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>

That is doing 2 different things in the same patch, please make this a
patch series and do only one type of logical thing per patch and resend
them.

thanks,

greg k-h
