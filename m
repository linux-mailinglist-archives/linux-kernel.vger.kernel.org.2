Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D54437CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhKBVbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhKBVbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:31:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDECD6109F;
        Tue,  2 Nov 2021 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635888515;
        bh=22np0nhoCBeVdC+z0ZU1kdFMj6fAbFXgWI8nIffYKzc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LtJQmrh6RmDidMKmFiHDXKVrssMh+zgaq9iAzbqVHqil1rIUM0NGTqW5C4jUfVPuA
         2/X2nGLhTN/FOmc+EGmcWGLTlwJ7HWc8pfPDTbmOzCcyLVk8tUK8iWcYkeRRWM/y08
         wzOVB/7xldDHVRdGkYbi/e0ni4dpgljw3c3VR/demGrn7ebCPCfnOqTfLIRdIedmex
         AmKQshYlkoTveae7WQYFLad2LPV1+VWLjgxuMje5ml5eZZZyZrF3hZ0rhvnprZ941/
         cE4SupzlxG2D2OKYBWY4vZQPmrqQ8E/XAbmxmST0+1arHHp+0CGTwi4QlnbB5Yx98z
         aAbxC+l09ionQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210929065824.23691-1-liumh1@shanghaitech.edu.cn>
References: <20210929065824.23691-1-liumh1@shanghaitech.edu.cn>
Subject: Re: [PATCH -next] clk/actions/owl-factor.c: remove superfluous headers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>
To:     Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mianhan Liu <liumh1@shanghaitech.edu.cn>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 02 Nov 2021 14:28:34 -0700
Message-ID: <163588851451.2993099.14167470091705420453@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mianhan Liu (2021-09-28 23:58:24)
> owl-factor.c hasn't use any macro or function declared in linux/slab.h.
> Thus, these files can be removed from owl-factor.c safely without
> affecting the compilation of the ./drivers/clk module
>=20
> Signed-off-by: Mianhan Liu <liumh1@shanghaitech.edu.cn>
>=20
> ---

Applied to clk-next
