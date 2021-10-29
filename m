Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB0A43F4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhJ2ByJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:54:09 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41883 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhJ2ByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:54:08 -0400
Received: by mail-ot1-f42.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so11399575ote.8;
        Thu, 28 Oct 2021 18:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XPwGXJ1V/dR251Mepapu6gd7Z/3D3f2xhW9/s9yK4A=;
        b=2OKRY2f4UdvefdZ1STPhZ7BOBHB/Hla0CXBYkIyCLmudCqLEFF5+Bw+nHBC7sAR8nG
         cIE7Zap9Bx9dsCg6SBjCjVkOgToPXqcjkkw1z9TtaY8EFOBEsBK1klMZUKJxwpjaraS1
         mkFvjUbe2pnlBH9gkJytCgs3CiQxeXcz2kY8nPbrEWtMbkBPZ6kJoDWn7UO1oTWSicbr
         0iplPw8hQqdn/xppl46fI8xCatsOoe3dMaxUeQEd5wLwa2USGCK17uMbxWS+z3uQMO82
         t1tJBsvQ02wW9r/XYOX4mS5PoBRvajYLi/pvfylnAWkH5QnSfs2o8HdZcM823Bt4SttT
         655w==
X-Gm-Message-State: AOAM532kWmfbQ0ESGiZON6EFjUSe4DJQ3SKwGKrUtp4GRWk1xzi/LEYd
        zZ3BojG86lTapPJsuasDFWY/2WeN4A==
X-Google-Smtp-Source: ABdhPJylROWnkIHchlp6lrq+FxqZC1NjzjgAMB2PK1lUrPpJZQh19nd+Fpy94N3AhRwkLhqWomjftw==
X-Received: by 2002:a9d:669:: with SMTP id 96mr6342680otn.224.1635472300405;
        Thu, 28 Oct 2021 18:51:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i15sm1493903otu.67.2021.10.28.18.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 18:51:39 -0700 (PDT)
Received: (nullmailer pid 989900 invoked by uid 1000);
        Fri, 29 Oct 2021 01:51:38 -0000
Date:   Thu, 28 Oct 2021 20:51:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     qinjian <qinjian@cqplus1.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: sunplus: Add bindings for Sunplus
 SP7021 SoC boards
Message-ID: <YXtTquSFYktcVWnf@robh.at.kernel.org>
References: <20211022060507.280329-1-qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022060507.280329-1-qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 14:05:07 +0800, qinjian wrote:
> This introduces bindings for boards based Sunplus SP7021 SoC.
> 
> Signed-off-by: qinjian <qinjian@cqplus1.com>
> ---
>  .../bindings/arm/sunplus,sp7021.yaml          | 26 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
>  MAINTAINERS                                   |  6 +++++
>  3 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
