Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1CF41439F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhIVIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233349AbhIVIXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:23:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D7956113E;
        Wed, 22 Sep 2021 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632298930;
        bh=YVUE/IuRazROFam3Q6i3lQJsonfTlSmzIXXSeAHgj/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Evy01oEUF//CrZuYRNhQhinv6kvUEW2y8lCsInrv/LwFRk7JI74cuAxEmTh/fJga5
         QV2u/o5w7N+iDIKk0MtEnb7ZzcfHcIvt+KbPXjbaYrLs/J6wtxtUmq7FafZtMPnT54
         2TwOXm8uA7WMBcYhW7Svby1wLZlxq4pUiXrKrQLmzxPs/MIPQglcby0NksAkVl9Dj1
         gvUjUuJC3tyxBBVrhiGpW5jntXTGE6q2VxsT9wwOB/6JxalAzLerJbDgg0LLbLPjmN
         +YPCmNTIbK0Bhuk9WSuwjsp47hweiQfFlyUZOQOGe35CSZ2bWyRMBYKfGP+amShLxG
         +L6pNJl573tow==
Date:   Wed, 22 Sep 2021 16:22:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1012a: Add serial alias for ls1012a-rdb
Message-ID: <20210922082205.GI13480@dragon>
References: <20210909111229.2444950-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909111229.2444950-1-kuldeep.singh@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 04:42:29PM +0530, Kuldeep Singh wrote:
> U-boot atempts to read serial alias value for ls1012a-rdb but couldn't
> do so as it is not initialised and thus, FDT_ERR_NOTFOUND error is
> reported while booting linux.
> 
> Loading fdt from FIT Image at a0000000 ...
>    Description:  ls1012ardb-dtb
>      Type:         Flat Device Tree
>      Data Start:   0xab111474
>      Data Size:    11285 Bytes = 11 KiB
>      Architecture: AArch64
>      Load Address: 0x90000000
>    Loading fdt from 0xab111474 to 0x90000000
>    Booting using the fdt blob at 0x90000000
>    Uncompressing Kernel Image
>    Loading Device Tree to 000000008fffa000, end 000000008ffffc14 ... OK
> WARNING: fdt_fixup_stdout: could not read serial0 alias: FDT_ERR_NOTFOUND
> NOTICE:  RNG: INSTANTIATED
> 
> Starting kernel ...
> 
> Fix the above error by specifying serial value to duart.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>

Applied, thanks!
