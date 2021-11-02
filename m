Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC04437EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhKBVkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhKBVkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:40:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0F136109F;
        Tue,  2 Nov 2021 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635889057;
        bh=pl4AM8Y0lxGRZaeGGrlVgPHxzYunnuMomjC4IonZ8ks=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iplq4Hg7fuCjZQaKb5I/wFjiKUTBWbPdKQKZ54eCHfQeABBIA7JFpBjODwS11fP7w
         Ogplzb5AdN2pJA7i40q8Y4BRtDEGaPiwCltJ+JMOLehitHdzyXt76J6eVjEHlIIIS+
         1nRz0lE713QXY4ewyCDDwGL/OcGu4eKbhyAhtO/uuTmc+0X1ZpSSbe+xNAg4ek+iqy
         V1TXBJb745pfBOnWu3RAOM9ErK5v1IVh2auCv+IixbWDWqMES9bB6X8b6CjfsG7k4o
         GJ7Z7SFZf/6Kdtx4+gSbYgAAnN7nZbdT4SZkQjiQuUAe2AeGpNtZ9mboQ9KEPnk5wb
         +X2+/+4f84zVg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634000035-3114-5-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634000035-3114-1-git-send-email-hayashi.kunihiko@socionext.com> <1634000035-3114-5-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: clock: uniphier: Add clock binding for SoC-glue
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 02 Nov 2021 14:37:36 -0700
Message-ID: <163588905660.2993099.8818902450188245985@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kunihiko Hayashi (2021-10-11 17:53:54)
> Update binding document for clocks implemented in SoC-glue.
>=20
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Applied to clk-next
