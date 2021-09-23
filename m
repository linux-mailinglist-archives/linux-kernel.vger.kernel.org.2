Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDAC415BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbhIWKLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:11:24 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:19145 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:11:24 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 18NA9pCO039041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:09:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1632391786; x=1634983786;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8uLEPirSzFXXJhghyMD5pFq6MZ0M2Si7Jy50+8SWWM4=;
        b=TaHoTfQ0wyI13DueDKuviTjMXAm96gHwikesLSW0hTjKYm30LVFqwiR1/lTiqbO7
        Bin2Roe2HMDmT2umcVNeRd2GBAi5B7Awst3QMEZSqNMsYuCyXVsoO2XKljEMQ9Dl
        jMFzVi5mpTIvhs8uxH37znGrpCWoe5Oigpypp7XiUxDaMIzuF9Gmz9ql5PxP8ZFE
        Tw3Ep/JXFhauUIMR/I6CkOBxbdJWLVZ2/UYAS0HJJDeWC+bol4oa8/aNSpgZ+fw7
        tMlMfkiJgW6ubxq5rU4SPnlmlfSMdT7I7KT6K4xVbwKgK/3usun+J0yAg519fYNv
        bnuxiuRtsgpPkHz1Oiacfw==;
X-AuditID: 8b5b014d-ba8f670000005d46-40-614c526a5842
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 70.5C.23878.A625C416; Thu, 23 Sep 2021 13:09:46 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 23 Sep 2021 13:09:45 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
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
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
Organization: FORTH
In-Reply-To: <CAAeLtUDu0yaDBcuC06nX1WUQC9k4eNuWjvAFrpkP_h0nf5BZAw@mail.gmail.com>
References: <20210923072716.913826-1-guoren@kernel.org>
 <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
 <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr>
 <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
 <CAAeLtUDu0yaDBcuC06nX1WUQC9k4eNuWjvAFrpkP_h0nf5BZAw@mail.gmail.com>
Message-ID: <88696248a0c19a5dff660354b837514d@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsXSHT1dWTcryCfRYM4RPosnh9rZLKYdOMRu
        0TphN4vFkw8T2SxaPrxjtfg76Ri7xaIV31ksluyUttjzag+7xYXmHkaLeyuWsVvs7p/DYrH9
        /Hc2ixd7G1ksjj/axWKxcvVRJosLjTfZLS6vns9k8fzUMTaLS1+usVhc3jWHzWLb5xY2i5Xr
        jjFbzPjxj9Gi+d05doutG9cxWnSvrLY4ueEAo8WapVMZLVr2T2Gx+HnoPJPFwtfz2B0UPF61
        PWPy+P1rEqPHu9/LGD2m/j7D4rGm8zWTx6yGXjaPO+fOs3lseLSa1eP/oZUsHjtn3WX3WLCp
        1KPlyFtWj4ebLjF5bFrVyeax86Glx+Yl9QESUVw2Kak5mWWpRfp2CVwZHWsb2Au2slbsnjmN
        sYFxNksXIyeHhICJxNwF79m7GLk4hASOMkoc+vqeDSJhKjF7bycjiM0rIChxcuYTsAZmAQuJ
        qVf2M0LY8hLNW2czg9gsAqoSuz99YwKx2QQ0JeZfOghWLyKgJ3H4/C4WkAXMAjs4JTb8Byni
        4mAQuMEocW7XarBJwgLmEm+/NrCD2PwCwhKf7l5kBbE5BQIlbl34BbZBSOAbk8StR2IQF7lI
        /P3wmRniUhWJD78fAPVycIgC2ZvnKk1gFJqF5O5ZSO6eheTuBYzMqxgFEsuM9TKTi/XS8otK
        MvTSizYxgpMNo+8Oxtub3+odYmTiYDzEKMHBrCTC+/mGV6IQb0piZVVqUX58UWlOavEhRmkO
        FiVxXl69CfFCAumJJanZqakFqUUwWSYOTqkGJu13+r2T1Jg4jTx+35uUxGpyek9L8+W0fot6
        bwF2g9AnG9Z4pp1YrHvqctRhr/OZc9Nsr/dOzde8e78k/Zzu9ZZlM2pDV2V/eBdy1Vp7rt1+
        IaOlfUZfw18tU//YVse1YOKVO3KBn+7qTo2ukbYWtzGL1/yv36CaaiFWL3r54I+NJzcvlcj8
        nH1nfm+I8kWNuKtWElu29/U+Zbe6VLGkjC3d76pGpsSrN0INJ/luxs87lhe5fPv8Rwt+rJVW
        j4kpv+g1uziwQvcN62dX5mVLdfs3tzPmTCqozL/xzuyqyhWlPblzvbknsxQdP+Du/+nvqX+F
        D74qXH0955aw96fzWdams+tVxKqVj/7qev7IXomlOCPRUIu5qDgRAP/jkDSlAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-09-23 13:04, Philipp Tomsich έγραψε:
> 
> How if we expand this to a mmu subnode in cpu@x and add a booleans for 
> adornments like svnapot and svpbmt?
> The older mmu-type could then treated to indicate a mmu w/o any 
> adornments specified.  I am aware that this generates an additional 
> parsing-path that will be maintained, but it will allow future 
> properties to be grouped.
> 
> cpu@0 {
> ...
> mmu {
> type = "riscv,sv39";
> supports-svpbmt;
> }
> ...
> }

I was about to propose the same thing, we can do this now without 
breaking backwards compatibility, we don't really use mmu-type property 
at this point, we are either sv39 or nommu.
