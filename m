Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F37534AD3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCZRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:18:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51843 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZRSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:18:07 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4C22E2000A;
        Fri, 26 Mar 2021 17:18:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND 1/1] arch: arm: mach-at91: pm: Move prototypes to mutually included header
Date:   Fri, 26 Mar 2021 18:18:04 +0100
Message-Id: <161677907718.203839.17372873158505015568.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210303124149.3149511-1-lee.jones@linaro.org>
References: <20210303124149.3149511-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 12:41:49 +0000, Lee Jones wrote:
> Both the caller and the supplier's source file should have access to
> the include file containing the prototypes.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/pinctrl/pinctrl-at91.c:1637:6: warning: no previous prototype for ‘at91_pinctrl_gpio_suspend’ [-Wmissing-prototypes]
>  1637 | void at91_pinctrl_gpio_suspend(void)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/pinctrl/pinctrl-at91.c:1661:6: warning: no previous prototype for ‘at91_pinctrl_gpio_resume’ [-Wmissing-prototypes]
>  1661 | void at91_pinctrl_gpio_resume(void)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~

Applied, thanks!

[1/1] arch: arm: mach-at91: pm: Move prototypes to mutually included header
      commit: 10e9119e865047f4e22cbd69de991d6bc26c4faf

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
