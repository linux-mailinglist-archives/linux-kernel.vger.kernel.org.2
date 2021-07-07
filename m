Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54E3BE514
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhGGJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhGGJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:07:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31364C061574;
        Wed,  7 Jul 2021 02:04:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625648685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KA4zh50Vy7cN7XMqgCrDYfFsQROF3Kqzlq265H9GB0=;
        b=oPUgyfZHilFAm6ZfWHTKY2nS6zXnCCjYWSz/LDGhjnkzdiUq1UQ4A1JUCl4N5Kinp4GYpF
        Uj31JiWkSEJcSL07x9VisLOwEu0p7hFeYk3MhFyxafFPPESQ4rI49Mb5FHqj3jrOYurf7h
        WWNaDDDc0/AKisCLQ8+YV7L5I97XJW0h6ES4vBepI4IEfK+rXbTPjk/iatb4gL8LUGX2+P
        vKTyz7FTxrVTXrCm9ECFdnJt00hjVNbNQk3NCNx2M/7JSWXLrgwfFNQKzVXkLlp5FP1Dj7
        BljZdhJ4ln3/SroJGM2dfLV24GET4lrujwDizv7v/aZ1LAO6wkGLBi/Asc5Uzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625648685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6KA4zh50Vy7cN7XMqgCrDYfFsQROF3Kqzlq265H9GB0=;
        b=npDBNOM+rafYFMXRExrTYurWwUsiaKyaolwufsCCiTkDtOvpvREd4+aA8UJSEAjHANjlxM
        ZypW2UMjP9VRMWAQ==
To:     Nishanth Menon <nm@ti.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Christoph Hellwig <hch@lst.de>,
        Rahul T R <r-ravikumar@ti.com>
Subject: Re: [PATCH] LICENSES/dual/CC-BY-4.0: Lets switch to utf-8
In-Reply-To: <20210703012931.30604-1-nm@ti.com>
References: <20210703012931.30604-1-nm@ti.com>
Date:   Wed, 07 Jul 2021 11:04:45 +0200
Message-ID: <87eecaqytu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,

On Fri, Jul 02 2021 at 20:29, Nishanth Menon wrote:
> Lets drop the unicode characters that peeped in and replace with

Again: s/Lets//=20

> equivalent utf-8 characters. This makes the CC-BY-4.0 file inline with
> rest of license files.

>  Creative Commons is not a party to its public
>  licenses. Notwithstanding, Creative Commons may elect to apply one of
>  its public licenses to material it publishes and in those instances
> -will be considered the =E2=80=9CLicensor.=E2=80=9D The text of the Creat=
ive Commons
> +will be considered the "Licensor." The text of the Creative Commons

In theory the License text should be a verbatim copy. But yes, this
unicode stuff is a pain.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
