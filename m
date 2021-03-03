Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DAE32BE94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385865AbhCCRcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347609AbhCCNwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:52:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BA5D64E87;
        Wed,  3 Mar 2021 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614779492;
        bh=Q0Vb2SGnrSs8HgbmqfhAgb/e3kTO5iqQWJd83jG7GKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDHyw9mpt9xMBd3eXnAIV2qIKJuFw/0UJSvBvgmZ/jigvps/9P23uuBizJceAQqmt
         SZzEmUnP5XaDXCtf+nDUr0p8I4N5zveXpTe0jDUYVOhajEjGfQtEC3S5EEebgwWU4w
         aHCx1APq0Pg3Qla5T6d/CtSBkgXJBdsLWe485lnQ72awBFIv/+UTne1Zl1NxGHfhqo
         xG0uxl14NtthXh5J+AFmhiUckAL8SWK3jsS0YUu8k3kbtg8xU6xoqb4pc+L8LwddXz
         NPEQDoNbM1EGnMz2071RIqa0xZHK8i4L3FLZQ4+YJHWasNHioUupr4Q7mbFtLbu9V2
         0pOmBMWLH5+GQ==
Date:   Wed, 3 Mar 2021 21:51:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        yukuai3@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] arch: arm: mach-imx: Fix a spelling in the file pm-imx5.c
Message-ID: <20210303135126.GM15865@dragon>
References: <20210205083831.339095-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205083831.339095-1-unixbhaskar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:08:31PM +0530, Bhaskar Chowdhury wrote:
> 
> s/confgiured/configured/
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Applied, thanks.
