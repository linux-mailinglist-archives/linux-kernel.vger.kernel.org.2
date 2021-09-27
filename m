Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA6418EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhI0GHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:07:01 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53223 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232924AbhI0GHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:07:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id EF1F4580B91;
        Mon, 27 Sep 2021 02:05:22 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Mon, 27 Sep 2021 02:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=Ad8Mo2JmqwP95c4T90ptb8f2J/t+
        t9+n9AaXp5lUmg8=; b=G0yp5HfCrWmMymIR/TZsPWIqgGQ/QO1ElX+MJmWplwEE
        ah7l21gtLLAHvMzo0ne9tpQPt1cYh7eQg9amsINuN07DQa7Ex+rYyw4dwlDqqMe7
        1qxBax7I6+//QT0KbwuoNTQFygNgbmlnW838v8G7qPANmrSjYy2rCOHKzwt36TQN
        3CCJsoi1oXg4WU6PbTT8RCugIBYzHTvxslaN4enIWIvFZan32Rx0DuD18s4iygsh
        wShQlUDjZ4J44XD6bn9KngBIUzizQDbnBEdYOPukalcIZPWcmEAERg7hwaJu27WU
        RyMysJ3udIZbmGs3KvSTbjmisWwO8NfumsmUW8dNJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ad8Mo2
        JmqwP95c4T90ptb8f2J/t+t9+n9AaXp5lUmg8=; b=u8+Zx+cZ4gHnv5sjA9hYXz
        d5NXFByXmk2N3LCpuqnp45kBTPpgyATokzqNbnudAtcpzdTYUk9LZVGQgJJyPWzQ
        TpFZMjn0pBiRicAqdLzxngKgxQq0YMc3Z+3pPGcJeWfF+o7Tq6seY7XfXgmamND6
        FW+Y2dBo639ZtpcbxVrx320s0JnQ6U9UH/3VC8BMteDBGK0O8Xa/oouOSmxc/DCb
        pTR8yY/Zs91sqBx1vKstCBBdlaLzIoTttHNhK6KoSJak3L+tbBzVi78K9ssg2kuJ
        ghUXRplLKmBIp5XwN8TclP3HeHeCmnMacT867HrD38Vp+aU2N/l70/R8gI1+baDw
        ==
X-ME-Sender: <xms:Il9RYTYL9q0CU1t0-TQvQ5NYWDdYKVGJ2M3NpavBWWUNeaTyS57OnA>
    <xme:Il9RYSZmk5HtyLjr017jRkLqbvcvxKDtLiqw2aPfDwFXVW60S86YlPhSd9Kql4ITl
    G3U0CDON9dgRpeykls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejjedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepheefffevvdetvdejtedthfffheeifeelgfduteeuudegueetieegudei
    leeltedvnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    vhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Il9RYV_68H9yu_Q98e5RKHIJgo5kyZR-7HO8z_KKx7f-A5ABYa5ilA>
    <xmx:Il9RYZpgA3HzQuoCMwO-JOKm52E5EZEJ_l7IWIXWzjaMRi-cTmSXUg>
    <xmx:Il9RYepBdv0y2ZixzpJ5Mci_YiUMgI9qHWn6lHXeMP6gNSdhLKhQUg>
    <xmx:Il9RYUgoUX4osfB4ijkajmrupDe31hU2SiQu8amsI3T9_EjVaA1Psg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3775951C0060; Mon, 27 Sep 2021 02:05:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <d4fb602c-43ab-4b5d-93ad-fa9116462dec@www.fastmail.com>
In-Reply-To: <PNZPR01MB4415F35759F136E812A8F91DB8A79@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
References: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
 <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
 <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
 <20210926020839.GA96176@C02WT3WMHTD6>
 <1a6f5030-27d9-d1ae-aff4-0ed2a10dce6b@protonmail.com>
 <1b5d6bef-db6f-073f-8d24-4963f0df82ab@protonmail.com>
 <PNZPR01MB4415801C6084E8CFD068A84AB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <d65ecc69-35c9-4400-8fb0-95aa04360b03@grimberg.me>
 <31c4dc69-5d10-cc6a-4295-e42bbc0993d0@protonmail.com>
 <PNZPR01MB4415F35759F136E812A8F91DB8A79@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
Date:   Mon, 27 Sep 2021 08:05:00 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Aditya Garg" <gargaditya08@live.com>,
        "Orlando Chamberlain" <redecorating@protonmail.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Keith Busch" <kbusch@kernel.org>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "hare@suse.de" <hare@suse.de>, "dwagner@suse.de" <dwagner@suse.de>,
        "hch@lst.de" <hch@lst.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[REGRESSION]_nvme:_code_command=5Fid_with_a_genctr_for_use?=
 =?UTF-8?Q?-after-free_validation_crashes_apple_T2_SSD?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Mon, Sep 27, 2021, at 06:51, Aditya Garg wrote:
> I am getting the same error.
>
> ________________________________________
> From: Orlando Chamberlain <redecorating@protonmail.com>
> Sent: Monday, September 27, 2021 4:22 AM
> To: Sagi Grimberg; Aditya Garg; kbusch@kernel.org
> Cc: linux-nvme@lists.infradead.org; regressions@lists.linux.dev; 
> hare@suse.de; dwagner@suse.de; hch@lst.de
> Subject: Re: [REGRESSION] nvme: code command_id with a genctr for 
> use-after-free validation crashes apple T2 SSD
>
> On 26/9/21 18:44, Sagi Grimberg wrote:
>>
>>> I checked out the proposal sent by Orlando Chamberlain to replace NVME_QUIRK_SHARED_TAGS , by NVME_QUIRK_SHARED_TAGS | given in the patch on http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html. The , still causes panics to the T2 as described before. In the case of |, the kernel boots correctly without panicking the T2, but in case we are having Linux on an External Drive, which is my case, then the internal SSD doesn't seem to be recognised at all. I've tested the patch on 5.14.7.
>>
>> That sounds like a separate issue, because with this patch applied,
>> all tags should be within the queue entry range (with generation
>> set to 0 always).
>>
>> Is it possible that the io_queue_depth is being set to something
>> that exceeds NVME_PCI_MAX_QUEUE_SIZE (4095) ? the default is 1024
>>
> I've been able to reproduce it by using the same kernel Aditya is using:
> https://github.com/AdityaGarg8/T2-Big-Sur-Ubuntu-Kernel/actions/runs/1275383460
>
> From the initramfs:
>
> # dmesg | grep nvme
> nvme nvme0: pci function 0000:04:00.0
> nvme nvme0: 1/0/0 default/read/poll queues
> nvme nvme0: Identify NS List failed (status=0xb)
> nvme nvme0: LightNVM init failure

Maybe I should've just submitted the quirks required for the M1 already...
The ANS2 firmware on there doesn't support the vanilla nvme_scan_ns_list
call. That should not break anything though because core.c falls back to
nvme_scan_ns_sequential in that case which does work. It just results
in that "Identify NS List failed (status=0xb)" error message.

Not sure where that LightNVM failure comes from though. Afaict lightnvm has been 
removed from 5.15 and shouldn't be used for the Apple controller anyway.

Sven
