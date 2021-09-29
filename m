Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52A41CF29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbhI2WVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:21:50 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:33268 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346536AbhI2WVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:21:49 -0400
Date:   Wed, 29 Sep 2021 22:19:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1632954001;
        bh=wlfd3aFM6flc6EKGBKFJ9DQEr0vlbNWY0hgFscOGS7Q=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kaZBwngIFQDBNYgq6KFNBANVVwu6egaqhXeG78d7qm4BtBE903EZE+m8TvEesnKb6
         pingsim5vS69vRC2Xk7EpuiLTuDNLl0E2TLuPOirygf54eSqBlv/ZlYJ2IYAV/5kXB
         P9LuBx3D4KHoUbrJRkqusy84MjGOdDNZfCCUUCR7fHolVJLHcXr/9GahLC/fymaLg4
         r6NtIIa1mL/vnZC2h4xB3P/tyw2M3qekvkykaAV7Xb3WDuKrUV3GxzNjo821+NEf4k
         e0kUNh2x9nAsex1Ndqf68KsqaZD53BG49vuUS9+uv6wZbvE+Kfg++C/bL+frcqi4sg
         HBCRyv2VLR5ZA==
To:     Dawid Esterhuizen <desterhuizen@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] staging: rtl8712: Statements should start on a tabstop
Message-ID: <20210929221948.ybhdx2lnu4s72yas@h510>
In-Reply-To: <YVTN5i8qwjlGwOPp@kkobus.whirley.local>
References: <YVTN5i8qwjlGwOPp@kkobus.whirley.local>
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

Welcome Dawid!

On this day, September 29, 2021, thus sayeth Dawid Esterhuizen:
> This path fixes four checkpatch.pl warnings:
>
> Statements should start on a tabstop
>
> Signed-off-by: Dawid Esterhuizen <desterhuizen@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_xmit.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl=
8712/rtl871x_xmit.h
> index 2e6afc7bb0a1..bc1287cc853e 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.h
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.h
> @@ -182,11 +182,11 @@ struct sta_xmit_priv {
>  };
>
>  struct=09hw_txqueue {
> -=09/*volatile*/ sint=09head;
> -=09/*volatile*/ sint=09tail;
> -=09/*volatile*/ sint=09free_sz;=09/*in units of 64 bytes*/
> -=09/*volatile*/ sint      free_cmdsz;
> -=09/*volatile*/ sint=09 txsz[8];
> +  /*volatile*/ sint head;
> +  /*volatile*/ sint tail;
> +  /*volatile*/ sint free_sz;=09/*in units of 64 bytes*/
> +  /*volatile*/ sint free_cmdsz;
> +  /*volatile*/ sint txsz[8];
>

I'm thinking a better way to silence checkpatch.pl here would be to
remove the volatile comments. I find it easier to read when everything
is aligned, comment or not.

~Bryan

