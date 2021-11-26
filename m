Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90CE45F316
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhKZRnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhKZRlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:41:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DDDC061375;
        Fri, 26 Nov 2021 09:16:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B41612E8;
        Fri, 26 Nov 2021 17:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C3EC93056;
        Fri, 26 Nov 2021 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637946624;
        bh=L6p+xuALx/hWf8VhNxB6GhCXng5TdKvWILFI/TqVbAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lVg9v/QWFud6lNs2xDPXJyJ6Kila07ysdf/dxVAzkfUz2h8+Nc0xACBZKir9eblcs
         lmLaljhQuqqcQjXDbsg7s49vrjtcLk35ReVtplw1VxL3Qtbtz/MN1TANoWZ0CrfUf6
         /FjzJwAKxEnafpWlg/yGDI1r2BqTWyUilvafRQz+tEFWuQQ8mSKx13bAGReVTOyr30
         7VmbX5liaV2Lmt6s2K2Cz06b5Dm6quNJARYj3cS9wMOxTyhNtatIVfdsrkxJTKZUN/
         yXOQPu9kMxix2eHI5ZALYcMHoB8f5jJw4L0JoRpKMUKAoZuLtKSc2F5Z00WJAG9MlY
         AxYUKo0fW+l6w==
Date:   Fri, 26 Nov 2021 18:10:07 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm/arm64: dts: Enable CP0 GPIOs for CN9130-CRB
Message-ID: <20211126181007.77b5b15e@thinkpad>
In-Reply-To: <20211018011211.3836590-2-chris.packham@alliedtelesis.co.nz>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
        <20211018011211.3836590-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 14:12:10 +1300
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Enable the CP0 GPIO devices for the CN9130-CRB. This is needed for a
> number of the peripheral devices to function.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
