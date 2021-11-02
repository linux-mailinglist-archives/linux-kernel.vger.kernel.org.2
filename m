Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD34434BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhKBRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:46:47 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42653 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhKBRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:46:45 -0400
Received: by mail-oi1-f172.google.com with SMTP id g125so31099935oif.9;
        Tue, 02 Nov 2021 10:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1SmEr1k0s7n+Ap3lvkJLWzJiWyw4fGH67BDx2Poz4iM=;
        b=A5R6z8XpmItM9CX2bk2lJ3cOp7G/6FKCY6a6er+fwC7w7Z6cld4bU20TO095QkVoav
         DHllEiuDrrCSpYqvjOnwSNuxsUJPelqdPuHx/svaore24YsWZEj5/My3FfEeEPjCNf8p
         dBNKo/cIp7zuTftK/pAW0ZvbUQ5n/4H0xQsxd3bPpsx5A7MhZtJr/ZPqpwcihAL92Qct
         kZrX26McvXxgf7os6ctwuIxZjnFRzAxUOI3h6Kul3wFdb0RQ7nifPtSFrUTYx1ZLKAJb
         GiYUNb6CPLZlPzs3Y3t7C2U5rxyk28epGkt8IOsy9SXFjSbWilHfJcn965o3+as0RZhq
         72Nw==
X-Gm-Message-State: AOAM531DJcxOkxD0p0tNr7mRiWyN5C+Zh+sZgIAaTraIt6F4elXoF59W
        7rW9EwJqYO/lLXOufjIpvA==
X-Google-Smtp-Source: ABdhPJxBIecywmYXbnEap9qc5dDUbTqVmZVPKWGPUUIKP/Z7AhbRBm0jx7LwK4YSUiNa7vO+6mapVQ==
X-Received: by 2002:a05:6808:f8b:: with SMTP id o11mr6034751oiw.5.1635875050384;
        Tue, 02 Nov 2021 10:44:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z13sm1097381otq.53.2021.11.02.10.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:44:09 -0700 (PDT)
Received: (nullmailer pid 3142432 invoked by uid 1000);
        Tue, 02 Nov 2021 17:44:08 -0000
Date:   Tue, 2 Nov 2021 12:44:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     p.zabel@pengutronix.de, linux-clk@vger.kernel.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        wells.lu@sunplus.com, maz@kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: vendor-prefixes: Add Sunplus
Message-ID: <YYF46H/1JUSD59AZ@robh.at.kernel.org>
References: <cover.1635737544.git.qinjian@cqplus1.com>
 <1a5f86dbfd1e4053cd2a69111fc7b277a49bc98a.1635737544.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5f86dbfd1e4053cd2a69111fc7b277a49bc98a.1635737544.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021 13:01:51 +0800, Qin Jian wrote:
> Add vendor prefix for Sunplus Technology Co., Ltd. (http://www.sunplus.com)
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
