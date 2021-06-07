Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C900439DA15
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhFGKuD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Jun 2021 06:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhFGKuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:50:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC9C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 03:48:10 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lqCnh-0001Ov-12; Mon, 07 Jun 2021 12:48:09 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lqCng-0001vO-2S; Mon, 07 Jun 2021 12:48:08 +0200
Message-ID: <8b6d19f5e7a67469d9ea1d555ccac696c04dc26a.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: berlin: support module build
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 07 Jun 2021 12:48:07 +0200
In-Reply-To: <20210607181015.5b8d3711@xhacker.debian>
References: <20210607181015.5b8d3711@xhacker.debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-07 at 18:10 +0800, Jisheng Zhang wrote:
> Make reset-berlin driver to be tristate module, support to build as
> a module, this is useful for GKI.
> 
> Partially reverts commit ed4dba99cae8 ("reset: berlin: make it
> explicitly non-modular")
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> Since v1:
>  - Add default m if ARCH_BERLIN per Philipp's suggestion

Thank you, applied to reset/next.

regards
Philipp
