Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF9233E09B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCPVec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:34:32 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:32940 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhCPVeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:34:08 -0400
Received: by mail-il1-f172.google.com with SMTP id r7so14141272ilb.0;
        Tue, 16 Mar 2021 14:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wtVmsGWaSjLvC34llZbZffJDXkhsenU9qqvAZVKv1/8=;
        b=FsYj12I7PF1E8QucrpHUxHRQAYLuPgEAYBUSNNfzkPKpHOpZKXmcWjzojdfXdVOLgE
         Zn3kFTrs03E5/nZnnRe/gGRXL7eCnc1iyrPGNQPoBOLP1bmaMUGZbgOO/SA5wNUvoPBM
         e6ZvatMueqd9OK61mHKKCpTrX/0VygWRHGyubhowsE3tsIzbUvXKlW7oNJQS5bKtNgCI
         i3C5PtdSfr1Q0yzsgFQawxaOXc/v2d1OM02++SI9xaO8w7h71LN4vj9wGEz9JMIFTpyw
         NDdS+ioizNxAkm2tUM5W80rJ7DO0vujV6k3wN5RhsxwDCNSzkUwvyKkdZ7AfwmgCSwly
         9gpg==
X-Gm-Message-State: AOAM530s/pd//EEiKASx4W04jM+rp+iJPOgBrQWajFCQ5YSJpTetWBRo
        Nq1IG8vYspYEqddeWxsnwThwdDAcqw==
X-Google-Smtp-Source: ABdhPJzBVv7HSI1t2gaU7fAZ+GPPij0ZTroo2DRbrLzDx38CURXW9/HTqY0BthmvVcdgHn2IQ6rywQ==
X-Received: by 2002:a92:c5cf:: with SMTP id s15mr5219725ilt.149.1615930448006;
        Tue, 16 Mar 2021 14:34:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k4sm9048115ion.29.2021.03.16.14.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:34:06 -0700 (PDT)
Received: (nullmailer pid 3710741 invoked by uid 1000);
        Tue, 16 Mar 2021 21:34:04 -0000
Date:   Tue, 16 Mar 2021 15:34:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
Message-ID: <20210316213404.GA3710556@robh.at.kernel.org>
References: <20210311095715.17048-1-ansuelsmth@gmail.com>
 <20210311095715.17048-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311095715.17048-3-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 10:57:00 +0100, Ansuel Smith wrote:
> Document nvmem-cells compatible used to treat mtd partitions as a
> nvmem provider.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/mtd/partitions/nvmem-cells.yaml  | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
