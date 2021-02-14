Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C753531B26C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 21:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBNUdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 15:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhBNU3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 15:29:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B83C64D9A;
        Sun, 14 Feb 2021 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613334711;
        bh=PwrzKQcoivbaeM1UVeBtvD/eD8kSXoahIkWv4pBcuZI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ak1SUAEhGzRZz13/YQwUNrafym8xdZw/7qKQUJxltNWKdsvaXC4BccWruvBatJ8rD
         PXBbn4PuxZ7n/F34lMkYuEGySueWNlryUZP3Wi5sKVSLMUMubyfgRKi3qUOgxaJ/B5
         Rx6KRlmD2YLKS0SI1brolGk5FLzYnq56Vc2KWDENXtn34Z0O+jIMRLA5k97Fc+7776
         07p5lUQbYyc3fKR5pXSyUDehNPOpHFt/0hPbzG9zbMeaLtBhkCVGRdXmKhneuT6fQr
         g0j+Ue31dhm1giW4SZml1lgsqLSkHv8DjqcKY/59yErZRKlhYelv12ab5NgO+EVNVm
         JN4r5n4IQCm5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210211052206.2955988-2-daniel@0x0f.com>
References: <20210211052206.2955988-1-daniel@0x0f.com> <20210211052206.2955988-2-daniel@0x0f.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: clk: mstar msc313 mpll binding header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>, Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Sun, 14 Feb 2021 12:31:50 -0800
Message-ID: <161333471028.1254594.13093277561501616603@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2021-02-10 21:22:00)
> Simple header to document the relationship between the MPLL outputs
> and which divider they come from.
>=20
> Output 0 is missing because it should not be consumed.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
