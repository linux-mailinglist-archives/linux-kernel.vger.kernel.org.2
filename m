Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597AF426351
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbhJHDuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231658AbhJHDt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1B8160FC3;
        Fri,  8 Oct 2021 03:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633664884;
        bh=UbaCa4xinuSzh8zJwgpxQpjmGmzbsKM2tJqtcsJ0WJ8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m8Mrr/vkY5SKBzTIneWKh5fczZuOwiFn1I0bhC/+zjrPfHFRrD3NwJQBB8K7AzH4k
         KQN+AeUaeiA6AJUg2BztMjLB5rTOJOxRgtTgUgJMmW831DcWBUoP6kKHrlDABy9qJP
         yqAcl9VQ6Zz0fs42QVdoSBHM7Slp+MQqwHCOvavVw/l9OjwV9wg8OqIAVVd4T8sfiN
         4p/pkbnwDG0RIjWxRtmx7Ec1QueBuJp6beUzie0paXNKwkwZL7gr3G7Q7tC+2stuWr
         Z588Qu8ao3aPypGsFlT1vNEMuZ73S6AixooScKKye3a21QBzFlEUmXIpddLXvsFxNr
         mIoR7S1S5xfjA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210913082633.110168-1-clement.leger@bootlin.com>
References: <20210913082633.110168-1-clement.leger@bootlin.com>
Subject: Re: [PATCH] clk: at91: check pmc node status before registering syscore ops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Thu, 07 Oct 2021 20:48:02 -0700
Message-ID: <163366488264.2041162.17217723256659455955@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cl=C3=A9ment L=C3=A9ger (2021-09-13 01:26:33)
> Currently, at91 pmc driver always register the syscore_ops whatever
> the status of the pmc node that has been found. When set as secure
> and disabled, the pmc should not be accessed or this will generate
> abort exceptions.
> To avoid this, add a check on node availability before registering
> the syscore operations.
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---

Applied to clk-next
