Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD622387AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbhERORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:17:04 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46904 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbhERORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:17:03 -0400
Received: by mail-ot1-f54.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso8703215otb.13;
        Tue, 18 May 2021 07:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mJbr7ww1QgtzBYT1L28PEZqlHG53KqvcMRL581kxa8I=;
        b=GMK2kSGFjXjcbnQrjy/7XNqzW44/MGIYf2COGC2gWM8tJFCNxN3hxTcjllxFFpFr/T
         HtT+cTIBjhSIIAJFqA/5ef1HJoa3Y/Fw+HhrmT/O+1KmxXHy8UmT5bXMRYQ3/7h+M3bU
         J8F7xN3w0TMx4WJU6mQ4e5UBrlSah9/EVLELJhG5mRt0A0AAC85tnFcgaqETKcxjH6yF
         qbpRXx2OBTQQMV9mAIZi6wS8zCWKcIkVYqrprgWOta1/k30ace/Lw4kb/jJ6H+kn64ZO
         H6Kfjszuu9XiDV3tezNzb8wOOp2qGVeDLDQM0i879hhBkc7CzS1E5cbEsnXScItpITUd
         50tQ==
X-Gm-Message-State: AOAM531IMnvDkJsEuQEZh6h2GC4TVFb2LehiYB+OBQhRdslfkGkPW/Pr
        CgkDj6DbT20VNdcB9L8YLA==
X-Google-Smtp-Source: ABdhPJw7OjmnhmzqDYUciqYWlxNM88KRZcsAl2yFnabZhsV4PRb8bs8Ra4HthCKHfyUgBvMbY5TiUg==
X-Received: by 2002:a05:6830:1bd3:: with SMTP id v19mr4525568ota.276.1621347344362;
        Tue, 18 May 2021 07:15:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w10sm3720387oou.35.2021.05.18.07.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:15:43 -0700 (PDT)
Received: (nullmailer pid 610764 invoked by uid 1000);
        Tue, 18 May 2021 14:15:42 -0000
Date:   Tue, 18 May 2021 09:15:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: arm: rockchip: Add Rockchip RK1808 and
 TB-RK1808M0
Message-ID: <20210518141542.GA610723@robh.at.kernel.org>
References: <20210516230551.12469-1-afaerber@suse.de>
 <20210516230551.12469-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210516230551.12469-2-afaerber@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 01:05:43 +0200, Andreas Färber wrote:
> Define SoC and board compatibles for RK1808 SoC and Toybrick mPCIe card.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
