Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AEA319037
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhBKQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:41:42 -0500
Received: from mail-40137.protonmail.ch ([185.70.40.137]:29080 "EHLO
        mail-40137.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhBKPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:32:55 -0500
X-Greylist: delayed 100274 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 10:32:54 EST
Date:   Thu, 11 Feb 2021 15:22:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613056967;
        bh=lP4LCLM34lKQoJFuaFYzzhqgHmMpdeJhyhqNiV1y5I8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=CPoovHoWibAqfetQeu5O0K1BFbLTrfoF/DrStRF7jfi754MPPYHEvifmHC/rpEb62
         SekRA/oeBZKFtW7oTgWoI5pbjGZB2dPAKszz4XaSyno1UmWuLVVWJfDxbt0bVPCanX
         VLikhuNbkNtx+CX5gRBkPbI5c03L4RP44CNl81eo=
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH] arm: dts: sun5i: Add GPU node
Message-ID: <l8LhDUnOwZRTHGGlNyEsHnTHdNloDXz4_ivI_yTBZF-JBBdyKH2st_FebOKWq6FTpjUBDLD5Yku_LuCOkHNNn90ZedVkNDeD0PiBOfBnDWg=@protonmail.com>
In-Reply-To: <3SosG1rcYyn7x4mZWYK0uLKhbdlJxf3irBb7V2qGMqgH0Adv_RvNjn5lsEsx1lii5uKgurcC-lhfQ8r_AprSs9oSl02eYxZvQBqPy0qt3pw=@protonmail.com>
References: <3SosG1rcYyn7x4mZWYK0uLKhbdlJxf3irBb7V2qGMqgH0Adv_RvNjn5lsEsx1lii5uKgurcC-lhfQ8r_AprSs9oSl02eYxZvQBqPy0qt3pw=@protonmail.com>
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

On Thursday, February 11, 2021 7:01 PM, Yassine Oudjana <y.oudjana@protonma=
il.com> wrote:

> sun5i has the same Mali 400 GPU as sun4i with the same interrupts, clocks
> and resets. Add node for it in dts.
>
> Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
>
> arch/arm/boot/dts/sun5i.dtsi | 42 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 42 insertions(+)

Sorry, this patch got messed up somehow. I'll send a fixed one.
