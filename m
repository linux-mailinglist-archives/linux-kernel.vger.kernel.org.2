Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785223142AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 23:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhBHWNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 17:13:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231235AbhBHWMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:12:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BAB764E9C;
        Mon,  8 Feb 2021 22:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612822326;
        bh=CtSTHr+IHwjK8skk3C0GZRJ7Ggi+hz69WkmTK8J4Unk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NmF7fyPzFlkCtl8PHMOUqRJ1Qp3oKJBh9UmbCKWc7YgXtorcrjtua7zz9FofZp5/0
         fsojDfJCf96AVChCiUpQAA0N+agLSbjxzwUYNFYYtwRXGcBuJOpKu+AXdXtAcCURRq
         7KuYhHEtRnoVC0jiGZWLPAP07/VZXOdSfxwb60ynbSTN9hyA2hCpPqhnblKSei7/an
         3qFskTUvDnQLPqEFxIDOxFgoQCIzK0folLZTvdWEyaHTU/U7ij1ZkOjGbEMc3Qg3SK
         4pbHfQYFgGq0DbyKG0UtnMU6golnRxrtcM2eU3HiflWrMHpWdrYhjuk9We1RG8R9PU
         F3mwEQIMqVwqg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c67050c01ffc28977fee772ced7144390a96ba51.1611949675.git.mchehab+huawei@kernel.org>
References: <cover.1611949675.git.mchehab+huawei@kernel.org> <c67050c01ffc28977fee772ced7144390a96ba51.1611949675.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v8 11/14] spmi: hisi-spmi-controller: move driver from staging
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Mon, 08 Feb 2021 14:12:04 -0800
Message-ID: <161282232477.4172033.10207198700180540073@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mauro Carvalho Chehab (2021-01-29 11:51:57)
> The Hisilicon 6421v600 SPMI driver is ready for mainstream.
>=20
> So, move it from staging.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

Rob had some comments on the binding that don't look to be addressed
though so I'd prefer we get the binding into shape before graduating
this driver from staging.
