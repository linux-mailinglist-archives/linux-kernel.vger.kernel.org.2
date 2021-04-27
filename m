Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804A736BCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 03:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhD0BWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 21:22:41 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:30412 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhD0BWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 21:22:40 -0400
Date:   Tue, 27 Apr 2021 01:21:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1619486515;
        bh=GkamwvI1sTILaPhsP/F3zjMbVJYsi0uLKbqbp36xmkI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=nDsjBoOtId8LlwDAkbgf3loR5WVTORsFO9tNr0L57YdRBen5xTDtQiIV1jgmPV+HS
         qfNuHRGVYjXZTZkz6eLos6EqfegILR7IZYoxRjLbTj0GtCm8DoQJUh091HUGPLDw4e
         ns+xrL7snLb1BZeQktXEprZkDeKLoPDZIuxMXE6F5uT6+UwvUMjA1hSF6yrq9pvu9I
         fu+AlZe+O7RBWytG9EwDg31oxVwlgq6N5j/P+20Q8RykrVzQlP+ZPPj9M8Hv5JE6YI
         p8VoV1YuBiKdNw9sC5iQPHHJxbh0h3cdi/wwYqMFqRGF/Z3rKvC4yvfSeUfQSgtCuE
         SKxrJmNjqjJ+A==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Kalle Valo <kvalo@codeaurora.org>
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH 095/190] Revert "rtlwifi: fix a potential NULL pointer dereference"
Message-ID: <20210427010457.rk7t6p2zs3d2eudn@bryanbrattlof.com>
In-Reply-To: <20210421130105.1226686-96-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-96-gregkh@linuxfoundation.org>
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

On Wed, Apr 21, 2021 at 02:59:30PM +0200, Greg Kroah-Hartman wrote:
>
>This reverts commit 765976285a8c8db3f0eb7f033829a899d0c2786e.
>
>Commits from @umn.edu addresses have been found to be submitted in "bad
>faith" to try to test the kernel community's ability to review "known
>malicious" changes.  The result of these submissions can be found in a
>paper published at the 42nd IEEE Symposium on Security and Privacy
>entitled, "Open Source Insecurity: Stealthily Introducing
>Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>of Minnesota) and Kangjie Lu (University of Minnesota).
>
>Because of this, all submissions from this group must be reverted from
>the kernel tree and will need to be re-reviewed again to determine if
>they actually are a valid fix.  Until that work is complete, remove this
>change to ensure that no problems are being introduced into the
>codebase.
>
>Cc: Kangjie Lu <kjlu@umn.edu>
>Cc: Kalle Valo <kvalo@codeaurora.org>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
> drivers/net/wireless/realtek/rtlwifi/base.c | 5 -----
> 1 file changed, 5 deletions(-)
>
>diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wir=
eless/realtek/rtlwifi/base.c
>index 6e8bd99e8911..1d067536889e 100644
>--- a/drivers/net/wireless/realtek/rtlwifi/base.c
>+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
>@@ -452,11 +452,6 @@ static void _rtl_init_deferred_work(struct ieee80211_=
hw *hw)
> =09/* <2> work queue */
> =09rtlpriv->works.hw =3D hw;
> =09rtlpriv->works.rtl_wq =3D alloc_workqueue("%s", 0, 0, rtlpriv->cfg->na=
me);
>-=09if (unlikely(!rtlpriv->works.rtl_wq)) {
>-=09=09pr_err("Failed to allocate work queue\n");
>-=09=09return;
>-=09}
>-
>

Hey Greg!

If you're still working on this series, this patch looks to be a=20
legitimate fix for the potential NULL pointer.

However we should probably inform 'rtw_init_core()' of this failure in=20
addition to printing about it.

Do you want to apply this revert and I send a fix after this has made=20
its way through?

--
~Bryan

>
> =09INIT_DELAYED_WORK(&rtlpriv->works.watchdog_wq,
> =09=09=09  rtl_watchdog_wq_callback);
> =09INIT_DELAYED_WORK(&rtlpriv->works.ips_nic_off_wq,
>--
>2.31.1
>

