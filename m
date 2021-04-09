Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD9359485
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhDIF2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:28:14 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:44290 "EHLO
        6.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhDIF2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:28:13 -0400
Received: from player692.ha.ovh.net (unknown [10.109.146.168])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id A5DA41FC359
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 07:27:57 +0200 (CEST)
Received: from RCM-web3.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player692.ha.ovh.net (Postfix) with ESMTPSA id 10B651CC96314;
        Fri,  9 Apr 2021 05:27:37 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 09 Apr 2021 07:27:36 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        SoC Team <soc@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: New 'make dtbs_check W=1' warnings
In-Reply-To: <632cbdec-e477-212c-f5a8-81151915fdeb@gmail.com>
References: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
 <632cbdec-e477-212c-f5a8-81151915fdeb@gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <903fdcef324310c97627ada4bbc77ebb@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16563395004640431855
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudektddgleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvufgjfhgfkfigihgtgfesthejjhdttdervdenucfhrhhomheptfgrfhgrlhgpofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepveefvdetjeffueefkeeuuedvgefhgeegjefgvedvgeeiteduueeivdeltedthfetnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-09 05:37, Florian Fainelli wrote:
> On 4/8/2021 8:08 AM, Arnd Bergmann wrote:
>> Greetings to all Arm platform maintainers,
>> 
>> I've just gone through the DT merges I've received so far and, with a
>> little help from Rob,
>> managed to run 'make dtbs_check W=1' before and after, to see what
>> warnings we get.
>> The good news is that the number of warnings is going down, but
>> unfortunately there
>> is still an unmanageable amount of remaining warnings, and some new
>> ones crept in.
>> 
>> I'm still working on my tooling for this, to catch these better, but
>> ideally I think we should
>> try to not introduce new warnings. I think some platforms are already
>> clean, and I did
>> not see any new warnings for mvebu, samsung and broadcom. There were a 
>> lot of
>> warnings from .dtsi files, and I probably did an incomplete job at
>> deduplicating those.
> 
> There are definitively a ton of warnings for Broacom DTS files, a 
> number
> of those warnings exist because the bindings were not converted to 
> YAML.
> Rafal, do you think you could help me with taking care of the
> BCM5301X/4908 warnings?

Sure, I got rid of one or two warnings already, I'll keep working on 
that.
