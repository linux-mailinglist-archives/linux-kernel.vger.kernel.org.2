Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6D38CCE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbhEUSHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238505AbhEUSHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:07:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15A51613CB;
        Fri, 21 May 2021 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621620375;
        bh=PGlP4iraJhEmtFARuI90AqejPX1/fQS9paNMLEY2w+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iz450FZH/5bpTdyYLCWpyUOLw72CFhgN2ndPP3/YgWcYOR8Jkfl95UxlVx/K+Av6g
         f5ijoFD/NawtnO+gJA2BAiHN2iZROdpHLjIyjMrHUXwB+/hR6E53cP3Qk/wowOSo+B
         a4bUrLbrIfYkcP4jIqjDPr38Ofe7e4S+HAie+dPE=
Date:   Fri, 21 May 2021 20:06:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 3/3] Revert "usb: common: usb-conn-gpio: Make VBUS
 supply optional"
Message-ID: <YKf2ldQhJCVbR3N8@kroah.com>
References: <1621406386-18838-1-git-send-email-chunfeng.yun@mediatek.com>
 <1621406386-18838-3-git-send-email-chunfeng.yun@mediatek.com>
 <YKezl0nlWFQhLyf/@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKezl0nlWFQhLyf/@orome.fritz.box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:20:23PM +0200, Thierry Reding wrote:
> On Wed, May 19, 2021 at 02:39:46PM +0800, Chunfeng Yun wrote:
> > Vbus is already an optional supply, if the vbus-supply is not
> > provided in DTS, will use a dummy regulator,
> 
> That statement is not entirely correct. The dummy regulator is
> substituted only if the supply is in fact not optional. The idea behind
> that is to allow DTS files that don't specify all required regulators to
> get away with it, based on the assumption that the supply is one of
> those always-on supplies that are often not described in DTS.
> 
> > the warning log is as below:
> > "supply vbus not found, using dummy regulator"
> 
> And the reason why we get that warning is to point out that the DTS has
> a bug and that it should be fixed (by adding a proper regulator to take
> the place of the dummy).
> 
> > This reverts commit 4ddf1ac79e5f082451cd549283d2eb7559ab6ca9.
> 
> But if you read the description of that commit, the purpose of that
> patch was in fact to make the supply completely optional in the case
> where we already have the VBUS supply specified for the USB port that
> the connector is parented to.
> 
> So in that case the DTS doesn't have the bug because the VBUS supply is
> already specified for the USB port and therefore it doesn't have to be
> specified in the USB connector again. In fact, specifying it twice can
> lead to a situation where the USB port may not be able to switch the
> VBUS supply on or off because the setting might conflict with that of
> the USB connector.
> 
> So unless there's a real reason why this is needed, I don't think this
> should be applied.

I've dropped this from my tree now, thanks.

greg k-h
