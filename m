Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F141A42F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 02:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhI1AZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 20:25:30 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:20409 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbhI1AZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:25:29 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 18S0Nk73077350
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:23:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1632788621; x=1635380621;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H4H4eHZ/VB5yQHB7IzcqAr0zdp0RwBZizZ+dsLp428E=;
        b=sNfQG71BU+m15ZBqpIM20Jl0Adajon9dQxJtOmnZNBc/pj49T1vSXigQGzlxXnK+
        6dhAR78y55ml3vSJA9jXWRRlkn5ihVg+cWnaleeLXETlDLh89P4wJAnAROQN2feL
        BNwxcZ7rjSNV8Lls2mmLxXk0h7fCOOh3nKJVSquCuGhJwRNXcbKk+6HrUNYxiw71
        lbAUj5UzMvMhkugELcfTVRPBBuUCCR1AOHlzuFEzJdw2l7nptigs2esUy22FKwIV
        +zVs+/TxmAbx0+NU6CuQm6Ti9AfSXtBLkkVLCJz+XPa3jBkRg+32N5VpZZfAP9lL
        nsleE/GIT3o24n+554MhOQ==;
X-AuditID: 8b5b014d-b84f570000005d46-96-6152608d7b89
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 92.5D.23878.D8062516; Tue, 28 Sep 2021 03:23:41 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 28 Sep 2021 03:23:37 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Greg Favor <gfavor@ventanamicro.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
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
In-Reply-To: <CA+Qh7T=kud8AM-6JjuWNwJY0r_gkmnP6SmzVXqeE2VYxViLUoQ@mail.gmail.com>
References: <20210923172107.1117604-1-guoren@kernel.org>
 <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
 <CA+Qh7T=kud8AM-6JjuWNwJY0r_gkmnP6SmzVXqeE2VYxViLUoQ@mail.gmail.com>
Message-ID: <ce3bb9f5c72f0feb1cf9a0d67edaedf6@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsXSHT1dWbc3ISjRYF6DvsWTQ+1sFtMOHGK3
        aJ2wm8XiyYeJbBZ/Jx1jt1i04juLRcc5N4slO6Ut9rzaw25xobmH0eLeimXsFrv757BYbD//
        nc3ixd5GFovjj3axWKxcfZTJ4kLjTXaLy6vnM1k8P3WMzeLSl2ssFpd3zWGz2Pa5hc1i5bpj
        zBYzfvxjtGh+d47d4uXlHmaLrRvXMVp0r6y2OLnhAKPFmqVTGS1a9k9hsfh56DyTxcLX89gd
        FD1etT1j8vj9axKjx7WOjSwe734vY/RY0/mayWNWQy+bx51z59k8Njxazerx5uVLFo//h1ay
        eOycdZfdY8GmUo+WI29ZPR5uusTksWlVJ5vHzoeWAZJRXDYpqTmZZalF+nYJXBkz33QwF1zl
        qGjeNo2lgfEbWxcjJ4eEgInE0u7HrF2MXBxCAkcZJebv/8AEkTCVmL23kxHE5hUQlDg58wkL
        iM0sYCEx9cp+RghbXqJ562xmEJtFQFVi5a4dYDabgKbE/EsHwepFBDQkTn7bxw6ygFlgF6fE
        lcONYI6EwEQmiV9XpoJNEhawk1g+byvYZn4BYYlPdy8CncTBwSkQKHFtcxrEdb1MEr9bn7BB
        XOQisendZFaIS1UkPvx+wA5SLwpkb56rNIFRaBaSu2chuXsWkrsXMDKvYhRILDPWy0wu1kvL
        LyrJ0Esv2sQITjuMvjsYb29+q3eIkYmD8RCjBAezkghvMIt/ohBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXFeXr0J8UIC6YklqdmpqQWpRTBZJg5OqQamJWsNI8MrhTznWWta7u5dcyNoY7Rdxcpn
        Jk5VN39zWctHPm/MNTvw/5zDrcurjhhHKZh/vSl45NiD+2c6ZFP4V8Uf2+9vm/2Z1UjawmRP
        9M9bf9w1tMMiVxWpr7/0pfqjAovWtYXPVCJXzto4N2th9BWBlTnX455n3M07kn6+abuCe1nV
        PldWrrMzmNbcbRGI/rRfMHT3fb6aFS7iHCelOrfdP9/F7cjO/dapeOWB2b7p03nYLJ52C70p
        1Egx/3ckZlG1GmO293Nh8dPp92e3Hj8m/OqTWd6EC3LSNhc04758rfxX+mv6xJf3g+ZqHNgo
        97e5fH9A9PVX1pECQuH/z1/ftrejJGl65u7Vrzt5lFiKMxINtZiLihMBau+qEaoDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Στις 2021-09-27 23:53, Greg Favor έγραψε:
> With the big caveat that I haven't been in the middle of this 
> discussion, it seems like Allwinner D1's changes represent a custom 
> (and nonconforming) extension.  Isn't this just a matter of the patch 
> needing to be treated as for a RISC-V custom extension per the recently 
> clarified policy for handling upstreaming/etc. of custom extensions?  
> (Philipp can speak to this clarified policy.)  Or what am I missing?
> 

The Priv. Spec. defines sv39/48 without allowing custom use of reserved 
pte bits by implementations, Allwinner D1 claims to be sv39 but it does 
use reserved PTE bits. When vendors want to do custom stuff on PTEs, the 
standard says they may use values 14-15 on satp.mode for that and define 
their own MMU basically. Messing up with the implementation of sv39 is 
not an extension, is violation of sv39. Even worse this implementation 
can't work if we ignore the customization since without setting the 
required bits on PTEs dma (and I believe SMP as well) doesn't work.

Regards,
Nick
