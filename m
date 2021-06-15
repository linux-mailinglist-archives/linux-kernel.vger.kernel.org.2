Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DB3A8146
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhFONsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhFONsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:48:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC13761369;
        Tue, 15 Jun 2021 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623764767;
        bh=/+gmgKcGaUl2w2pHI0RFsnXNGdAV3gE2Fa42rbSgcAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2xoiRqX+DJ/Hr27SKsx9hbbHh814udQK1z3qctXfLGvFMsnDN150/opaDqR4JBiU
         ucSKrU3q8epgf14UAW8anxxwHv4F20xYO3bTrWdfjSBZtNWsa6akMaN1tupRLOdhah
         m1fI0L3LdDRQrEmthipACK4K7+ev2Y/hBPuz9lRw=
Date:   Tue, 15 Jun 2021 15:46:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuwen Ng <yuwen.ng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 00/23] Add support gadget (runtime) PM
Message-ID: <YMivHG2hwqFZLj6/@kroah.com>
References: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623139069-8173-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:57:26PM +0800, Chunfeng Yun wrote:
> This series mainly adds support for gadget suspend/resume when the controller
> works at device only mode or dual role mode, and also adds support runtime PM,
> in order to fix the sequence issue about resume and role switch event arised
> by extcon or role-switch, rebuild and unify the flow of dual role switch for
> all three supported ways.

I've applied patches 5-13 here, as they did not mess with the DT stuff.

I will have to wait for the DT developers to review the yaml changes
before I can take the rest.

thanks,

greg k-h
