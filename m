Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E143B6E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhF2GNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2GNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:13:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A249761DC5;
        Tue, 29 Jun 2021 06:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624947045;
        bh=4vWroYLOAfeFgToGVKsNjogg9cgdVR+LSZ4k73m4X7U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AdJdRjJi1xUvUV4fWmE59NrX+dtkpd+RfDTDcPmTscunbumLrvvoHlokJizP4Z6JL
         YU+2VgUqe7R/yHu+YvZS0VsNUGfDnUth7kiqulIcMwjBK0uw/EcqFjXHYBktxFCEVO
         SIYmLu035TMBINxl+IGPJBtkSWvs826ow37p9Ucrp1CDn3NL0EHXa+FXFSRyffgb/Z
         lBb0zVOAacN2OYhU+C6oXCn3zAUR8/Z+cMo6JYSqrxD0Jks+9cD/UkNAsfz1LdBWu1
         UYHtPSH4FzSFII/ul/brXtwnsbHD9ul5honIR6Hno5riptHH8ZkMnxPt/ukO2NafX+
         nyYXizEYQseUA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210628070122.26217-4-rajan.vaja@xilinx.com>
References: <20210628070122.26217-1-rajan.vaja@xilinx.com> <20210628070122.26217-4-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v6 3/4] clk: zynqmp: Use firmware specific mux clock flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, kristo@kernel.org,
        lee.jones@linaro.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, quanyang.wang@windriver.com
Date:   Mon, 28 Jun 2021 23:10:44 -0700
Message-ID: <162494704445.2516444.3705660787035671682@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2021-06-28 00:01:21)
> Use ZynqMP specific mux clock flags instead of using CCF flags.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next
