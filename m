Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4132058B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 14:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhBTNaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 08:30:10 -0500
Received: from mail-40138.protonmail.ch ([185.70.40.138]:49288 "EHLO
        mail-40138.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBTNaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 08:30:08 -0500
X-Greylist: delayed 109123 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Feb 2021 08:30:08 EST
Date:   Sat, 20 Feb 2021 13:29:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613827765;
        bh=nBN6LG4sLZ4L3bMupaUJy01he70RPBUnzyMU2l20OWs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=XfPuUb9GYzZwart2A+TiOfpJpDr1OfnrO2u8jxpCST7s++naA1GH6zRsPxP9X63Ln
         VDSeM16yFsgc9YAtSqHw0BQyj8EZSdpND4KoUfCxQ1+8FNmwqFa+qjL0hHe7c/mcQO
         vFKQl4zzUoPTPVlQy0QsSRUAVnQiSfRwUj4qIBIo=
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
Message-ID: <RpmkVZBUhx36C8VTTIM1SZz6jf46qBoOL4rMaBMuTMRTe-TQGmEfgeMcrGhXWt1N6SSPrHfFERM_hzHRBod7Xn9XV6d0cyEHoQ8nqXi7rXA=@protonmail.com>
In-Reply-To: <NBnmv-hTU50xKWL-Q7clpw69elSJgEX7kWA2LiuvzVJ4uOwh8xc5yh83qQDmAfMZl8OcCZxatCZ84dxV2-R2bv25kZLhW0howAP0kOadkwE=@protonmail.com>
References: <YA/E1bHRmZb50MlS@kroah.com> <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com> <YC6nZH/4CkLLsxxB@kroah.com> <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com> <YC91OWVGAfyorRbc@kroah.com> <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com> <YC+U+beaI91aXh5z@kroah.com> <OurD0pqDIPLLZlt1kk-JE57wXeMoh0NFPKKcBrbY3ValknDXcpLwAJz6x1DMbB6LNZ6FDdeUrPM-pX60VF5FERTiDK_gzgHy4tq7iG3MFAM=@protonmail.com> <YC+d/NyXDebGSHwN@kroah.com> <NBnmv-hTU50xKWL-Q7clpw69elSJgEX7kWA2LiuvzVJ4uOwh8xc5yh83qQDmAfMZl8OcCZxatCZ84dxV2-R2bv25kZLhW0howAP0kOadkwE=@protonmail.com>
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

On Friday, February 19, 2021 5:23 PM, Jari Ruusu <jariruusu@protonmail.com>=
 wrote:
> My contribution here is trying to point you guys to right direction.

I have been able to narrow the beginning of the problem to these kernels:
4.14.188 ... 4.14.202

Same "fix" that went info 4.14.y is also bugging 4.19.y kernels.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

