Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF43158A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhBIV0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:26:01 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46802 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhBITFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:05:45 -0500
Received: by mail-oi1-f173.google.com with SMTP id k25so20546835oik.13;
        Tue, 09 Feb 2021 11:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E86zkumSxU1Imvr3X7AkPNquYJQ//itWITGEp5B1Dss=;
        b=LAes0LBe9mqvipXUyKsgfnVHkwcXZIWvE/5bTf8UoYNowjaz7T1BCazX9fAeSPe+UI
         yLCokhm/Qp/Va08ARhLNVXY74AsylfEjFrCmhPW5YO/pDnQg/MgelFOesrUhf4zcD2UA
         Z9cO2wlwWwptmHU4agcfr26yqQgaZDNvWNATqYlyo/8Art5ZJMAt1Lc5W11j3vRFhf9Q
         Pzqdl44haW1fF+SV20UEkyQPTJckq0jDZ5AKMTbDuvLX9n5hXNtTYSPCXQ2nauiOvk87
         70IvDWPv89cM1/Un7SCJbjlgAdYva1i0JILNw+1wzrnxKzeownR1k/Dc1a2cnGoamc2M
         zadQ==
X-Gm-Message-State: AOAM5330VWv/pFNHYyni7LHz+TNUclqe2nC+oR7fJA6KN7Y7I4aGS0rZ
        QOM3hj+WMyoNT2oZcbr0Sg==
X-Google-Smtp-Source: ABdhPJytn51DUQba57wBwOykcJgXxKXzNpMCjrf1KwtaYlCyGRn1PoaVmI5ZkwFwQM2JA7IXg6ampA==
X-Received: by 2002:aca:ccc3:: with SMTP id c186mr3498299oig.74.1612897458826;
        Tue, 09 Feb 2021 11:04:18 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w2sm3070812otq.9.2021.02.09.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:04:17 -0800 (PST)
Received: (nullmailer pid 4160125 invoked by uid 1000);
        Tue, 09 Feb 2021 19:04:16 -0000
Date:   Tue, 9 Feb 2021 13:04:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        lcherian@marvell.com, suzuki.poulose@arm.com
Subject: Re: [PATCH V3 12/14] dts: bindings: Document device tree bindings
 for Arm TRBE
Message-ID: <20210209190416.GA4160095@robh.at.kernel.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-13-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-13-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 14:25:36 +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Document the device tree bindings for Trace Buffer Extension (TRBE).
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V3:
> 
> - Added missing description for the TRBE hardware
> - Fixed all DT yaml semantics problems
> 
>  Documentation/devicetree/bindings/arm/trbe.yaml | 49 +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
