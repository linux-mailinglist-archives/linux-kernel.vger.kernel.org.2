Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9640D4434C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhKBRsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:48:33 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:41922 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbhKBRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:48:32 -0400
Received: by mail-oo1-f53.google.com with SMTP id t201-20020a4a3ed2000000b002b8c98da3edso7662993oot.8;
        Tue, 02 Nov 2021 10:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CKYzsICswV19mFk3bA4uM8xafXZBR+kPBIPsP0pIGHE=;
        b=yODZDOWb6VB2UCKtWcte99sWr1Hc1oQjMxKKiauv5LsW0DHcG/bFSZBjfjoNOlY/01
         rdf58ZqIaA1b2lqkfdRp47SZVxLHtRhXRHIDR12Ej6JAhJsUZ7mj5HEqE1lybEqLRpdK
         ZUp8OmtsRQUVDjvlms7wWzCiD2vwKVXEMzd1dWgkjFit6CUTooxZVcG4LiFOKm9Lj3Wv
         RLrRiBkuccVMzkmtb3Kc8trWAd+L+ld5VgV1ueI17F4rXwGeo4upKHWUt02SuACCUKN3
         8WZYm9MUoojwU6HUlB6casAZLnU6wT4ANuOW1uH82WJ/xkl4af8Xn9AbrqY+NfCGR+jl
         zSDA==
X-Gm-Message-State: AOAM531ShTAywwuM5DgFz4CUIR6LCYgK2K1Hc0TBuHYNVt8Oq+oPujio
        X1EyowEoIhqq1JIFnoTx2g==
X-Google-Smtp-Source: ABdhPJxFwD+eSnmtSAUlQdMT3bUxYTxWRKlvKp8eIjLNIwETQKMo6jomT5joBByWdDQ2Z00NVXHygw==
X-Received: by 2002:a4a:c91a:: with SMTP id v26mr25953826ooq.77.1635875156734;
        Tue, 02 Nov 2021 10:45:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q63sm2519782oia.55.2021.11.02.10.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:45:55 -0700 (PDT)
Received: (nullmailer pid 3145622 invoked by uid 1000);
        Tue, 02 Nov 2021 17:45:54 -0000
Date:   Tue, 2 Nov 2021 12:45:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com,
        mturquette@baylibre.com, sboyd@kernel.org, maz@kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Message-ID: <YYF5UsvoIBeoUCeE@robh.at.kernel.org>
References: <cover.1635737544.git.qinjian@cqplus1.com>
 <c2f6c4c150a53cf73e942ee7da234a8976909382.1635737544.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f6c4c150a53cf73e942ee7da234a8976909382.1635737544.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021 13:01:57 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 interrupt controller bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../sunplus,sp7021-intc.yaml                  | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
