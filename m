Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DCC32BBD2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350375AbhCCMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:54:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1842743AbhCCIMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:12:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 100FD64EDC;
        Wed,  3 Mar 2021 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614758381;
        bh=Kk5vZ5bewIKfc2mHgHI4/ZeIkuOPpVHLt3iDzWvNhz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQ78G9eQnFydvkIiILyEmWL7hA0fYHr0/5tJjeX7kjlMVUfFGRIguODxrVUDDMgww
         TIp72frsckpCkRUm75oiaD6ue03Ep/viDSZZMA8pkjiR7KAtz505jvNFnnN2QARoTS
         +EVjTktEBsjrjZO4KWrNzO6j36p3m4EY+cNLQ2gpFpTPnuFg2eVTCZwSHvAlQ4GcgX
         TX6vUidz+k8uVQLjtDlh9+15s7jPsCh174c73Gi1TA1kbP+nN+1kBxzShReB/pbkSE
         J3Z+L9yKf0wP4gt/0lBuncLDjcgM40SXQVryuueBLcugMfPULiBT4F9q3tjA7bg6kq
         JLuTDSiG1dzNw==
Date:   Wed, 3 Mar 2021 15:59:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net
Subject: Re: [PATCH] ARM: dts: imx6sl-tolino-shine2hd: Add Netronix embedded
 controller
Message-ID: <20210303075935.GC15865@dragon>
References: <20210124214127.3631530-8-j.neuschaefer@gmx.net>
 <20210125190804.12552-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125190804.12552-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 08:08:04PM +0100, Andreas Kemnade wrote:
> For now, the driver detects an incompatible version, but since
> that can be handled by auto-detection, add the controller to the
> devicetree now. Only PWM seems to be available, there is no RTC
> in that controller.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks.
