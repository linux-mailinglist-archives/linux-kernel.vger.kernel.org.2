Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB634C125
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhC2BfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhC2Be7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:34:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 724F9600EF;
        Mon, 29 Mar 2021 01:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616981698;
        bh=6+VxiZVQue9t6p9Kolu9ET32ku6Xz3xw7XrpNKRIlKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgZBo7jtus/fXb/WCdsZOgAK9H4KGX6JBuzzOweRFG4WRHIkaR4/YE+WxS3D0KCC5
         rZumauk2GLIfhodp6iDQHzWV7MYXZGh/gnKsMVz5+qIBPigv0r+qvGdVP01JJVbxL7
         YKYOWv9xob0t+KGZaHqYpjqZOkzPPSNP+j0pT8NG+kSPd6HYTYcpTGxcD9IaT29CDM
         Z9mfnbOzjRh5GQ9vBDwViSmYFwcagTI4kvXWHAyWdld0cz/m7t+dnk/5hUeUHtc3IX
         JQk0QzMOUhqvQBj0CgRNM5xEEJj+DDQe+pCbQf/MYC8JGzlOsfjLYb15Slqw0iiFUa
         9+lAISkQ0lZeQ==
Date:   Mon, 29 Mar 2021 09:34:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, victor.liu@nxp.com,
        peng.fan@nxp.com, daniel.baluta@nxp.com, mirela.rabulea@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lznuaa@gmail.com
Subject: Re: [PATCH 1/1] firmware: imx: scu-pd: add missed ADC1 pd
Message-ID: <20210329013452.GI22955@dragon>
References: <20210319212352.31869-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319212352.31869-1-Frank.Li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 04:23:52PM -0500, Frank Li wrote:
> ADC1 is not defined in pd driver on 8QM.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied, thanks.
