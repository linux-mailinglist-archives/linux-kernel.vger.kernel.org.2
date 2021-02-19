Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07231F588
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBSH7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:59:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CBD964E86;
        Fri, 19 Feb 2021 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613721521;
        bh=QLmVodVolZdp+cdbU5KFKcOrHnnHjoAfLhJ+tRrOHPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BImyCgz0P8S9LY2/2fUqC6sQRE1dZDx+eAYvOf/L60t/+gTmVANYG9+825tApds4B
         A+U024+d40gmO5AdUQnWSghCH9zpmLRXD7bBGqx3cUxfeP+RuCSvlS3x5px1i5ZrWv
         USTPzuCe1pGJ9tzQETiX97Wiaz2KClYq84jzY9Cr3xW73Pa/gCKsGmMn2vQ3a3y9eu
         7RJTpkVcT9MLI+8CdYu4j0Z72k4noh/BlzDEDe8xqDpoVAxKaDgp576y4O6AIsqhfH
         Ab86xVbwuk+r2D9ZZlPxNbiAYsy/TuUeZtmfnQ3i9olP8TGbdRt7ZaJFff7ymIDiws
         8HvJ6wl5eWlPA==
Date:   Fri, 19 Feb 2021 13:28:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     geert@linux-m68k.org, kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
Message-ID: <20210219075837.GX2774@vkoul-mobl.Dlink>
References: <20201211191241.21306-1-liambeguin@gmail.com>
 <20210113114941.GD2771@vkoul-mobl>
 <C9BWPQC23WXC.2TUP0Q9J7VAX5@shaak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9BWPQC23WXC.2TUP0Q9J7VAX5@shaak>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-02-21, 10:22, Liam Beguin wrote:
> Hi Vinod,
> 
> On Wed Jan 13, 2021 at 6:49 AM EST, Vinod Koul wrote:
> > Applied, thanks
> >
> 
> I can't seem to find where this was applied, could you point me to the
> right repository?

Yeah I cant find the commit in phy-next. I will apply this after merge
window opens.. sorry for the miss

-- 
~Vinod
