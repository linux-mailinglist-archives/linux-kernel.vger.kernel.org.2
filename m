Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9127833C3D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhCORNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbhCORNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:13:22 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6E0C06174A;
        Mon, 15 Mar 2021 10:13:22 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 343E022234;
        Mon, 15 Mar 2021 18:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615828400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WvXuiNr6/ZH9LeLj3FbJ4cXG+gnUdCJXUawyo6mrnF8=;
        b=FDedj9diIvD/llhNi5mdiIowvQEiqOlJyODlAvBfiNTOJY4AtjHMVm5PejQE7LXWxdaQ1w
        +qgXPv1Yllm/Mktd2tWNeVVy42rVvx8kreG52pzZq4uWZZ4u+bY2ol8GegZmiE28BlTzMd
        PWmUz3fRLEO4VhGrks7HEgmxtsyOnoU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 18:13:20 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, robh@kernel.org, sharadg@nvidia.com,
        thierry.reding@gmail.com
Subject: Re: [PATCH 1/3] ASoC: simple-card-utils: Fix device module clock
In-Reply-To: <3b3c5aea-60bc-d7bd-9ae6-5e890782b2e8@nvidia.com>
References: <ca540fb6-2ea7-90b0-66ad-097e99b6e585@nvidia.com>
 <20210311161558.GG4962@sirena.org.uk>
 <f21b87f1afb3eda54b5f00f2d1c146d3@walle.cc>
 <20210312113544.GB5348@sirena.org.uk>
 <6ed28bb5330879b1919aced5174f319f@walle.cc>
 <20210312120456.GD5348@sirena.org.uk>
 <684332700f8be9f77348a510eb6eba22@walle.cc>
 <20210312134642.GF5348@sirena.org.uk>
 <8cdf1cfa971945792b509a687a4de735@walle.cc>
 <6af6439c-bdb8-cd0f-635d-069040ba5b65@nvidia.com>
 <20210315153925.GC4595@sirena.org.uk>
 <3b3c5aea-60bc-d7bd-9ae6-5e890782b2e8@nvidia.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <67ca8858be63a07e3549f73afcc08437@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-15 18:10, schrieb Sameer Pujar:
>>> Yes this is a problem, unfortunately I missed checking some of the
>>> simple-card examples. I wonder we should be specifically looking for 
>>> "mclk"
>>> clock here.
>> That would definitely help mitigate the problem but I really think 
>> it's
>> cleaner and safer to just push this down to set_sysclk().
> 
> Understand now. I will push patches based on this. Thanks for the 
> details.

Please keep me on CC, I'm not subscribed to the sound/alsa mailinglist.

Thanks,
-michael
