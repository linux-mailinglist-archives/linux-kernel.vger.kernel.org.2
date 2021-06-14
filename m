Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641BA3A7174
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhFNVgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:36:48 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:42881 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhFNVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:36:47 -0400
Received: by mail-pg1-f177.google.com with SMTP id i34so9734288pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YAazy044guK0npar/4m+sPmQIOtSucx//piB7AyNprc=;
        b=Z7xW+wRkbGrbzLJ5EtWsRaDHBI5oP2nbOTXGnc0u9JN6J1Za57bhRzNCQK90E+aTzV
         B1C1RMN/oPNJT0a1Ak5hklQAl82aWGfszjBE3KsufZ3CS7JGEBBMGfkVH6nRRgdesEyc
         8ffYuR0FAX0ar0MbAIfm+0yz2ptTdtoHH5ejo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YAazy044guK0npar/4m+sPmQIOtSucx//piB7AyNprc=;
        b=Bo3YGoWqJj9uq+O5+kx8sa2YSWoPPm9U3mRpLsV4r0kxDk/8NfMRkOsGairZwqDiMh
         wa7V8Ac428Hr7LKXPy9bpQ4Rql7Si8srSDRKKHppaEHgh9+2CBBa4ALUHNr+EuKEcA3a
         VcVHXgzHMdMgFPsz0gHxyQSVpxmfaUwZPE0DMuHeNplDloEkPTUlFeQ4NNbcqxwDq3Cw
         cYRPJ+hUWoi+N5q8g7ksuEY8TtlsOa5FlTo58JvxrhWeeIsXOxEMMGjh0Pkm3z7BplVb
         Sn5/UMFfj4dhD1z1z5NG2YZnxBn450HMh3zeuJr19QLYqy+nXUn34U81XwI8kaVULCEI
         WLag==
X-Gm-Message-State: AOAM531dhw8/Tf2GdSmXNYXDeR+Gxsh6Qfw6126uIRQU/L/Kpl5woeVf
        in5lVJlCM0TEl07uEiiNdB/pwg==
X-Google-Smtp-Source: ABdhPJy4CL30u6bAxb4PGryg/WDNkqUOaQVD/x2xDd0ID9AX4PdjeaNgQLcghpBcgDiBvWxK4jivjg==
X-Received: by 2002:aa7:8b4f:0:b029:2bd:ea13:c4b4 with SMTP id i15-20020aa78b4f0000b02902bdea13c4b4mr1073202pfd.48.1623706407494;
        Mon, 14 Jun 2021 14:33:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ea91:688d:ccf2:cf48])
        by smtp.gmail.com with ESMTPSA id x23sm163375pfh.172.2021.06.14.14.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:33:26 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:33:25 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v1 1/1] platform/chrome: cros_ec_typec: Put fwnode in
 error case during ->probe()
Message-ID: <YMfLJbTUqyKAcBeu@google.com>
References: <20210614203310.339541-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614203310.339541-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jun 14, 2021 at 11:33:10PM +0300, Andy Shevchenko wrote:
> device_for_each_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
> 
> Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> Cc: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Minor nit, but regardless of that:
Reviewed-by: Prashant Malani <pmalani@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 27c068c4c38d..fb03c22fa34d 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -375,6 +375,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>  	return 0;
>  
>  unregister_ports:
> +	fwnode_handle_put(fwnode);

It reads better to have this at the location where the goto's are called, but
there are several of them. Instead, can you add a 1-line comment explaining that
the reference is left over? It isn't clear even by going a few calls down the
stack of device_for_each_child_node().


Best regards,

-Prashant
