Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF83B8897
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhF3Slm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233129AbhF3Sll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:41:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC98F61419;
        Wed, 30 Jun 2021 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078351;
        bh=ZfJAuekNP3FT8Toh4W8fRrjT1OZV0Yxwl7l8MeBHaiE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m6Eqz7nGvioL4VtIVTS7PU3drh15Jujss2c2UVnjSPJB3YULypHLfCQX3iCi5z6MJ
         7dpGpU1yyrJlv2hDR9xIkPe3yy5GrPe8xQXC/MkIFkvyb/Qr7seRLRt8nSzWBHpkzS
         ddr54f3nsuK23mOnfG4X1CnMUpGSGyEloME0C9VWlPHBI8vxWDT//kNE37oYZcE5pS
         UHc0XfIbRxW7Ux14ln7u8B8vG+hgH4vwG9FXs/0s2eF374wKs2I7UgUpLKGcw4ihnR
         11JdrVEfMW7gqEHKavh7NzhtktRHhoPA4fDsLQAPLB1R6ma/VK1ZMSZuyb1cCRb3in
         2h04hae3VxSVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210627223959.188139-2-martin.blumenstingl@googlemail.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com> <20210627223959.188139-2-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 1/3] clk: divider: Add re-usable determine_rate implementations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Wed, 30 Jun 2021 11:39:10 -0700
Message-ID: <162507835057.3331010.8069847562722001420@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-06-27 15:39:57)
> These are useful when running on 32-bit systems to increase the upper
> supported frequency limit. clk_ops.round_rate returns a signed long
> which limits the maximum rate on 32-bit systems to 2^31 (or approx.
> 2.14GHz). clk_ops.determine_rate internally uses an unsigned long so
> the maximum rate on 32-bit systems is 2^32 or approx. 4.29GHz.
>=20
> To avoid code-duplication switch over divider_{ro_,}round_rate_parent
> to use the new divider_{ro_,}determine_rate functions.
>=20
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Applied to clk-next
