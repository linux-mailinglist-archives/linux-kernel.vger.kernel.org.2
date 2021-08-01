Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557943DCA4B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 08:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhHAGYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 02:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHAGYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:24:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E5A561054;
        Sun,  1 Aug 2021 06:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627799046;
        bh=ks/ukZ06hvygJCLIa2PTX+w6AXhvqSLQrTu660ebCaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSUOMYxeAibn4TUQS9HCIGYvDQudTCNbPPC0LcVGiCetalbb+XVeMTMXGop70IzFR
         pvuceJDU5XtEgRuVH8/L4V07fOfMqREq+XwG3f24HY4AAK/yDBWWdRL3sFGikpgFG+
         fAyN+32myMKyWuhI/sLFrRcYd+gYIbpX7v2yJ5HQ=
Date:   Sun, 1 Aug 2021 08:24:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] firewire: ohci: make reg_(read|write) unsigned
Message-ID: <YQY+BL4nR9Loddum@kroah.com>
References: <20210731104112.512449-1-jordy@pwning.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731104112.512449-1-jordy@pwning.systems>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 12:41:12PM +0200, Jordy Zomer wrote:
> The reg_(read|write) functions used to
> take a signed integer as an offset parameter.
> The callers of this function only pass an unsigned integer to it.
> Therefore to make it obviously safe, let's just make this an unsgined
> integer as this is used in pointer arithmetics.
> 
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> ---
>  drivers/firewire/ohci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Same thing should probably also be done in
drivers/firewire/init_ohci1394_dma.c for the same inline functions,
right?

Anyway, nice cleanup:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
