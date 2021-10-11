Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05BF4291DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhJKOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbhJKOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:33:45 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20E5C061345;
        Mon, 11 Oct 2021 07:25:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o4so24832115oia.10;
        Mon, 11 Oct 2021 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/p5U+cPIs1EYHKiD6U4YrHpe9KTVTfBsKJ8HxEXnMLk=;
        b=Yfe0ZbPT1ZsRLK5v4wae2PFNLtJ56izXoI149bVvdUQRdokMecbZ8xoS0rxFrFfz6t
         IAektKE8tOD37wchKyuhz1yhlMuEG5CK+UBc3asivQKV8p/14w5mErUTeHnfHyKhR37r
         qDkzyz+wP6KzxnBW91D8ETEJsQ5YsVTM/10pW84PNKEQVtQhBz2YIc+cn2yCOls7vKKD
         kXDvoqgehNH5C4qRaRc5W3PFmGRXjmtViyX8T6NGHXSUYhc8+ahB878LtsR90JfW5jgo
         mH3TOtF7u/hWss5JiTUuESCtlHnqbj7E/rltT57GhcwMSvhSG7NFfPxibbqxOv5ST5NE
         FGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/p5U+cPIs1EYHKiD6U4YrHpe9KTVTfBsKJ8HxEXnMLk=;
        b=Ez3/Ev1uCwSTVUmBzVzQpHh+Ib8+dHJfMEZ3BYyUjpBJ5xfU0/tOmg7F309HV4JhqH
         IPwlPrv9jM73XFvNEASFH+uCoucK3kyFFe2dQen7WdKsQSbw6qLSbTTv6k5CKzXvTFc9
         X2qLdrdilMVRg2CgFc6aMe+A4KBFwrPNRB/u2EBiEAvijdD3t/WorwQo1PmZ7xLGeeb4
         0PFp/b/R//zT7Jv4sEClN9zDRcs4fhEow72fD7nTyTZOS2l1lVHsCYcqYuGDocbIza0G
         X9/EmTF3td135kqn/hCB2mdBOoe7CEOYQJA5jS3DZBhT7rftbhqx4vdUTXYMalkXjVFC
         azrg==
X-Gm-Message-State: AOAM532rd+MDBaoYxnxnBkTHFXEKQZhmWgA9VDIsy39LDgyo+prmgva5
        sQHk8XDBFovfp/C1nJ/VbV0=
X-Google-Smtp-Source: ABdhPJz0tX9UOumFDdWz9PhLR0xPQmGzPGzy9mx/cdCrXjJxPdmqatFd9XRMoItCikF9uwNA2qszGA==
X-Received: by 2002:a05:6808:16a4:: with SMTP id bb36mr26825361oib.91.1633962338165;
        Mon, 11 Oct 2021 07:25:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p18sm1787448otk.7.2021.10.11.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:25:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Oct 2021 07:25:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (asus_wmi_sensors) split out T_Sensor
Message-ID: <20211011142536.GA2036789@roeck-us.net>
References: <20211003133344.9036-1-oleksandr@natalenko.name>
 <20211003133344.9036-3-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003133344.9036-3-oleksandr@natalenko.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 03:33:43PM +0200, Oleksandr Natalenko wrote:
> Move `T_Sensor` addition into a separate `case` statement in preparation
> for the next patch that introduces a board without it.
> 
> No functional change.
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>

This patch depends on acceptance of the asus_wmi_sensors driver,
which should at least be mentioned here. The same applies to the
next patch of the series. In general, please do not send patches
for multiple drivers as single series, and please always mention
such dependencies.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus_wmi_sensors.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
> index 6b04fad18891..98e761861601 100644
> --- a/drivers/hwmon/asus_wmi_sensors.c
> +++ b/drivers/hwmon/asus_wmi_sensors.c
> @@ -144,14 +144,22 @@ static void asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec, int boar
>  		asus_wmi_ec_set_sensor_info(si++, "Motherboard", hwmon_temp,
>  					    asus_wmi_ec_make_sensor_address(1, 0x00, 0x3C),
>  					    &ec->nr_registers);
> -		asus_wmi_ec_set_sensor_info(si++, "T_Sensor", hwmon_temp,
> -					    asus_wmi_ec_make_sensor_address(1, 0x00, 0x3D),
> -					    &ec->nr_registers);
>  		asus_wmi_ec_set_sensor_info(si++, "VRM", hwmon_temp,
>  					    asus_wmi_ec_make_sensor_address(1, 0x00, 0x3E),
>  					    &ec->nr_registers);
>  	}
>  
> +	switch (board) {
> +	case BOARD_RS_B550_E_G:
> +	case BOARD_RS_X570_E_G:
> +	case BOARD_R_C8H:
> +	case BOARD_R_C8DH:
> +	case BOARD_R_C8F:
> +		asus_wmi_ec_set_sensor_info(si++, "T_Sensor", hwmon_temp,
> +					    asus_wmi_ec_make_sensor_address(1, 0x00, 0x3D),
> +					    &ec->nr_registers);
> +	}
> +
>  	switch (board) {
>  	case BOARD_RS_X570_E_G:
>  	case BOARD_R_C8H:
