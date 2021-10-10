Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12A428367
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 21:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhJJTeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 15:34:11 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:37852 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhJJTeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 15:34:01 -0400
Received: by mail-ot1-f48.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so18895200otv.4;
        Sun, 10 Oct 2021 12:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=9HyABHgPYgGal/sy/skHP8VtC/QmAdxeyMbtN7+dwms=;
        b=3I6IpCpE+6hM3qSB1EEyrtYfmo6+uMa5m+cAbXIFa4dbZ286DcGkhYKg+9885b/JaU
         wcM79znX74eRiKeW93fpQLOZqM8d05Y0RdZ7Er/hRsYbKPgokXq9bNp0BaVcjUaYaxKp
         52Q0efexDEEbM8IiUQk5gqejul1rTaGrlGJYlI8WuigdVnXWh34Di7M0EEJoSAwM0ZSq
         y4LI11+AjvDs+IlHmojP4adN/Cdeeu1hvoQNatJzTjXydkSiIBM2G9nin7ZSx++cZrvF
         +AYMf4g9WACDqBQuv+5o+2pgVZH9Zbpvtc9ezqYgf/dFIt9Naoi18W3quqgMQnMyikmX
         pz/Q==
X-Gm-Message-State: AOAM530NbHCW3UClwK6UAgKTZKF/jt3MANNTBZtuoOfxx4PIHOSX0gQo
        4NO0CLchvI9uSXoyeodm+w==
X-Google-Smtp-Source: ABdhPJxUkh7mUwxcvqyvZnzD/TkQmuaAeXID3n3EbuHLG3ekM/EhzvUKrm3JDoG9JI2V0JVaELrd9w==
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr17982596ots.372.1633894322514;
        Sun, 10 Oct 2021 12:32:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bo31sm1271139oib.13.2021.10.10.12.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 12:32:02 -0700 (PDT)
Received: (nullmailer pid 3158662 invoked by uid 1000);
        Sun, 10 Oct 2021 19:31:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Oskar Senft <osk@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
In-Reply-To: <20211010033112.3621816-1-osk@google.com>
References: <20211010033112.3621816-1-osk@google.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: Add nct7802 bindings
Date:   Sun, 10 Oct 2021 14:31:56 -0500
Message-Id: <1633894316.391361.3158661.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Oct 2021 23:31:11 -0400, Oskar Senft wrote:
> This change documents the device tree bindings for the Nuvoton
> NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
> Changes from PATCH v5:
> - Refactored to use patternProperties.
> - Added validation for sensor-type and temperature-mode.
> ---
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml:41:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml:48:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml:53:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml:66:19: [warning] wrong indentation: expected 20 but found 18 (indentation)
./Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml:85:19: [warning] wrong indentation: expected 20 but found 18 (indentation)
./Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml:90:19: [warning] wrong indentation: expected 20 but found 18 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1538966

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

