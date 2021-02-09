Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E2315B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhBJAgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:36:31 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36525 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhBIU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:58:46 -0500
Received: by mail-ot1-f41.google.com with SMTP id 100so12104993otg.3;
        Tue, 09 Feb 2021 12:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rRfkDWuhdRzZoOribuVD2PezXOJHDbSyE2BVdAF+5Vw=;
        b=TPxfXt7C01jI5L6l6Gq/s9J78umXQXkAXysCPzZCWtGeIEZhkxsYormKG3z3PSY7us
         hzwhGSA2age2iAK8sjCpeYmEA0Z6fOs4B4Tb2WFdKRSWtQXO09tu3jy8tIemijc0pRwN
         6u66F4ExqQm3CU6Cxq0bKzO8KKsW8y5NsJUJ0ySoCJyJI53z25m9lPN7JYESMKgcbV+A
         6v+D+8cSNrZ/e+Mp8+1v/FqfgyrPhIG59pcFZ6KtwK/Lu3fMS0Qjt5aXMhkcvfrUF9uV
         1bbfXPH9FvoGVnnWOPHU1tL42a8716XKeuKRbLaqMSOwGHVp+VVGbnHAyHmdvc08TG74
         RfUQ==
X-Gm-Message-State: AOAM5314Kf/JQ2Juj7BMVxPN+78QAfJXFohNVAEjsi5dyqtSfRecS7Qe
        bhBG4G/Z56eo4tbjUEvQ1eXbZw5L2Q==
X-Google-Smtp-Source: ABdhPJwYi62y19ckUjwSs1SUPVJAmhbSWiMZlMABR5E1y6iKKlzqdx86uZroADjTsQo3imS9ZrWaHg==
X-Received: by 2002:a05:6830:1153:: with SMTP id x19mr7173363otq.14.1612904268181;
        Tue, 09 Feb 2021 12:57:48 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w134sm1513227oia.56.2021.02.09.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:57:46 -0800 (PST)
Received: (nullmailer pid 168561 invoked by uid 1000);
        Tue, 09 Feb 2021 20:57:45 -0000
Date:   Tue, 9 Feb 2021 14:57:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the Minix
 NEO U9-H
Message-ID: <20210209205745.GA168506@robh.at.kernel.org>
References: <20210201210508.1528-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201210508.1528-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 21:05:07 +0000, Christian Hewitt wrote:
> The Minix NEO U9-H is a small form-factor Android STB based on the
> Amlogic Q200 reference board with an S912-H chip.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
