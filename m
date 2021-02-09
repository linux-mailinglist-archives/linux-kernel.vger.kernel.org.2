Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8423314661
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhBICbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:31:42 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:33714 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhBICbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:31:19 -0500
Received: by mail-ot1-f51.google.com with SMTP id 63so16220605oty.0;
        Mon, 08 Feb 2021 18:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PED255axvbXNFhk6Zwh4TAvJp8y+j/S6dmdpcXF2Uuo=;
        b=RcEiTow6Wt0XM0DIRrV7x1wZRjST4kRmFxb8yDt2v54gvt8MTQJBlrYovVTnMW7omP
         eOjHS3z5M9HPeIyfOQSaFXYTHxY2xp0Iq5+HYnehTmCPwcF76C4MyR03noA4ZYB8b4N6
         i/ynzYTKu76jE0mjr0uBhsLvHK33I3YYylDtou7u+A7Rszy9CctuXTXdaqHW3iYHv24I
         9YwSzQgMTACV4xB4pXbeDyG0ou1aqOmZDowdrl2LMSJfTbkDELAvJaIwV4YLdC5vAw1C
         CC+ju0giTmoPwsflBID2J3yG9Limn8FQGIEw3DR4amlLYttHliCBdWKNeaevYZcdN3GS
         H9ZQ==
X-Gm-Message-State: AOAM53312EK0hhA668OlmhFchHGTAghP+M3SaVLlrG30MooFliNG7c+W
        RG6UB1G3mUmX3TAp9thgOebWipu3PA==
X-Google-Smtp-Source: ABdhPJzMRVr0ERYwjWHNwtA/F8L0VEP60pgUm4Q8mQsVdH8KoZ4wC3e++6km4F5eItWOJzZQoaGiHQ==
X-Received: by 2002:a9d:2270:: with SMTP id o103mr10128656ota.303.1612837837674;
        Mon, 08 Feb 2021 18:30:37 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z20sm4062344oth.55.2021.02.08.18.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:30:36 -0800 (PST)
Received: (nullmailer pid 2558082 invoked by uid 1000);
        Tue, 09 Feb 2021 02:30:35 -0000
Date:   Mon, 8 Feb 2021 20:30:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Howard Yen <howardyen@google.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: usb: usb-xhci: add USB offload support
Message-ID: <20210209023035.GA2552083@robh.at.kernel.org>
References: <20210119101044.1637023-1-howardyen@google.com>
 <20210119101044.1637023-5-howardyen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119101044.1637023-5-howardyen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:10:44PM +0800, Howard Yen wrote:
> Document USB offload support for usb-xhci.

Is this a standard XHCI capability or specific to certain 
implementations? Do all versions of DWC3 support it?

> 
> For example:
> 
> &usbdrd_dwc3 {
> 	...
> 	/* support usb offloading, 0: disabled, 1: audio */
> 	offload = <1>;
> 	...
> };
> 
> Signed-off-by: Howard Yen <howardyen@google.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> index b120dd6612a2..aab1fd499f15 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -46,6 +46,7 @@ Optional properties:
>    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
>    - imod-interval-ns: default interrupt moderation interval is 5000ns
>    - phys : see usb-hcd.yaml in the current directory
> +  - offload: supporting USB offload feature, 0: disabled, 1: audio

What does not present mean? Unless you need 'keep the h/w default', then 
this can be boolean instead.

>  
>  additionally the properties from usb-hcd.yaml (in the current directory) are
>  supported.
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
