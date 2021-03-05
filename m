Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEC32F5D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCEWXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:23:11 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:41925 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhCEWXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:23:04 -0500
Received: by mail-oo1-f41.google.com with SMTP id h38so803120ooi.8;
        Fri, 05 Mar 2021 14:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b8P+vy/tLdxvp5/ToJi80Q/DHBxXI6Ot1Z2gtZWpXw8=;
        b=OiU5TlzzQbhrPvgFCbqqx43HKubGaGdUXicwxF2LerJxK0Erq07MqWXetSeviTotvA
         nI9fijQaBiGNWw+u+FYN/qUS75949jv3+iYgUJtDb1q4EgmAtkDZdh8msJ45Ynmjdwug
         znm+oCrNumui9x2MlexOnVlIY6/34ifAuIzo1naJKmT/6Oow73P8umNEjV1cvK7Qxz6z
         Ztb13QGX1JoEGuV9MjYmGfuDW0ZY7u8bku55oz6F9+9qkcTQIGZJ4NvWZc5WCGZO4z04
         XUdbrK8tQ/2XHw88kZzVWnhesbRnQfew/s0XwdMbIoguHAP3eAYXOH0lbKAq0C4YkxGG
         6xZg==
X-Gm-Message-State: AOAM532qdusV+yrCAWMsbvzn5Rgu4GQHrFkg/+7hYk5lI+Ii0Wt596gF
        4NZCS48Ja8ey78C5JoYNoA==
X-Google-Smtp-Source: ABdhPJyOKMFlHRvt9nZGqAzqrlWl3iV1hED2sgZuiivhtD5q9gLMMzNY/ECHThZmidDO6Y8cIe1wLQ==
X-Received: by 2002:a4a:3012:: with SMTP id q18mr9540216oof.21.1614982982146;
        Fri, 05 Mar 2021 14:23:02 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s73sm818019oih.36.2021.03.05.14.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:23:01 -0800 (PST)
Received: (nullmailer pid 750912 invoked by uid 1000);
        Fri, 05 Mar 2021 22:23:00 -0000
Date:   Fri, 5 Mar 2021 16:23:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: Document use of
 nvmem-partitions compatible
Message-ID: <20210305222300.GA718014@robh.at.kernel.org>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-4-ansuelsmth@gmail.com>
 <1cf374f1-09d5-9fa9-9b0d-d8079f2f6fbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cf374f1-09d5-9fa9-9b0d-d8079f2f6fbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:01:55AM +0100, Rafał Miłecki wrote:
> [Rob: please advise]
> 
> On 16.02.2021 22:26, Ansuel Smith wrote:
> > Document nvmem-partitions compatible used to treat mtd partitions as a
> > nvmem provider.
> 
> Until now we were using "compatible" string in partition node only for
> parsers (looking for subpartitions). We need to think if this change can
> break anything from DT / Linux perspective.
> 
> Compatible strings should be unique, so there is no risk of conflict
> between NVMEM and parsers.
> 
> Now: can we ever need mtd partition to:
> 1. Contain subpartitions
> 2. Provide NVMEM
> at the same time?
> 
> Let's say:
> 
> partition@0 {
> 	compatible = "vendor,dynamic-firmware-partitions", "nvmem-partitions";

I think you'd want the "vendor,dynamic-firmware-partitions" parser/code 
to serve up any nvmem regions. Whether you have a fallback here depends 
if an OS could make use of the regions knowing nothing about 
"vendor,dynamic-firmware-partitions".

> 	label = "firmware";
> 	reg = <0x0 0x100000>;
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	ranges = <0 0x0 0x100000>;
> 
> 	firmware-version@10 {
> 		reg = <0x10 0x4>;
> 	};
> 
> 	firmware-date@10 {
> 		reg = <0x20 0x4>;
> 	};
> };
> 
> Is that allowed to respect both "compatible" strings and have:
> 1. Linux parser parse "firmware" for subpartitions
> 2. Linux MTD register "firmware" as NVMEM device
> ?
> 
> If not, what other options do we have? Is that allowed to have a
> dangling MTD NVMEM node with phandle to MTD partition?
> 
> firmware: partition@0 {
> 	compatible = "vendor,dynamic-firmware-partitions";
> 	label = "firmware";
> 	reg = <0x0 0x100000>;
> };
> 
> (...)
> 
> firmware-version@10 {
> 	compatible = "mtd-nvmem";
> 	reg = <0x10 0x4>;
> 	mtd = <&firmware>;
> };
> 
> firmware-date@10 {
> 	compatible = "mtd-nvmem";
> 	reg = <0x20 0x4>;
> 	mtd = <&firmware>;
> };

This, I would not like to see.

Rob
