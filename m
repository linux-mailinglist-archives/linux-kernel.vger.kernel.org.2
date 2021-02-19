Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2D31F54F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhBSHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:12:11 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:55876 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:12:08 -0500
Date:   Fri, 19 Feb 2021 07:10:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613718643;
        bh=IilQbrURoxVGYoN+0YWmzRSHrM3TBzF2c3XiNCRyIgY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aHfU/SAiY+R+mCYhf1t+QIce+4+reHlaNon2wOC90r1/pIi4yLuezWsBfeFy9ENVe
         vR9E65cSJ4RQdEPIG8v/IqaHWZ7dBp8BDCNoFINl0cTnz9Ngj0jnTCzBmCQJxAWwnr
         rlULu/HqCLHLDsRYVkO6jgog0ednUDxyfLhCJLLQ=
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Reply-To: Jari Ruusu <jariruusu@protonmail.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com>
In-Reply-To: <YC6nZH/4CkLLsxxB@kroah.com>
References: <YA/E1bHRmZb50MlS@kroah.com> <YCzknUTDytY8gRA8@kroah.com> <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com> <YC4atKmK7ZqlOGER@kroah.com> <20210218113107.GA12547@1wt.eu> <602E766F.758C74D8@users.sourceforge.net> <20210218143341.GB13671@1wt.eu> <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com> <YC6nZH/4CkLLsxxB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 18, 2021 7:44 PM, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> > It was the other way around. Fine working in-tree driver got
> > broken by backported "fixes". I did mention bit-rot.
>
> It did? Please let us stable maintainers know about, we will always
> gladly revert problems patches. What commits caused the problem?

I don't have a list of commits for you. It took me long time to
figure out that it was iwlwifi that was causing those problems.

In-tree iwlwifi on 4.19.y kernels needs professional quality
locking audit and backporting of necessary fixes from upstream
Intel out-of-tree version.

> So something in the 4.9.y and 4.14.y stable kernels caused a regression,
> can you please do 'git bisect' to let us know what broke?

My ability to do WiFi tests on that laptop computer are limited
for now. Earlier that laptop's connectivity to world was through
mobile WiFi router. That mobile WiFi router no longer has a
SIM-card, so no connectivity through that anymore. That laptop's
connectivity to world is now through wired ethernet to fiber.

It was actually this switch to ethernet/fiber that made me realize
the brokenness on in-tree iwlwifi on 4.19.y kernels. When in-tree
WiFi was not used, those problems never triggered. Switched back
to in-tree WiFi, and problems came back. Switched to out-of-tree
Intel version of iwlwifi, problems went away again. Then I looked
at the fixes in out-of-tree Intel version of iwlwifi that were
missing in in-tree version, and I understood why that was so.

Those stability issues on in-tree iwlwifi on 4.19.y kernels are
difficult to trigger. Sometimes it may take days to trigger it
once. Sometimes I was unlucky enough to trigger them more than
once a day. I say that two weeks of operation without issues are
needed to pronounce those issues gone.

Currently, special arrangements are needed for me to test WiFi at
all on that laptop computer, and those arrangements are something
I am not willing to commit for multi-week testing run. Sorry.

> And if 4.19.0 was always broken, why didn't you report that as well?

I didn't test early 4.19.y kernels.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

