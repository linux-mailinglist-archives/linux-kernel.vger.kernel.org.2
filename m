Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7943B6E21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhF2GNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2GNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:13:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E625661DC5;
        Tue, 29 Jun 2021 06:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624947052;
        bh=85E4bCz0J8Knq4WBqIa5jZgR0ZZ72QjNHf1hztwEL7w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HKq+Vng3Y0hOVbQHsxCFccyZjskJt6bwjLScg5wQHzID06iSvbHlJXIQAVe9lkCDH
         9nHYBkjahAgNHlOYZRJersnkiNUfGmUSmYV6HXbZMgb6/Awlb5CT0P4C9FihdneLAS
         Z8LatZpEuE59rQUoj/n/75YyJfareV1tDExBUfycbMq5MC/HbaA44xqcGsYSpWe0lN
         quoZ+dhnVdEb5qmhwSN4Zcn1Fj2KiWu9nWD8dYCaQIuxCEC+jt2Sebaip/WyMlV3GJ
         LhwRnMFmPhP0ebsR6wan6uHhCcdVrE25vvD2Hc6zaES6Vb2OvOcpQPG5e/ZmJHAhBo
         u1PvGsUKZzILg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210628070122.26217-5-rajan.vaja@xilinx.com>
References: <20210628070122.26217-1-rajan.vaja@xilinx.com> <20210628070122.26217-5-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v6 4/4] clk: zynqmp: Handle divider specific read only flag
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, kristo@kernel.org,
        lee.jones@linaro.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, quanyang.wang@windriver.com
Date:   Mon, 28 Jun 2021 23:10:50 -0700
Message-ID: <162494705066.2516444.12484471667064926730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2021-06-28 00:01:22)
> Add support for divider specific read only CCF flag
> (CLK_DIVIDER_READ_ONLY).
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next
