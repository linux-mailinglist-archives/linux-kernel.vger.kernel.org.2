Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0290B3FA982
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhH2Gmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 02:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhH2Gmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 02:42:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C8D606A5;
        Sun, 29 Aug 2021 06:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630219313;
        bh=sfhKMIVk0ywD2iXpGJajxBTAUEUFNiZdGB9ENiaUPfg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AdSRDiBthPgqQtKsEFf/cEljkNpEafH2WV1j/kQG2Zf4pqpZ2s/HtjMyv3UmT7sA2
         g7LcTC9WAm2QdL65tlJZW9Np7O0xf2gsxDMLdcTMbGz1xEzcbYqjce6zwxNg9GvxFq
         x7xXcMz/d/nBjS+EbYJgathIw9sNV8alY7NQ57Lv/vGmxYlfIxfEX9eZXOpQsXyCcT
         Ud++3eFTPgks7X/1J3JCB1sa5duxWOKIPWJ31X+ewiu86c4L/pCAx4T+I9XwAeUiIy
         JeXERNICfJdrY4rb/TJUVduDTeq4tEgeWJuRazhRIyTFhu35etGU7xM6Z6p6EYMvM5
         eHZqCy7IHrfkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6ecc4822-8112-43d4-1259-cd7dfe79d71c@microchip.com>
References: <20210401122726.28528-1-claudiu.beznea@microchip.com> <6ecc4822-8112-43d4-1259-cd7dfe79d71c@microchip.com>
Subject: Re: [PATCH v2 0/6] clk: at91: updates for power management and dvfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     viresh.kumar@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mturquette@baylibre.com
Date:   Sat, 28 Aug 2021 23:41:52 -0700
Message-ID: <163021931214.2676726.2951110502140668721@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2021-08-02 01:36:52)
> On 01.04.2021 15:27, Claudiu Beznea wrote:
> Hi Stephen,
>=20
> Please ignore the DVFS patch in this series
> (clk: at91: clk-master: update for dvfs) as I have some updates to it. I'=
ll
> introduce them in the next version.
>=20

Can I apply the rest of them though?
