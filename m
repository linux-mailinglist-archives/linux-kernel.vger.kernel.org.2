Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E603A5725
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFMIhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 04:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhFMIhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 04:37:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC0E2610A0;
        Sun, 13 Jun 2021 08:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623573318;
        bh=u+5RuXoIpdCPzSoPH35t+Q5SAfW+Qhc58p3O+tzvhgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVKlEj8rYrwCCFq/4XZLDESTM9Rx1wz1F3sS89Ch1gurR3mh1UkqiN51z0eyA1KeQ
         kOMujjfizroSAeZre6C6iJEiXPre8ZPhL1JexJTYJ8dEVGTpmUz7LMTZHtYiMoPxSV
         IhDPhYD4C4PhXHLbikofNwi+qYQXpWHOgZI9WwryH8kPxjHEvEYyaTy+VzKVZoUq3X
         y5ZhLYmvHCvrdkfoTih1FvuwQOygd/ETl+4OKy9BR7JWcVF+ERgHxsw9QDhVBVZrjj
         3Z6saNo/m5d6asGpUEMsrode+UbtIVyL6AaR273hJjGZexwWbx2q9qY2xkTjiW8Lm4
         akXMULgcSJ2ig==
Date:   Sun, 13 Jun 2021 16:35:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: dts: imx6dl-yapp4: Configure the OLED
 display segment offset
Message-ID: <20210613083512.GB29138@dragon>
References: <1620813314-30803-1-git-send-email-michal.vokac@ysoft.com>
 <20210523034952.GU8194@dragon>
 <9add872f-0c98-3c11-ea1f-5349f0f0bed2@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9add872f-0c98-3c11-ea1f-5349f0f0bed2@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 10:59:14AM +0200, Michal Vokáč wrote:
> On 23. 05. 21 5:49, Shawn Guo wrote:
> > On Wed, May 12, 2021 at 11:55:14AM +0200, Michal Vokáč wrote:
> > > The imx6dl-yapp4 platform uses a GE-LX012864FWPP3N0000 OLED display.
> > > The display consist of a 128x64 OLED panel and a SSD1305 controller.
> > > 
> > > The OLED panel resolution is 128x64 but the built-in controller default
> > > resolution is 132x64. To display properly a segment offset needs to be
> > > configured.
> > > 
> > > Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> > 
> > Why are you resending?  Please state reason when you resend.
> 
> I can't tell where but a while ago I read in some documentation
> that if you do not get any response for aprox. two weeks you
> can/should resend the patch in case it fell through the cracks.
> I sent these patches in the middle of April, four weeks ago,
> and have got no replies since then. So I [RESEND PATCH] these.

No.  You can send a ping if there is no response for 2~3 weeks but not
RESEND.  RESEND is normally used to refresh aged patches that needs to
be rebased to the latest release, or to make some minor update that
doesn't deserve a new version, like error in commit log etc.

> 
> I totally understand that you, and all maintainers and reviewers
> in general, are very busy so it may take a long time to reply.
> 
> AFAIK one does not need to state a reason for RESEND PATCH.
> The word RESEND itself should explain the reason. This is not v2,
> where I would of course describe what has changed.

No. Always state the reason for resending.  Maintainers do not know why
you are resending.

Shawn

> 
> Please correct me if my understanding of this part of the submitting
> process is incorrect.
> 
> Thank you,
> Michal
