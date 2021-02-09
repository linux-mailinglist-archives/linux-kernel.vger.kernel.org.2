Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69796315C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhBJBcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234559AbhBIXUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:20:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A59FD64E3C;
        Tue,  9 Feb 2021 23:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612912754;
        bh=y7nuEnZmTSZuVNVT2pS7h6Vmk5WPZrAiVJLoZufmIT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kacfmR8tR439GZxqISOrrO8CfmtNRRrNUdFF76RwpdWLzytEzifPjXRSqvuMyWuA+
         qJzHLdE36jSBwFeLGZ3vv1+1akyDfsUj9l+AGwMHLSKLVvkgYiUiyKqPTvvqfsZptV
         0kd79vxJdbfR7PUjtipL/kmPqjqmsK19qK58ShJGgNzy8Mmth5dmjiSIEMganc7h7v
         RgEkMLN6AbycilQZvyLVmV4IKJCqkoOCN+MUhUqO6WmdSxW7IBByCKYOM/vBhPXpPf
         nXncZN7DGTw/ZXlZd3HrBPk5ZHS+UP7e9VnXMv1gv13HLfQ0pVZU43WRIyxmXhR7Dg
         U2S+sRBJl5KXQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kai Stuhlemmer <kai.stuhlemmer@ebee.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers: soc: atmel: fix type for same7
Date:   Wed, 10 Feb 2021 00:19:07 +0100
Message-Id: <161291272294.978640.9951247825022818611.b4-ty@arndb.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204154934.1880048-1-arnd@kernel.org>
References: <20210204154934.1880048-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On Thu, 4 Feb 2021 16:49:25 +0100, Arnd Bergmann wrote:
> A missing comma caused a build failure:
> 
> drivers/soc/atmel/soc.c:196:24: error: too few arguments provided to function-like macro invocation

Applied to arm/drivers, thanks!

[1/1] drivers: soc: atmel: fix type for same7
      commit: 7deff441f53cc148cbf18381bd252a754b0d7d4e

       Arnd
