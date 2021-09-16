Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A8E40DA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbhIPNFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:05:14 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:38616 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbhIPNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:05:13 -0400
Received: by mail-il1-f180.google.com with SMTP id q14so6548661ils.5;
        Thu, 16 Sep 2021 06:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xm9Xe5gjMezORsww/slJFTPNqAjcAangvFqeNrb/6gY=;
        b=Y3NJZwP80slc3NFLFUHlhb+qHl4kAFpKY80Q+B1bLjcRXTcgzjHz17L28df6kVSgVh
         +EnOa9ncdQmiptASKYOGCfjbic7+doQcNonykUBfobA9pUytmFaGIW4uGO/RjRmQFXbf
         iFXIf3VpfQiqJ4TwL5D9xSzlXKmK5xsD1djOBTOPeiShi81NuKnB4vwXiHIHkjPCmEGy
         ZG9V056i51c3yYG/3+9w+EBrKfdNC3LplE/Y3feC9dK0hqfsHyYoi4EsV2xOISYP3+QB
         2Zdz+fKXkPlN9EqqtbjeOFmLmDFVccbOs95WsUwgTkS43Gu+XWc0MzOOZrxn/3nj3UJT
         cIjQ==
X-Gm-Message-State: AOAM531RlGMPh5jocWSQLcBwJyAmAop0sH2FBelznaOOMVLs2g+Z+xnD
        RLtVTQGLDoMYA+lXxrED6Ehy72L1nw==
X-Google-Smtp-Source: ABdhPJzvAmFQ5t5GjSdvsOIzuFbTAjayjg+B9Q7VZG0D4kQxYJb6vlyLOVLr5Mu2OjhHrbTrX4w2lw==
X-Received: by 2002:a92:c211:: with SMTP id j17mr3908832ilo.57.1631797432572;
        Thu, 16 Sep 2021 06:03:52 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id y11sm1733089ilh.73.2021.09.16.06.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 06:03:52 -0700 (PDT)
Received: (nullmailer pid 1177697 invoked by uid 1000);
        Thu, 16 Sep 2021 13:03:51 -0000
Date:   Thu, 16 Sep 2021 08:03:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YUNAtwXJzQy1cQgR@robh.at.kernel.org>
References: <20210916084714.311048-1-zhang.lyra@gmail.com>
 <20210916084714.311048-2-zhang.lyra@gmail.com>
 <1631794913.500942.1119419.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631794913.500942.1119419.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 07:21:53AM -0500, Rob Herring wrote:
> On Thu, 16 Sep 2021 16:47:11 +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > 
> > Add bindings for Unisoc system global register which provide register map
> > for clocks.
> > 
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> xargs: dt-doc-validate: exited with status 255; aborting
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml] Error 255
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1441: dt_binding_check] Error 2

Please reorder your patches to avoid this.
