Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D2F365AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhDTN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:59:17 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:36765 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhDTN7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:59:15 -0400
Received: by mail-oi1-f173.google.com with SMTP id v6so11197037oiv.3;
        Tue, 20 Apr 2021 06:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Kl/HdC6UYvnDbbF4wYRMMSs2xIVc93NKIkmpe2ylv/Y=;
        b=tSS70KtEO61nEHubzz8/EPxvkUv60OzEqiNLYHXEsBXzWexN0kDnBtqjqTPjy+KdJm
         pH8vmBtaX1fs8akUf9lMGQH+sc4yc0ieI+Jdo3NTG0pc9eHw7PQx63ltbDUViZLB3ivi
         lcPyxxa5VDAvju1vKnpppgHpWzdtZl19Vv+VsOsEqFaMH93i56qVv7IN19eeWn5ESbxi
         zlrTfklnRa5heJqJ4AsjkMaTTBmgdxstLKgey7XAL9kCE8gi/zlscbiNyfE7xGaaID4O
         Aj+m1S2UGFAykcSbKuEYoPpmd1H9nDsqilcpMbJ2JpvEDwKATSO78suKOMjQoff7Ex4W
         n/yw==
X-Gm-Message-State: AOAM532bzHIzoVjdnDQS9r7k9RazEO4Gh1183XmKjUVCCX3x6RoFY94v
        DLLFDBLMOacqLlWKk2kVtw==
X-Google-Smtp-Source: ABdhPJw25ncs9k0AEknxek2E28DfrCDHuZPo05s3wKLawuoCrO9ETCuf/42fREidw6vw5JWxLvmu2Q==
X-Received: by 2002:aca:3684:: with SMTP id d126mr3137121oia.129.1618927123047;
        Tue, 20 Apr 2021 06:58:43 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 104sm660466oti.52.2021.04.20.06.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:58:42 -0700 (PDT)
Received: (nullmailer pid 3235335 invoked by uid 1000);
        Tue, 20 Apr 2021 13:58:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     robh+dt@kernel.org, tejas.patel@xilinx.com,
        michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        linux-arm-kernel@lists.infradead.org, amit.sunil.dhamne@xilinx.com,
        dragan.cvetic@xilinx.com, derek.kiernan@xilinx.com,
        jolly.shah@xilinx.com, git@xilinx.com, chinnikishore369@gmail.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20210420081153.17020-5-nava.manne@xilinx.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com> <20210420081153.17020-5-nava.manne@xilinx.com>
Subject: Re: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi config driver
Date:   Tue, 20 Apr 2021 08:58:41 -0500
Message-Id: <1618927121.480164.3235334.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 13:41:52 +0530, Nava kishore Manne wrote:
> This patch adds the binding document for the zynqmp afi
> config driver.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  .../bindings/misc/xlnx,zynqmp-afi-fpga.yaml   | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.example.dt.yaml:0:0: /example-0/firmware/zynqmp-firmware: failed to match any schema with compatible: ['xlnx,zynqmp-firmware']
Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.example.dt.yaml:0:0: /example-0/firmware/zynqmp-firmware/afi: failed to match any schema with compatible: ['xlnx,afi-fpga']

See https://patchwork.ozlabs.org/patch/1468230

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

