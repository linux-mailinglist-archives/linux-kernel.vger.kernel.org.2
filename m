Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70EE392E23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhE0Mkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234466AbhE0Mkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:40:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A9F26135F;
        Thu, 27 May 2021 12:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622119148;
        bh=wrDHOIrTEbbIVEs/Rd4ajst8tcrTUo3otaR3wmoLEXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6aFuYu8zvPtljdWWHPdEhLklq91GqVjpYOjMhtiFpamoWdMI7ZpK84Mkf3oL9trA
         Tgo26/wCvhpdAnD9miquFuDg1Fxg7v5bI1pQx2CN8stL0L1NAOjR/iyBrLthZfMLd4
         aAjuQLpynfa6zrPHl8nrmezC+oQB48VsmkkH+XLQ=
Date:   Thu, 27 May 2021 14:39:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
Cc:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, jens.taprogge@taprogge.org,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipack/carriers/tpci200: Fix a double free in
 tpci200_pci_probe
Message-ID: <YK+S6agat0rGUNI9@kroah.com>
References: <20210524093205.8333-1-lyl2019@mail.ustc.edu.cn>
 <c00938c1e634340663e145b51c5989bd4a20f326.camel@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c00938c1e634340663e145b51c5989bd4a20f326.camel@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 12:04:28PM +0200, Samuel Iglesias Gonsálvez wrote:
> Hi Lv,
> 
> Thanks for the patch!
> 
> Patch is,
> 
> Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> 
> Greg, Would you mind picking this patch series through your char-misc
> tree?

Sure, will do.
