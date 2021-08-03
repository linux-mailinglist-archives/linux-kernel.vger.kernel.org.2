Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A63DF5CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbhHCThv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:37:51 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:34612 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbhHCThs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:37:48 -0400
Received: by mail-io1-f52.google.com with SMTP id y200so25589544iof.1;
        Tue, 03 Aug 2021 12:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=awPX2572GEzzjUL3JXpiLF5AW4vUeYgoU7+cxj4sBs0=;
        b=M0oQyZjFxYgF5p3Q+mFIKVrlc8TpxztVTfkLxio3vv5zOrtN/I+jSxduXjCIiDa9Pp
         oIGyJTotAqT3OIck/OLxZISIcA/OXAKJJlEyvYm8+HhNzPvPaX+GMicYRxzYK05kaZo8
         kvSmijydIbwiHlx1HupZyvw0SVrpkjzArjft9ka7Earyeb1n80Z3Ym5WzoFMsb4J1Gy7
         l98oW6cSVN3o0Tx6EcL13UY0z716Hkyyb3PlWaFdbD9svoP+yLKvQRb/s//R/Bx362og
         85N2Rc85OujiHwpbgRrGj+acJoTep6esulobD8mrgrb6yiU6keaPErtaHK/+p4AISld6
         Gjtw==
X-Gm-Message-State: AOAM530V9FkrsR4Jie7E78YkdWUD6Vicq/E3UhbpJFEUQ93b4JscJOSG
        RPcWQqy1NRlvVqd7RiVJbA==
X-Google-Smtp-Source: ABdhPJxTW3LQ/I5Gpxjj5wICbeFt9DLx5+z9hUR5Ig/Wj7tJJZJcRjcZAUeLqRgmlQ4cPKO3yU+/kQ==
X-Received: by 2002:a5e:d905:: with SMTP id n5mr70751iop.136.1628019456792;
        Tue, 03 Aug 2021 12:37:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s195sm7857ios.38.2021.08.03.12.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:37:36 -0700 (PDT)
Received: (nullmailer pid 3613141 invoked by uid 1000);
        Tue, 03 Aug 2021 19:37:34 -0000
Date:   Tue, 3 Aug 2021 13:37:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: connector: Add pd-supported property
Message-ID: <YQma/tXBtfWGk4Ge@robh.at.kernel.org>
References: <20210730061832.1927936-1-kyletso@google.com>
 <20210730061832.1927936-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730061832.1927936-2-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 02:18:31PM +0800, Kyle Tso wrote:
> Set "pd-unsupported" property if the Type-C connector has no power
> delivery support.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 92b49bc37939..21ec470117a6 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -111,6 +111,10 @@ properties:
>        - 1.5A
>        - 3.0A
>  
> +  pd-unsupported:

'disable-pd' or 'pd-disable' would be a bit more consistent with other 
flags like to enable/disable things.

> +    description: Set this property if the Type-C connector has no power delivery support.
> +    type: boolean
> +
>    # The following are optional properties for "usb-c-connector" with power
>    # delivery support.
>    source-pdos:
> -- 
> 2.32.0.554.ge1b32706d8-goog
> 
> 
