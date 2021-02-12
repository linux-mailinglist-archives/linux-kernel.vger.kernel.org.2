Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC5319913
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBLEW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhBLEWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:22:21 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46A9C061756;
        Thu, 11 Feb 2021 20:21:39 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id c16so7341735otp.0;
        Thu, 11 Feb 2021 20:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJsyMp1u/mQDkCLfOf8XbRo0L0Ns6Xn77vZ3K2nP4Lo=;
        b=LGCkNgnY6pHSASNfNNY2tFsVyY/1sqOfavkp9JNPyymd9OzJQvfNR5hKQLzwcLI3xm
         RTUrCFCbLeoaOeejKbTtMYw6pIDoAtR0biY6712cAe6zMArtbE2OV2m5V/2K6yz+0+Hj
         Rek08m1CgVSihA+NBtK1PV4g22WgsDTbigJpghDzoJEAPHqBxkpODvV9PsvcIuYfmRwf
         2rgHiZ9unLwF4nXzflqPaMwYhUbixs892rE5iq0uNJbvtUrY7Q0x43BnrP6Vy6WiNpcV
         xvzgrBBOrm7JIVPqSTYhuk3kYJFS6N/Lz1G48PNvpdAuEJaK4NiZQHQH9c8BJN23PdE8
         1mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJsyMp1u/mQDkCLfOf8XbRo0L0Ns6Xn77vZ3K2nP4Lo=;
        b=S4Tt1NQQtmbiXFbfdiznpU35A0lHktUWdDwXu5FCiw1E5WIS7Oe/EyMD3nZo/r+lll
         +dnu033dIDIUR13rJlzFg+URVfEUDsS0hDOVEzvuXDllm8pLDP1l9nmZJvoK0Uk9l5F7
         ZghxB+0cWHDw4QHccM8/nqn6iqPKW/HaVpAIJKTdsidTyTijpczgkJaVL+rbSmlxnSN+
         H4w67NwVaAgzI0Wlg+L6v+d7N4EfSGJoT3NtGYC8ZMzBFBA3kTuUPkQqN9qIqoZ5mPcZ
         /HkKtcZFY5hX20WHkOzjwsPKBYA/e1z5L5afP/HBgsLJ+UVPgVIh9vVFK43qwGc8SFm/
         oorg==
X-Gm-Message-State: AOAM530n2Qtq2uyUdxV16xyEYUc3BeF9OvQiI4KOBQ5Vy/O6wjoBGFKG
        ElHqkBEOkxo1d6npohol0cODDNCaxJA=
X-Google-Smtp-Source: ABdhPJwVxI/t/DODJSa8XK/2dT9qV59q9WZnT3mJD0nfein8FG1kfCbYIpc/VO8ocz+QpoZe5udFkA==
X-Received: by 2002:a05:6830:1f4e:: with SMTP id u14mr835452oth.65.1613103699409;
        Thu, 11 Feb 2021 20:21:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d1sm1391062otc.57.2021.02.11.20.21.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:21:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:21:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 7/7] usb: typec: tcpm: Get Sink VDO from fwnode
Message-ID: <20210212042137.GG103223@roeck-us.net>
References: <20210205033415.3320439-1-kyletso@google.com>
 <20210205033415.3320439-8-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205033415.3320439-8-kyletso@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:34:15AM +0800, Kyle Tso wrote:
> Commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config
> configuration mechanism") removed the tcpc_config which includes the
> Sink VDO and it is not yet added back with fwnode. Add it now.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v5:
> - no change
> 
>  drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b45cd191a8a4..be0b6469dd3d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5722,6 +5722,20 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>  			port->new_source_frs_current = frs_current;
>  	}
>  
> +	/* sink-vdos is optional */
> +	ret = fwnode_property_count_u32(fwnode, "sink-vdos");
> +	if (ret < 0)
> +		ret = 0;
> +
> +	port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
> +	if (port->nr_snk_vdo) {
> +		ret = fwnode_property_read_u32_array(fwnode, "sink-vdos",
> +						     port->snk_vdo,
> +						     port->nr_snk_vdo);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.30.0.365.g02bc693789-goog
> 
