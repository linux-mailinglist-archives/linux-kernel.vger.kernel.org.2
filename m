Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF8632AA41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581754AbhCBTRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1839697AbhCBQhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8B4464EE4;
        Tue,  2 Mar 2021 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614703031;
        bh=DzRlQapNW+t20Ym+PTiz63F55oDyks7fqmYk9cGUF5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=taibYnba0sBUkA9aOh26cgC19LM0kBq0kmRnYaftS0622/HoZ+oCenpuAmQB+JiQ4
         ub3b1MDAmIhWXzMTOIo8Jy/jMyvQRPeBosdDFHpno5do2Twk+rsJajcfR0yi7rU12U
         cQA3LhrSDIkYDmoZbEO5l/+INsCP8vkE5+mimPniFpyM9ETMBzqieBxKzagLh+JIe9
         yqUWDphAl5FVMwcQewxuzf7z6AiOMUTYteXjr9cD7++TiUtjKYX6XqlOMlvXQXeNn2
         Ni9khMSP4y4oNg6/e3S+lom21qzpa6ybZIWZQy436wXSwXg4EJ4amUCSZuxPC16pPo
         J6rlv9H51fjFQ==
Date:   Tue, 2 Mar 2021 22:07:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     geert@linux-m68k.org, kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
Message-ID: <YD5ps6h3rR/O915w@vkoul-mobl>
References: <20201211191241.21306-1-liambeguin@gmail.com>
 <20210113114941.GD2771@vkoul-mobl>
 <C9BWPQC23WXC.2TUP0Q9J7VAX5@shaak>
 <20210219075837.GX2774@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219075837.GX2774@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-21, 13:28, Vinod Koul wrote:
> On 17-02-21, 10:22, Liam Beguin wrote:
> > Hi Vinod,
> > 
> > On Wed Jan 13, 2021 at 6:49 AM EST, Vinod Koul wrote:
> > > Applied, thanks
> > >
> > 
> > I can't seem to find where this was applied, could you point me to the
> > right repository?
> 
> Yeah I cant find the commit in phy-next. I will apply this after merge
> window opens.. sorry for the miss

Done now, it should be in linux-next for tomorrow

-- 
~Vinod
