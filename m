Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0207236C8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhD0Pca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:32:30 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:48545 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhD0Pc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:32:27 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9198422258;
        Tue, 27 Apr 2021 17:31:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619537501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHwDMyfzVmnvQzR1/tI/7RjBBvNQ6LnB9q7jyFx1J8o=;
        b=bPMQzAgHV12u+SCs3Mxl8E8oHZI3RoQzl+RRgr2mOo9HKzVavVV4yPN9BYY/eqYSYD4bUD
        u/RzqvBK7rdh865OI+axJGD6U1Q0iEJXNMO2lPF3ibTLxlIU3LLpr1zweQykHIOFIxzrDn
        iYpe26l96CrGpZKgZ/VF61Jg2D3AGqw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Apr 2021 17:31:41 +0200
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
In-Reply-To: <a1ec388def4febd9af6ef477245ef2d3@walle.cc>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
 <20210427101926.GA4605@sirena.org.uk>
 <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
 <e20b9c8a2715b5d091a8d1f37ba890b4@walle.cc>
 <20210427135703.GH4605@sirena.org.uk>
 <cc9a39f977c3765d1060ab1b0038bc79@walle.cc>
 <a1ec388def4febd9af6ef477245ef2d3@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1aa3a8716d2416f0cc127737dcff092a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-04-27 17:29, schrieb Michael Walle:

> freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts. The codec name is
This should read "CPU name" of course.

-michael
