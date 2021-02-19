Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92BF31FBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhBSPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:24:53 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:33304 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:24:49 -0500
Date:   Fri, 19 Feb 2021 15:23:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613748198;
        bh=MueneSwKDccF8X96BfyJ3qZPMNE2w94bTNHVduNARbg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=pE2OQnnLhRBWcydc1IOD+/mwIkFzr3fFrUw31hz7kT55R9Dqgd2rHA87xF8IC+bmE
         FB17O3YtzQH/qNnbOG3wG3BiN81XOrA2SHHb0XSv3xJi+LZaP3IczMqqRwHJFBwpmw
         m9aIis1BhyQ1+EROHUAe3dElemmXRH+6mBuOMn3Q=
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
Message-ID: <NBnmv-hTU50xKWL-Q7clpw69elSJgEX7kWA2LiuvzVJ4uOwh8xc5yh83qQDmAfMZl8OcCZxatCZ84dxV2-R2bv25kZLhW0howAP0kOadkwE=@protonmail.com>
In-Reply-To: <YC+d/NyXDebGSHwN@kroah.com>
References: <YA/E1bHRmZb50MlS@kroah.com> <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com> <YC6nZH/4CkLLsxxB@kroah.com> <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com> <YC91OWVGAfyorRbc@kroah.com> <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com> <YC+U+beaI91aXh5z@kroah.com> <OurD0pqDIPLLZlt1kk-JE57wXeMoh0NFPKKcBrbY3ValknDXcpLwAJz6x1DMbB6LNZ6FDdeUrPM-pX60VF5FERTiDK_gzgHy4tq7iG3MFAM=@protonmail.com> <YC+d/NyXDebGSHwN@kroah.com>
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

On Friday, February 19, 2021 1:16 PM, Greg Kroah-Hartman <gregkh@linuxfound=
ation.org> wrote:
> Great! Can you run 'git bisect' on the 4.14.y stable tree to find the
> offending change?

As I tried to explain earlier, that laptop's connection to world is no
longer iwlwifi based but ethernet connection to fibre. I can't do much
bisecting when iwlwifi is not being used at all. Sorry. My contribution
here is trying to point you guys to right direction.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

