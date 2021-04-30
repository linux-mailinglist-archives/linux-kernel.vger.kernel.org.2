Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641AD36FBBF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhD3Ntr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhD3Ntq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:49:46 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7169C06174A;
        Fri, 30 Apr 2021 06:48:58 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d25so32510325oij.5;
        Fri, 30 Apr 2021 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TZFUbfNvpT7fbj8sNiRF6SOdSs72X7RGCFWwHq6pMJw=;
        b=szZcaxPtpapObT1Oa0rHL3G8oPL0Zq33ptUHl/B60ekDYxFw1O9DYH1F1nvSTdvowp
         g+Hh5GdF6SZ1q5eguZbkcw5fwNMcyzxgrlrayYLC6hPgMxRjQQuWafSEXKPoCE1K1dF/
         OkHj0wxdDgg40f6Y9DGBiWQPWoOB+gdI7dDiEkQk/dJJmfksqBWpF5t5for9Bb0iilld
         DboXTWZiemP0bAyDQJimwZvIdpROzV0OtLb9ia6W8RknKyyOdASTk6nrBudetWoMMdu4
         QmWz2Epzp3HmHO4451IGFDQfHQODF8GVWTePMOGgmapjCMYnWqQIWhelHXrx5gO3N//3
         QecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TZFUbfNvpT7fbj8sNiRF6SOdSs72X7RGCFWwHq6pMJw=;
        b=YuL3cYkwfEf/Bn4rqE2KUk6uQO4mX6bikMR/k7V8ljuretcNWSsD21HF8Z9HF/YK4/
         U4IBd75uLIPuhqDH7hJSYC2ffrfIvK+8fVdm4XQou+fcYeB5iwniIBk0+Mhwr6pBX1Rh
         5NfBZ3Cx4c8AopIziqDSuLAc78hnc71R5hTGd727GAn+jcbouLPNDhQxWjxwKyR9yvCC
         9UwzWvLBHKVemcT4ZQ9eDmFW9GYkqe/0XXXGgp+QXKU3ZW9oclZ6RJ4ZTTIws3L42DYH
         JFDHa83CRBGm9gtW0co0npObBKUVN3UddJ3oKfT+YFlykOkN+cUaMxulrm7oJAsjR3f1
         NgZA==
X-Gm-Message-State: AOAM533LmD/hTT4XdnpC672gYd+yGzSdTxfi6iKZsjuG1m+9O+YxaXi+
        bH0FgOA3dnJE5wU1RDDeXHZ4vDL+xpk=
X-Google-Smtp-Source: ABdhPJwNCQtHd5hP/pnaakJqj0PKg6w+KBGyekyx7wLQKb1i8wDVlpeVIKVQkUj04dR2Rt2joCqCyA==
X-Received: by 2002:aca:ed50:: with SMTP id l77mr3932373oih.13.1619790538105;
        Fri, 30 Apr 2021 06:48:58 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u195sm734630oif.55.2021.04.30.06.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 06:48:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Apr 2021 06:48:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: pmbus: Add Delta DPS920AB PSU
 driver bindings
Message-ID: <20210430134856.GB2714262@roeck-us.net>
References: <20210430132735.127342-1-robert.marko@sartura.hr>
 <20210430132735.127342-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430132735.127342-2-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:27:34PM +0200, Robert Marko wrote:
> Add binding document for the Delta DPS920AB PSU driver.
> 

Is there a reason to not just add delta,dps920ab to the list of trivial
devices ?

Thanks,
Guenter

> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  .../bindings/hwmon/pmbus/delta,dps920ab.yaml  | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/delta,dps920ab.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/delta,dps920ab.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/delta,dps920ab.yaml
> new file mode 100644
> index 000000000000..e05363a8e455
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/delta,dps920ab.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/pmbus/delta,dps920ab.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Delta DPS920AB power supply
> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +description: |
> +  Delta DPS920AB is a 920W 54V DC single output power supply
> +  with active PFC capable of 16.88A on the 54V output.
> +  It has a built in PWM capable fan with tachometer.
> +  PMBus is used to expose information about the PSU.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - delta,dps920ab
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        psu@5a {
> +            compatible = "delta,dps920ab";
> +            reg = <0x5a>;
> +        };
> +    };
> -- 
> 2.31.1
> 
