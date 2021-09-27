Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18656419902
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhI0Qjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:39:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34132 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235467AbhI0Qjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4sxfiBgqp/uQp2XeZa3d9lQieCGZPBbVDDYzLPHHaPs=; b=0REYNa9EsKmF3Nk7hg5iDxu4JB
        ROMORqYCMrTlqGlxv6Jx6a6B/3p3bAYTP1t22ZrlkTzAE3y2yP/+II8IBlOdu/1LCOjH8Fzwonc9x
        uUttASvjml3qZ6V8+92cvNk/HmSFWznzuf4qat3tY4dpPltNQHOqCkJQaSnXW/i3Z/74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mUtdT-008T1L-FZ; Mon, 27 Sep 2021 18:37:47 +0200
Date:   Mon, 27 Sep 2021 18:37:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: marvell: espressobin-ultra: enable UART
 output by default
Message-ID: <YVHzW/+hjn5uVqeh@lunn.ch>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927154159.2168500-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 05:41:56PM +0200, Robert Marko wrote:
> Since Espressobin Ultra board has a microUSB port
> with the onboard USB to UART connected to it to be
> used as a debug UART it makes no sense to require
> the bootloader to pass console args to the kernel in
> order to get console working.
> 
> So, use the "stdout-path" property to enable the UART
> output on the microUSB port by default.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
