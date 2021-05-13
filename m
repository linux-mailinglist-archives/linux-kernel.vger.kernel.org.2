Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA5A37F3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhEMHxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhEMHxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F34D613C1;
        Thu, 13 May 2021 07:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620892321;
        bh=ha2slVL2AsHNyn4zoXapi1HIJ0uyngwOu9tPz2ex8wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHGQeoqy10S5RTQzj3PhoQbIE5cSDhG/+Gwc8NfD1lh5zj4YVJiG7+c7O0ziBF3iZ
         i8L6G0pTT6QN/B5mSaILWEMhCPTxEElUqRV7lv2IhyajfyPWpz0zjZNyZCiAzx07ga
         hr20RxzEnLvxRekrhxoOBLWpGpOqcosiSvv18PCICEsGaBkaPzRuqXATB7G76egOjO
         rJRCHeGmC0UDvQ0U37SJHWMwWdjUxtFexFmwOAo9NS9/DhVHQCd+OoLLwrKCiAXR7l
         XakN3mlxtH4ojV71oOKVsmm4VmrCuE0GcQchcF3ZDqtdN3F/77y2H6/4Wg48DkzNXa
         hakUmF6Pjgp0A==
Date:   Thu, 13 May 2021 15:51:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1012a: enable PCIe on freeway board
Message-ID: <20210513075156.GV3425@dragon>
References: <20210426075211.30467-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426075211.30467-1-ykaukab@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 09:52:11AM +0200, Mian Yousaf Kaukab wrote:
> ls1012a-freeway board contains a M.2 2230 slot. Update the status of
> pcei1 node to okay so that the pcie controller can be probed.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>

Applied, thanks.
