Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D206C378DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbhEJMuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbhEJL6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:58:42 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0DC07E5FF
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 04:52:25 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5675322239;
        Mon, 10 May 2021 13:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620647543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yO4AK8WNlzpOysSwYhMdNTxh6p0zS+xaRzCx4D02VTA=;
        b=aJ87l8l+za7++bQhHM8uOwBLK2wipB1v1+sZx34XkEkmjZHOv75oGC1IDaKjYhbCW71sEx
        pumTU78vNkCc0/3mJpbDWKIuAN9pKWtEZKYHgp+s552bdDH5W9F4pN9yl3O7xwd2dNhHPZ
        Xt/zqwgvO0o4O2tu8faj/8U4oUrSDKI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 May 2021 13:52:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci-results@groups.io, Heiko Thiery <heiko.thiery@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
In-Reply-To: <87o8djcxas.wl-kuninori.morimoto.gx@renesas.com>
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
 <1aa3a8716d2416f0cc127737dcff092a@walle.cc>
 <87o8djcxas.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <99b3cd8db134d9682c16784f75f40bae@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-05-10 01:16, schrieb Kuninori Morimoto:
> I'm sorry for my late response. Japan was holiday
> 
>>  _But_ later
>> asoc_simple_canonicalize_cpu() will reset the dai_name pointer to
>> NULL in simple_parse_node() if "single" is 1 and then we end up
>> having two links with the same name.
> 
> Ahh, OK thanks.
> I think understand that why my posted patch
> (= 59c35c44a9cf89a83a9 "ASoC: simple-card: add simple_parse_node()")
> breaks your board.
> 
> I will try to fixup the issue.
> 
> Thank you for your help !!

I've just tested your new patches. Unfortunately, it was very
successful. I've also traced the is_single_links and it is still
1 for this board. Is this correct?

Still these two questions are open:
>> Which begs the two questions:
>> (1) What is "single" actually and when should it be 1?
>> (2) If single is 1, then the sysfs file will be named 
>> "(null)-codec-name".
>>     Do we want that?

-michael
