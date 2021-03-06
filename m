Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCE32FCFE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhCFUDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:03:07 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:54885 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhCFUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:02:35 -0500
Received: by mail-pj1-f47.google.com with SMTP id i14so1011925pjz.4;
        Sat, 06 Mar 2021 12:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cbbHIxEsNw57fJN13JTZ3OV6pXh3aK0TMuJ9YIkxYTg=;
        b=FQELXK/SjmTen/RkJvfk6BP3GKKmiCVyIR9Aslr/iTzL9SX9U1G8S13uqaDE9UN/td
         waBQsITVriHFdagi+8lV2Ge3w2P5ByIzwyiAZPe8lm08FNgBN7wjMS6dWpfQL6K6MpQx
         5hicOBrSi8ZkkU60VU5UN8OqV5pupuwQEJQiIId6i9nVn3FnHDSx2OEJidUO9oNC2WB+
         mDk6s3smGOjBV+hOAKtbFwItXHPXHlkBMFPi3URiGPPr0/yXQ5mrnEHnZ/K9juH4IX/3
         fl5g5fQQL9wkfYfEJD4QeR6PtXWVLPB7f/wZDlPnS8L+YNlUMqtAP6PKGuN/ZaRhr9YM
         xgkw==
X-Gm-Message-State: AOAM532u1yRDlZb98C6zC5WrcqqZmhxWYw8ozxOtJplzZYKkgMt5T51X
        u06WecnPyi3vVsyJbpR29A==
X-Google-Smtp-Source: ABdhPJzGIMsI/Q88OhPbDheIL7OjSGvCNegORha0U/xeVNFIQ56hnLttSULrFk+QHQex2UC1z3oyfQ==
X-Received: by 2002:a17:90b:228c:: with SMTP id kx12mr14994095pjb.7.1615060954653;
        Sat, 06 Mar 2021 12:02:34 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id r2sm5789597pgv.50.2021.03.06.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 12:02:33 -0800 (PST)
Received: (nullmailer pid 1127562 invoked by uid 1000);
        Sat, 06 Mar 2021 20:02:27 -0000
Date:   Sat, 6 Mar 2021 12:02:27 -0800
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonas.gorski@gmail.com, f.fainelli@gmail.com,
        linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: generic-ehci: document
 spurious-oc flag
Message-ID: <20210306200227.GA1127510@robh.at.kernel.org>
References: <20210223155005.21712-1-noltari@gmail.com>
 <20210223174455.1378-1-noltari@gmail.com>
 <20210223174455.1378-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223174455.1378-3-noltari@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 18:44:54 +0100, Álvaro Fernández Rojas wrote:
> Over-current reporting isn't supported on some platforms such as bcm63xx.
> These devices will incorrectly report over-current if this flag isn't properly
> activated.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v3: no changes.
>  v2: change flag name and improve documentation as suggested by Alan Stern.
> 
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
