Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778193193EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhBKUGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:06:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhBKT6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:58:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DADE64E15;
        Thu, 11 Feb 2021 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073464;
        bh=alzHTEZhm9pjacHcNPbW8z+uwYbdZPt+3CVqs65827Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FBbs5OQwreZ89QJJozNwA0mFPVb+rtUFjyjD/fmqXnwDg6wrkCHEF78mQUquef098
         1P80FvAe0BmgUVqrhYu5+OxH5EUr5dDqN+2XO/ELRQB8ed2MJUrfC6KL7iV3HJt4CF
         nLVcLkLeHCMx6u850nuqwpIRalCaHhzXucm60rGZ6WbeRccOfO0AQpfrzSlnVqJg87
         6ImfyuFgPeTcOtcT5SZ/nklIjfNG1e+1neCyonRn8VOSMO0K7dEzGutF8ZjxUqJaXi
         V5pJRboOUz9MfNtn/xP1llKmyUbA+fb2Rcn0C5yiNFSEdJGFr1hZEI03d3j8rYwrYB
         61qghzsig5ezQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126124540.3320214-18-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org> <20210126124540.3320214-18-lee.jones@linaro.org>
Subject: Re: [PATCH 17/21] clk: clk-xgene: Add description for 'mask' and fix formatting for 'flags'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Loc Ho <lho@apm.com>, linux-clk@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:57:43 -0800
Message-ID: <161307346327.1254594.2993346380128159554@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-26 04:45:36)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/clk-xgene.c:229: warning: Function parameter or member 'mask=
' not described in 'xgene_clk_pmd'
>  drivers/clk/clk-xgene.c:229: warning: Function parameter or member 'flag=
s' not described in 'xgene_clk_pmd'
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Loc Ho <lho@apm.com>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
