Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA451395713
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhEaIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhEaIiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:38:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6F96610C9;
        Mon, 31 May 2021 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622450192;
        bh=8UWXaEsN34Y+xxspiLKY6aJsw9CfGWSVExwJO+Go8HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVoripSAeT2V5ux+kgOG7X6XXGTj8s4FkTFvymEXl549qJVWB2MTfh96YHGuKC7St
         R8g1NSZXDf7j4wtA2r2h31r5i0zwRCYlQGvTnejANMo+RC9QNwacRpmyij9Ixwazwd
         Vfdr54io+j1FYz/aF8mYlvoNRPSgIiv7NaFOvbfzcbYBsFrsEpyIaWYZoeD6V2L2yk
         nP2qhdlMn0pxSum3CEyzDQORO55iAH7PstMiuKqjq1myeTE0qsQJnqzX1Y2xJrj5ZQ
         veXN1lBVLo5UedKZ7uF2cVAzn+1qCORww4XOIf9R+IV7RH2Pd3fziMttNojJLiJoZE
         4ed+4qS/qISWQ==
Date:   Mon, 31 May 2021 14:06:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] phy: phy-twl4030-usb: use DEVICE_ATTR_RO macro
Message-ID: <YLSgDJ38DtPbmEbh@vkoul-mobl.Dlink>
References: <20210520135132.37628-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520135132.37628-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-21, 21:51, YueHaibing wrote:
> Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
> which makes the code a bit shorter and easier to read.

Applied, thanks

-- 
~Vinod
