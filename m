Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008D037F360
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhEMHHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231529AbhEMHGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBC3D611CC;
        Thu, 13 May 2021 07:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620889521;
        bh=bSUE6ueSKM3g2P3ZNMm+Qe0ylu0JauQOS+NjkK3bFHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiqQ1ABNF82i+HjfUdpNNZTvaX/d1KG3J1frzsbWXJOeIGGQf/PgIURjF/fgPWFhd
         grLoycQ6TscaHTCrSe38iXYXAtOUUGGNKHRFhW83x6tRxZ6i/iMlwYFfArIzQOWa19
         96nynLz4nwuDrRGSI8Vv3vEcrrB0Gq0kcv5NYbGMTsxXi1h67s5CEyNcAlwU6Ad9bG
         ccu7Iyh+lZen133DYYNiXQ8x5tpXu94HhNRVX313JNu7FOGUu9S1mbdh/zHCzJIZhi
         aLL8Md+3fs9J8vhSwuG+Lzu1hXbJoe0tR+n7p+CsDxw8/Q5npNpdlgM23cPelm97kL
         21bE4WAoNn7Ug==
Date:   Thu, 13 May 2021 15:05:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Configure the OLED display
 segment offset
Message-ID: <20210513070515.GO3425@dragon>
References: <1618326076-6869-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1618326076-6869-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 05:01:16PM +0200, Michal Vokáč wrote:
> The imx6dl-yapp4 platform uses a GE-LX012864FWPP3N0000 OLED display.
> The display consist of a 128x64 OLED panel and a SSD1305 controller.
> 
> The OLED panel resolution is 128x64 but the built-in controller default
> resolution is 132x64. To display properly a segment offset needs to be
> configured.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks.
