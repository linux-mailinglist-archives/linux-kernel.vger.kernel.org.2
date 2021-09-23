Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F4415B32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbhIWJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:44:07 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:29843 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbhIWJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:44:06 -0400
X-Greylist: delayed 1092 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 05:44:05 EDT
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 18N9gXeI038035
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:42:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1632390148; x=1634982148;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=REVIbiYY3tzh8nWvkfpsBLWmSnyEr4yRMntSdzxF5UA=;
        b=V59fssE5tBUm7ZA/ovi83MXG0MyFNiPGmIXYgcDAr5FJ2hZp0K3UUcEaKj0hnHg5
        QVCm75G7OG+aIcrqbaVtEYyS68rqHLYirByBk9pyAcVyC7WDMnDrm+1ZRqqkZkuE
        479nGizkAzou0nFMUgs03U1ONqhF8ESmun+IoPZ+v20tHk1E6J4X4t9C0+GCPmmU
        NZhgwB2JLUe8i++IHG5P0FNEPqlH+NauyxfLgqLXnfRZprXr/lAMs+6mKikcA44l
        sY4vtL+jD5fBiZaBGvexD6NXrnUGg/W2SsOaGVQNdmwtLsOGX3HX7YYztBwKj478
        Dxf/Z5p/qAOj874i19ctfw==;
X-AuditID: 8b5b014d-ba8f670000005d46-f0-614c4c0469b6
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id AF.FB.23878.40C4C416; Thu, 23 Sep 2021 12:42:28 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 23 Sep 2021 12:42:28 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Anup Patel <anup@brainfault.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>, Guo Ren <guoren@kernel.org>,
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
In-Reply-To: <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
References: <20210923072716.913826-1-guoren@kernel.org>
 <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
Message-ID: <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42Lpjp6urMvi45NocPWDmsWTQ+1sFtMOHGK3
        aJ2wm8XiyYeJbBYtH96xWvyddIzdYtGK7ywWS3ZKW+x5tYfd4kJzD6PFvRXL2C12989hsdh+
        /jubxYu9jSwWxx/tYrFYufook8WFxpvsFpdXz2eyeH7qGJvFpS/XWCwu75rDZrHtcwubxcp1
        x5gtZvz4x2jR/O4cu8XWjesYLbpXVluc3HCA0WLN0qmMFi37p7BY/Dx0nsli4et57A4KHq/a
        njF5/P41idHj3e9ljB5Tf59h8VjT+ZrJY1ZDL5vHnXPn2Tw2PFrN6vH/0EoWj52z7rJ7LNhU
        6tFy5C2rx8NNl5g8Nq3qZPPY+dDSY/OS+gCJKC6blNSczLLUIn27BK6M+1+vMRXs5ak4vu84
        YwPjJ84uRk4OCQETiW3rXjGD2EICRxklzr6Rg4ibSsze28kIYvMKCEqcnPmEBcRmFrCQmHpl
        PyOELS/RvHU2WC+LgKrE9wc/WEFsNgFNifmXDoLViwioSDx/eg6onguofg63xMZ9P5lAEsIC
        5hJvvzawg9j8AsISn+5eBGvmFAiUuPLjIwtIg5DATkaJ6c+fMUNc4SLxcvNXRojrVCQ+/H4A
        1MzBIQpkb56rNIFRcBaSW2chuXUWklsXMDKvYhRILDPWy0wu1kvLLyrJ0Esv2sQITimMvjsY
        b29+q3eIkYmD8RCjBAezkgjv5xteiUK8KYmVValF+fFFpTmpxYcYpTlYlMR5efUmxAsJpCeW
        pGanphakFsFkmTg4pRqYPEMN3u/PkwrWjOr9k2vz6k6sYGz1pCUJ0rWfnDw1udYaLDdXc1I7
        qsfXExZSy/Fiy6yuK3Knsvc3rjq64GlUYu9DM58/l9cab5W8lf73q1CCklxESNHiTQ0SXuo3
        D16tLddfZTD/w4LlcVsmRRjtjdkWlDUlfsXpe+eZetyfHl7IcMIu2zMjeLukn+XzlohLKyaa
        8rdPet/H55x46amiRhVXVNA1oQWRm9yeFE9yixIonbYy7tDPwxbtb535JBmutc675vGyo31x
        sHnedKsnd+LmandMVDbcyiL5csr9zx8EBGr68748v9zmnsS+PPno7cBmvg8Xvx6/fEDCbffC
        BYHbnZRjti/42njfUnyfEktxRqKhFnNRcSIANIa0FpgDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-09-23 12:37, Anup Patel έγραψε:
> On Thu, Sep 23, 2021 at 2:55 PM Nick Kossifidis <mick@ics.forth.gr> 
> wrote:
>> 
>> Hello Guo,
>> 
>> Στις 2021-09-23 10:27, guoren@kernel.org έγραψε:
>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> index e534f6a7cfa1..1825cd8db0de 100644
>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> @@ -56,7 +56,9 @@ properties:
>>       enum:
>>         - riscv,sv32
>>         - riscv,sv39
>> +      - riscv,sv39,svpbmt
>>         - riscv,sv48
>> +      - riscv,sv48,svpbmt
>>         - riscv,none
>> 
>> Isn't svpbmt orthogonal to the mmu type ? It's a functionality that 
>> can
>> be present on either sv39/48/57 so why not have another "svpbmt"
>> property directly on the cpu node ?
> 
> Actually, "mmu-type" would be a good place because it's page based
> memory attribute and paging can't exist without mmu translation mode.
> 
> Also, "svpmbt" is indeed a CPU property so has to be feature individual
> CPU node. Hypothetically, a heterogeneous system is possible where
> some CPUs have "svpmbt" and some CPUs don't have "svpmbt". For
> example, a future FUxxx SoC might have a E-core and few S-cores
> where S-cores have Svpmbt whereas E-core does not have Svpmbt
> because it's an embedded core.
> 

I should say cpuX node, not the root /cpu node. We can have an svpbmt 
property in the same way we have an mmu-type property.

Regards,
Nick
