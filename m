Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED232F5E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCEW3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:29:51 -0500
Received: from mail-oo1-f48.google.com ([209.85.161.48]:45324 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhCEW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:29:37 -0500
Received: by mail-oo1-f48.google.com with SMTP id s23so808888oot.12;
        Fri, 05 Mar 2021 14:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2mEx7AzioSmhIvSqTtuS7sxxfYsuKN7rfPuyoPffZ0=;
        b=o07u8uNLbRqvMfWtSsusg4QRUmN4tgKhoRXKx8tB9vy+UK9yu6fHoIvItauvaKIDOs
         WSrCwR+Z19jr0MddrInFSbJSDVjeKTpAXjjXaoS6T/Xs+0ah2RdV/nicD92iyLq623y5
         cTHo02Ii4ExAcyk/L/u4xFoej3ddu0fQ4+uKmNfZfdziki0vJSXHCD/QReMamOWRRxSB
         w5aEAEPUCrR0x6ZwB4oRQB4O6c+tJE8/c6pOofvB1qaDkMW8N1bIVBhz8Fj9OL/ppbfK
         s7w9TVr+tvwKLBu+wvDppXy9JcmLQ7HGid+RE8FNFwN2W641eQ9LhPtd3i9uUUjTaTMf
         dB4A==
X-Gm-Message-State: AOAM532ggJ0f841jyndO33yNyujfPvzpTHOO9mzAS5089evUh6zR9Ac8
        Et10NQtJivnSdY980EghDQ==
X-Google-Smtp-Source: ABdhPJz4imY34lBmh4FKpKVJoq/JUMsDHQ4pCGqDe+BfFp22cL+m+O/lgmEZ0U5u3CaWG5kbcAI32w==
X-Received: by 2002:a4a:3012:: with SMTP id q18mr9559180oof.21.1614983374121;
        Fri, 05 Mar 2021 14:29:34 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p19sm914608otk.63.2021.03.05.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:29:17 -0800 (PST)
Received: (nullmailer pid 758589 invoked by uid 1000);
        Fri, 05 Mar 2021 22:28:39 -0000
Date:   Fri, 5 Mar 2021 16:28:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        wahrenst@gmx.net, Scott Branden <sbranden@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>, eric@anholt.net,
        phil@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org
Subject: Re: [PATCH v3 02/15] dt-bindings: soc: bcm: bcm2835-pm: Introduce
 reg-names
Message-ID: <20210305222839.GA758527@robh.at.kernel.org>
References: <20210217114811.22069-1-nsaenzjulienne@suse.de>
 <20210217114811.22069-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217114811.22069-3-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 12:47:57 +0100, Nicolas Saenz Julienne wrote:
> Anticipating the introduction of BCM2711, of which we'll need to support
> its new RPiVid ASB, introduce reg-names into bcm2835-pm's binding. This
> will help to have a consistent mapping between resources and their
> meaning.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
