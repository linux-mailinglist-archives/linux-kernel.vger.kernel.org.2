Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7991731940F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhBKUMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhBKUKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:10:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A58CF64E45;
        Thu, 11 Feb 2021 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613074207;
        bh=sHtepH+R1YJaC4C7qg+oeaTiGycr5+oS58XbG63uUw0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QRfwpVHBsv/5cIYpcINlKly3QyoUSsCHyYygwGZ8T8vqSjXC2vKnH+uPsJZ5cMydj
         VPDtJ/UXZpqctIE7QUZ0VW4Syc/ZTR38E0hLkSYXHXl/8Yn1zBCtbR0JgD1Boi5khN
         V6H/8r8S7ucqKU55UgFQ9NtrXCYFN9iVLVF7Zhx5Uq0MnejZeiPVrQvlvZDvXHwVgX
         f5rWJy482FQKInSUxpydj1C5Ch792bKxejvFyGAM0bl0K/MHFTZPLZrTKOJyfoUESB
         pvfX+vWo32crntQy0YFmkHSPQ6mfIsh0qnQDj7mAIDRxtFOi4p+LgM05cIPTUF+8up
         03S64LDOhFidg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210207185140.3653350-2-aford173@gmail.com>
References: <20210207185140.3653350-1-aford173@gmail.com> <20210207185140.3653350-2-aford173@gmail.com>
Subject: Re: [PATCH V3 2/2] clk: vc5: Add support for optional load capacitance
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Thu, 11 Feb 2021 12:10:06 -0800
Message-ID: <161307420631.1254594.8104869204365867750@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2021-02-07 10:51:39)
> There are two registers which can set the load capacitance for
> XTAL1 and XTAL2. These are optional registers when using an
> external crystal.  Parse the device tree and set the
> corresponding registers accordingly.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---

Applied to clk-next
