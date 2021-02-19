Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6649A31F753
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBSKdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:33:22 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:49494 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBSKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:33:16 -0500
Date:   Fri, 19 Feb 2021 10:31:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613730712;
        bh=Ma3I+SGzZJqYcMeaWe7/7hREWS08/LF4MRWzS6XAPMA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=sdNC+sFY3ZZVwkHQCWDH9DzcYTTWCHxrTPn8alws9dqbxxUhom1R1RhJrgqmE0o/r
         0+oCEBQ5mBBGDJ5PBSokfG/4LVGE+86YcKacVvV+2qHRYj7B0sVt9zcL8vjptUgaeB
         L1ywzZjb5t8lawN1gGSDKk61ejxFnLEUjuMvQfy0=
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
Message-ID: <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com>
In-Reply-To: <YC91OWVGAfyorRbc@kroah.com>
References: <YA/E1bHRmZb50MlS@kroah.com> <YC4atKmK7ZqlOGER@kroah.com> <20210218113107.GA12547@1wt.eu> <602E766F.758C74D8@users.sourceforge.net> <20210218143341.GB13671@1wt.eu> <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com> <YC6nZH/4CkLLsxxB@kroah.com> <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com> <YC91OWVGAfyorRbc@kroah.com>
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

On Friday, February 19, 2021 10:22 AM, Greg Kroah-Hartman <gregkh@linuxfoun=
dation.org> wrote:
> That's not the goal of stable kernel releases/trees. If the driver
> version that is in 4.19.y does not work for you on release 4.19.0, odds
> of that "changing" in later stable releases is slim to none.

But in-tree iwlwifi worked fine on 4.9.y and 4.14.y , and then got broken
in later 4.14.y versions. I tried later versions of 4.19.y in an attempt to
fix the breakage. Basically you are are saying that I should have NOT
attempted to upgrage 4.9.y -> 4.14.y -> 4.19.y

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

