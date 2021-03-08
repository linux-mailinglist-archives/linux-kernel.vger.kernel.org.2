Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31A53305A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 02:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhCHBah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 20:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232035AbhCHBag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 20:30:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A652965142;
        Mon,  8 Mar 2021 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615167036;
        bh=kEfU/3VkTkKBq1rMsZZhlHiDpEv+Qcgk2HYB8ZbRqYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRO9ip7dOYDmDmyUMXNfY5Yc+sIKWbu7lBWoKjX+d5UlWEgNE90vGiPpcc3JH+3ri
         OJRBDSHPHJn5FyPp+t1/LDidwZ3YyNj053DsFPmSTU+FNbwMtl66uaV0rrRHsc854G
         zG0HnwzLb/I91lG1nculemSbb22OItfc0pkO4whwpK4VsR6I0yo/ga/LvLKghNH/G6
         HgNHyHa+qYHWWcrk2wTDs5f3cd2zoPEHePWnUmygrTyTHs8xqx8WAsagTbYiErx3KU
         AZ6LwflrA+VsrWNdKL06SEj6zEnyUY5F1AXMYbHdd9vK+/OLaccR16f6k6Z0570LwL
         cx5iO+7si+dFg==
Date:   Mon, 8 Mar 2021 09:30:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: colibri-imx6ull: Change drive strength for
 usdhc2
Message-ID: <20210308013009.GT543@dragon>
References: <20210304093139.471554-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304093139.471554-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 10:31:39AM +0100, Philippe Schenker wrote:
> The current setting reflects about 86 Ohms of source-impedance
> on the SDIO signals where the WiFi board is hooked up. PCB traces are
> routed with 50 Ohms impedance and there are no serial resistors on
> those traces.
> 
> This commit changes the source-impedance to 52 Ohms to better match our
> hardware design.
> 
> The impedances given in this commit message refer to 3.3V operation.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks.
