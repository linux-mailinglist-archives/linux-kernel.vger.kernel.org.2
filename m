Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E9534C0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhC2BGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhC2BGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:06:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AF7B614A7;
        Mon, 29 Mar 2021 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616979969;
        bh=sgOCgJ0fNbUnbq1ruCpC4fNsf05dxvQ2et8MYttPLJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYe326TOpyuTw90ywfiYO7i9DHkgnojZ0fldviAAmo1Qd+AXcIAI7VrtsldRwpFR3
         i0xXFCmrRNvQzvWMAjFUGosvOohR6VUCAVTwn2IeIMCDBXKbNPGgQ35yHd7qjfXlv9
         whvT+ZifAYXnarBBqYtygbUGK1hUB/snUxvAz0l13/3Ghr/KMoFTJUXrS8drGzMNdO
         oMiSJHM5uDzGIHakkYzrTMHD9mhRB889sHOmZSxVF6I0TlgI+3hcqAW2gjeAiqPLz+
         FQJ3nqapEMnD/zPfK8SMuKL5x3Srn2bdEy23YaeX/sHcJ5pEtJ7dcBSFIG7A98IZNq
         WxGQE6lFoUfGQ==
Date:   Mon, 29 Mar 2021 09:06:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: fsl-ls1028a-kontron-sl28: move MTD
 partitions
Message-ID: <20210329010604.GG22955@dragon>
References: <20210318171856.3487-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318171856.3487-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:18:55PM +0100, Michael Walle wrote:
> Move the MTD partitions to the partitions subnode. This is the new way
> to specify the partitions, see
>   Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
