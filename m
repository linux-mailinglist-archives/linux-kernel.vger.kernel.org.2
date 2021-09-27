Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364DB419F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 21:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhI0Tux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 15:50:53 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33335 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhI0Tuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:50:52 -0400
Received: by mail-ot1-f54.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so3930476otu.0;
        Mon, 27 Sep 2021 12:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3X+wjPsLHdbHHLOIdFLeZFTDer1mNGJ5h56vCLWbqs=;
        b=xIRL3J4Quyt6kayACMC06tfo2NW5cebdUBAn7fiD7lQLvzySg5PRdewwv/QaOW99eJ
         vi1GDVVx5h5rKLccZ6Yp3AkLvegLzvLQLTmUJM2nqEh8D7kIkbVZ3/Abk+DhvDPADFbA
         9ng12jv0LEurIdZFRIWYDXwFzXpcGNPpmenzDYcGLt4+ORb5pdTt5TlPVtLJx6gsD7py
         uTBmiL2IiVwsXNZpABBhlc5sO5e4SL+GcY9HV3iSGqYcYS9mCOGB7Mzrm41S7KvR+mPX
         hATidAYk2W+ol6YSNinnKW2pzxyh3JM7rcKuoHzitrm9IInZDvSZ/P1KKRdupVB9eodL
         m5Nw==
X-Gm-Message-State: AOAM5308tiVLDa3niX8DS2MrS2erlrkoyPDqthk0ClQ0muqBKdA9CxVs
        L4f2/pBfZQ17lUEBWR/3vA==
X-Google-Smtp-Source: ABdhPJyleznAu2MKSj+YiKyFiWNS4q99Tud7oCWafmfk9MV1l4IgbjJutq3IJCsBNvICg3ZBJhXEyw==
X-Received: by 2002:a9d:758c:: with SMTP id s12mr1576115otk.325.1632772154036;
        Mon, 27 Sep 2021 12:49:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o126sm4065598oig.21.2021.09.27.12.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 12:49:13 -0700 (PDT)
Received: (nullmailer pid 3767231 invoked by uid 1000);
        Mon, 27 Sep 2021 19:49:12 -0000
Date:   Mon, 27 Sep 2021 14:49:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>, linux-clk@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 3/4] clk: sprd: Add dt-bindings include file for UMS512
Message-ID: <YVIgOFhY4VvKdBmB@robh.at.kernel.org>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923064137.60722-4-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 14:41:36 +0800, Chunyan Zhang wrote:
> From: Xiongpeng Wu <xiongpeng.wu@unisoc.com>
> 
> This file defines all index of clocks included on Unisoc's UMS512 SoC.
> 
> Signed-off-by: Xiongpeng Wu <xiongpeng.wu@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  include/dt-bindings/clock/sprd,ums512-clk.h | 396 ++++++++++++++++++++
>  1 file changed, 396 insertions(+)
>  create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
