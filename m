Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548803FD879
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbhIALMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbhIALMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:12:05 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC76C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 04:11:08 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4H01Zd4ylbzQkBy;
        Wed,  1 Sep 2021 13:11:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1630494662; bh=g7wYD5yqdl
        D1LFC8b2a26qOAWY+lw+FL1h8Cz5AsAnI=; b=cLvJvCWZi9cFc5Kp2KJuuhGOaP
        RQXMODR0FXhlsAxa/QXRopBjayAY/z1z89i1BIVBKHcjlSVYh4ASmpvsxDPe9V6/
        kdhojfIdJhxFOJ4NjN0sNzgCQAh876QCjoa2h2yU6yQmdBMrH+VP8aSUT0fNZmCy
        lVrj3PsaxFqPkUVdMYe+UNXi51w92LbEeJIuF6c/BDGKqgQXcK17H+IPfnS3hmVg
        JOY6UIJBVDy6kSnpqvqnl6qdIWzcf5f1Ri0EbmJPoZQW6+DycUc5t+O5GULSLk4X
        IHgV45wIIb2kaKeQ+ahMXEt7XP4Jp2/8e/Qhe2wm8PrOd7wKXpfUCOkZxvZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1630494663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVjLIa5ukEcRiqoQYW3N8gtUf8eP4aka2iiO+aqRH9g=;
        b=WuoJDT+yIZYdsA6WjhuuEOLOZ7R5EmBJGm0S+Wht9ihQ9uPSwJEfBzDUaHbS/TogoqvvcJ
        iDany6qO11w7mZBGJYETPd8wkZ78sqY3+iWqMVirDFYyMx8UiwJ4WlZikpsSNTeSDZP6z1
        +qhp91h0b54TqgZ4EEWbqiHzCRbqIap9I6ZPrtg7QCoVxYACA+4V9AxP+1Fp59+57edJOq
        RFoalEBaIXsWPPn1uOq7bJzj1H4MvM9Relw72/aH9QQq32N0iKF2n0NeJ0FyyqDL/pFxI6
        Gacm/qiG5M49/nWoLXkbJAm7bpvHHF/gOaupczEhgEJJVlYkXJz/CwaQn4DF1w==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Wed, 1 Sep 2021 13:11:01 +0200 (CEST)
From:   torvic9@mailbox.org
To:     Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@redhat.com" <hpa@redhat.com>
Cc:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>
Message-ID: <1693972970.60125.1630494661286@office.mailbox.org>
In-Reply-To: <2df1c3d5-301d-dc46-7f9f-d28be2933bd3@redhat.com>
References: <1876334901.51676.1630481868266@office.mailbox.org>
 <e6f9921d-0fb6-da30-4dc5-53b4cb7b5270@redhat.com>
 <2df1c3d5-301d-dc46-7f9f-d28be2933bd3@redhat.com>
Subject: Re: [PATCH v4] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung
 860 and 870 SSD.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 415AB270
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hans de Goede <hdegoede@redhat.com> hat am 01.09.2021 11:38 geschrieben:
> 
>  
> Hi,
> 
> On 9/1/21 10:55 AM, Hans de Goede wrote:
> > Hi Tor,
> > 
> > On 9/1/21 9:37 AM, torvic9@mailbox.org wrote:
> >> (Sorry for not doing a proper reply)
> >>
> >> Hello,
> >> Noob here.
> >> I have a Samsung 860 Pro connected to a AMD X570 chipset mainboard and
> >> it just works flawlessly on 5.13 and 5.14.
> >> Are you sure that *every* 860/870 is concerned by this problem on
> >> *every* AMD controller?
> > 
> > I am pretty sure that every 860 / 870 EVO is affected,
> > I am not sure if the PRO is also affected.
> 
> So while reading https://bugzilla.kernel.org/show_bug.cgi?id=201693
> again to add a comment asking if anyone was seeing this on a
> pro to I found existing comments of both queued-trims being
> an issue on the 860 pro, as well as the 860 pro having issues
> with some AMD sata controllers.
> 
> So it seems safe to say that the 860 pro has the same issues
> as the 860 and 870 evo models. Chances are you don't have
> discard support enabled causing you to not see the queued-trim
> issues (which means you also won't see any difference from
> disabling support for queued-trim commands).

Thanks for your answer, Hans.

If you mean the "discard" mount option, then yes, you're correct,
I don't use this because some (apparently) knowledgeable people
recommended against using it especially on LUKS partitions.
I don't know whether that's true though, it might be outdated.
I do however do manual TRIMs with "fstrim".

> 
> So this just leaves your question of:
> 
> "concerned by this problem on *every* AMD controller?"
> 
> Where "this problem" is needing to completely disable NCQ
> and I guess the answer is no, not every AMD controller
> is affected. Still the plan is to err on the safe side for now,
> allowing overriding this from the kernel cmdline with:
> 
> libata.force=ncqamd

I agree to do it in a safe way, that sounds like a good solution.

> 
> I will add a comment to:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=201693
> 
> Asking for PCI-ids of the controllers where people are seeing
> this and then maybe we can narrow down the "AMD" check in a
> future follow up patch.

I can send you PCI and device IDs later if it helps.

> 
> Regards,
> 
> Hans
