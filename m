Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3840D736
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhIPKP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:15:28 -0400
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:39990 "EHLO
        9.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhIPKP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:15:27 -0400
X-Greylist: delayed 2366 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2021 06:15:27 EDT
Received: from player726.ha.ovh.net (unknown [10.109.146.50])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id AB3222619A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 11:34:39 +0200 (CEST)
Received: from RCM-web1.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id 1C4E5221DD910;
        Thu, 16 Sep 2021 09:34:33 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 16 Sep 2021 11:34:32 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/24] MAINTAINERS: update brcm,unimac-mdio.yaml reference
In-Reply-To: <39e251389606fb11d0d5888d76aacaf595643da8.1631783482.git.mchehab+huawei@kernel.org>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
 <39e251389606fb11d0d5888d76aacaf595643da8.1631783482.git.mchehab+huawei@kernel.org>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <9b8d6cab5e682e9fdd3031294ec8efba@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1130122033111215067
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudehgedgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvufgjfhgfkfigihgtgfesthejjhdttdervdenucfhrhhomheptfgrfhgrlhgpofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepveefvdetjeffueefkeeuuedvgefhgeegjefgvedvgeeiteduueeivdeltedthfetnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-16 11:14, Mauro Carvalho Chehab wrote:
> Changeset 5d1c5594b646 ("dt-bindings: net: brcm,unimac-mdio: convert
> to the json-schema")
> renamed: Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
> to: Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml.
> 
> Update its cross-reference accordingly.

Quick question: do we want to reference .yaml files in the MAINTAINERS
at all?

Every YAML has maintainer specified on its own and new YAML files often
come without a MAINTAINERS entry.
