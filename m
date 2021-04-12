Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF75135CF42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbhDLRLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:11:13 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:21347 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbhDLRLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:11:11 -0400
Date:   Mon, 12 Apr 2021 17:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail3; t=1618247450;
        bh=Bk58r5KxeglWZsaj3TvPM8D2XXqW6yrQ2YKhGW/xiE4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=RmC88qUlDzbuJzrj9YfH1xajWpJirjYC9P41w93yxnVM8fxE9uF/tNGQhofRv3gm2
         joR+CwhtOhHg7yHUQZgsZQsNLVPXGhyvFOQOEnSqKDU7w62TXgZ1Ui7jIYYZDnF96C
         yey31HRp2D2Q1GIgx3HLLrpYp/pn/5+EsyCKsqRlbB5rsaHaupGD+OOXzcWcdNAwM+
         46YgrGlzIOc13khW7z+J25/EMCJ8lvewga8+VPBLStHu2cd5vjlxHDxyC8cHaPqDsn
         g7vFa9WXWujc40T3vOOTG8f8uJHcjYkrDsrb8HWhgmIlrnDTGkWV6RY7fXJpzjyuPM
         /UTD+z2RAVtZg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: remove unnecessary adapter
Message-ID: <20210412170939.beicrv26yiaapt7i@bryanbrattlof.com>
In-Reply-To: <YHR5L2aSZ4hNNmT0@kroah.com>
References: <20210412163650.42467-1-hello@bryanbrattlof.com> <YHR5L2aSZ4hNNmT0@kroah.com>
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

On Mon, Apr 12, 2021 at 06:45:35PM +0200, Greg Kroah-Hartman wrote:
>
>On Mon, Apr 12, 2021 at 04:43:56PM +0000, Bryan Brattlof wrote:
>> The if2 adapter is defined in rtw_dvr_init() and in the dvobj_priv
>> structure but never used anywhere in the driver. This will remove all
>> definitions of if2
>>
>> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
>> ---
>>  drivers/staging/rtl8723bs/include/drv_types.h |  1 -
>>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 10 ++++------
>>  2 files changed, 4 insertions(+), 7 deletions(-)
>
>What changed from v1?  That goes below the --- line.
>
>v3?

Oops.

it's the simple things that always seem to be the hardest :)

During the rebase to next-20210412, I lost the bracket on the=20
conditional statement:

   394: +free_if1:
   395:          if (status !=3D _SUCCESS && if1) {
=09=09=09=09=09=09^

I'll be sending v3 shortly with a proper change long :)
--
~Bryan







