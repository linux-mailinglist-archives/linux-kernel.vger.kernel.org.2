Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40423C7F42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbhGNHWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238139AbhGNHWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:22:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C20C3613B2;
        Wed, 14 Jul 2021 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626247164;
        bh=CYQk9xZNIgFk/5wW7NQ9Nf7e+pn0tCgRscirqolRy8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXpp2iLicQ9E3iiuitNF60d0UHLYApkCymiExJfRKXmlQGsrO4GbRr61Y63gaaP6F
         mZVTDH/xOXYn0QJoBiy1dLroCLL3oNC7fBg6U9YdVdL6TgvKM6Pfyd4qLvAdvm6dV+
         iqItdxsGfTIWgo7enBSyPLdZZm6oIGJQuav74KEVH0lOFbqW4yRxGklKTe5zAHG3Dm
         SNd/BVI1pt98AFw6Iq2XJ3I1P/SaHa9UQxadpsk5/eW7qW0bXqJDKSci3CNml1+RQ1
         x0ZIxY/7z0hKL3hr6O3ks4zVyKA7t2wsY/LtU84Yi2XNDR4LQGpKSN04FUh2cmauug
         d7hohD7TG/mmQ==
Date:   Wed, 14 Jul 2021 15:19:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [PATCH -next v2 0/2] ARM: imx: free resources
Message-ID: <20210714071919.GB4419@dragon>
References: <20210615125239.1348845-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615125239.1348845-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 08:52:37PM +0800, Yang Yingliang wrote:
> mmdc_base need be unmapped and mmdc_ipg_clk need be disable and unprepared
> in remove and error path.
> 
> v2:
>   hold mmdc_base in structure and free the resources on error path.
> 
> Yang Yingliang (2):
>   ARM: imx: add missing iounmap()
>   ARM: imx: add missing clk_disable_unprepare()

Applied both, thanks.
