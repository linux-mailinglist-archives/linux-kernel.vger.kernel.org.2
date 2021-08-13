Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06113EBC4A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhHMS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:56:45 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36631 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhHMS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:56:43 -0400
Received: by mail-ot1-f42.google.com with SMTP id u13-20020a9d4d8d0000b02905177c9e0a4aso2595415otk.3;
        Fri, 13 Aug 2021 11:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hzJEw0L+kP4NgMaVTXLDpwO/ZHH+044EBwZ0FnUt4pc=;
        b=JDtVNpqxseK7J0JNE2n643/0w6XzQLQZBY4+v2uhfM3qmtsJInS61IgyaD3IJRoKs9
         VphgPyl+zYicE9YzqB8oR/lRMdaV+5sgZJBDm3KBWruReGr5qwxG+YlcDT4h5KeKM4fv
         nvKtlNITERrjn/1Pjf7mLDSRW4exJGzaupQzgGsJfuOcEMqnFXQCYB52dCGOW/rnll6u
         wW7ks9qC/WUbO0hI01SSicX9TlBXY4U17hGu97Yfqz72ZPpwcpXek0LNgFFaP7HFv2dV
         zGdtI1QAwB343i3JGH8FAJpnl+PceO2prUapcUsDILOE7Im9FHxzui6HPmTrStmG2fdX
         t1ow==
X-Gm-Message-State: AOAM5335zCMkeqDGBMDq8R+L4O1Rn5iiiLHxr0U4SSmzGNoln1KYSLVw
        jyPFaTDs/AzubyHJ52EkuA==
X-Google-Smtp-Source: ABdhPJxF3tjwBS2dlLyMp36aylpfzvH9ZeHuko+34laK+0gtd9fhwvTyAGtSV/ixwbCc6l+jU0CfSg==
X-Received: by 2002:a9d:7d90:: with SMTP id j16mr3341650otn.186.1628880975818;
        Fri, 13 Aug 2021 11:56:15 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm485076otl.48.2021.08.13.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:56:15 -0700 (PDT)
Received: (nullmailer pid 3860867 invoked by uid 1000);
        Fri, 13 Aug 2021 18:56:14 -0000
Date:   Fri, 13 Aug 2021 13:56:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, olof@lixom.net,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        ludovic.desroches@microchip.com, arnd@arndb.de
Subject: Re: [PATCH 5/7] dt-bindings: add vendor prefix for calamp
Message-ID: <YRbAThIgS8qPi9UP@robh.at.kernel.org>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
 <20210805155357.594414-6-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805155357.594414-6-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021 18:53:55 +0300, Claudiu Beznea wrote:
> Add vendor prefix for CalAmp Corp.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
