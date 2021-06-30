Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41393B8841
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhF3SVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhF3SVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:21:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC2C861159;
        Wed, 30 Jun 2021 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625077115;
        bh=k716vSAadTFPAw6m1tRKqa78k3IKWlFrre5nAMX7UdA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Y/hKntSLE5TI4906/U2vzFdLCRTQbzk/vWRznu2k+j45ON6XpwiU3x4AxsN33A5tb
         Rp3dVzD8Vs7Pb36uiQZo/q3H4lN7uyTxkcbOXSz/rNnVj2PtLRU+Q5qVrB7/bEPoOJ
         m9m0v74i2YLQPXliBCvVyqPaHnwg2tosh/eiPhZKwxJU8a822pA/tN/w9m8OwyJHbC
         NcT3cFZqahT7P+2tT9FY2BHlsn7syVST5NIzzWBakuH9ryPZtrhUBPuJxJhAnOvlks
         vfjK4iWyujIfrXKSV+QaP0UQPmnx9WlK4u28n3Xm5zxCUe5N/asuDv0jDJzq+krtck
         SrI4WO2lo5IpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210630020322.2555946-1-wanghai38@huawei.com>
References: <20210630020322.2555946-1-wanghai38@huawei.com>
Subject: Re: [PATCH -next] clk: lmk04832: fix return value check in lmk04832_probe()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Wang Hai <wanghai38@huawei.com>, lvb@xiphos.com,
        mturquette@baylibre.com
Date:   Wed, 30 Jun 2021 11:18:34 -0700
Message-ID: <162507711455.3331010.7831190546024557147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wang Hai (2021-06-29 19:03:22)
> In case of error, the function devm_kzalloc() and devm_kcalloc() return
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
>=20
> Fixes: 3bc61cfd6f4a ("clk: add support for the lmk04832")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---

Applied to clk-next
