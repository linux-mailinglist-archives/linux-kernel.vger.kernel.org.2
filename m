Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6573140AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhBHUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236249AbhBHT1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:27:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9567364E85;
        Mon,  8 Feb 2021 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612812434;
        bh=lQzNDGvScztY3AioxUvdDXqZgv85hKfFs5OO+tKskOQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DBqfmZVP97d47yn6vrx2fKMYayA8lKLc9UXgNm6LHPiaM3AQqPMM7ExxaCfgO3RBH
         PjfFWvcgvMa6d+TbBzFzWdLxq6pCw9ibotLXOinwBnZZE1HTqcVpRdL97UK+qFwQyU
         m+1an9pvMdQHDl0D/O7XWrrvU5zEmqsPFJgiDaMxA/pUYAzjWwp0uwCi6ptQLA3tts
         l/umJd0gwC7s7I2nQLQATCTvRwD4vAsLAJyGPvpEYv1+mqVf+woBRDQfe3GIHJWvuy
         PXfLWRqaz17qdzV61b3Yb3n1uf+EGJGR+kSwPpezTBE1w2UONyBxea6XoMbMVL0DGt
         WK3SJxM/h9g+A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1610542388-12078-1-git-send-email-abel.vesa@nxp.com>
References: <1610542388-12078-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH] MAINTAINERS: Add section for NXP i.MX clock drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Mon, 08 Feb 2021 11:27:13 -0800
Message-ID: <161281243302.76967.13559736813671271895@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-01-13 04:53:08)
> Add a section for NXP i.MX clock drivers and list myself
> as the maintainer.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next
