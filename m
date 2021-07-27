Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97933D7E08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhG0Swr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhG0Swq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:52:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 834BC60FC2;
        Tue, 27 Jul 2021 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627411966;
        bh=pUjaDzhsKvtngJqX+fO9uS6w9yDBaA+2gMkNyDWgjyU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mecrAxgmI3gLfwHwEn0DpPVdu1I1DCLQbbkmC+7CqnYGTIX4Hmv+cyhUxt69Y6Npu
         g3r6sOmgN51yRIAfXonuLv3oosumn2JMIRVHMzbMMMTJ/VvuAYc7smhMsF2Bmg9EAG
         4TqfWan3tIP2AAA94Gn4VI8x9gJfBEqmMyxoFITzrOEiP98+KDUlX7xnJgmv6hCCH3
         j6ngqCx49cp9eEmxEMSNeG0AlxlCLf/GgwKaclxZt5vlyrvFwXwDQkmP8w3XMByp4L
         8La+XPZvmSgT17PM5QNCOHbBeafTnLCAb1WU6B5YBJ1R8y38FedA0IgenXGRaSInLX
         xoOhjjiPkZ/pQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210708211645.3621902-1-liambeguin@gmail.com>
References: <20210708211645.3621902-1-liambeguin@gmail.com>
Subject: Re: [PATCH 1/1] clk: lmk04832: drop redundant fallthrough statements
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Liam Beguin <liambeguin@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Liam Beguin <liambeguin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 27 Jul 2021 11:52:45 -0700
Message-ID: <162741196515.2368309.6774719322538411114@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liam Beguin (2021-07-08 14:16:45)
> When the body of a case statement is empty, it is well understood that
> it is intentional and explicit fallthrough statements are not required.
> Drop them.
>=20
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---

Applied to clk-next
