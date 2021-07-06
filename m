Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3DB3BDC4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhGFRb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 13:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhGFRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 13:31:26 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C4C06175F;
        Tue,  6 Jul 2021 10:28:47 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so22362044oti.2;
        Tue, 06 Jul 2021 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2avUQElU1qp51DDfhaEp68Epdl/5/BzhWEer5zeB0c=;
        b=gQ5VGgn6W0feAAqxlMmkGf1xB1YpQyaThSPsp0msS+tYJg13wVRsFwWYAklnkZnuY7
         F0fnv80KSgK+Sqe6ahGdehdfU5Jvjj+3Pga+OZPGYng+rS5TaV5CIepT3uRM7sdPf/jA
         C9EHQqaIyEEQvMoTxSBgmoC/GnKkmApTmamt1mhlN1Pi+KqjgyYkZsLgDrgyY3bwg1ez
         pNF4ZfxnMfBdn7SU0Kwml3J25F4k0KOv3V2LcjeiWSfZ5ELyhCtNnBXdtU1THXCBkSdO
         hFLrMIOPgAVPAh37IX6pVJ+G5o1G/aKVGV/zSVdoQchZ4T2xY5BffftYdPcqF9XhPi2w
         WukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=J2avUQElU1qp51DDfhaEp68Epdl/5/BzhWEer5zeB0c=;
        b=ipd6PnTec3fTuE6cZ8tsQDelROrv4QRNz4PX1n7aC1HDYLQldXTUvswnapYTtZg0pr
         m5ovJAnnxtCQFr7ZJ9tS8WnITxZcKtqHer5yQl3MGTkhRWvxQDQjaoF9yerkxvjLGzBf
         UGc4yo1RNildoywfKPE6DTYL1qmRHqg/nSFhOfnPoPbNM67nI50GQJ7GzQJ4e35ugkho
         bap/Re5/1NYc4nzbPODIcMEckUlCId7qmJwsubVorXRmIfLfPrATXTD9RHJpupKfBWVs
         GdOyvQ6O6RGDPPB8luogJZLR9oTL3QIarIftIoLxSZORxf8KHshF9jCRAV5g6D8c/hL2
         /Jpg==
X-Gm-Message-State: AOAM532NmTH4h4UVCS7BhLuq0QGXWkY3dM1V6qGEWKdfmtAUaWM5Fms9
        t1M4qs9jXd/AEe1Ax7DnjHU=
X-Google-Smtp-Source: ABdhPJxi6FdkTq7HIyDaswbKg4Ba9wMGHYw2NkfWwF5mFV8tKBf6n9fo3LZjQc5Zb9tgKN+l7a/97A==
X-Received: by 2002:a9d:6484:: with SMTP id g4mr15686141otl.331.1625592526934;
        Tue, 06 Jul 2021 10:28:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 76sm1397185otj.28.2021.07.06.10.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:28:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 6 Jul 2021 10:28:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: Re: [PATCH 3/3] Documentation: hwmon: New information for DA9063
Message-ID: <20210706172845.GB943349@roeck-us.net>
References: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
 <089cba74f35e1f7cb07064fa336518d853c8d569.1625581991.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089cba74f35e1f7cb07064fa336518d853c8d569.1625581991.git.plr.vincent@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 02:34:49PM +0000, Vincent Pelletier wrote:
> From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
> 
> Addition of HWMON documentation for the DA9063 driver.
> 
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> 
> Updated temperature formula, as of datasheet rev 2.3.
> Converted to ReStructuredText.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
> Changes in v2:
> - ReST-ified
> 
> Originally submitted by Steve Twiss in 2014:
>   https://marc.info/?l=linux-kernel&m=139560868209856&w=2
> 
>  Documentation/hwmon/da9063.rst | 73 ++++++++++++++++++++++++++++++++++

Needs to be added to index.rst.

>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/hwmon/da9063.rst
> 
> diff --git a/Documentation/hwmon/da9063.rst b/Documentation/hwmon/da9063.rst
> new file mode 100644
> index 000000000000..aae69c58a5d6
> --- /dev/null
> +++ b/Documentation/hwmon/da9063.rst
> @@ -0,0 +1,73 @@
> +Kernel driver da9063-hwmon
> +==========================
> +
> +Supported chips:
> +
> +  * Dialog Semiconductor DA9063 PMIC
> +
> +    Prefix: 'da9063'
> +
> +    Datasheet: Publicly available at the Dialog Semiconductor website:
> +
> +	http://www.dialog-semiconductor.com/products/power-management/DA9063
> +
> +Authors:
> +	- S Twiss <stwiss.opensource@diasemi.com>
> +	- Vincent Pelletier <plr.vincent@gmail.com>
> +
> +Description
> +-----------
> +
> +The DA9063 PMIC provides a general purpose ADC with 10 bits of resolution.
> +It uses track and hold circuitry with an analogue input multiplexer which
> +allows the conversion of up to 9 different inputs:
> +
> +- Channel  0: VSYS_RES	measurement of the system VDD (2.5 - 5.5V)
> +- Channel  1: ADCIN1_RES	high impedance input (0 - 2.5V)
> +- Channel  2: ADCIN2_RES	high impedance input (0 - 2.5V)
> +- Channel  3: ADCIN3_RES	high impedance input (0 - 2.5V)
> +- Channel  4: Tjunc	measurement of internal temperature sensor
> +- Channel  5: VBBAT	measurement of the backup battery voltage (0 - 5.0V)
> +- Channel  6: N/A	Reserved
> +- Channel  7: N/A	Reserved
> +- Channel  8: MON1_RES	group 1 internal regulators voltage (0 - 5.0V)
> +- Channel  9: MON2_RES	group 2 internal regulators voltage (0 - 5.0V)
> +- Channel 10: MON3_RES	group 3 internal regulators voltage (0 - 5.0V)
> +
> +The MUX selects from and isolates the 9 inputs and presents the channel to
> +be measured to the ADC input. When selected, an input amplifier on the VSYS
> +channel subtracts the VDDCORE reference voltage and scales the signal to the
> +correct value for the ADC.
> +
> +The analog ADC includes current sources at ADC_IN1, ADC_IN2 and ADC_IN3 to
> +support resistive measurements.
> +
> +Channels 1, 2 and 3 current source capability can be set through the ADC
> +thresholds ADC_CFG register and values for ADCIN1_CUR, ADCIN2_CUR and
> +ADCIN3_CUR. Settings for ADCIN1_CUR and ADCIN2_CUR are 1.0, 2.0, 10 and
> +40 micro Amps. The setting for ADCIN3_CUR is 10 micro Amps.
> +
> +Voltage Monitoring
> +------------------
> +
> +The manual measurement allows monitoring of the system voltage VSYS, the
> +auxiliary channels ADCIN1, ADCIN2 and ADCIN3, and a VBBAT measurement of
> +the backup battery voltage (0 - 5.0V). The manual measurements store 10
> +bits of ADC resolution.
> +
> +The manual ADC measurements attributes described above are supported by
> +the driver.
> +
> +The automatic ADC measurement is not supported by the driver.
> +
> +Temperature Monitoring
> +----------------------
> +
> +Temperatures are sampled by a 10 bit ADC.  Junction temperatures
> +are monitored by the ADC channels.
> +
> +The junction temperature is calculated:
> +
> +	Degrees celsius = -0.398 * (ADC_RES - T_OFFSET) + 330;
> +
> +The junction temperature attribute is supported by the driver.
> -- 
> 2.32.0
> 
