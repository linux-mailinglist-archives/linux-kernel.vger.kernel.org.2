Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27A415B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbhIWJuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:50:01 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:30114 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbhIWJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:49:55 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 18N9mKjl038266
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:48:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1632390495; x=1634982495;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b40pxG74vSyzDsUyZQqj5rECdnyCEnKf/bmituQ7HGQ=;
        b=V0AwFjJwMt9ytoSGdr4fLFEfbQoduL+VS+PcwZA6BZE++rej7lwPTa2ujaSC6Ozp
        /gAfSYjSaEDWi5/XF0hVRH4bBxOh1UnWOoY+lCC9IDB6EZ/cQ77yVIbb1DD0PB9B
        IfSJqLXiZgTCv8VNB17ejkWcqNBirqWSR9MiTLsL5uULhKk2+01rxR6qxAFvwjnl
        4H4VxP29tbvjOzgwEZTiCzovnNPDE3KQm90/S+WkWWi5DyZKd9SyIXoDmwoVWTw2
        ZwyMKXEdsdMEacCrlRLqaxEkzQ/RZ59xxGPCqaedD22EvqELUgK7k2l354HB5op9
        gX1JRoL0w2stoTiMblR6bw==;
X-AuditID: 8b5b014d-ba8f670000005d46-5e-614c4d5edca6
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 20.1C.23878.E5D4C416; Thu, 23 Sep 2021 12:48:15 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 23 Sep 2021 12:48:13 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
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
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
Organization: FORTH
In-Reply-To: <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr>
References: <20210923072716.913826-1-guoren@kernel.org>
 <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
 <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr>
Message-ID: <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42Lpjp6urBvv65NoMOsWi8WTQ+1sFtMOHGK3
        aJ2wG8j9MJHNouXDO1aLv5OOsVssWvGdxWLJTmmLPa/2sFtcaO5htLi3Yhm7xe7+OSwW289/
        Z7N4sbeRxeL4o10sFitXH2WyuNB4k93i8ur5TBbPTx1js7j05RqLxeVdc9gstn1uYbNYue4Y
        s8WMH/8YLZrfnWO32LpxHaNF98pqi5MbDjBarFk6ldGiZf8UFoufh84zWSx8PY/dQcHjVdsz
        Jo/fvyYxerz7vYzRY+rvMyweazpfM3nMauhl87hz7jybx4ZHq1k9/h9ayeKxc9Zddo8Fm0o9
        Wo68ZfV4uOkSk8emVZ1sHjsfWnpsXlIfIBHFZZOSmpNZllqkb5fAlfH+J3fBM76KeUfOsjcw
        vubuYuTkkBAwkZi+qJGli5GLQ0jgKKPEm3sv2CESphKz93Yygti8AoISJ2c+YQGxmQUsJKZe
        2c8IYctLNG+dzQxiswioSvz7eBisl01AU2L+pYNg9SIC6hKdz98wgixgFpjJLbHz/FewZmEB
        c4m3XxvAGvgFhCU+3b3ICmJzCrhKbJ3exghx0RdGiX0zT7JDXOEi8WT9bCaI61QkPvx+ABTn
        4BAFsjfPVZrAKDgLya2zkNw6C8mtCxiZVzEKJJYZ62UmF+ul5ReVZOilF21iBKcURt8djLc3
        v9U7xMjEwXiIUYKDWUmE9/MNr0Qh3pTEyqrUovz4otKc1OJDjNIcLErivLx6E+KFBNITS1Kz
        U1MLUotgskwcnFINTIoxbxTs1F/vquCMceK//yeO/3/Qg3X38jd/z9BM4TTWPpG50j1xkUY1
        V9DP6M+Z+4p+fHb0Z83JeKXj57y3oHiR5dHU06riPz7pSh1LP7S27cSSyq9LKy0zAxj0e5w5
        7ptKRDuz2uYLv7t0MXUfh9ILm2fdt3KNprS42224n5TwjT/dOE1/w+5sg6jDb1t9Aj1t5JNr
        VBPYtjxTr4n9pSyrcmXvbuGGVcyT3x1b6VigWqgst1CsozTZ/o91yLe3nw9JvK2+eYfpyKd9
        n6yvyAe9aalIunpN+lmsmucdgz9Pg46/ULfKW2I1/ePzeRa3966ozVkvJVEn+Wd9ur1XxRd7
        jhfmhw5GdIUW/HVRYinOSDTUYi4qTgQAqeAjvJgDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-09-23 12:42, Nick Kossifidis έγραψε:
> Στις 2021-09-23 12:37, Anup Patel έγραψε:
>> On Thu, Sep 23, 2021 at 2:55 PM Nick Kossifidis <mick@ics.forth.gr> 
>> wrote:
>>> 
>>> Hello Guo,
>>> 
>>> Στις 2021-09-23 10:27, guoren@kernel.org έγραψε:
>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
>>> b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>> index e534f6a7cfa1..1825cd8db0de 100644
>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>>> @@ -56,7 +56,9 @@ properties:
>>>       enum:
>>>         - riscv,sv32
>>>         - riscv,sv39
>>> +      - riscv,sv39,svpbmt
>>>         - riscv,sv48
>>> +      - riscv,sv48,svpbmt
>>>         - riscv,none
>>> 
>>> Isn't svpbmt orthogonal to the mmu type ? It's a functionality that 
>>> can
>>> be present on either sv39/48/57 so why not have another "svpbmt"
>>> property directly on the cpu node ?
>> 
>> Actually, "mmu-type" would be a good place because it's page based
>> memory attribute and paging can't exist without mmu translation mode.
>> 
>> Also, "svpmbt" is indeed a CPU property so has to be feature 
>> individual
>> CPU node. Hypothetically, a heterogeneous system is possible where
>> some CPUs have "svpmbt" and some CPUs don't have "svpmbt". For
>> example, a future FUxxx SoC might have a E-core and few S-cores
>> where S-cores have Svpmbt whereas E-core does not have Svpmbt
>> because it's an embedded core.
>> 
> 
> I should say cpuX node, not the root /cpu node. We can have an svpbmt
> property in the same way we have an mmu-type property.
> 

I'm also thinking of future mmu-related extensions, e.g. what about 
svnapot ? Should we have mmu-type be riscv,sv39,svnapot and e.g. 
riscv.sv39,svpbmt,svnapot ? It'll become messy.

Regards,
Nick
