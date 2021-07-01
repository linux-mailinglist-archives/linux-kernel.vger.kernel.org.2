Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7813B8D78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhGAFpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:45:39 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:42959 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhGAFph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:45:37 -0400
Received: by mail-lf1-f53.google.com with SMTP id bu19so9590170lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=h0ILKXS4FbWPEzPuXa+aBDqgYseVPseyPle/w1SbzFc=;
        b=Mfl/kF/WzuDalZ18EKtdXZ6upkZ4nache8QnxVz6KEzPQn8Ke7KTMKLF0/GWRRMi1Q
         2fSp3V15ciEn8/cARhyjpmDs7QFTxiP02GI1csxBKr+8AAfrYZ+Rd94ie0DA4jOiTFna
         piS42xiPHElm0UCDkxpRfhHSR4u/JbJ+f/qm7p9oxQuI3sDv1969xczlHyvb432sX0zv
         W8A1jBmEpMYcKxJ8ky2xGgQhkF4ZdLjUZuqSf4HHwRryLJ2sKoMs6MMehj/iiFYi0Yi9
         zET9yPr4UCj+x5IcmgCc04gBF38MhzwVleukwui9z0tBq/wH8We40ujL/PLzS/O0waYt
         xr4A==
X-Gm-Message-State: AOAM530t5oN261fWVYIqBamXhnbcVY3WC+L+A4TR8P3ETM9voyM3jGKb
        1Cadbw1QaECy4E7SxIjNW7I=
X-Google-Smtp-Source: ABdhPJyggGRc1HAuQeGom8v0NBPYT/cPqVImIA91iqvZ5A9ImRglDl0zQRanUIlzUVwQViEPCh+9Ug==
X-Received: by 2002:ac2:51c3:: with SMTP id u3mr30050266lfm.298.1625118186861;
        Wed, 30 Jun 2021 22:43:06 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id e4sm2437899ljf.82.2021.06.30.22.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 22:43:06 -0700 (PDT)
Message-ID: <9ba184b3f4781cf68ee953b34ea67fdb678cf10f.camel@fi.rohmeurope.com>
Subject: Re: [PATCH] regulator: bd9576: Fix testing wrong flag in
 check_temp_flag_mismatch
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210623153443.623856-1-axel.lin@ingics.com>
References: <20210623153443.623856-1-axel.lin@ingics.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Thu, 01 Jul 2021 08:19:21 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2021-06-23 at 23:34 +0800, Axel Lin wrote:
> Fix trivial copy-paste typo.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/bd9576-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/bd9576-regulator.c
> b/drivers/regulator/bd9576-regulator.c
> index 8b54d88827be..3023069536ff 100644
> --- a/drivers/regulator/bd9576-regulator.c
> +++ b/drivers/regulator/bd9576-regulator.c
> @@ -294,9 +294,9 @@ static bool check_temp_flag_mismatch(struct
> regulator_dev *rdev, int severity,
>  				    struct bd957x_regulator_data *r)
>  {
>  	if ((severity == REGULATOR_SEVERITY_ERR &&
> -	     r->ovd_notif != REGULATOR_EVENT_OVER_TEMP) ||
> +	     r->temp_notif != REGULATOR_EVENT_OVER_TEMP) ||
>  	     (severity == REGULATOR_SEVERITY_WARN &&
> -	     r->ovd_notif != REGULATOR_EVENT_OVER_TEMP_WARN)) {
> +	     r->temp_notif != REGULATOR_EVENT_OVER_TEMP_WARN)) {
>  		dev_warn(rdev_get_dev(rdev),
>  			 "Can't support both thermal WARN and ERR\n");
>  		if (severity == REGULATOR_SEVERITY_WARN)

 Once again, Thanks a lot Axel!

Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>


