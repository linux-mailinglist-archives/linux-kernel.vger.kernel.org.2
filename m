Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858E833C421
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhCOR2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:28:35 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:42748 "EHLO
        6.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhCOR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:28:05 -0400
Received: from player771.ha.ovh.net (unknown [10.109.143.201])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4854928148A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:27:55 +0100 (CET)
Received: from RCM-web2.webmail.mail.ovh.net (klient.box3.pl [176.114.232.43])
        (Authenticated sender: rafal@milecki.pl)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 8F4371C256371;
        Mon, 15 Mar 2021 17:27:46 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 15 Mar 2021 18:27:46 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-phy@lists.infradead.org, Vivek Unune <npcomplete13@gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
In-Reply-To: <YE85xs+HX5UUXlXo@vkoul-mobl>
References: <20201116074650.16070-1-zajec5@gmail.com>
 <ed093ddb-da37-c3c4-cdd9-3b8e8db776bb@gmail.com>
 <YE85xs+HX5UUXlXo@vkoul-mobl>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <97981a899fe74c534d29d11485a2dbd2@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 176.114.232.43
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11032411713050807880
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvledguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvffujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejffeludekhfeiieetkeejhfegheegffetleehuedtueehteetudegheefteekteenucffohhmrghinheplhhkmhhlrdhorhhgpdhoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpudejiedruddugedrvdefvddrgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-15 11:41, Vinod Koul wrote:
> On 11-03-21, 21:31, Rafał Miłecki wrote:
>> Hi,
>> 
>> On 16.11.2020 08:46, Rafał Miłecki wrote:
>> > From: Rafał Miłecki <rafal@milecki.pl>
>> >
>> > 1. Change syntax from txt to yaml
>> > 2. Drop "Driver for" from the title
>> > 3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
>> > 4. Specify license
>> >
>> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> > ---
>> > I think this should go through linux-phy tree. Kishon, Vinod, can you
>> > take this patch?
>> >
>> > This patch generates a false positive checkpatch.pl warning [0].
>> > Please ignore:
>> > WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>> >
>> > [0] https://lkml.org/lkml/2020/2/18/1084
>> 
>> Kishon, Vinod: I sent this patch back in December, it was Reviewed-by
>> Rob, but never accepted.
>> 
>> Could you push this patch to the linux-phy.git?
> 
> Can you please rebase and resent me this patch. I am trying to
> streamline patches now using phy ml and pw instance so that we dont 
> miss
> anything..

Both patches apply cleanly. Maybe your mail client malformed them for 
you?

They are accessible in the devicetree-bindings patchwork:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201116074650.16070-1-zajec5@gmail.com/
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201116074650.16070-2-zajec5@gmail.com/

You can apply both patches doing e.g.:
curl 
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201116074650.16070-1-zajec5@gmail.com/mbox/ 
| git am
curl 
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201116074650.16070-2-zajec5@gmail.com/mbox/ 
| git am
