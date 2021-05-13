Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC337F10B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 03:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhEMB6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 21:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhEMB63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 21:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 244B3613C9;
        Thu, 13 May 2021 01:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620871037;
        bh=EiZdiBHL8EZ+BD3Z4LiEsJR03MfWMzEqO5FrU4oFnjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQEyES+iN2Mv3RFq7e1jB9zF+cXTRXQRaLlsd81Ac9v5Jk7JtlPn903nMy2lDKlBN
         2BQdyFux3SMhd5I95fUfa292mqLiR6C28TtmfgECVoPWCpkFD+oH4nMaHblRDOfh0+
         OI8lOMKTOid/hf/sfUBzp9UfqJWoZlVlGgcSPzQUvYs6x+4Y9sjLzD7nEvm19cLkM+
         GWFE+LJ9OkxHBsVCEHtaxRYtwTqjCzUHX+VB6rFfgDiJATC8oKgULzVaj3RDcEprxh
         SbVzcjUoXWWwt0yYWPibJyhRZXAw68PLggy2TtZg8bq56vNwfLR4rL3iEprfI80CQ0
         XuW7IWvKhaWag==
Date:   Thu, 13 May 2021 09:57:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add peripheral support to imx8mq-nitrogen board
Message-ID: <20210513015710.GH3425@dragon>
References: <20210511193601.2584324-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511193601.2584324-1-adrien.grassein@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 09:35:57PM +0200, Adrien Grassein wrote:
> Hi,
> 
> this patch set aims is to add support of multiple peripheral of the
> Boundary8M board:
>   - USB Host;
>   - USB device;
>   - DB_DSIHD sub board for MIPI-DSI to HDMI output (via lt8912b chip).
> 
> 
> Updates in v2:
>   - Use a GPIO hog to handle the USB HOST reset line;
>   - Remove useless GPIO hog for lt8912b.
> 
> Update in v3:
>   - Fix bad squash in git commits.
> 
> Updtaes in v4:
>   - Fix issues found during review (bad DTS style);
>   - Fix comment for the USB HOST.
> 
> Thanks,
> 
> Adrien Grassein (4):
>   arm64: dts: imx8mq-nitrogen: add USB OTG support
>   arm64: dts: imx8mq-nitrogen: add USB HOST support
>   arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI to HDMI
>   arm64: defconfig: Enable LT8912B DRM bridge driver

Applied all, thanks.
