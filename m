Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580BB357DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhDHIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:12:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55316 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhDHIMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:12:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 17C96202353;
        Thu,  8 Apr 2021 10:12:22 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B24B20234E;
        Thu,  8 Apr 2021 10:12:22 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E8B81202D9;
        Thu,  8 Apr 2021 10:12:21 +0200 (CEST)
Date:   Thu, 8 Apr 2021 11:12:21 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.13
Message-ID: <20210408081221.qp5kcv23vgz3qqjs@fsr-ub1664-175>
References: <1617568824-2311-1-git-send-email-abel.vesa@nxp.com>
 <161786558917.3790633.14467115349480488916@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161786558917.3790633.14467115349480488916@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-04-08 00:06:29, Stephen Boyd wrote:
> Quoting Abel Vesa (2021-04-04 13:40:24)
> > The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> > 
> >   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
> > 
> > for you to fetch changes up to 054ef44ea3ef2883e0f63c9a54c91c07f321a0b4:
> > 
> >   clk: imx: Reference preceded by free (2021-04-04 22:39:05 +0300)
> > 
> > ----------------------------------------------------------------
> 
> Thanks. Pulled into clk-next. Next time can you send a signed tag with a
> small blurb about what is included?

Oups, I mistakenly used the branch instead of using the tag.

The tag is here:

https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/tag/?h=clk-imx-5.13
