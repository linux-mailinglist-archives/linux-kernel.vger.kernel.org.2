Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91343A4C82
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFLDuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLDuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:50:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A95A610CD;
        Sat, 12 Jun 2021 03:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623469692;
        bh=BgSc5eNV8LNoD06fOZfSS5WP12SPBxHqUYHSLdA9RBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l0W+VIrz6HKwGMrx9sivII7lLBAHX2QXoLXrN9j4nGPtDzHJKy8tUsXHodIt4BO2C
         ga0iMGb5388GnTSyye6nNJLlL75iEWVVd5s3iA+RWNblcHPHMkU2MxGWQoeFveLlm5
         hHzU3SpkVR5mfHcF05aSlBFmJ+S7rMhvVKzqsOqHbwlfx2BYaDXZytaTkyxVkoadMQ
         D7el2ygAbOKP6YtEHlLaO4JhcccWiA0MYaX4ZEeM6qMclBTpzzuosGymPXO4lRpLdF
         k+9c/43gKzTqL8TsIQmURfIcqJ1QpQvx97apuloqpN0iARaLvdRSONpmEZbJ2gSpyT
         S6CRA4feJIMmA==
Date:   Sat, 12 Jun 2021 11:48:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: add defines for i.MX8MN power domains
Message-ID: <20210612034805.GK29138@dragon>
References: <20210525010732.115562-1-aford173@gmail.com>
 <20210525010732.115562-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525010732.115562-2-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:07:28PM -0500, Adam Ford wrote:
> The i.MX8M Nano has a similar power domain controller to that of the
> mini, but it isn't fully compatible, so it needs a separate binding
> and power domain tables.
> 
> Add the bindings and tables.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks.
