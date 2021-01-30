Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D85309552
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 14:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhA3NZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 08:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhA3NZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 08:25:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DADB764E05;
        Sat, 30 Jan 2021 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612013062;
        bh=rcVz3odlRQxvQVQDt+9gbC1th3nxcGUpxsJgHDut048=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KDdugzK9W9KR/fcOS7nXjpQfhSXzs0405o+HkgarDWKnAY0+zIt6ozo0ya/EE/pvr
         JnfIhI98VXNwViOQAdyofluqJ0EhU/N4uefEUd8ITSIUAU2DqpQZjqzdqQBcJqt81e
         epbKlsYm1V3DuB/6zm97AWDuNgxfWcowycBZLt5gXOsWePItrXcUcLm6oRq/gRraqQ
         rMYE6cCaVMtz7w1z0HjKh5LrOZvF4mpq0lVAHf3fVbjt1jGS/SPdIddXsulPEFthPG
         wMMlaZ2Ua7CX5iPkoIyegTUzLKOVZHUKBBQRwEJM9sdnALpP3K0WygloLTAbCV0MPr
         P4q0h5U5rdkkA==
Date:   Sat, 30 Jan 2021 21:24:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>
Subject: Re: [Patch v2 0/3] Enable flexcan support in LS1028A/LX2160A
Message-ID: <20210130132417.GH907@dragon>
References: <1611226659-30129-1-git-send-email-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611226659-30129-1-git-send-email-kuldeep.singh@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 04:27:36PM +0530, Kuldeep Singh wrote:
> This patch set adds device-tree support for LX2160A-RDB/QDS.
> 
> Also, update flexcan entry for LS1028A and enable support further for 
> LS1028A-RDB/QDS.
> 
> Patch1: Add dtsi and dts properties for LX2160A
> Patch2: Update dtsi properties for LS1028A
> Patch3: Add dts properties for LS1028A.
> 
> Changes since v1:
> -Use clockgen constants instead of numeric numbers
> 
> Kuldeep Singh (3):
>   arm64: dts: lx2160a: Add flexcan support
>   arm64: dtsi: ls1028a: Update flexcan properties
>   arm64: dts: ls1028a: Enable flexcan support for LS1028A-RDB/QDS

Applied all, thanks.
