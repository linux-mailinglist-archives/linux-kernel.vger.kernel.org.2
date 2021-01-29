Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89488308604
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhA2Grf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbhA2Gra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:47:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13EBF64DD9;
        Fri, 29 Jan 2021 06:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611902809;
        bh=qT+LcC36t8BUmkKIR3cxWo3lbjU9Ek/TxSVKtTqMf/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRF1EaUtluL63l0SMpM4X3+5owLVZISzWsAECPdCYq2QqcVYJY/5yZaM6nYgvQK4+
         m0vm8ZIlzTZOB2g0yLgtfkaV6sCKruHlEtGPT+BmOSjKQW7csqaWDpfYI/QZgbwTCU
         eCcSAcXqTUZ/ulvxnWHovTEqP8vP/KXu1LZztKqYkmeTLbkKALAUZf5VQSyjxoyaF8
         nCqrViEnYu9s02KCG1yZiiZJgLiodRkVDKRf9FtGmRtU6A7UF6JePmpUEF+xul9OG8
         NmxUfyltbeQLrDcAdBuMb5nuW2nW/h+85ig85i6E7eTgq72Hjj9jRF0z8P/5Pw9sZZ
         uJluXAwvy0grQ==
Date:   Fri, 29 Jan 2021 14:46:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: use_dt_domains for pci node
Message-ID: <20210129064642.GE4356@dragon>
References: <20210115032657.15390-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115032657.15390-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:26:57AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> We are using Jailhouse Hypervsior which has virtual pci node that
> use dt domains. so also use dt domains for pci node, this will avoid
> conflict with Jailhouse Hypervisor to trigger the following error:
>           pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");
> 
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
