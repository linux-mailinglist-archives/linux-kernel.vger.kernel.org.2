Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA63A3E2075
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 03:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbhHFBKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 21:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243145AbhHFBKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:10:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD5B661179;
        Fri,  6 Aug 2021 01:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628212220;
        bh=nT9ry6c4LrsiJQ8cWoGAK0iM4DrJwicfZg25683t/dM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jAJw5sXxe5TUBzcneaByqTfHf2AH5PNzEHKBmReDMxB6a++i4z4KcTYyEn3JFz/K5
         fKXS4nDByIBt3KZUnW5bHEYU77xgzXFr8w3XRsdBvIg2+KKbrg29JC18pFtn5RKgza
         Mg/XrgRPpj8WSYML14ou9xUNIw/3+g+Hf+5aYGbalYoKB9jR5CGCIr4hluEzYB4OXL
         GQMKGE8uWEYMZ5HTuohCJcI+v8ZZYCHfaZpu2Km3zPRaLWh/fZ0/dUvqyonVd7wIwv
         92gCJiwBHsvpra+vfSDeoB1SJAms3K1dnXh/BXhDBvN9ZqpIhVPqt3ROzvccEw8RL1
         9sMFnMJZtho8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210702225145.2643303-4-martin.blumenstingl@googlemail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com> <20210702225145.2643303-4-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 3/6] clk: bcm2835: Switch to clk_divider.determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 05 Aug 2021 18:10:18 -0700
Message-ID: <162821221874.19113.16738014912388895260@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-07-02 15:51:42)
> .determine_rate is meant to replace .round_rate in CCF in the future.
> Switch over to .determine_rate now that clk_divider_ops has gained
> support for that.
>=20
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Applied to clk-next
