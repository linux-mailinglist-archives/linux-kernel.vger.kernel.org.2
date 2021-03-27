Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2548834B885
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhC0Reo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:34:44 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:38741 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhC0ReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:34:14 -0400
Received: by mail-oo1-f52.google.com with SMTP id n12-20020a4ad12c0000b02901b63e7bc1b4so2055223oor.5;
        Sat, 27 Mar 2021 10:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NxA1sn+9uwE2RI99uLLHNJJHlWQKXJdbkGoVTG130Fk=;
        b=OFJBSjYB4mcqPF//FIqDdAR6I2rUqwSTPYSffZP28crb9w8SOpf24+Q3oMgATwzdmR
         H/MLckmWM5dMC7KODbqZv+mLqQ84e6cGnR7X+uwUicZa4ARzl0YN2GAKYtzcxCAcgjsQ
         CF5/Yu5/P3vqqaDs7qzQE5d6jCwV7jEd8A2cCeFvqf10OiSoCYZtfT+YJ8O3DUDd9BHS
         hKsp5KzBiw5soKiRTDwBYzUMGk28p8ar3jgchNE6ZMo0luqStXhJQqLFnsiTVn1L0wrE
         ZGqOzqEkPPlaUeSnFetN+XRmGefVm5TFZOz83zhpxr1bUAy/hdGFi4WDWdS9Apm9zJ7Q
         0DKA==
X-Gm-Message-State: AOAM531NcNcogYDxmDGGFq3IHKO/1YRgsxTbpN0zxdnzy6E6Ll4dB/y1
        YyFjemis7ohkcFXpmvn/2Q==
X-Google-Smtp-Source: ABdhPJy2UaEYcjINsvCbiGKwwHNRRLcY94acJeW1o0bZtqRxbteM6QcXGzfhTC19iAa2QLCxdhmzgA==
X-Received: by 2002:a4a:2747:: with SMTP id w7mr16011732oow.11.1616866451865;
        Sat, 27 Mar 2021 10:34:11 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id x25sm2886240oto.72.2021.03.27.10.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:34:11 -0700 (PDT)
Received: (nullmailer pid 288867 invoked by uid 1000);
        Sat, 27 Mar 2021 17:34:09 -0000
Date:   Sat, 27 Mar 2021 11:34:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ddr: Add optional manufacturer and revision
 ID to LPDDR3
Message-ID: <20210327173409.GA288784@robh.at.kernel.org>
References: <20210324010405.1917577-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324010405.1917577-1-jwerner@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 18:04:05 -0700, Julius Werner wrote:
> On some platforms, DDR parts are multi-sourced and the exact part number
> used is not know to either kernel or firmware at build time. Firmware
> can read identifying information from DDR mode registers at boot time
> but needs a way to communicate this information to kernel and/or
> userspace. This patch adds optional properties for this information to
> the existing "jedec,lpddr3" device tree binding to be used for that
> purpose.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  Documentation/devicetree/bindings/ddr/lpddr3.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!
