Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBAE320A0E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 12:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBULkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:40:15 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:48544 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhBULkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:40:10 -0500
Date:   Sun, 21 Feb 2021 11:38:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613907525;
        bh=a3IDBP1MUD9HVWhd+LV35seWKF7UAKzn50KHWLxZjLs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=jeA4FCl12JIu9/6k7T8wCa4iAkeZjzYowzqqnIzHnK+GORYGfCisT2MICkGmlSIWA
         R3K7oW71zzR2L8oyVt2ZIcik2GM3V5iGQTWuOADIF/ZlqDB/mB+qARomfJd20aqLbW
         mvgYCVu+jTcYvlD8Ac4LaiOUOWMWcvAq7Sm2Pkyo=
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
Message-ID: <wZCdYp_4tvo3IvJ4KO3jTbgJaofJam1HGxEuIm09vHQPhoCx4eWLaoZ7yBRvHg_aMA51hqW5SGTV8nshbHebC6LdiUoln5MC5G925JMQrE0=@protonmail.com>
In-Reply-To: <YDEzOg4WTRWBC7DS@kroah.com>
References: <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com> <YC91OWVGAfyorRbc@kroah.com> <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com> <YC+U+beaI91aXh5z@kroah.com> <OurD0pqDIPLLZlt1kk-JE57wXeMoh0NFPKKcBrbY3ValknDXcpLwAJz6x1DMbB6LNZ6FDdeUrPM-pX60VF5FERTiDK_gzgHy4tq7iG3MFAM=@protonmail.com> <YC+d/NyXDebGSHwN@kroah.com> <NBnmv-hTU50xKWL-Q7clpw69elSJgEX7kWA2LiuvzVJ4uOwh8xc5yh83qQDmAfMZl8OcCZxatCZ84dxV2-R2bv25kZLhW0howAP0kOadkwE=@protonmail.com> <RpmkVZBUhx36C8VTTIM1SZz6jf46qBoOL4rMaBMuTMRTe-TQGmEfgeMcrGhXWt1N6SSPrHfFERM_hzHRBod7Xn9XV6d0cyEHoQ8nqXi7rXA=@protonmail.com> <YDEzOg4WTRWBC7DS@kroah.com>
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

On Saturday, February 20, 2021 6:05 PM, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> On Sat, Feb 20, 2021 at 01:29:21PM +0000, Jari Ruusu wrote:
> > I have been able to narrow the beginning of the problem to these kernel=
s:
> > 4.14.188 ... 4.14.202
> > Same "fix" that went info 4.14.y is also bugging 4.19.y kernels.
>
> Great, any chance you can narrow this down to the commit itself?

I am not able to test WiFi on that laptop computer anymore,
because that laptop now connects to world using wired connection.
It was that WiFI->wired connection change that led me to realize
the buggyness of in-tree iwlwifi in 4.19.y kernels.

I did that narrowing to specific kernel versions by digging my
archived backup files and their notes. No tests were run.

Problems started triggering in those kernels that I mentioned in
earlier email. That does not mean that the bugs were not already
there in kernels older that those. Maybe some change just widened
"window of opportunity" enough for me to see the issues.

In-tree iwlwifi in 4.19.y is missing locking fixes. No amount of
smooth-talking is going to change that.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

