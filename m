Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F1453FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhKQFMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhKQFMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:12:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D3F0610D1;
        Wed, 17 Nov 2021 05:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637125749;
        bh=BkYRzzXhDsou+pZnpTkWMs/gKIFRNcpK1JQNxoX5kaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWTdjEATmNY7c2bjPY9M0J028p1Hq2QYeTIfapV30kVaLZNI7Nh2RagWbpZwfqk8e
         J9NgFZ1LHV5PcWO+OnW+zK9g2rjyBuL+axGF8aPuFpbgqYqxj3P4XPldTbFlPChuaU
         3izJvMFC9brvffKLFuQMewK0z3jI5kePdRzL76KKDlPz5gUM5SCvU9TR/uSRhg55kV
         F3Q8R9kH7gVLMFvaUpFjzvHZ8heTL4rug1/vQJop3r+9I3RpkdgZ0IyUYQNvrqkcKk
         gfM+7mYZSSHoW+VPxQlTmZo0s3UNNdvM+s3o/BboafP8pR0ZW6J96dEZ9sMWxfmQrO
         TxwAU4jf7ppLA==
Date:   Wed, 17 Nov 2021 10:39:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anibal Limon <anibal.limon@linaro.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Robert Foss <robert.foss@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] lontium-lt9611: check a different register bit for HDMI
 sensing
Message-ID: <YZSOcBz+W9ORXf1z@matsya>
References: <20211117020724.2647769-1-pcc@google.com>
 <CA+_AqisE1yMvkPvRtp-8ZxMSpuwmfTrETkomfQHgSM-sEazuaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+_AqisE1yMvkPvRtp-8ZxMSpuwmfTrETkomfQHgSM-sEazuaQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-21, 22:49, Anibal Limon wrote:
> Dmitry,
> 
> May be this is the reason of my HP monitor not working in RB5.

Rb5 has Lt9611UXC


> 
> Regards,
> Anibal
> 
> El mar., 16 de noviembre de 2021 20:07, Peter Collingbourne <pcc@google.com>
> escribió:
> 
> > It has been observed that with certain monitors such as the HP Z27n,
> > the register 0x825e reads a value of 0x79 when the HDMI cable is
> > connected and 0x78 when it is disconnected, i.e. bit 0 appears
> > to correspond to the HDMI connection status and bit 2 is never
> > set. Therefore, change the driver to check bit 0 instead of bit 2.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link:
> > https://linux-review.googlesource.com/id/I7e76411127e1ce4988a3f6d0c8ba5f1c3d880c23
> > ---
> > N.B. I don't currently have easy access to a monitor that works
> > with the existing driver, so it would be great if people with
> > monitors that currently work could test this patch to make sure
> > that it doesn't introduce any regressions. Otherwise I will change
> > it to check both bits.
> >
> >  drivers/gpu/drm/bridge/lontium-lt9611.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c
> > b/drivers/gpu/drm/bridge/lontium-lt9611.c
> > index 29b1ce2140ab..71f1db802916 100644
> > --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> > @@ -586,7 +586,7 @@ lt9611_connector_detect(struct drm_connector
> > *connector, bool force)
> >         int connected = 0;
> >
> >         regmap_read(lt9611->regmap, 0x825e, &reg_val);
> > -       connected  = (reg_val & BIT(2));
> > +       connected  = (reg_val & BIT(0));
> >
> >         lt9611->status = connected ?  connector_status_connected :
> >                                 connector_status_disconnected;
> > @@ -926,7 +926,7 @@ static enum drm_connector_status
> > lt9611_bridge_detect(struct drm_bridge *bridge)
> >         int connected;
> >
> >         regmap_read(lt9611->regmap, 0x825e, &reg_val);
> > -       connected  = reg_val & BIT(2);
> > +       connected  = reg_val & BIT(0);
> >
> >         lt9611->status = connected ?  connector_status_connected :
> >                                 connector_status_disconnected;
> > --
> > 2.34.0.rc1.387.gb447b232ab-goog
> >
> >

-- 
~Vinod
