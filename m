Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC733AA70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCOEck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhCOEcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:32:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59FD064E09;
        Mon, 15 Mar 2021 04:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615782752;
        bh=SzAcA90VMd5QVeYlFyZNSy2VN4Z/HMrClayKI6MMZ4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMYe3NUr65ge5GHeVxRuZUZxAS7+E24VUXfHlNkI9NI21Ga6iKu7nl4uHxRz1J7h4
         WsMNqTXxfAhDP01EEWPFtZ3qTV+7s5ZjRJOLTqFVjj6DhZamhcoedws3ySr/i49y+k
         84Jv9tTgHQDGT/+arasmro+I7Xu+L73F31NY+emm1aNndJV24G5T2XHTX8JV2tGSFF
         1PJA67z4jhl/olnRfCjN0FDnzdjtMdUmTEHYU2o80LTGq9zvPgPhCo0HQ0fhQ5GGt3
         kmkbu5QtWAoirLlebrlDo5EGdHGanE4gbecP5rDceKr4PLk+H3YAi2SuX79aT5VUAL
         DgHQzL1wSUYRQ==
Date:   Mon, 15 Mar 2021 12:32:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Greg Ungerer <gerg@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: ls: mark crypto engine dma coherent
Message-ID: <20210315043225.GD11246@dragon>
References: <20210307204737.12063-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210307204737.12063-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 10:47:34PM +0200, Horia Geantă wrote:
> This patch set adds "dma-coherent" property to the crypto node
> for NXP Layerscape platforms where the IP (CAAM) is configured
> HW-coherent.
> 
> Horia Geantă (3):
>   arm64: dts: ls1046a: mark crypto engine dma coherent
>   arm64: dts: ls1043a: mark crypto engine dma coherent
>   arm64: dts: ls1012a: mark crypto engine dma coherent

Applied all, thanks.
