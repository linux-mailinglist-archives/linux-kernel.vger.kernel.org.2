Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1534D432B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 03:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhJSBcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 21:32:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45586 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJSBcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 21:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=P9eKgWwZT998ZHwrSl4En+On4TMrd3VT2wj4QRLHO4g=; b=PJl5j9JqBfvwIzguldRnXWyBkW
        QovUhV+iG3mKhEGUnKlXly6SI9S4aC7fli5i/gA1UqhDFImhHi5VUAZT2jbQTKh/d2nVhc8ch0i+o
        Fp13oGSSOT6116cNHcnsTIJ3sARAqenANEtIqTdDDY3iCLF1uVJ7lzEgtlwGxMb2mFJc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mcdwb-00B1fF-74; Tue, 19 Oct 2021 03:29:33 +0200
Date:   Tue, 19 Oct 2021 03:29:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB
 device tree
Message-ID: <YW4ffdCORksl1w2P@lunn.ch>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
 <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 02:12:11PM +1300, Chris Packham wrote:
> The CN9130-CRB boards have a MV88E6393X switch connected to eth0. Add
> the necessary dts nodes and properties for this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
