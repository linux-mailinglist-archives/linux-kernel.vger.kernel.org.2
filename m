Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB434B866
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhC0REd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:04:33 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43892 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhC0RER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:04:17 -0400
Received: by mail-ot1-f52.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so8211881otn.10;
        Sat, 27 Mar 2021 10:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QMzMCD0TfleB/wF3Fq0kYULJqD6sNthBOgcL7cz5zI=;
        b=ebdwtKdqKL51oLmltmX2etBEc1OdbPh983RzCroyc9De8txRxY/kcADaj2HQuwvRdD
         OhVYGkyDRWJRm/ZlOozMvMrT9LiVThBE9qmhYBRY5E7Z+qrf4gmJprDXa+QbB3oej+l1
         uttMGa2ujf5ID90hmVg4+R2wXxkwZOo61mp1JaFq+exc99uIt0BnFkjpEXYJjxKeDrw9
         ZxYFBO4bsyqdSsNCC0QpjWBAWJlTeBoH1HBVV6NcP8PR9W/4e5nfF17ZOSNXChvgmMmJ
         PfTN3c5rHbTeEj9aRhx0uZmIXtskcvxpBW5JrJ8b8ShNEZ439kcMxpeqv5+dQ7n7Xocu
         yT7g==
X-Gm-Message-State: AOAM533cWGmUE21cw/Ej1C+LbyqL8fXtguZuU2JohJKaiy123ba1ifRv
        /bO0zCJf3SgYO4P37Mhvgw==
X-Google-Smtp-Source: ABdhPJx89xF40rCPZdk+uFfBNPZfmZp4Lxp9fKzlVfPyAeBfideUde4GPIVUtdo4G9vJsPphbpX/+w==
X-Received: by 2002:a9d:5e94:: with SMTP id f20mr9756895otl.150.1616864656986;
        Sat, 27 Mar 2021 10:04:16 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id a15sm2711590otd.57.2021.03.27.10.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:04:15 -0700 (PDT)
Received: (nullmailer pid 249165 invoked by uid 1000);
        Sat, 27 Mar 2021 17:04:13 -0000
Date:   Sat, 27 Mar 2021 11:04:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] dt-bindings: mtd: add YAML schema for the
 generic MTD bindings
Message-ID: <20210327170413.GA249072@robh.at.kernel.org>
References: <20210322181949.2805-1-michael@walle.cc>
 <20210322181949.2805-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322181949.2805-3-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 19:19:47 +0100, Michael Walle wrote:
> Convert MTD's common.txt to mtd.yaml.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Btw, I've asked Miquel if I can add it as the maintainer.
> 
>  .../devicetree/bindings/mtd/common.txt        | 16 +-------
>  .../devicetree/bindings/mtd/mtd.yaml          | 39 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mtd.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
