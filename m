Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C8F36FD3E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhD3PDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:03:37 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:44992 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhD3PDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:03:34 -0400
Date:   Fri, 30 Apr 2021 15:02:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1619794963;
        bh=uJ93FdzeuJKlxGtUoTvmmv9JTpBe/uRISripULjHqKk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=iA0mM7dZx+F/e6N0MLncIGmmeSoVrOKRIWfwHZwkCbu1Tgkn7hQ1zcTQfED1BAqBZ
         pInf54OJYaSsadqggbAOQ6hkycCOTehlYoLSqE30dTmgPJsKXe9c+/mNOH6zPY2c1J
         UNvrpzQk9HRRDSzh02aBkL3GWlwBgDhBG2IDCPQoZh0gojNbXOzc6xZNawOgsSUij9
         c5ZwjeDT09CrfOGezjsmlupM/EB7yNpDYfLnRIyhGUihFi3KBtZCjnIatRc4Yr4tBG
         LJ+BdIL+4kUpRWSyc+O53b65OwNW/F/BN+pdNwY4C2fRQ5KE/wrdUj0fdnw4adbEWl
         YHgDHS7R2aBtA==
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH 02/43] staging: rlt8723bs: remove if-else blocks left empty by ODM_RT_TRACE deletion
Message-ID: <20210430150232.23extupxlsweecrg@bryanbrattlof.com>
In-Reply-To: <20210430144959.GA1387@agape.jhs>
References: <cover.1619768150.git.fabioaiuto83@gmail.com> <646608de41fb1ef915834a33453b0a99907d46b0.1619768150.git.fabioaiuto83@gmail.com> <20210430143100.jfdaitqlqaclmajp@bryanbrattlof.com> <20210430144959.GA1387@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 04:50:00PM +0200, Fabio Aiuto wrote:
>On Fri, Apr 30, 2021 at 02:31:08PM +0000, Bryan Brattlof wrote:
>> On Fri, Apr 30, 2021 at 09:43:20AM +0200, Fabio Aiuto wrote:
>> >remove if-else blocks left empty by ODM_RT_TRACE deletion.
>> >remove unused variables to suppress compiler warnings.
>> >
>> >Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
>> >
>>
>> Hi Fabio!
>>
>> I just wanted to point out a spelling mistake in the title 'rlt8723bs'
>> in the off chance you submit a v2.
>>
>> Way to go switching this over to netdev btw.
>
>what do you mean exactly?
>

I was just praising you for all the work you are putting into this
driver. :)

>
>> --
>> ~Bryan
>>
>
>Hi Brian,
>
>thank you! Ouch I've just sent a v2 for other issues...
>no problem I will send a v3, sorry all for spamming.
>

Don't worry about me. I would wait until Greg and others have feedback
on your v2 before sending a v3 with this minor nitpick.

--
~Bryan

