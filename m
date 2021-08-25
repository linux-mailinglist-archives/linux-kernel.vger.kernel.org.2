Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7F3F7B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbhHYReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:34:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41766 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhHYReL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=6Xzd/AZhGEUTldtwR/3mpDMdo0JtSuZfq2s/7VUNu5g=; b=Tp6vm8DQ3pXH/aMvAg7kgi7Qmb
        up/tvBoKJB85IMwCXdOBveejocdSSuHagFm4n3pupB/D0l7sOl3BuMzVZ1FgZoYS/M93FP9fV2Cbw
        5rfbZt/oNwZFzYpOAmFRQb1mFjrRppJXhU2KcoxD/kpdbxDXV1ytCN44dK62NVzN18Rk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mIwlx-003pjW-O3; Wed, 25 Aug 2021 19:33:09 +0200
Date:   Wed, 25 Aug 2021 19:33:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Turquette <mturquette@linaro.org>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: ehci-orion: Handle errors of clk_prepare_enable()
 in probe
Message-ID: <YSZ+1bFUEMsJlrcu@lunn.ch>
References: <20210825170902.11234-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825170902.11234-1-novikov@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 08:09:02PM +0300, Evgeny Novikov wrote:
> ehci_orion_drv_probe() did not account for possible errors of
> clk_prepare_enable()

Hi Evgeny

Your patch looks good.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

At the time this was added, clk_prepare_enable() could not actually
fail, the clocks are built in, there was no error path that could
trigger. I've no idea if this is still true, so please do have this
patch merged.

      Andrew
