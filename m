Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5110A421E61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 07:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJEFsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 01:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhJEFsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 01:48:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73BB761074;
        Tue,  5 Oct 2021 05:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633412773;
        bh=N/EJ5VaYZxG/JNhYnWmWrIGL2Zjh/9JsBZk2LwTmXuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePMRe2Ymbaidv2AdjVKpi8hTQc77Ar8/GGeqZN3rrb4lsnk/TE94gEK8StLIOEm5Q
         XdB4UE660tckTJsK704blZE0vGIZ3Uv8HyjVuC01DnBgOheUlrH4NH3kALEuRcFPjv
         2o3nmPqI1A05MHy8Seq56cC1mIexvR4CQQa5hcKouMGRKrlJ/qGNnF+yx74xL3dpBj
         EdGbi4JVcJFbbGzyMYgMLrtHHWQyRLAMjgtsUeiLvC55jDlvai9nWO2gmyAh5J/63R
         dTCRFz4rtF37Qsm0biDJwW3QEkF3WMplu0ovs5B8NSPIwUAeBf1HjebX/lr9rmTFUo
         +2N69/guXZKgg==
Date:   Tue, 5 Oct 2021 13:46:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 0/5] ARM: dts: imx6sl / imx6sll: dtbs_check errors
Message-ID: <20211005054606.GM20743@dragon>
References: <20210924091439.2561931-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924091439.2561931-1-andreas@kemnade.info>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 11:14:34AM +0200, Andreas Kemnade wrote:
> Fix some errors found by make dtbs_check during adding of new device trees.
> These are not all errors, just the ones which seem clear to me now.
> 
> Changes in v2:
> - style: correct align in operating points
> 
> Andreas Kemnade (5):
>   ARM: dts: imx: e60k02: correct led node name
>   ARM: dts: imx6sl: fixup of operating points
>   ARM: dts: imx6sll: fixup of operating points

Applied above, thanks!

>   ARM: dts: imx6sl: fix mmc compatibles
>   ARM: dts: imx6sll: fix mmc compatibles
> 
>  arch/arm/boot/dts/e60k02.dtsi  |  2 +-
>  arch/arm/boot/dts/imx6sl.dtsi  | 26 ++++++++++++--------------
>  arch/arm/boot/dts/imx6sll.dtsi | 28 +++++++++++++---------------
>  3 files changed, 26 insertions(+), 30 deletions(-)
> 
> -- 
> 2.30.2
> 
