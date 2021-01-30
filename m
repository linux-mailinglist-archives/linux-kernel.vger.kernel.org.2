Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03B8309730
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhA3RYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 12:24:31 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43185 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhA3RY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 12:24:27 -0500
Received: by mail-ot1-f43.google.com with SMTP id v1so11926793ott.10;
        Sat, 30 Jan 2021 09:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5lm7/hV6c65Q/cr5m5sS/rDOMt7YQe2hob//4UI9ygY=;
        b=jPnbMbKNeEoUVJ/B+G0yZ2HWful3K9ag+IuSg95xQDVpUiAVfCTycl7JxX48UXhDEt
         obQYNyUQCmjeVOlfGENqlhK2G7it/q5DSCnyQmMmth3192uLyRhgVIdfbljhnVUOggkg
         bHe+Gx3fEpSyF0oQoU14EUwryct69rYyqEt5nYRIwlc4so/mqBKHI0CxjUZhxwfUnPpM
         R8CDGH7jMiYiQlMvi3Qf1SYn9lfjsTzAzX1KCpIn/F78tm1YWMCfaR89s6deeU468tM9
         BI5LLO2tCRXh3SNWr0tj4cLr/thsdKRDIl46TBMrty/PygROvCqw934Ospuu0DIJtqy5
         BjuA==
X-Gm-Message-State: AOAM531XB/cbvKYxnku9SMLjJFNWsY9dhmIzPY4ZTFRjpc088+rsKPwN
        rRsrP+hh0E/2DX+wBatj8w==
X-Google-Smtp-Source: ABdhPJyhGSjrtearJ7B0HPT/DK9nWeCKSNSbetxEe9fIbZlYqZYRIWpOtCXi+5rFhjJ/QqYCOH5yRA==
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr6633245oth.332.1612027427057;
        Sat, 30 Jan 2021 09:23:47 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f92sm2207955otb.21.2021.01.30.09.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 09:23:45 -0800 (PST)
Received: (nullmailer pid 1419432 invoked by uid 1000);
        Sat, 30 Jan 2021 17:23:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     palmerdabbelt@google.com, linux-kernel@vger.kernel.org,
        dragan.cvetic@xilinx.com, paul.walmsley@sifive.com,
        jassisinghbrar@gmail.com, arnd@arndb.de, bp@suse.de,
        robh+dt@kernel.org, markgross@kernel.org, shawnguo@kernel.org,
        gregkh@linuxfoundation.org, damien.lemoal@wdc.com, corbet@lwn.net,
        peng.fan@nxp.com, devicetree@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
In-Reply-To: <20210130022124.65083-68-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com> <20210130022124.65083-68-mgross@linux.intel.com>
Subject: Re: [PATCH v4 32/34] dt-bindings: misc: hddl_dev: Add hddl device management documentation
Date:   Sat, 30 Jan 2021 11:23:40 -0600
Message-Id: <1612027420.855682.1419431.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 18:21:22 -0800, mgross@linux.intel.com wrote:
> From: "C, Udhayakumar" <udhayakumar.c@intel.com>
> 
> Add hddl device management documentation
> 
> The HDDL client driver acts as an software RTC to sync with network time.
> It abstracts xlink protocol to communicate with remote IA host.
> This driver exports the details about sensors available in the platform
> to remote IA host as xlink packets.
> This driver also handles device connect/disconnect events and identifies
> board id and soc id using gpio's based on platform configuration.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: C Udhayakumar <udhayakumar.c@intel.com>
> Signed-off-by: Mark Gross <mgross@linux.intel.com>
> ---
>  .../bindings/misc/intel,hddl-client.yaml      | 114 ++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,hddl-client.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,hddl-client.example.dt.yaml: example-0: hddl@20320000:reg:0: [0, 540147712, 0, 2048] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

See https://patchwork.ozlabs.org/patch/1433603

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

