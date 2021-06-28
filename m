Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1193B5680
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhF1BNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhF1BNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:13:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A7C061469;
        Mon, 28 Jun 2021 01:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624842652;
        bh=0zt0soaf70nU9mbhOGtg7NdBHhO0vymgLqaXe7lbEi4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nutQHu+opCVnhFFQEqo69ydmISH9n6Pa42nycJW2YyvBiwxb/RaVFCD8Z4A3oBYmL
         mGOhRecsEm0OCwPbgKz0sxFrAJyWVnW0PLMC+zBNsrI3x/vdD665+4x1NCKuQ7jiZd
         LD+jIqbGBW4C8wc1Extud1hX9JpFgLqEs3gJTP1giOJJcoM6JR4iDnckB/pv2MHfef
         3izDraJVDuJLGBdEmI+Zs+RKJlXZT8EOSAWzWcVUOeUQdESRiAByJrlYpd995WwoNu
         3r2PRBdqnYb8oKDpi+Llj4dZUqskQDoo0NQUUUs6DHmFYNeLEVzXxwvq89Jnh1C1W6
         ikyeGmjuPW9Uw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210423004057.283926-2-liambeguin@gmail.com>
References: <20210423004057.283926-1-liambeguin@gmail.com> <20210423004057.283926-2-liambeguin@gmail.com>
Subject: Re: [PATCH v5 1/3] clk: add support for the lmk04832
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     julia.lawall@inria.fr, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
To:     liambeguin@gmail.com, mturquette@baylibre.com
Date:   Sun, 27 Jun 2021 18:10:51 -0700
Message-ID: <162484265104.3259633.12790193081105606165@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liam Beguin (2021-04-22 17:40:55)
> From: Liam Beguin <lvb@xiphos.com>
>=20
> The LMK04832 is an ultra-high performance clock conditioner with JEDEC
> JESD204B support and is also pin compatible with the LMK0482x family of
> devices.
>=20
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---

Applied to clk-next
