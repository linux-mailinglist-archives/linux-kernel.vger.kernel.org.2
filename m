Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DA5357888
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 01:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhDGX3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 19:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDGX3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 19:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95A7C61246;
        Wed,  7 Apr 2021 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617838183;
        bh=cJogNOH2U7LRtGhANiNxmCvrETxMdec2vVMiimauulc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Om8sBkAW3b18eJq6jaEI7NfnbGqjmmXMqAzPz21ONqkPdUE0dC98J7ArDA93hP7Hr
         Qki2qFxvgtxnaJFFt3gjYW6OcTH1U4BoRgiy68rsR/ckku97PDRplQCatQH9I1UEAK
         ILeffM+iOPo3bybhsUdiWU9s5kLZKs06b6+Mhvwm+wEfToOc/HimtMY2PScvWvX8zf
         RRJqcdvRiyfAFAMMI31maVZel1h6QrrhgH70Kfdv2VugiGyJdaAMI9jD1sYMN7iTN1
         KIIF9HT7qwReV+Dst2/70IUNdhlpNnqCQVolP3Hgg5vY8I0SNMPtkpIMQ0pGqzQf1x
         j8E2HfaW6S1rQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210406170115.430990-1-colin.king@canonical.com>
References: <20210406170115.430990-1-colin.king@canonical.com>
Subject: Re: [PATCH] clk: socfpga: arria10: Fix memory leak of socfpga_clk on error return
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Colin King <colin.king@canonical.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:29:42 -0700
Message-ID: <161783818236.3790633.17349674576901992073@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2021-04-06 10:01:15)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is an error return path that is not kfree'ing socfpga_clk leading
> to a memory leak. Fix this by adding in the missing kfree call.
>=20
> Addresses-Coverity: ("Resource leak")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next
