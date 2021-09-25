Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0255418481
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhIYUuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:50:37 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:59939 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhIYUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:50:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 73A0D580D4B;
        Sat, 25 Sep 2021 16:49:00 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Sat, 25 Sep 2021 16:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=YgDo6sYrTikpb+AQKSVT01CWd92f
        psqGQwY+L/v1hmw=; b=Beb9qi2CBq+tq3fFfSs3C7lo0iIdSVu8DPDA0M3BYvZX
        Vl6lnn0BYLZ6Og/CHAhoEKq0FQjvC0R7x/eN3fksG84f74ng3uMp+K0rJuL/cTNk
        OY7UuuPbSqhJaCTYUBy8gXBrmNnJotuS/h0Os57W+jSLLJs3jeY7oLB0SyDdCTYQ
        dh9m/Frpm4YTzgFb1pDL/yf/rZPjh2fAQ4Xrj8fJfTFisWVyctxD91dOItMInDpm
        eMRsPL21C5jnihmp3cOd0tTgQ8vpMvmUD0LEX1Whg13ugxNNrVFa6eAlz4pUIEj2
        GQCfhJS6WxTxHv5gSCZh0ejjZrxw0IksxSYNk05IGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YgDo6s
        YrTikpb+AQKSVT01CWd92fpsqGQwY+L/v1hmw=; b=Y0tazXopVJ4wOuH/GdmVZ9
        kpXx/Z+n9YlFtlaV6gR9jsqjJN0BFeJbEROI8sInODGnC/ZpXGB1xVoG2jejhUV2
        8/YTSO/H5B9TOdTu2Pp6EgLfp/MUCfaOF/Rz4vuMM2LjJfEOkdWW8JtIcKMOkPc1
        7qViP1TpJ5+xDlPExiPXUAou7X5JjG2psu3KWPJc/55E4l0O5uSfzYMRN6lANvCm
        hdF2eVraanfgrGmFkN9ywRYOofjYO87C8dqD9Lc5Af56Y5soym6Y/uqT/eTuzVuC
        FFmELZL8a9RG4P3lLpplS5AkRjcC/S76qftriKXzZJ6wBuO4GPMPgn74JUF1jMHw
        ==
X-ME-Sender: <xms:PItPYfjERS1UX_pdipN3izCU5fFI1UHCXC4xvZvqeS3qemcZeiZXtQ>
    <xme:PItPYcDJQeIkJcmGKsqzwFotHKX-6fgc-w2rSjaXiBCcanGYMPafKLxXAuvy0TBHJ
    Hd9TTSvncMyfBoCDuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejfedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:PItPYfG-peXMduQ1Q37ca64Fkdym_zISF-4uNoaxabWrxttgB-g4jQ>
    <xmx:PItPYcQ-Lvrfol7dMyKvMNrbKSK7uAk_sQW0defAsvS4zrBmKX9iXQ>
    <xmx:PItPYcyVCCMPrD2g7ec8YfJq-hsDHHe7XECRpTcdHMCliISBkgDt8g>
    <xmx:PItPYYeYIPDvslIqOUY6SI0vN2OXRORl3tOiKJORThvS8SwNFuqDhw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 03A5351C0060; Sat, 25 Sep 2021 16:48:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <08930bdf-6a3a-4d49-b366-8029b88b25b4@www.fastmail.com>
In-Reply-To: <20210925203857.GC116968@dhcp-10-100-145-180.wdc.com>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
 <4849f3d3-4abd-49b7-b053-d7965daa7138@www.fastmail.com>
 <20210925203857.GC116968@dhcp-10-100-145-180.wdc.com>
Date:   Sat, 25 Sep 2021 22:48:39 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Keith Busch" <kbusch@kernel.org>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Aditya Garg" <gargaditya08@live.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Sep 25, 2021, at 22:38, Keith Busch wrote:
> On Sat, Sep 25, 2021 at 10:08:53PM +0200, Sven Peter wrote:
>> I actually ran into a similar issue while adding support for the NVMe
>> controller found on the M1 and assumed it was only present there.
>> 
>> Some background why this happens: ANS2 is a co-processor that emulates
>> an NVMe MMIO interface and uses the tag as an index to an internal data
>> structure. 
>
> Thanks for confirming the behavior. The patch should restore the
> command_id values to when everything was working. I'll just need to
> update the quirk description to better align with the actual limitation
> if the patch is successful. 
>
>> On the M1 we can directly talk to ANS2 and while we can submit
>> commands with a higher index it'll just ignore the upper bits and only
>> return the lowest eight IIRC in the completion queue.
>> I guess whatever software is running on the T2 actually has an assert to
>> ensure that the tag is within the limits before forwarding the command
>> to ANS2.
>
> Is the PCI Device ID for the M1 the same as reported for the T2? Either
> 0x2005 or 0x2003 should make this quirk apply.

Oh, it's worse. It's no longer a PCIe device there but a platform device
directly attached to the SoC's bus. It'll need almost all T2 quirks and then
some additional changes to the way command submission works and support to
program a tightly coupled IOMMU which Apple calls NVMMU (which probably is another
reason for this limit: they use the command id to find the corresponding entry in
the IOMMU that allows access to memory listed in the PRPs).
I'll just use the quirk in my platform driver and submit it once I get it into a
shape that can actually be reviewed.



Sven

