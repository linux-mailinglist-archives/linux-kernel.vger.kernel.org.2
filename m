Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9601341A473
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 03:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhI1BD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 21:03:56 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:35585 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhI1BDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 21:03:54 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 18S12ENu078406
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:02:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1632790929; x=1635382929;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aKI1g1YuFemJMSGp7WOPcbguj+DMCSUHf8jtNniFvYo=;
        b=bYOLrvo7NDJSeYEzeFjiqW45kRxxpYicGEeEyMfIx3Z5pLn1w4A57slB8nBCOU2I
        i6Ax5sztnM3PDQrg5Ildu3LumNOlz/drBXX7uvk0+l8M3FX7vw2YHvzyXtakaoHk
        o6B9ip/JFXF984RXGjHCU9mNuyt9ibwlO1LqGVzGFEcLcqxoP390ZoZFkUrNTa51
        Ov3qfzVCvkPL6aCEnw0rlTcEdQDiDnCKfe+q2RbNgqlBtzJkA5xmWp6GhedMGJqR
        SzgfaJvB/rpVfgW8io9cqILdRX6Fh0V7dBn8dcoPp6Ezi+wpjt8GLqgeqfFJVyN8
        TOQYCDnavU0nPk0SrJ/4EQ==;
X-AuditID: 8b5b014d-b84f570000005d46-95-61526991456f
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id CB.8D.23878.19962516; Tue, 28 Sep 2021 04:02:09 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 28 Sep 2021 04:02:06 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?Q?Wei_Wu_=28=E5=90=B4=E4=BC=9F=29?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
Organization: FORTH
In-Reply-To: <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
References: <20210923172107.1117604-1-guoren@kernel.org>
 <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
Message-ID: <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42Lpjp6urDsxMyjRYPJUVYsnh9rZLKYdOMRu
        0TphN4vFkw8T2Sz+TjrGbrFoxXcWi45zbhZLdkpb7Hm1h93iQnMPo8W9FcvYLXb3z2Gx2H7+
        O5vFi72NLBbHH+1isVi5+iiTxYXGm+wWl1fPZ7J4fuoYm8WlL9dYLC7vmsNmse1zC5vFynXH
        mC1m/PjHaNH87hy7xcvLPcwWWzeuY7ToXlltcXLDAUaLNUunMlq07J/CYvHz0Hkmi4Wv57E7
        KHq8anvG5PH71yRGj2sdG1k83v1exuixpvM1k8eshl42jzvnzrN5bHi0mtXjzcuXLB7/D61k
        8dg56y67x4JNpR4tR96yejzcdInJY9OqTjaPnQ8tAySjuGxSUnMyy1KL9O0SuDJ2vnrEXNDP
        X9Fwpp2lgbGZp4uRk0NCwETiU/MGpi5GLg4hgaOMEovmzWaHSJhKzN7byQhi8woISpyc+YQF
        xGYWsJCYemU/I4QtL9G8dTYziM0ioCoxZd4NsBo2AU2J+ZcOgtkiAuoS17f8BFvALHCGW6Ln
        xQQ2kISwgJ3E8nlbmUBsfgFhiU93L7J2MXJwcAoEShycxgoSFhI4xijx5FUVxA0uEqd/noS6
        TUXiw+8H7CDlokD25rlKExgFZyG5dBaSS2chuXQBI/MqRoHEMmO9zORivbT8opIMvfSiTYzg
        1MLou4Px9ua3eocYmTgYDzFKcDArifAGs/gnCvGmJFZWpRblxxeV5qQWH2KU5mBREufl1ZsQ
        LySQnliSmp2aWpBaBJNl4uCUamCquGY/Q2M15+31WXHb/5q92/7nsdCaPcZn+d/YhvqcCv4Q
        kMwgaZUtZGj1Wb096myz3fwUxsYXAjKvZerVXokoN8+/tGn+hO1vf99RW2e396DaF5YsfoGI
        5xs4Ml57flWadXL1+qqT1z9Y7ms+90BBbUOuzNnEtLhlx4OXfn3LbRzwSb3T27P48uoz7rsE
        Qxt36lzwUvmxO2Ynw903lY+nmdrvulZ4wzqmcJ69ye3Ib1X8zFYbwrNNHG4cPsXIfVm5Ysmv
        7++fLws92CUh3cYodX+B9iKhDE7+OXWsrm9ZGNj+vBfKXx1nKpnmP2/OFx83FcaOs4fyDwu9
        +MfOlbddwsjZgatbUN6o8POXRDslluKMREMt5qLiRACfBDtpnAMAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-09-27 23:13, Atish Patra έγραψε:
>> We need to decide whether we should support the upstream kernel for 
>> D1. Few things to consider.
>> – Can it be considered as an errata ?

It's one thing to follow the spec and have an error in the 
implementation, and another to not follow the spec.

>> – Does it set a bad precedent and open can of worms in future ?

IMHO yes, I'm thinking of Kendryte 210 devs for example coming up and 
asking for MMU support, they 've also shipped many chips already. I can 
also imagine other vendors in the future coming up with implementations 
that violate the spec in which case handling the standard stuff will 
become messy and complex, and hurt performance/security. We'll end up 
filling the code with exceptions and tweaks all over the place. We need 
to be strict about what is "riscv" and what's "draft riscv" or "riscv 
inspired", and what we are willing to support upstream. I can understand 
supporting vendor extensions upstream but they need to fit within the 
standard spec, we can't have for example extensions that use encoding 
space/csrs/fields etc reserved for standard use, they may only use 
what's reserved for custom/vendor use. At least let's agree on that.

>> – Can we just ignore D1 given the mass volume ?
>> 

IMHO no, we need to find a way to support it upstream but I believe 
there is another question to answer:

Do we also guarantee "one image to rule them all" approach, required by 
binary distros, for implementations that violate the spec ? Are we ok 
for example to support Allwinner D1 upstream but require a custom 
configuration/build instead of supporting it with the "generic" image ? 
In one case we need to handle the violation at runtime and introduce 
overhead for everyone (like looking up __riscv_svpbmt every time we set 
a PTE in this case), in the other it's an #ifdef.

Regards,
Nick
