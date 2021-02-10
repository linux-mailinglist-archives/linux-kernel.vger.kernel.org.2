Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51316317396
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhBJWpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:45:33 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45915 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhBJWpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:45:32 -0500
Received: by mail-ot1-f50.google.com with SMTP id o12so3404530ote.12;
        Wed, 10 Feb 2021 14:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c6FoamD4ZthKquOoe7izx7q3lybPDFbg0yImDCydR0k=;
        b=UeMrPmqrHA7zV72xovy4aC/MLMj14/XDSU9dLI3kBOf2GC9ofnV384rR4XQ1OwZVON
         IRK1GPuWi7RM14rEY1sfYFMEh5IqgQxPpXDae6S2SDEVfzibKMDPe0568TV8BhrukNg+
         aBtMT5CFahsxeoFEDMG76v17/9awAcbVVhdvMUUhRZbBRM8wmJ6bw0DMNaGh/a0ZW8AT
         3e19zB+W6lGOgdLfW0k3ktGbZwXF3wyibih/soHPba+9q+X0UmwwTAMTVfWYww16ncfG
         RDtlebGOruOLJKz4Bw9/odnN3AzOHrAmmrCCj0HSKeMSjuu29mMbuctTlZM0HhIOPcEj
         9RcA==
X-Gm-Message-State: AOAM53296bOcSLIjyBQ+nBeE9kOzLF2ZDyOGbXPjPXAt3HGV60fAiIKc
        urFJCnfx2ZKmt3Q5qHJi7Q==
X-Google-Smtp-Source: ABdhPJwng7XZUYhvWWUAuPRjz9bdF63u5+/jFwD2ccy3qVL8IJ7dP6GDQdG7qZrCCl/C/VqdlMnRVQ==
X-Received: by 2002:a9d:12f3:: with SMTP id g106mr3668655otg.29.1612997091028;
        Wed, 10 Feb 2021 14:44:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k32sm662406otc.74.2021.02.10.14.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:44:50 -0800 (PST)
Received: (nullmailer pid 2950595 invoked by uid 1000);
        Wed, 10 Feb 2021 22:44:48 -0000
Date:   Wed, 10 Feb 2021 16:44:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        mripard@kernel.org, wahrenst@gmx.net,
        linux-arm-kernel@lists.infradead.org, eric@anholt.net,
        phil@raspberrypi.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC/PATCH v2 03/16] dt-bindings: soc: bcm: bcm2835-pm: Add
 support for bcm2711
Message-ID: <20210210224448.GA2950565@robh.at.kernel.org>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
 <20210209125912.3398-4-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209125912.3398-4-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021 13:58:59 +0100, Nicolas Saenz Julienne wrote:
> Add a new compatible string for BCM2711 and the option to provide a
> third reg property for the board's new Argon ASB.
> 
> In BCM2711 the new Argon ASB took over V3D, which is our only consumer
> of this driver so far. The old ASB is still be present with ISP and H264
> bits but no V3D.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml      | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
