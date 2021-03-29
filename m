Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4934C13B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhC2Bnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhC2Bns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:43:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4938B61490;
        Mon, 29 Mar 2021 01:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616982228;
        bh=aiptcvuP7ZJYmORUrDmWUxLPU3jUf8HXLM9QFkckTJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5c0fRgdkvx3Yi8bG83OV5t59I5jCs/aF/7BcaNawDUOAc7+ceRfXZjnsZkIzkud0
         JtMPMBGCA/cKuOtZ0sbAPIwOMySerKf1UY0Y/uVNDJw6aWA6/tVL9MO+2c2ZvE21+G
         xQ73CLhC//CozKGY/GlPId/za/LKOTNwbzVKT+GN/u6LDvbVGJ00H4/8irEPGejDg3
         japgtxv7juFVULrc6e4+HT5gmgS8MNOK9oEsiA/+1p6um2qmtKqrG/LIpgv1SjfNGm
         TEIlDBAB8lhsNSoJqn/q0xeNP3hDwYSEwXprpecer4vZVPoAqNpPnV+CtdrWw0VQ0S
         F3wwXkBPsFi0A==
Date:   Mon, 29 Mar 2021 09:43:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v6 1/3] dt-bindings: Add vendor prefix for reMarkable
Message-ID: <20210329014341.GK22955@dragon>
References: <20210322130928.132-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322130928.132-1-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:09:25AM -0400, Alistair Francis wrote:
> reMarkable AS produces eInk tablets
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Applied all, thanks.
