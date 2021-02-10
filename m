Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD77315CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhBJCKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234644AbhBJAy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:54:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFF2364E54;
        Wed, 10 Feb 2021 00:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612918457;
        bh=cW3qYYfH4q/8re3Ex8OZxsVP8E02KQVHm4+lDC21aFc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mOq0ULodlxWJ/tc1Xexx8Bpdz9hkfxT4OqQACU0MkAATQ37gmb8A5nlLJE1gUKjIi
         8gV2n9DPlvX1Arl/mu/pjZjMtHOn4pBxGpioMGbEGDd+EBvCtj3LYaYJcJD5jNlvjG
         bDvvOtDXHRtSw9nK/CLQGJ+viZcYSolcKUGZNljLWqRNPmhUDITX8erunLpCoJkO58
         uqovedqMurBfO0nk/+v8edgK6cthcT81Pwv4dNUaoytJmIbklhYL4lFIKbghNpgtNY
         Xg8TGS4uDUclqFHw4D7ePm4GU7XjzsosWmoxfyuq7jTpfDlGGdtXCS9CHdZySdpPUD
         HTQiULX9rOIww==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5bc4f5b7-5370-bdd5-143e-429c83447ce1@microchip.com>
References: <20210203154332.470587-1-tudor.ambarus@microchip.com> <5bc4f5b7-5370-bdd5-143e-429c83447ce1@microchip.com>
Subject: Re: [PATCH] clk: at91: Fix the declaration of the clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mirq-linux@rere.qmqm.pl, Claudiu.Beznea@microchip.com,
        a.fatoum@pengutronix.de, krzk@kernel.org,
        Codrin.Ciubotariu@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        Tudor.Ambarus@microchip.com, alexandre.belloni@bootlin.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, saravanak@google.com
Date:   Tue, 09 Feb 2021 16:54:15 -0800
Message-ID: <161291845517.418021.17378265940034341908@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tudor.Ambarus@microchip.com (2021-02-08 01:49:45)
> Hi, Michael, Stephen,
>=20
> Do you plan to take this patch for v5.12?
> If fw_devlink will remain set to ON for v5.12, some of our boards will
> no longer boot without this patch.

Is fw_devlink defaulted to on for v5.12?
