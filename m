Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B233C7F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhGNH1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238079AbhGNH1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0276D6115A;
        Wed, 14 Jul 2021 07:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626247479;
        bh=rO8XVaGSS1DadxXuGBb5br1rzFdP+6x8iugqqXiT9Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfyIe9aABp7AeFDh4AThjalSs96dP6YKYkGqFBGH2j7fkcbPjC43hG/5btfJjBrvi
         pkc3yTFlP0RZqqeRnzrDBDTnnauqMtehM0qfnt6KgYuZnfYwjfmsP7QfiVG4gehYZq
         e+Nhtq9klKm9x7m3RuIB8gN50boDRIBPVceFMiON/EMqTrTUvcElnFKYCo/Lz5/lw2
         bPGhDRL5AjfPwKX9+GCKVn2F0j2lsJP4r2bMLHks+gpBvEqW703XzQTtfzlxUMmP/4
         rQ5XzlggUC3dBbSqZw3qa8qO/RVrib0glR+Z7R1QSwdEKFFGjTPAsxzaWdo6WFi7O0
         y3HjZFyUa8SUQ==
Date:   Wed, 14 Jul 2021 15:24:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ciorneiioana@gmail.com>
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 0/3] arm64: dts: add PHY IRQs for the DPAA2 based RDB
 boards
Message-ID: <20210714072434.GD4419@dragon>
References: <20210615160337.1320644-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615160337.1320644-1-ciorneiioana@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:03:34PM +0300, Ioana Ciornei wrote:
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> Update the DTS PHY nodes to specify the IRQ lines for the PHYs found on
> the DPAA2 based RDB boards.
> 
> Ioana Ciornei (3):
>   arm64: dts: lx2160ardb: update PHY nodes with IRQ information
>   arm64: dts: ls2088ardb: update PHY nodes with IRQ information
>   arm64: dts: ls1088ardb: update PHY nodes with IRQ information

Applied all, thanks.
