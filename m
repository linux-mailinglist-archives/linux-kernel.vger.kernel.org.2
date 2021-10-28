Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07AF43DBE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhJ1HYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:24:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:27502 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1HYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635405727;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kOBZjRlCxa2iH7iZrnGYd692rY43y4CmP/9XW3tcKfQ=;
    b=nP3fEgWu6xJnfqllIlADlnzTrnju370sDmyroJ3WIqU2bwe4TfndmT2MaBVLK0G0f4
    7R1NS8fhWimfE41KR1/x62xPwzVQSu8fyQhUi3VQXNSnmEyT4n20hqcB+RdEsqz17cH+
    lglEnTbshGHNhlL1etYfpt9DuGlN/t4Gm4k7LRaSwcEF3bnHjsVZEhbWX0YUjbOo1fPG
    suL6JDnR8yKTbXrg9GvyICJwVZGtngqjLA2ON5C8XUN98WPCbFZ7KiAKQwYR0tZHgfoF
    ZuQ0Uzunk2jqg2DmYh3D4UbkStZ+4EVKMwi+caZibCmgUfWuNgRdTqePJAHF2TFFiomR
    XaQw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrKw7/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.34.1 AUTH)
    with ESMTPSA id 207811x9S7M79PH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 28 Oct 2021 09:22:07 +0200 (CEST)
Date:   Thu, 28 Oct 2021 09:22:05 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v1 1/4] ASoC: codecs: tfa989x: Add switch to allow
 disabling amplifier
Message-ID: <YXpPnQ2YTo5ZdQnm@gerhold.net>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
 <20211024085840.1536438-2-vincent.knecht@mailoo.org>
 <YXaMVHo9drCIuD3u@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXaMVHo9drCIuD3u@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:52:04AM +0100, Mark Brown wrote:
> On Sun, Oct 24, 2021 at 10:58:37AM +0200, Vincent Knecht wrote:
> > From: Stephan Gerhold <stephan@gerhold.net>
> > 
> > In some configurations it may be necessary to explicitly disable
> > the amplifier with an ALSA mixer. An example for this is a stereo
> > setup with two TFA989X. If only one of them should be used (e.g.
> > to use it as an earpiece) the other one must be explicitly disabled.
> > 
> > Add a virtual "Amp Switch" to implement that. There is no register
> > for this (SND_SOC_NOPM) so it only prevents DAPM from activating
> > the amplifier. Also it is inverted (= enabled by default) for
> > compatibility with devices that do not need this functionality.
> 
> Why can you not use a standard pin switch on the speaker output for
> this?

Thanks for the suggestion! For some reason I was not aware of the pin
switch mechanism... :) We have tried this and it seems to work fine.
I will submit a separate series to allow setting up the pin switches
for the qcom sound cards instead.

The other patches in this series are independent of this one and still
apply cleanly for me. Can you just ignore PATCH 1/4 or would you prefer
a resend without this patch?

Thanks,
Stephan
