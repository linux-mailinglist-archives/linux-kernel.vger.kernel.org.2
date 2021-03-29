Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1B34D9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhC2WK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhC2WKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:10:15 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED44C061762;
        Mon, 29 Mar 2021 15:10:15 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id f9so14541855oiw.5;
        Mon, 29 Mar 2021 15:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Vcj/Yi21ZkBpjZGfETbHIEvLLNDhdaXnn80hlKG9iQ=;
        b=CoFBvuhPMLk/7aLGCtafHT+zBgLB72FtaNuND2L4opXVqUx0wlhPO/qxK0Gpidy6n9
         Y5/0wrZxuS9xcfQkDOcX9tvbnIPm1XeexotaAyWmu3Oo0sn/2Uf8PMuTxe9ZddijhbmR
         gancMeR2o19MBPJYIBsUM63uBWq4ynz88ehAVyf88xsuYI+lP+EWbTNnTygQ+/nq1MQe
         4wfdRrFe7KYrgHvPZkGrY4akhW1AC7pwl9/B1qnsYLywU2HcfhFIDNTT6GxG141GKh26
         JSTEajoppUZUg0rp+waLZRVSXaoeW8b08nxW8hqf6bxE3DN8ptVxR61fQLXxwAb157Sf
         t+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Vcj/Yi21ZkBpjZGfETbHIEvLLNDhdaXnn80hlKG9iQ=;
        b=UboJL8Iem+lnZFz8Gt4BRULEGapddombvr01+F7qMT6sheIJh4IlAC99oXqrDOr2mI
         nUwVydGnBguQSrX2o/CJhFIRM7D0ibl6usxjwZQ3UwyJDM6Yh9DooIs8VTyWvoN/qfOB
         wjBX9iipQoWywCV2kXe0ZB3euds+OlxeCVnE2cbMK9Xb374b/m5a/9GVv9JClfd0J6Vg
         p5b7UXwkTQOMneVqb2Cv29VMS8HeiBBJsjB9owLCXjtLOPjyMuw0kK6FBirRL6Hs/AFI
         EZx8AbcpLWrK9fq7faP1DjkrhvwybTpedZYBU/ziPybZycIc/CtNou30s/QJ1lLUHCo2
         fpoA==
X-Gm-Message-State: AOAM533NW7AXJYSB9bVfapjQigIuRht9AOYog+0WGtSqqEzb/5Dsdqbn
        hp/WetGeGElLzXyHHUpiiz4=
X-Google-Smtp-Source: ABdhPJxWitoYaw1dDjKa5+m4csfLke/e1XWYiM1+duJI4SY5VOX/l4Mjvt/4gVXgbV7PKiyg78eXkw==
X-Received: by 2002:aca:4c0c:: with SMTP id z12mr908790oia.109.1617055815085;
        Mon, 29 Mar 2021 15:10:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i25sm4724161otf.37.2021.03.29.15.10.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Mar 2021 15:10:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Mar 2021 15:10:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add trivial device entry for TPS53676
Message-ID: <20210329221013.GA223040@roeck-us.net>
References: <20210318212441.69050-1-erik.rosen@metormote.com>
 <20210318212441.69050-2-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318212441.69050-2-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:24:40PM +0100, Erik Rosen wrote:
> Add trivial device entry for TPS53676
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index a327130d1faa..2e29c2a91966 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -288,6 +288,8 @@ properties:
>            - ti,tmp103
>              # Digital Temperature Sensor
>            - ti,tmp275
> +            # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
> +          - ti,tps53676
>              # TI Dual channel DCAP+ multiphase controller TPS53679
>            - ti,tps53679
>              # TI Dual channel DCAP+ multiphase controller TPS53688
