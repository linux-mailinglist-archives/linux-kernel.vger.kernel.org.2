Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C1942635C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242902AbhJHD45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhJHD44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB89A61029;
        Fri,  8 Oct 2021 03:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633665302;
        bh=+EkkyjIhhqO+XutX6zzNrU0Eff4K8Tbaj4u19XXVsiQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Idwi3LvJeSjU7ELXSISq8Sza5y0QESpnSZIXHz1WbYa1R8OQ7Um0WwXGdpreY1f3d
         4c5KVWT+PjioddlkEg9A6NLxxA5mqLbGDoynVUs0/w5VKiMYY6X7wRt0TD5o/egA/j
         qA71tmgVTuZP+shjsMbtYgxR0E4iF/mPTTdW2eek2NVJJXFx0rg7CS6b29cwDwyHYQ
         uZpj85r8KUX40yz/T1Hv2V9AZYXdco6WF3n3o0j8KlVDncTkaZE0jFDnfaRlyA/t7a
         RdkllffXA+sP4XaRRnDkjJMHdE5rY6lNWfvhYWIYr3CnyGVXq6+eScNdSdrxcQ3+bM
         +CXo9HJ+GHznQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210923132046.1860549-18-claudiu.beznea@microchip.com>
References: <20210923132046.1860549-1-claudiu.beznea@microchip.com> <20210923132046.1860549-18-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 17/17] clk: do not initialize ret
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Thu, 07 Oct 2021 20:55:00 -0700
Message-ID: <163366530066.2041162.4430484541692921674@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2021-09-23 06:20:46)
> There is no need to initialize ret.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Same comment. Feel free to send them separately.

>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
