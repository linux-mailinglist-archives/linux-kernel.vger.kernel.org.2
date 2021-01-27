Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172BF305DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhA0ODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:03:04 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41713 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhA0OBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:01:02 -0500
Received: by mail-ot1-f41.google.com with SMTP id k8so1711354otr.8;
        Wed, 27 Jan 2021 06:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Pvt6d5CGxTpASp51QfzOAN0WTM5rhfa8sxsywVVWTQU=;
        b=TKRW92nmZoNHGUHtCg8A1p5Bx1ljqZgctxs3hOyteW000GF1DLdTNJkIb5WO4qpK3m
         XhpjeMjm4DFtXiAik7Jt/7IIB35nOq+Zin+L3siyvJT2v2qmjDdaqLs8YH3rWri0xqqB
         eta9+c+7CrFXs79LgIpKTNlY/DzNpsE8FnSNzeJfZH/eVa+P8+XwYyCHbnrywGPyWxT9
         hlWDSyCita96G4DumQM9tHhYT2lik4COmYGLmkEuiqmTRfeIpSzbU6wmTzeagZY/CxOX
         mq5GIJbk9ukbngN7UFEWk1ZZIdoYt7yZ3x5gN0vMv7HFq+8VqcsxwNJ8zqvZ7t9wEdlj
         WeuA==
X-Gm-Message-State: AOAM532alZm29j7SBHhDzdRrThLzbXj++4VHs+QT87Qt7DDMAU1Awh3G
        JayQ6XUSjOPVmD5jRs8zFQ==
X-Google-Smtp-Source: ABdhPJxrv2PX6DjBNA4sK0RpUtZ4n5E/3ozNvvrU/J4B1isCcaGQnkD28bbKGMc8th2nG4cPX+a1GQ==
X-Received: by 2002:a05:6830:2152:: with SMTP id r18mr7951897otd.296.1611756022385;
        Wed, 27 Jan 2021 06:00:22 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g13sm364529otr.74.2021.01.27.06.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:00:21 -0800 (PST)
Received: (nullmailer pid 1429684 invoked by uid 1000);
        Wed, 27 Jan 2021 14:00:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     bp@suse.de, damien.lemoal@wdc.com, shawnguo@kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        jassisinghbrar@gmail.com, markgross@kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>,
        devicetree@vger.kernel.org, paul.walmsley@sifive.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org, corbet@lwn.net,
        peng.fan@nxp.com, robh+dt@kernel.org, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, palmerdabbelt@google.com
In-Reply-To: <20210126054036.61587-18-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com> <20210126054036.61587-18-mgross@linux.intel.com>
Subject: Re: [PATCH v3 17/34] xlink-ipc: Add xlink ipc device tree bindings
Date:   Wed, 27 Jan 2021 08:00:11 -0600
Message-Id: <1611756011.192491.1429683.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 21:40:19 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add device tree bindings for the xLink IPC driver which enables xLink to
> control and communicate with the VPU IP present on the Intel Keem Bay
> SoC.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
> ---
>  .../misc/intel,keembay-xlink-ipc.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml

See https://patchwork.ozlabs.org/patch/1432167

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

