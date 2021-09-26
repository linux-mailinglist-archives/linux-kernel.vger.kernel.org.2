Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA42418B73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhIZWe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhIZWe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 18:34:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1760C061570;
        Sun, 26 Sep 2021 15:33:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v18so25851343edc.11;
        Sun, 26 Sep 2021 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wk/Y/R5VR5GDX1mBfmj5o+efAe8gDibSjLgM5RqrMNk=;
        b=KCm9fD3ZbVm4AXFVJQ5IgVVriJbzc+9nNnE/JGhHoBMu3wmmP1c4E4RngZS3iNvygi
         zfR7T4vbrm5bKez/OfYKGzDj1HjsfvB6+TlXbsJtGLXgfp9izgyACRZlvq3YhKxFfHhm
         AaVkKTkKkipaJKk0C7qRllsc3oLmkekVyXMc3GXSqkRrKsHLUsBxoO+bBMT0gZ+GhrHV
         BWJHjM+Ga0umsazS2Tbb/dmeUPfpnwjMGrQrPatcH2oNHnScSoRfKtfXq7ap67bQHoi5
         ouS9k94ty8SLnmxEo/riO0Darm2uaKbWs9YqnYO/6se1FpK4g6DAoXN0Orc7vqBRXyzW
         hSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wk/Y/R5VR5GDX1mBfmj5o+efAe8gDibSjLgM5RqrMNk=;
        b=q+T+lWJNs1ZnqR2hUVmbiwPjcOyrdamStTaasZQTjEuj8eFCyqdl6yMaK+We+QGpNL
         8s5PzxoBLv0hEctYYahJzxbgL8alB7aQ1WErC7NyW0PHZPLG0MDdTyE1MAQHkaFPH01t
         OmOkgWwpPD+4Hn9xACeAy/juxNjE//jz8I7PcfVJ+7Q8swWSILU9PiLjsKtJlHJ2qNtM
         sxm0UPS+ugomJ3baUsdccVM8+DQjPIj6JtncPwxh7nwW+0/tWOx5ZUwZcGanpf1NoXq5
         P8lJTUAAPMUdreszxw9pjL7oRxcdM9zf3qDxsZL6HcRpAU8JCKaTtlxWuOO7bH4OpIa1
         a5Fw==
X-Gm-Message-State: AOAM531OLmcfhnHF8y21G0/w+RHdbQgJLbOG6KXz7P1yYR2fA0U9hJDh
        HA35tg+6WpWwtjWVtvEeWlk=
X-Google-Smtp-Source: ABdhPJwPuYe57o4R2vwPquxA9kJ9P7bMaowKjZvNpGHgJsYh874p5HBTAhpWAQE/PFBALYYKYLM2xw==
X-Received: by 2002:a17:906:7754:: with SMTP id o20mr24629870ejn.475.1632695598513;
        Sun, 26 Sep 2021 15:33:18 -0700 (PDT)
Received: from tom-desktop (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id l23sm204684ejn.15.2021.09.26.15.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:33:17 -0700 (PDT)
Date:   Mon, 27 Sep 2021 00:33:15 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     nicolas saenz julienne <nsaenz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Fix pcie0, pci warning.
Message-ID: <20210926223315.GA39851@tom-desktop>
References: <20210918143542.146060-1-tomm.merciai@gmail.com>
 <408e5e27fae24f22a408afdaf538702858cc324c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408e5e27fae24f22a408afdaf538702858cc324c.camel@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:21:46AM +0200, nicolas saenz julienne wrote:
> Hi Tommaso,
> 
> On Sat, 2021-09-18 at 16:35 +0200, Tommaso Merciai wrote:
> > Fix the following warning:
> > 
> > ./scripts/dtc/include-prefixes/arm/bcm2711-rpi-4-b.dts:220.10-231.4:
> > Warning (pci_device_reg):
> > /scb/pcie@7d500000/pci@1,0: PCI unit address format error, expected "0,0"
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> 
> This issue was already addressed here:
> https://lore.kernel.org/all/20210831125843.1233488-2-nsaenzju@redhat.com/
> 
> It's available in linux-next and will eventually show up upstream.
> 
> Regards,
> Nicolas
>
  Hi Nicolas,
  Thanks for your feedback.

  Tommaso
