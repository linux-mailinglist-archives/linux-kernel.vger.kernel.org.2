Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7F431A6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhBLVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231896AbhBLVS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:18:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C49B64E13;
        Fri, 12 Feb 2021 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613164699;
        bh=sbVaOXptDfCB2ICnb7v5VzzceTsROFEJ0igGDzKJ1q8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W0hx+Zi59Ajv4PAc9xIdc/O7MEI383oc3RJwuBTOWuHfHYaysc2jr+MIw8eXmHiyk
         Scao3FnVIF2vOqHPpoTAiMr59hTzS3/v5SYNAQMgmTkOsSTWebGcVjRvbLtu5ybrF8
         8LcbWi2UnQeUNPrAl7hJCVGJAzNk/p8pn1jpaP/+UFkXEKm5ab1aCm4upNCo63J8Eg
         JFjRXZm3W07y33gvk/yrNXy1W4/9B94cwbybqf2g+ab0Iry8eln01XBrXpwhl98Xj7
         pKjuqIh/QAHKDe77o9bS2xMS5AB/Cg1ibEMSK/5LZ0D8WsdwbKNAWN/yT/Spsvyygm
         FrD7SIIpxZsug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210212143059.478554-2-dinguyen@kernel.org>
References: <20210212143059.478554-1-dinguyen@kernel.org> <20210212143059.478554-2-dinguyen@kernel.org>
Subject: Re: [PATCHv2 2/2] clk: socfpga: agilex: add clock driver for eASIC N5X platform
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>
Date:   Fri, 12 Feb 2021 13:18:17 -0800
Message-ID: <161316469787.1254594.10308305640247596022@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2021-02-12 06:30:59)
> Add support for Intel's eASIC N5X platform. The clock manager driver for
> the N5X is very similar to the Agilex platform, we can re-use most of
> the Agilex clock driver.
>=20
> This patch makes the necessary changes for the driver to differentiate
> between the Agilex and the N5X platforms.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next
