Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423033A2F42
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhFJP1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:27:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53649 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230322AbhFJP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:27:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B276C5C0238;
        Thu, 10 Jun 2021 11:25:32 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Thu, 10 Jun 2021 11:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=hgIWeMcs0WaS6LFG8rrruJfEcZAE
        +U7xIPv+dywc0xs=; b=BGD+q6anMOYGnnJQI7bp3FxKonK6jI4vs/9yv99bb55R
        n1fda1ZgLXGoLhpewsROFiIIY2rymBbS36+ioOsTHzJ4cgEfwAlkLKl7OLXFPDc3
        cxt0c7Op0qWfOEgqKkrSf7VxETsPUMmJmibDWM3gB0y3MPvjmLTgQ96hem3P424D
        c2o+yDz11ELSI7N6HAIGeUyrmSJpfuakdLjrJD+dL4oQNEUn7iwFHBWxM6LVk5W6
        V8yKJb5Av8Jp2GWcLVvGjGUu19408ArVcdY2fFpMKnz8jo5sxKNGQcuk1rr/Bxn/
        eQPXO2DnPxtPkAWTh2a0N7dkeUAp+ReUKTEBgycEJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hgIWeM
        cs0WaS6LFG8rrruJfEcZAE+U7xIPv+dywc0xs=; b=GOro9iB+HIXpaB/mQad9L+
        UMJEFd7v4vILyVJaHfXIIIejVR42mJxCYVmqRAyAHrVy7G+1TQ769D0FTjFenPnE
        ycvaWpDliL18RqfxCyLXeiUJH0POSDg77GKkP5MY7l/I8wg0sLn+J3o9GznoWuY6
        udRH199aC/ij40rRnyCqiXt+xEFw0aaygxvEJ6sUjQ0wZaB27i1udaYn10NG9xO5
        BizySrNQfFZqd2qMAG9v36FgMuhib232LulWk4C98WVV1NM1aaO/Gy7Pp/4hKFm5
        1S8BKfGYLkuyp3R70OyUQww2nQBREvRtkw3+AeCmCSg2mPsNbsHVl3mv5ptUJbFg
        ==
X-ME-Sender: <xms:7C7CYOHHLGh3Dp53gT5qcq5viu7tXfIrCQwO65cc43Xcj3EQWvYCeQ>
    <xme:7C7CYPVcB0DxeMzQxFQZ2gvtFLKoJT7Mq1f7wdD50vIV5H2Q0CNj4qFp5I48EuDhF
    JHgVJpEJUaZhpwQlCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedufedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeettdffjeejkeevtdejfeekhfffkeevtdegjeehueeiveefgefgvdehvdeh
    fedvvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghv
X-ME-Proxy: <xmx:7C7CYIIK4__e2U_B3xdESXbXWc3tokUEHZFiE9J7rIDWQy9SAfrkSA>
    <xmx:7C7CYIGx15-_1_c0MKiuegQX6IeyB0If_kuYMEWfACiNrTpjRAazUw>
    <xmx:7C7CYEU-gJUQuKhpwA6t0twvhVom3MbHdftrfuntXFw-p2hS9faiWQ>
    <xmx:7C7CYBjv-IP14MaEV7uQYk2_qoD0yaf1OiQq_6eeoqjLPGyQVi_LeA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EAA551C0061; Thu, 10 Jun 2021 11:25:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <2cd8231e-c246-4255-a08e-c88ae9b62ed2@www.fastmail.com>
In-Reply-To: <871r9a2htf.fsf@kernel.org>
References: <20210607061751.89752-1-sven@svenpeter.dev>
 <871r9a2htf.fsf@kernel.org>
Date:   Thu, 10 Jun 2021 17:24:14 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Felipe Balbi" <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Jun 10, 2021, at 11:24, Felipe Balbi wrote:
> 
> Hi,
> 
> Sven Peter <sven@svenpeter.dev> writes:
> > Currently, the dwc3 platform driver does not explicitly ask for
> > a DMA mask. This makes it fall back to the default 32-bit mask which
> > breaks the driver on systems that only have RAM starting above the
> > first 4G like the Apple M1 SoC.
> >
> > Fix this by calling dma_set_mask_and_coherent with a 64bit mask.
> >
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> 
> Acked-by: Felipe Balbi <balbi@kernel.org>

Cheers!

> 
> > ---
> >
> > Third time's a charm I hope - this time much simpler :)
> >
> > I still think this change should be fairly low risk.
> >
> > Unfortunately I only have the Apple M1 to test this on but here
> 
> wait a minute. The M1 includes a dwc3? That's awesome. Mind sharing a
> regdump? Should be in debugfs.



Two of them, actually :-)
One for each of the USB C ports together with an unknown PHY and some weird
quirks (neither the dwc3 gadget mode nor the xhci hardware seem to receive
more than a single connect event).
I've actually written a very basic dwc3 gadget driver for our bootloader
m1n1 [1,2] loosely based on your Linux driver from before it was switched to
GPLv2-only to experiment with the hardware and load linux kernels over usb :-)

