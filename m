Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3632BE3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbhCCRSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380760AbhCCN3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:29:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F2864E02;
        Wed,  3 Mar 2021 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614778126;
        bh=KhFSMataHsGZ7AJ138B1Au+pcPiS3CjPeDpmVqerXfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hU6dUMv/g5EAqhju6UP+vRZHy/O9CADHkLmn123hDs/GCXVzmxRfL/uvcJPETBg/5
         yI2hovgjRV1LngZXlzxOnaqkNeyMai367ggkTjWC0pxY23sX/SHv4QAK94jAt0xXwi
         vIlDnxkxX01/8/zEzZQbBZXFBaulaYkrK56GaIB0Ypmba3RIWta8+wEYXY8AwJFE94
         CqpSpssoRuOTxcKuTlFeL7tY0/0kLkFoUtHhYRvq013eFC4V3IRaIfg5UwvFeQZn3n
         wTvLvNNof8iDiIl0lX2Q4v7xrIDWLASz/8ATWD7bPxr44bA651lgP/ErLMG1y/cDSk
         vlBqQSbP4IV/w==
Date:   Wed, 3 Mar 2021 21:28:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
Message-ID: <20210303132839.GI15865@dragon>
References: <20210205013847.1736929-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205013847.1736929-1-saravanak@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 05:38:46PM -0800, Saravana Kannan wrote:
> Using IRQCHIP_DECLARE lets fw_devlink know that it should not wait for
> these interrupt controllers to be populated as struct devices. Without
> this change, fw_devlink=on will make the consumers of these interrupt
> controllers wait for the struct device to be added and thereby block the
> consumers' probes forever. Converting to IRQCHIP_DECLARE addresses boot
> issues on imx25 with fw_devlink=on that were reported by Martin.
> 
> This also removes a lot of boilerplate code.
> 
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Reported-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Tested-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks.
