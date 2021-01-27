Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8772C305DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhA0OCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:02:19 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33026 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhA0OAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:00:55 -0500
Received: by mail-ot1-f52.google.com with SMTP id 63so1743850oty.0;
        Wed, 27 Jan 2021 06:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=h/XP4S0QrgFu5lhfiNjNNTiDPvZSTXVhFOBBdSSJhI0=;
        b=C89ygd9sjCLcEgKX0k+phEmwX1UAZMBnc605QIyNAY5zt3B7ubmE3BczQjBLErSqyI
         b+xqh/ec7LlM/jodXS/etFG+gkN/1DLIvalWf5zOcmsLFJOK/9WVVO14fbP9SZfvg+b0
         s/0QEqr7ShFRHWhJSVU5otQsSEBXJDIEvuiu3MBHENfS8FssumbPtjM22w+R0Pv+ylI6
         YdvHyTxF4VwyMLCwduPY1GFbFjKohMleEHh8TzIUThohEhQsPjt278mJSfs11El7hscd
         vzwVL5j3T216N/6FIkwqEmPkECgMGKd9uveCTXYC6O7TnhQwY3gOEc+9ua7RVZL2HRVa
         nx4g==
X-Gm-Message-State: AOAM533h5pgsRIdRJADJckCupcdAH3cNCk8IKW3AL//7/aGcqYFsR+lA
        yaJn1aIOsCxnt46L/NHYsg==
X-Google-Smtp-Source: ABdhPJwG1SJ4BiGFh1W5LAqX7QPY43/jyoKNzbqEUEzFLpeeFKXUzWOwYN3vIUuV4fazsG3ZMdt8tg==
X-Received: by 2002:a9d:5cc3:: with SMTP id r3mr8293768oti.286.1611756013636;
        Wed, 27 Jan 2021 06:00:13 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w11sm375352otl.13.2021.01.27.06.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:00:12 -0800 (PST)
Received: (nullmailer pid 1429681 invoked by uid 1000);
        Wed, 27 Jan 2021 14:00:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     jassisinghbrar@gmail.com, palmerdabbelt@google.com,
        dragan.cvetic@xilinx.com, devicetree@vger.kernel.org,
        arnd@arndb.de, paul.walmsley@sifive.com, robh+dt@kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        gregkh@linuxfoundation.org, markgross@kernel.org, corbet@lwn.net,
        damien.lemoal@wdc.com, Paul Murphy <paul.j.murphy@intel.com>,
        bp@suse.de, peng.fan@nxp.com, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210126054036.61587-7-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com> <20210126054036.61587-7-mgross@linux.intel.com>
Subject: Re: [PATCH v3 06/34] dt-bindings: Add bindings for Keem Bay VPU IPC driver
Date:   Wed, 27 Jan 2021 08:00:11 -0600
Message-Id: <1611756011.180359.1429680.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 21:40:08 -0800, mgross@linux.intel.com wrote:
> From: Paul Murphy <paul.j.murphy@intel.com>
> 
> Add DT bindings documentation for the Keem Bay VPU IPC driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
> Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  .../soc/intel/intel,keembay-vpu-ipc.yaml      | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1432168

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