I haven't found anything in debugfs, but I can share a simple dump of the MMIO
space. This is already after the controller has been initialized in gadget mode.
If you need something else just let me know.

>>> reghexdump32(0x502280000, 0xda00)
00000000  01100020 0200047f 1c0000f1 0200000a 0238ffcd 000004e0 00000440 0000003f
00000020  00000000 00000001 00000001 00000000 00000000 00000000 00000000 00000000
00000040  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000060  *
00000420  00000280 00000000 00000000 00000000 00000280 00000000 00000000 00000000
00000440  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000460  00000000 00000fa0 00000000 00000000 00000000 00000000 00000000 00000000
00000480  *
000004e0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000500  *
000008e0  00000401 00000000 00000000 00000000 02000402 20425355 00180101 00000000
00000900  03100002 20425355 20000102 00000000 00050134 000a4135 00000000 00000000
00000920  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000940  *
0000c100  00000001 00006f00 00f00000 01500000 30c12004 00000000 7e800020 00001908
0000c120  33313130 00000000 12345678 0a416802 00000000 00000000 00000000 00000000
0000c140  4020800a 02092486 12345678 10420086 48422019 643d0410 18cc803f 0f000e92
0000c160  00230000 9cc20006 00000000 00000000 257cf70a 00000000 00000000 00800000
0000c180  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c1a0  3139302a 736f3035 33313130 00000000 00000000 00000000 00000000 00000000
0000c1c0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c1e0  *
0000c200  00102400 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c220  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c240  *
0000c2c0  01021102 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c2e0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c300  00000023 002300c7 00ea00c7 01b180c7 027800c7 033f00c7 040600c7 04cd80c7
0000c320  059400c7 065b00c7 072200c7 07e900c7 08b000c7 097700c7 0a3e00c7 0b0500c7
0000c340  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c360  *
0000c380  000003e8 03e88809 0bf10000 0bf18000 0bf10000 0bf18000 00000000 00000000
0000c3a0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c3c0  *
0000c400  dead0000 00000000 00000100 00000000 00000000 00000000 00000000 00000000
0000c420  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c440  *
0000c600  00001744 00000000 18094246 0085560c 00000000 00000000 00000000 00000000
0000c620  00000000 0a0a0101 18181218 20201820 0a87f020 0001ffff 00000000 00000000
0000c640  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c660  *
0000c700  00080800 80f00000 00000007 008e0001 00000000 00000005 00000000 00000000
0000c720  00000003 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c740  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c760  *
0000c800  00000000 00000000 00000001 00010002 00000000 00000000 00000001 00020002
0000c820  00000000 00000000 00000000 00000000 00000000 00000000 00000001 00030002
0000c840  00000000 00000000 00000001 00050002 00000000 00000000 00000001 00040002
0000c860  00000000 00000000 00000000 00000000 00000000 00000000 00000001 00060002
0000c880  00000000 00000000 00000001 00080002 00000000 00000000 00000001 00070002
0000c8a0  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000c8c0  *
0000cd20  00000000 00000000 00000886 00000886 00000000 00000000 00000000 00000000
0000cd40  3c20060c 0002000b 00000000 00000000 00000000 00000000 00000000 00000000
0000cd60  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000cd80  *
0000d000  30302626 00940076 26261f1f 00000052 9c067d05 3fff3b15 42843603 0023287d
0000d020  4e928162 008b8080 00000c00 0047e1f4 00753546 5dc2f07d 00000ea6 f0966b32
0000d040  00026cf5 1130c850 00000000 00000000 01090650 00000000 00000000 00000000
0000d060  000034c2 00000582 00003540 00000600 00000000 00000000 00051565 00000000
0000d080  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000d0a0  *


fyi, the Apple Device Tree defines the following register ranges, some of
those are related the PHY and at least two are for the dwc3 itself. No idea what
the rest is used for yet.

<0x00000005 0x02280000 0x00000000 0x0000da00> <-- DWC3 + something else at the end
<0x00000005 0x02200000 0x00000000 0x00080000>
<0x00000005 0x0228c000 0x00000000 0x00001800> <-- DWC3, just before GLOBALS_REGS
<0x00000005 0x02a84000 0x00000000 0x00004000> <-- possibly related to the PHY
<0x00000005 0x02800000 0x00000000 0x00004000>
<0x00000005 0x02a80000 0x00000000 0x00004000>
<0x00000005 0x02000000 0x00000000 0x00080000>
<0x00000005 0x02080000 0x00000000 0x00080000>
<0x00000005 0x0228d000 0x00000000 0x00000800> <-- just after DWC3


Best,


Sven


[1] https://github.com/AsahiLinux/m1n1
[2] https://github.com/AsahiLinux/m1n1/blob/main/src/usb_dwc3.c

