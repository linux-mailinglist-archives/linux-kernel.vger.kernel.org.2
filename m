Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DED4280CE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhJJL1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:27:30 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36462 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhJJL12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:27:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 54D03FB03;
        Sun, 10 Oct 2021 13:25:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tSDyrNOlMlRU; Sun, 10 Oct 2021 13:25:27 +0200 (CEST)
Date:   Sun, 10 Oct 2021 13:25:25 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Diederik de Haas <didi.debian@cknow.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Message-ID: <YWLNpbvxWp/81lXz@qwark.sigxcpu.org>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
 <4974503.Y8KB3sNASq@bagend>
 <61a82214-0de8-816f-ff63-3979b86343bf@perex.cz>
 <5069869.zQgEQKRxDW@bagend>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5069869.zQgEQKRxDW@bagend>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Oct 10, 2021 at 12:40:00PM +0200, Diederik de Haas wrote:
> On Sunday, 10 October 2021 10:40:09 CEST Jaroslav Kysela wrote:
> > > Unfortunately this change broke multichannel audio on my Rock64 device
> > > running Debian. My Rock64 is connected to my AVR (Pioneer SC-1224) via a
> > > HDMI cable.
> > This looks like an user space configuration problem.
> 
> I have placed ALSA card definitions (I think) from LibreELEC on my system from
> https://github.com/LibreELEC/LibreELEC.tv/tree/master/projects/Rockchip/
> filesystem/usr/share/alsa/cards

You likely have the paths wrong, see how `simple-card` ends up in the
config file path:

   https://github.com/alsa-project/alsa-ucm-conf/pull/102/files

Cheers,
 -- Guido

