Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393E432BE7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376630AbhCCRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1445854AbhCCNrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:47:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 260FB64EF1;
        Wed,  3 Mar 2021 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614779231;
        bh=cXIOQWiMuykpjT+zabY+0Oz+LwgtGeJrMU2cY3hwKEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGPiIdwFMSMREbZlaZc+RQYz9jo2ERMULnGBuM9oRkP7EeS4JJWqzvfK+llvYSn72
         t95f1XEqnq6F9N8PYP1jB1/JQlqZlBePT7KaU8NJZUgZhH5xLOpcglsb/yU3dghDnJ
         UCkh/Nh5Dj+BD0/LwqltkiekoXoHSCptkb2+q94NUE0u0M1lUHLmVyQezoMxZJN/4v
         mQdnjnH4WpJKMQRHxrMDN31UuBIvyH6bLsh3jXId5cELYFL5ggkDE48fljgG2n4sWj
         1i27nLGw31koS4oX1uS94BlO/2d/9jeaxmiYvjPrn2zkDp2Y9ypPr2XbcYZ9YxrRBD
         YuMU0vkFzUeFA==
Date:   Wed, 3 Mar 2021 21:47:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v3 3/3] ARM: imx_v6_v7_defconfig: Regenerate
Message-ID: <20210303134704.GL15865@dragon>
References: <20210204030316.489-1-alistair@alistair23.me>
 <20210204030316.489-3-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204030316.489-3-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 07:03:16PM -0800, Alistair Francis wrote:
> Run make imx_v6_v7_defconfig; make savedefconfig to regenerate the
> defconfig.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

We can leave it to future updates on the defconfig.

Shawn
