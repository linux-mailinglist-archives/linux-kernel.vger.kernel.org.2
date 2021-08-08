Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F8F3E3D00
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 00:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhHHWSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhHHWSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 18:18:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1E7C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 15:18:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so27066726pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 15:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=workware-net-au.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uXF/HlLy6BpvjjoddG1ldyRg+oHgXHYKMFkCEC267qM=;
        b=lSQuWfRJMP36Z+1SgFTtAsmXpGj7xwm57C8lGNF1AHEK+lsyzHsIG6a9KEWScp0yEy
         LQWvITelD7LcyPACTS3je333OKZ7guO23WpAdtTNtNvevgV3j9+9ndVthkq7a1GFLOEx
         rfU8z/DtRCOka3Gi3xz74QQmX/Zo0TJJQSrDMNiDv0p/6SbQhwMlgQGmmTXfx8e38Byu
         R7HVDauTa3v2R5dukvxaZHGFRy0SqBkMd7i3HhMdiNBDwgMFn28mpWZXMTgzzFTjOHcK
         nX5Wrx9ZfXf8vrrM/1eHHPT133FVdPQHX72qep+LsTSnCgCLWBm68xl7i7RfKVEdk+RQ
         tNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uXF/HlLy6BpvjjoddG1ldyRg+oHgXHYKMFkCEC267qM=;
        b=IC5YR8p3TxI+R7KNPDy0OuwFdEfgo1u/ZZmUhOQvhGLaD91dlPs5e3fFI+7SpheC8p
         M6ZrrYrafz2rhhyLk2b8NcnL/Thf8D8H418Unl9LpPHjyNcAgRvtOTC5SIM0I7NY/L8D
         wQ4RFunp3IrYsC1nqhIVOfT40GxNlqiVMh0Uvf5hA/y2fyxrqTdkmAM3QNpNhM4kSqGL
         tOf2/xxvkbdZjdT8e0hh928fBnWKe3ZceCfg7h8inJQr4sv4QaUpkohmv6K0M0Jc92ri
         CD7HwFlhKFUtcyrZ1SEgfArpND4f3fJqU877W5AQ0adktIDw9ScrYzucpdWldJOQ0aiO
         9ntQ==
X-Gm-Message-State: AOAM530UoQYfi/aJaeqLQCXXImrKn08Wtxuo9OfUtgZUuXmPr+U3kFo4
        fuVrO5hqEKUUU8O/nyBgot4LuQ==
X-Google-Smtp-Source: ABdhPJwFwToNws/BYXYez5Gjg39xHwk/nkOmruK/PM8hyEb6KOfDeX15Aozd943TeypmTcOQQhnJpw==
X-Received: by 2002:a63:f754:: with SMTP id f20mr186055pgk.385.1628461113677;
        Sun, 08 Aug 2021 15:18:33 -0700 (PDT)
Received: from smtpclient.apple (117-20-69-228.751445.bne.nbn.aussiebb.net. [117.20.69.228])
        by smtp.gmail.com with ESMTPSA id m18sm15968802pjq.32.2021.08.08.15.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Aug 2021 15:18:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] net: phy: micrel: Fix detection of ksz87xx switch
From:   Steve Bennett <steveb@workware.net.au>
In-Reply-To: <20210807000123.GA4898@cephalopod>
Date:   Mon, 9 Aug 2021 08:18:28 +1000
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Workware-Check: steveb@workware.net.au
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8C5F7CD-343A-4C25-B04B-EEA5C086B693@workware.net.au>
References: <20210730105120.93743-1-steveb@workware.net.au>
 <20210730095936.1420b930@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <74BE3A85-61E2-45C9-BA77-242B1014A820@workware.net.au>
 <20210807000123.GA4898@cephalopod>
To:     Ben Hutchings <ben.hutchings@essensium.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Aug 2021, at 10:01 am, Ben Hutchings =
<ben.hutchings@essensium.com> wrote:
>=20
> On Sat, Jul 31, 2021 at 08:19:17AM +1000, Steve Bennett wrote:
>>> On 31 Jul 2021, at 2:59 am, Jakub Kicinski <kuba@kernel.org> wrote:
>>>=20
>>> Please extend the CC list to the maintainers, and people who
>>> worked on this driver in the past, especially Marek.
>>=20
>> Sure, I can do that in a v2 of the patch along with the more detailed
>> explanation below.
>>=20
>>>=20
>>> On Fri, 30 Jul 2021 20:51:20 +1000 Steve Bennett wrote:
>>>> The previous logic was wrong such that the ksz87xx
>>>> switch was not identified correctly.
>>>=20
>>> Any more details of what is happening? Which extact device do you =
see
>>> this problem on?
>>=20
>> I have a ksz8795 switch.
>>=20
>> Without the patch:
>>=20
>> ksz8795-switch spi3.1 ade1 (uninitialized): PHY [dsa-0.1:03] driver =
[Generic PHY]
>> ksz8795-switch spi3.1 ade2 (uninitialized): PHY [dsa-0.1:04] driver =
[Generic PHY]
>>=20
>> With the patch:
>>=20
>> ksz8795-switch spi3.1 ade1 (uninitialized): PHY [dsa-0.1:03] driver =
[Micrel KSZ87XX Switch]
>> ksz8795-switch spi3.1 ade2 (uninitialized): PHY [dsa-0.1:04] driver =
[Micrel KSZ87XX Switch]
> [...]
>=20
> And do the external ports work for you after this?
>=20
> I have a development board with a KSZ8795.  All ports worked before
> this patch.  After this patch, when I bring up the external ports they
> are reported as having link up at 10M half duplex, when the link is
> actually down.
>=20
> The ksz8873mll_read_status() function is trying to read a non-standard
> MDIO register that is not handled by the ksz8795 driver's MDIO
> emulation (and is not documented as existing on the KSZ8873MLL,
> either!).  It also also reports link up, which is obviously not
> correct for an external port.
>=20
> I'll post a patch as a reply to this.
>=20
> Ben.

Thanks Ben,

That looks reasonable to me. My board is running the external ports at =
10HD so
I didn't pick this up, but your patch looks correct.

Cheers,
Steve=
