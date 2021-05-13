Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D844337F3CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhEMIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhEMIAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2160261439;
        Thu, 13 May 2021 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620892762;
        bh=iUrtpqFnXdmWdBcpzXp0Ri1xgecNKmB4qbJd7wPBrss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZAFz5rA4Fgu/+xKLoQ9cK5gmvGLaj+7VPIKvDgCzPaTPu0EQEUFLQn7VQYtn3NPw
         Tb6QNmaDZ1rTbKNzCAyXjAa2IZxsmloOCKJz11ifsxYmfnLpA7QygLBkYIGE4PpjeG
         5KkRNkPitFKNhOlQekQHiniqnZyS/r3yJkClZ1Sfr3QyWaiVzeni5ybfphdGoVwJlW
         pNCb1xvkqtUA8hjIEWeV6Un9mxaRcwKzcm3prz9GnP2znWJDNWXuiyqDqBoxNFjVqA
         fOzV6p/lIUjp8gzn+tqQRfWOFBqb/mv6HHyB0cNSEsjTNP+McmsuNyf8gC6c6Ql+hK
         PXewaizjDjFvQ==
Date:   Thu, 13 May 2021 15:59:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls208xa: remove bus-num from dspi node
Message-ID: <20210513075917.GX3425@dragon>
References: <20210428125807.29553-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428125807.29553-1-ykaukab@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 02:58:07PM +0200, Mian Yousaf Kaukab wrote:
> On LS2088A-RDB board, if the spi-fsl-dspi driver is built as module
> then its probe fails with the following warning:
> 
> [   10.471363] couldn't get idr
> [   10.471381] WARNING: CPU: 4 PID: 488 at drivers/spi/spi.c:2689 spi_register_controller+0x73c/0x8d0
> ...
> [   10.471651] fsl-dspi 2100000.spi: Problem registering DSPI ctlr
> [   10.471708] fsl-dspi: probe of 2100000.spi failed with error -16
> 
> Reason for the failure is that bus-num property is set for dspi node.
> However, bus-num property is not set for the qspi node. If probe for
> spi-fsl-qspi happens first then id 0 is dynamically allocated to it.
> Call to spi_register_controller() from spi-fsl-dspi driver then fails.
> Since commit 29d2daf2c33c ("spi: spi-fsl-dspi: Make bus-num property
> optional") bus-num property is optional. Remove bus-num property from
> dspi node to fix the issue.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>

Applied, thanks.
