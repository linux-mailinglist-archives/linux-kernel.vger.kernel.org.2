Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED03B6E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhF2GNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2GNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:13:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E10E61DA0;
        Tue, 29 Jun 2021 06:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624947040;
        bh=FiOojVeqhT2aDVxTyPd3pIlaGs0BHh1/Vd1BDITgIE8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZDG2B/XKmek7tPy3Bg2G4OSE1E3Ah+sFRDWiv0nWOwhhvKfeLolLfQl9L96bptTcE
         zfgsScAtjW40068qfzuuD6Bf9CU1ZZYTXHTLk10Wa53Uuz1J1Mzc1wimdfd4Xdy7tK
         EeW2bxNdHW74KF9CbaNpelseqAgoEl0z568R7snj8uSih5GKoCxYkaVf4bGvIN0HTq
         RF/ujDrKi6MRbmpAlcqJ7kAQdsyIyu9O1xgfOlsYH2DHLIjCyv77RA03hmOLsFtCz+
         xtMQ86zVnv7pAw8Ay1OXFDEKPXkeCORN2ZM0eOY7a1KB4ypyL1JVuZApag90p/eOze
         dy276L+fjOaFQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210628070122.26217-3-rajan.vaja@xilinx.com>
References: <20210628070122.26217-1-rajan.vaja@xilinx.com> <20210628070122.26217-3-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v6 2/4] clk: zynqmp: Use firmware specific divider clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, kristo@kernel.org,
        lee.jones@linaro.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, quanyang.wang@windriver.com
Date:   Mon, 28 Jun 2021 23:10:38 -0700
Message-ID: <162494703864.2516444.2673279664223350505@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2021-06-28 00:01:20)
> Use ZynqMP specific divider clock flags instead of using CCF flags.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next
