Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287CD38783D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhERMBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbhERMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:01:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w12so3055629edx.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PisMFgDdWXg2D3g0jXTIbfoTlrtA5Bc6PgufqTlUJ3k=;
        b=MqBiadAlRjQ+P3OF0k9Cy7JFMJt8VybUe7GLaF2IsKEVH7+LNVVVLbmX5EMJf0bQye
         qC1RNKolkB4ZalO6a8Yqmsv6zMMSJrQ8fJkzTVfUv32fjYU5Q1wAHQvBclXlWpl5zFDm
         T6KJ1eATFovCDnwk+NfDCFFvQXj1CM02u7Yz3dyePEpZxYQRp2zmWKpnVNsF7UwarFOF
         AS7wBqdxFERlsaL88zlglNy3j0KyOR686fbZ5YAlnDPiOqfmTggXoVEKmfqi3L8aAwr/
         tUufjio6hb4qXxdX1vuQwd7Pc0gQ4kZYSghFAH3jikiYbtSXv8SVvmYXf0CIVA9uVizf
         ELcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PisMFgDdWXg2D3g0jXTIbfoTlrtA5Bc6PgufqTlUJ3k=;
        b=Hd/ATEDQC1D2/c0S4bnod+NoI2R8154gjq27xGotIP/B6E0fXfZMflx9DLNlS7oiy0
         EggUKuC1uCaxJXzPjfoTD9PhaRrMH2SqHhrxOrA5lnMs8xvsDEpM9Gb6sh1E22onkwZm
         pb6pb9+JGi3KfjXRKpN4JjwWxuocf0wXAT912TjYUI2QRP+2mQDZRbnEPNipqsZJF6v7
         u5nyCENzyS4TknoVPhf194Yi1qS/uGKnOA5M9w3e6K73EXiWtSpEtc8tXQ0qAIvZvQAq
         KwAcfcLpRGdmo7XSbXOrpb4Nuit8h2J8qVCSJerpUa/vTegQnNRqtVW0G3iqiqqwsdjQ
         E2GA==
X-Gm-Message-State: AOAM532cXUoONBvbU86ATM5WdFpFaQek9VeAtLsAaZ19/B/4BRcJpA5Q
        1polttGzEUghEPoSlIdiSpA=
X-Google-Smtp-Source: ABdhPJxLo+M80/grTifcuCNRJOhcvly6Eke9zFoHQ9M75IumFKAJOT/sxl9eBtTWuypoq3YAjhd11g==
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr6629269edb.327.1621339226276;
        Tue, 18 May 2021 05:00:26 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:bee0:f4e2:68f9:3d11])
        by smtp.gmail.com with ESMTPSA id w14sm12990474edj.6.2021.05.18.05.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:00:25 -0700 (PDT)
Message-ID: <8a8fad66288f38a3dacd5dc23cee62bf3e3e6d5f.camel@googlemail.com>
Subject: Re: [PATCH v2 1/2] regulator: fan53880: Fix missing n_voltages
 setting
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Date:   Tue, 18 May 2021 14:00:25 +0200
In-Reply-To: <20210517105325.1227393-1-axel.lin@ingics.com>
References: <20210517105325.1227393-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-17 at 18:53 +0800, Axel Lin wrote:
> Fixes: e6dea51e2d41 ("regulator: fan53880: Add initial support")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Christoph Fritz <chf.fritz@googlemail.com>

> ---
> v2: address Christoph' comment
>  drivers/regulator/fan53880.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
> index e83eb4fb1876..1684faf82ed2 100644
> --- a/drivers/regulator/fan53880.c
> +++ b/drivers/regulator/fan53880.c
> @@ -51,6 +51,7 @@ static const struct regulator_ops fan53880_ops = {
>  		      REGULATOR_LINEAR_RANGE(800000, 0xf, 0x73, 25000),	\
>  		},							\
>  		.n_linear_ranges = 2,					\
> +		.n_voltages =	   0x74,				\
>  		.vsel_reg =	   FAN53880_LDO ## _num ## VOUT,	\
>  		.vsel_mask =	   0x7f,				\
>  		.enable_reg =	   FAN53880_ENABLE,			\
> @@ -76,6 +77,7 @@ static const struct regulator_desc
> fan53880_regulators[] = {
>  		      REGULATOR_LINEAR_RANGE(600000, 0x1f, 0xf7, 12500),
>  		},
>  		.n_linear_ranges = 2,
> +		.n_voltages =	   0xf8,
>  		.vsel_reg =	   FAN53880_BUCKVOUT,
>  		.vsel_mask =	   0x7f,
>  		.enable_reg =	   FAN53880_ENABLE,
> @@ -95,6 +97,7 @@ static const struct regulator_desc
> fan53880_regulators[] = {
>  		      REGULATOR_LINEAR_RANGE(3000000, 0x4, 0x70, 25000),
>  		},
>  		.n_linear_ranges = 2,
> +		.n_voltages =	   0x71,
>  		.vsel_reg =	   FAN53880_BOOSTVOUT,
>  		.vsel_mask =	   0x7f,
>  		.enable_reg =	   FAN53880_ENABLE_BOOST,


