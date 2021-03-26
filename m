Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD11A34AE60
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhCZSPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhCZSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:15:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E55BB61A13;
        Fri, 26 Mar 2021 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616782512;
        bh=cOwjKFihwNyzd/rL9hUIKI33ht4GDyKw5r3WQgJxBeA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XPQDdwTNJgagJuhIeX585ooityFTGw1a4eCbfYH43P+1vYZ7t9/AMqZ4WkSLivDPI
         grIzP4k+bMMOGmn6znQHhMgmj/Un3Dn/nvWS+SscKCrmAFN4bB71A7tOp0wsMXhbvX
         8cDUZcvtu3afnq3bKAauD+3XKL8dyHnlzy6cxOBnZuSgU3/euv9q28OM6ALXqgKZot
         Vv/Lsk/7oJso8f6mhhFbD7XIkxSCpaE89jeso1amSaFTHrS+4f8IilxxJTLNadyMlh
         8l0U63QHuPWrgiERE6tOlQrxcuumRwrT4ma3Sfv8E3KboxmbJTcQiUoZTsPF9BFk/K
         K+WpGjo5RlosQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210326132844.33360-1-cristian.marussi@arm.com>
References: <161671733901.3012082.11186673559577220910@swboyd.mtv.corp.google.com> <20210326132844.33360-1-cristian.marussi@arm.com>
Subject: Re: [PATCH v8 18/38] clk: scmi: port driver to the new scmi_clk_proto_ops interface
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Michael Turquette <mturquette@baylibre.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Mar 2021 11:15:10 -0700
Message-ID: <161678251046.3012082.13459948209535858173@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Marussi (2021-03-26 06:28:44)
> Port driver to the new SCMI Clock interface based on protocol handles
> and common devm_get_ops().
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
