Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC1534C186
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhC2Bzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhC2Bzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:55:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBB2C6190A;
        Mon, 29 Mar 2021 01:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616982949;
        bh=/AwWsGoOloZLh4zqcebtzUjE3cMNGLn18h8cxTN7pIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYaixmelc3TyQwkymMzAa6nBKJk4AKqoz4RUDM8PjJziUzE99a2RBgjn4pdiLhl56
         R6gvSXyKo7hlNn11DZCoyVKwVNBQgDAyiR5GrNgovtTCy47XJvHSEHBdPibFPzVObL
         PtYok27UkvOmxUjQ6EtuWW7Bdg/39f5ArjKb1fJZ00CJmyEQ2qwhxBtO6cMMlp9u1I
         UaDdIaPvSH/X8UmdcNjgZ0DZerXpwzYWiqsuMTILNPvW8gPZzRqAyFQuWLmUU6gPD9
         I4jtZ1E6zimZNTJS9AGKnoJZ4DJud3vRsrrXZ65ynf5F87EOcqvttTGlcCP5Gg+5kF
         BLWH6M0f2WvBQ==
Date:   Mon, 29 Mar 2021 09:55:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ls1028a: move rtc alias to individual
 boards
Message-ID: <20210329015543.GM22955@dragon>
References: <20210323150757.3771-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323150757.3771-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:07:56PM +0100, Michael Walle wrote:
> The aliases are board-specific and shouldn't be included in the common
> SoC dtsi. Move them over to the boards.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied both, thanks.
