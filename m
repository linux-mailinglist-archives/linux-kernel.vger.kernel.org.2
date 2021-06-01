Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0D396C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 06:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhFAETM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 00:19:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36439 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231607AbhFAETJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 00:19:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 239155C014F;
        Tue,  1 Jun 2021 00:17:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 01 Jun 2021 00:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DiuozS+P4zLUAT9fUWzPHY8BCza
        XXcRmW1+OkkpOTwA=; b=ELwFulW4XOrPglHlHd5S8/ZUw4GkWwNvfQZpStAHnv/
        GTgZ783Dx0NW4Py4IIEsfO001lxvxJgI+muyh6pDRzvbAOTpzqcfEcznFzIel5qh
        /cPPRvjG8/GNsfzn8Q46Mn6bOag6OiyaEFSjlbT1taum9Jnb72ly0a/0rLmORkp+
        3Zx/dI7XX4m1iZHsyDCd3laNnNYxyrnmwA8IfuGYmfaeVEf1yggdUCazXeMiu2Tl
        yPxoUUC3ibhuROvr3VDIYnhQrE/pgRgPJpMZM/rDcDXim0xNPU6ebbqlaweI+3xc
        taRDXWw830g3ZqqbO6MnZ/vTHZNgSw1KWIPbl6fnxSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DiuozS
        +P4zLUAT9fUWzPHY8BCzaXXcRmW1+OkkpOTwA=; b=CsVyFY4vDdTPIQXfn3YTqs
        1BaNnw7oHar120J/iaKhh6MZmhpmSK7f+XYqIQTd+lRduIRzo7bpm8RNWi4uQfED
        5fuDihOu3Sz/or4JdhCcQnVXgRbHbLuFmzrV+jJf2yZU+WIugNQhv5HJHrEWCrrH
        7y3uwzbnl5Rk2LnlBOXkzl0WYILLyPCts1wYFM6sagFs+Th4GZYCOPD5K9ONzioM
        IOV7+0bwJk0KAoU7FvxDNUHCLMyRuMp1cMy0AGymjC4H3f7PI9eIGiiJu1qmVsXN
        IhtwjBHHQiL2J9ZYwGV7h1gHESXJ5dSZznw0Au5Il8BRwRGFm+WuQUN/9XTJMSRA
        ==
X-ME-Sender: <xms:17S1YB9W1nJl3PNEteH6IwX6Q1edfJP6jbCjuGSLSQycu6rXGernXw>
    <xme:17S1YFuhLAXzIxldZ3lXim4-gwZgzXXcFRUwqEyWBbBg9Ea-yBumHbS92YQ790_IR
    rXAKBDfU45y6UIi>
X-ME-Received: <xmr:17S1YPDNPO67t1Mi1skSOwnpBUDmhHefFZRRyzL_xDIKs5C6YkMUX2AVPTzO1AnRH0PSaP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelgedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfhomhcu
    hfhofihlvgcuoeifrgeiihhvghhtfhesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrth
    htvghrnhepffetueehvdehteffffdvfffgudduteekjeekudefiedtffffteekuefggedu
    iedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfi
    griehivhhgthhfsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:17S1YFe7DE_zEZGpjxj0jTIXOR9SvTJ3P129mnZeBKNrDFx8SiN9_A>
    <xmx:17S1YGOyM3v6H3jOxNVK8OCYe1zgpeXKKwGMvTTZlP-BG5JWId2Urw>
    <xmx:17S1YHmCcrUKYyJuOk2jZp6VKFEjY0Yx6cHHUN04xwha6FBCkDzfjA>
    <xmx:2LS1YFc4PdnYL_0iXUCBWY0xtiMNuWAR0umOfW-lXSqwtkIi7USOfQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jun 2021 00:17:26 -0400 (EDT)
Date:   Mon, 31 May 2021 21:17:16 -0700
From:   Tom Fowle <wa6ivgtf@fastmail.fm>
To:     speakup@linux-speakup.org
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        grandmaster@al2klimov.de, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: docs: Convert the Speakup guide to rst
Message-ID: <20210601041716.GA2812@qlf.suddenlink.net>
Mail-Followup-To: speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        grandmaster@al2klimov.de, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531220754.h4ep2dj65wl6hejf@begin>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I read through much of the speakup users guide in rst and it seems
completely accessible reading the file in email with the mutt email client,
speakup and a doubletalk PC synth. No guarantees I may well have missed
things.
Thanks for the usefull work.
tom Fowle WA6IVG
