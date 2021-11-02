Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8A4437D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhKBVbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhKBVbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:31:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABFF061053;
        Tue,  2 Nov 2021 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635888535;
        bh=DshmUyio/tKVX24PvxW598BqvEK6F1u1Hrk2U9OM5FM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SSl756+YUBchmrsquP7Dbl0x2VsmuMPIGhOu5eAZTm4Z7wkKHAaqidv1RO+4Qv/cN
         q1aCtPi5aykhnyw7MlQ+zdOsmhEJDgd8uZXxWCRoZhSF2xR0oOHigvTooqH6nJIPEN
         3khDoI7J3ChMCTBHyueuoP46AH3S7K0lgfkAmAgBKqFJXjKm7DHmw4cZCd1Zx0jKvS
         ZYYBg7jNP301ykTdkCdJ3TiCUC1vQFfjm0lrlqnS8LPX4m4XIKXHs7+XHSO7a4jTeV
         vJSimc9x5LMxO3mAA1mwNsHuJRtTaHeXqj2d98H/z3okxH/RTp8AuGXipvqcn6hXYL
         XxvZYvZqqQ9ZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210928095041.17116-1-luca@lucaceresoli.net>
References: <20210928095041.17116-1-luca@lucaceresoli.net>
Subject: Re: [PATCH] clk: vc5: Use i2c .probe_new
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-clk@vger.kernel.org
Date:   Tue, 02 Nov 2021 14:28:54 -0700
Message-ID: <163588853440.2993099.10286892148968503312@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Ceresoli (2021-09-28 02:50:41)
> The old .probe is "soon to be deprecated". Use the new, simpler form.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---

Applied to clk-next
