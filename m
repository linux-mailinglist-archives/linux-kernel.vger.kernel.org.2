Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB493A48D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFKSqL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Jun 2021 14:46:11 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53403 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFKSqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:46:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EF4E01BF207;
        Fri, 11 Jun 2021 18:43:50 +0000 (UTC)
Date:   Fri, 11 Jun 2021 20:43:25 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [GIT PULL 2/2] memory: pl353-smc for v5.14
Message-ID: <20210611204325.192ad206@xps13>
In-Reply-To: <20210611140659.61980-2-krzysztof.kozlowski@canonical.com>
References: <20210611140659.61980-1-krzysztof.kozlowski@canonical.com>
        <20210611140659.61980-2-krzysztof.kozlowski@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote on Fri,
11 Jun 2021 16:06:59 +0200:

> Hi,
> 
> Dedicated branch for pl353-smc driver changes.

Thanks for the branch, I'll include it and add the last NAND patches on
top of it.

Thanks,
Miquèl
