Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CDC37F3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEMHpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhEMHoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:44:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44B60613E9;
        Thu, 13 May 2021 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620891771;
        bh=3SfjdjknA0V6g3J4DziWxsUlgZHdtpI0rye33OpC7Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNsmZpJflFloWJg7xsCpNeZCVL26bxuTpJOWu73PsuVcV+QnLMsyp+u6uwUtLEWy9
         42cyc2PtmYXpkoXg9zIj1mIQa4FZq9qZwebFnHF4fc4TDfx9c7uGSIiAoA1SGpgpDt
         numGOFCEdcgZU11Ux6OQxrnMP6YQ1W90F1EunqscuDLEiV6jUCQKLYQ/ul/mbidOoG
         LsOKuPMHiN7L9pFRBH6J1+EJfJoEAqRs/8u7DsqPcc1J6eH7NzmakcUote9xWUwGxc
         Wulx8S5W7BgUCcYnAbuTZy7ousRs1xulQ0NG0SSKD0BFCWeHE8K54/MtIn4R3CDbzB
         R31+xFGkdffqg==
Date:   Thu, 13 May 2021 15:42:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: Initialize SoC ID on i.MX50
Message-ID: <20210513074245.GT3425@dragon>
References: <20210424162133.680213-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210424162133.680213-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 06:21:27PM +0200, Jonathan Neuschäfer wrote:
> As on i.MX51 and i.MX53, initialize the SoC ID based on the SoC
> compatible string of the board.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied, thanks.
