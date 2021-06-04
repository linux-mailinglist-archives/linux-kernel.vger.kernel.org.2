Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4460A39C098
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFDTq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:46:59 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45945 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:46:58 -0400
Received: by mail-ot1-f50.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so10135670otc.12;
        Fri, 04 Jun 2021 12:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=awQLh2q3fANMOOCZnBFVMiYm1TxL6yFS8QdxMIZ2xpE=;
        b=PSVScq4fUC3Iq7s0T5GanXAk7cEp8ykjQLOuzX9rXWs12ZbSMgPaUTeLjpHEeT7+Gz
         vMe218JfmK42OcSxwY8/0MuU3uxXFI6ZPQdJYr+wFhIOM01xrq63qckUQoLK0XU7kAxv
         nNpuS8KtOvkoNgXqj5t1mV7YGoxJZtySq1fkpmImv5fJh/FIifnFpFk0fIMjQIC7Lt2O
         ghKriKPhRQ2kUvQ7vWNY434iGbBGQQlRBjlFFNQwgSgzQLySUMn4bN6ifE95jpdmuRz7
         ESJAlJkA0IuL24ndyLwYPgiBYjiaKEkQjpLiIjLIqINJOanFINh4mIZvnoV+dEOuiiU+
         AE8Q==
X-Gm-Message-State: AOAM533XwsN/7ok+7weFkV4hOdHfwTMBd1kqxLnMy/UBZe7vsdmvucuH
        Lu55gesOyUeyKK3lPlYp8Q==
X-Google-Smtp-Source: ABdhPJwVhx6MG6ai07Bwc5cHhIK7rI0KCdCOiCDi+biU9Q/RF4dhM0wok0LY1qB6iggilqfIjjoEDA==
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr5047250otl.109.1622835911798;
        Fri, 04 Jun 2021 12:45:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n127sm648997oif.55.2021.06.04.12.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:45:11 -0700 (PDT)
Received: (nullmailer pid 3791295 invoked by uid 1000);
        Fri, 04 Jun 2021 19:45:10 -0000
Date:   Fri, 4 Jun 2021 14:45:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: remove compatible handled
 by other schema
Message-ID: <20210604194510.GA3787574@robh.at.kernel.org>
References: <20210521192505.13441-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521192505.13441-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 07:25:05PM +0000, Corentin Labbe wrote:
> Remove gmt,g751 dallas,ds1775 dallas,ds75 maxim,max6625 national,lm75 ti,tmp275
> from trivial-devices since there are handled by hwmon/lm75.yaml
> 
> Remove skyworks,sky81452 handled by mfd/sky81452.txt
> Remove nuvoton,npct601 handled by security/tpm/tpm-i2c.txt
> Remove maxim,max1237 handled by iio/adc/maxim,max1238.yaml
> Remove adi,adt7461 and adt7461 handled by hwmon/lm90.txt
> Remove dlg,da9063 handled by mfd/da9063.txt

Are the trivial-devices version wrong in some way? If not, we are going 
from having a schema to not having one for these devices that have a 
.txt file. 

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../devicetree/bindings/trivial-devices.yaml  | 24 -------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 4e92792f9153..d01c4211bda4 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -39,10 +39,6 @@ properties:
>            - adi,adp5585-02
>              # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
>            - adi,adp5589
> -            # +/-1C TDM Extended Temp Range I.C
> -          - adi,adt7461
> -            # +/-1C TDM Extended Temp Range I.C
> -          - adt7461
>              # AMS iAQ-Core VOC Sensor
>            - ams,iaq-core
>              # i2c serial eeprom  (24cxx)
> @@ -65,14 +61,10 @@ properties:
>            - dallas,ds1631
>              # Total-Elapsed-Time Recorder with Alarm
>            - dallas,ds1682
> -            # Tiny Digital Thermometer and Thermostat
> -          - dallas,ds1775
>              # CPU Peripheral Monitor
>            - dallas,ds1780
>              # CPU Supervisor with Nonvolatile Memory and Programmable I/O
>            - dallas,ds4510
> -            # Digital Thermometer and Thermostat
> -          - dallas,ds75
>              # 1/4 Brick DC/DC Regulated Power Module
>            - delta,q54sj108a2
>              # Devantech SRF02 ultrasonic ranger in I2C mode
> @@ -83,8 +75,6 @@ properties:
>            - devantech,srf10
>              # DA9053: flexible system level PMIC with multicore support
>            - dlg,da9053
> -            # DA9063: system PMIC for quad-core application processors
> -          - dlg,da9063
>              # DMARD05: 3-axis I2C Accelerometer
>            - domintech,dmard05
>              # DMARD06: 3-axis I2C Accelerometer
> @@ -107,8 +97,6 @@ properties:
>            - mps,mp2888
>              # Monolithic Power Systems Inc. multi-phase controller mp2975
>            - mps,mp2975
> -            # G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
> -          - gmt,g751
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IR38064 Voltage Regulator
> @@ -139,8 +127,6 @@ properties:
>            - maxim,ds1803-050
>              # 100 kOhm digital potentiometer with I2C interface
>            - maxim,ds1803-100
> -            # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
> -          - maxim,max1237
>              # 10-bit 10 kOhm linear programable voltage divider
>            - maxim,max5481
>              # 10-bit 50 kOhm linear programable voltage divider
> @@ -151,8 +137,6 @@ properties:
>            - maxim,max5484
>              # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
>            - maxim,max6621
> -            # 9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
> -          - maxim,max6625
>              # 3-Channel Remote Temperature Sensor
>            - maxim,max31730
>              # mCube 3-axis 8-bit digital accelerometer
> @@ -235,8 +219,6 @@ properties:
>            - miramems,da311
>              # Temperature sensor with integrated fan control
>            - national,lm63
> -            # I2C TEMP SENSOR
> -          - national,lm75
>              # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
>            - national,lm80
>              # Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
> @@ -247,8 +229,6 @@ properties:
>            - national,lm92
>              # i2c trusted platform module (TPM)
>            - nuvoton,npct501
> -            # i2c trusted platform module (TPM2)
> -          - nuvoton,npct601
>              # Nuvoton Temperature Sensor
>            - nuvoton,w83773g
>              # OKI ML86V7667 video decoder
> @@ -275,8 +255,6 @@ properties:
>            - sgx,vz89x
>              # Relative Humidity and Temperature Sensors
>            - silabs,si7020
> -            # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
> -          - skyworks,sky81452
>              # Socionext SynQuacer TPM MMIO module
>            - socionext,synquacer-tpm-mmio
>              # i2c serial eeprom  (24cxx)
> @@ -305,8 +283,6 @@ properties:
>            - ti,tmp102
>              # Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>            - ti,tmp103
> -            # Digital Temperature Sensor
> -          - ti,tmp275
>              # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
>            - ti,tps53676
>              # TI Dual channel DCAP+ multiphase controller TPS53679
> -- 
> 2.26.3
