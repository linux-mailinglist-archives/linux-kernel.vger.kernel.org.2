Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E158423993
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbhJFITr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Oct 2021 04:19:47 -0400
Received: from ni.piap.pl ([195.187.100.5]:41504 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237674AbhJFITp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:19:45 -0400
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_SOC_IMX6Q = i.MX6 Quad/DualLite/Solo
References: <m3sfxen0yw.fsf@t19.piap.pl>
        <8d54835921f1648a4d50d8d4e160b5a12582590f.camel@pengutronix.de>
Date:   Wed, 06 Oct 2021 10:17:52 +0200
In-Reply-To: <8d54835921f1648a4d50d8d4e160b5a12582590f.camel@pengutronix.de>
        (Lucas Stach's message of "Wed, 06 Oct 2021 09:36:05 +0200")
Message-ID: <m3ee8ymurz.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lucas Stach <l.stach@pengutronix.de> writes:

>> Print i.MX6 "Solo" name in addition to the "Quad" and "DualLite"
>> for SOC_IMX6Q.
>> 
> I don't think that's helpful, you would need to at least also print
> "Dual" to make it correct. The Solo is just a fused down version of the
> DualLite, just as the Dual is a fused down version of the Quad.
>
> Quad/DualLite refers to the two different die versions of the chip.

Perhaps we need to print Dual as well.

ATM "cat /proc/cpuinfo" (and everything using it) prints "Freescale
i.MX6 Quad/DualLite (Device Tree)" on Solo and this is, at best,
misleading: making people wonder what CPU do they really have.
-- 
Krzysztof "Chris" Hałasa

Sieć Badawcza Łukasiewicz
Przemysłowy Instytut Automatyki i Pomiarów PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
