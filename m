Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF9832DE5C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhCEAgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhCEAgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:36:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A07D965012;
        Fri,  5 Mar 2021 00:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614904560;
        bh=QahLWcayjeOiRUW3v4DB9LFDRrJlGBEW+fmSDFtQRJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDgESxh3pPujVLaec0g5T7ZoVok0qWQMFBwLUXrDL5DzknLQ+orjNAs+7uvmospRs
         DsZuZktnRzROZvvchvy8dBiQUaLOk7R7KMuTSG0dX+6G8AgOuZ80QAwuohZaCYmT/l
         9pI2Y48TelCVyFuNscRG56kbNbEd6JPgQix0HpTJmtBThVF0ULUkSLXfbE2QMog9CY
         I9R72Xe1G/oPd0UUVu0PDmRWWOlWbSxxuZc1/a/pGdMBPsL3z+EZzzjtk72hXuCwto
         tZ5y0Qs3vq4109QJHgRQ0yWMUU5YMcLB7DxzeTcqZsy+EQpaMeeEYt8MQT2ijS+mBD
         e7zAm6O3gM0Tw==
Date:   Fri, 5 Mar 2021 08:35:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: add interrupt to Root Complex Event
 Collector
Message-ID: <20210305003554.GS15865@dragon>
References: <20210209005259.29725-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209005259.29725-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:52:59AM +0100, Michael Walle wrote:
> The legacy interrupt INT_A is hardwired to the event collector. RCEC is
> bascially supported starting with v5.11. Having a correct interrupt, will
> make RCEC at least probe correctly.
> 
> There are still issues with how RCEC is implemented in the RCiEP on the
> LS1028A. RCEC will report an error, but it cannot find the correct
> subdevice.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
