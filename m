Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59033A19F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 23:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhCMW0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 17:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234872AbhCMW0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 17:26:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ED1964ECE;
        Sat, 13 Mar 2021 22:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615674399;
        bh=LnjlmYpZUcrfDAqVZXTwyRy3t5/zoJXv93X05JB6gE8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=grb0eISJKbPGlKE6nRTpFPY2X8Xu/HpUa2QPY5+FXQSEpmtaUehErYTp0sXeTgbtc
         n9NnF8DHqvqprWZnMC76C7OL5B7YWWCt4+5QczaUBeH1t1LfBouhXa1fgLU4YVE+9j
         P4IVvca/MjTxvQtyKNdmAAu45vIFhcGLTI5nyOFWKlN2vSOUKY68F96Ey1lpG2kYzr
         C9G37emwcsXP/UKeHWEToVdpfKhNowWAX7isckQACoAz4TOZ0ebPQTaVO79PsNq5Gp
         OqMlkpKw6wcx+JTzvQAwwg0a/0+7Z70JY+M5QLC4qtHNFUc7dKplKLlmfsILVCwCZX
         d6pcdXNpENV0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1615143128-6141-1-git-send-email-abel.vesa@nxp.com>
References: <1615143128-6141-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH] clk: Call clk_core_enable_lock variant when lock is needed
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Sat, 13 Mar 2021 14:26:37 -0800
Message-ID: <161567439796.1478170.2245148564092563344@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-03-07 10:52:08)
> Instead of locking explicitly every time, call the clk_core_enable_lock
> variant.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

This is done by=20

https://lore.kernel.org/r/20210305003334.575831-1-linux@rasmusvillemoes.dk
