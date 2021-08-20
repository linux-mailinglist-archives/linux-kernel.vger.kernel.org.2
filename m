Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766A43F29DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhHTKHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232244AbhHTKHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:07:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD9476024A;
        Fri, 20 Aug 2021 10:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629454024;
        bh=4wOWt2TLJnChpQZUoUnZ7pdN3g/0c/c11ETk2UqFr7w=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Z9iuAsW3c17hodu6Hgq6226o2iKkjrnDSLYW/eEIFf5COL+zNpvEOaf49CqrpDiMp
         2VtLuppafClyPPIzOHDdpOxerJxfrGOH0DncrlkR5dtR6Yd2Ki2g8+XklrDzt5snOt
         sAABGBYzV6REPEMdCg9yNSZ2vq23ArlwH2s0atAN0G0J9Q/WLpOclelAGDEpPSyW7W
         HUoSYTBIu6Zkw2IWj7XOqt7ZHe9+vRaILNXUDYrw7NW8VM1j38hegdj8zM3kHNy3aZ
         ivfRB1sb46h9nrBsIdVGD1h99d4LI5ZTLXQ/A31qv1hDldEejZgPyVpusnr6ksjEU0
         wGlW/8wThl4Cg==
References: <20210819154818.18334-1-lutovinova@ispras.ru>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Nadezda Lutovinova <lutovinova@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: dwc3: imx8mp: request irq after initializing dwc3
Date:   Fri, 20 Aug 2021 13:06:33 +0300
In-reply-to: <20210819154818.18334-1-lutovinova@ispras.ru>
Message-ID: <878s0wfn0c.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nadezda Lutovinova <lutovinova@ispras.ru> writes:

> If IRQ occurs between calling  devm_request_threaded_irq() and
> initializing dwc3_imx->dwc3, then null pointer dereference occurs
> since dwc3_imx->dwc3 is used in dwc3_imx8mp_interrupt().
>
> The patch puts registration of the interrupt handler after
> initializing of neccesery data.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
