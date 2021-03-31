Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F2934F684
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhCaCRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhCaCQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:16:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DAA361883;
        Wed, 31 Mar 2021 02:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617157009;
        bh=woXsgpNqVR7V3saS94lNNUyBUZsarlF1ceFey+N2++w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E5VLxSLsNDNa4+qh/w0vPDmZ34eW7Hj9nYdEewQiEGzBcyY1oQ+o1nUPKRABCbrcf
         KhFG+i27pmmHkw8YlfXehcMe3X1m6JJCxsfdbV6e0sp8CLiYE0rt8bwDf2KnddrIo9
         Lhu3vLfyYa65OMWJK0iX6fkUl/mQWcsarQI1sLSB3LVWxt52iFy84ggWFkv+9wDvCG
         UnCpod7UumokRKZ8Kn0nez7OSz+NJDfmBI4shgGk06Rz9NkTA2bRYneR3ORuxzz+n0
         IlV3dOVnkp+W5qf28FHJZXkxVvRhATxhdOPTq/Mf3pmN0X6OjsPmoUryRKxhpxWP5H
         BIxapKAaiihRA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1616469034-9691-1-git-send-email-dj0227@163.com>
References: <1616469034-9691-1-git-send-email-dj0227@163.com>
Subject: Re: [PATCH]  clk: imx: reference preceded by free
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Jian Dong <dongjian@yulong.com>
To:     Jian Dong <dj0227@163.com>, abel.vesa@nxp.com,
        mturquette@baylibre.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Date:   Tue, 30 Mar 2021 19:16:48 -0700
Message-ID: <161715700800.2260335.7834636340431628632@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jian Dong (2021-03-22 20:10:34)
> From: Jian Dong <dongjian@yulong.com>
>=20
>  when register failed, clk will be freed, it will generate dangling point=
er
>  problem in later reference. it should return directly.
>=20
> Signed-off-by: Jian Dong <dongjian@yulong.com>
> ---

Any Fixes tag?
