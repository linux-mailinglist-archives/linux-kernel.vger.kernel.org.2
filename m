Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D530D44D3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhKKJV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhKKJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:21:53 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAA5C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:19:03 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id p17so4684898pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W4oON9tVLzbGnMHdSvx5FpIn6WtCPoheg0Qx9WxWbPQ=;
        b=LEI+Zjqvo5YR46BDk0UGfF0Z206KbIE5NfmIdD1sEs38gVeU/TXLHux/kPRlEhpwpm
         CKnJNdTqjFVmVY7fu07F4vbbKnEpeJ2Bj16hCjCBZzOwas3FwxaISJe+xwjqMQMK5s+y
         pn5aWxgxZxZi8BHfshdRinyy3kjTyvS01GXAK/49RSSdNZf/MtmU9QfX2oAXmZwfe/hu
         UdzVBaFmyiNiYcmCL5HKtRanaJEGwvJsntBRkhIKEoM9iXFteOmnIX1xqzYBMHfQZN+8
         ubPkn+Q3+swfnbA88+4LlBqwA0ms/McQxqxEuCObiQiZfQLL7SMnHiyPBRvgKD4NsMoV
         x85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4oON9tVLzbGnMHdSvx5FpIn6WtCPoheg0Qx9WxWbPQ=;
        b=LbiWy5DuFFSKVZepcXSsONb7UzXmuwWjxDBqPA4RomOnkiCPTpAA5hIQAuVkeHZhMM
         YOJtQgJwPeTAuRuj7DUKzuJ6LqavB2E0LljbEHxHH5OJx9hN0kAyy66WYUcM1tdvQjGs
         suPvAtnkluuVCG5Wg2l3mtJkpQiFe5+T8yhS7BkbF8nqrGx+utnwkAy+VDYwaBkXSi8E
         GtMYqf0vIEoSi3zK1+mSjloloN7/MqnGmPan9q7Bbu4Ide6LBW0EDR9X+gcJLTqqfKTc
         gpHm+1LJx0tnJEJBbPLBU2IufA4gqlW/jfU9uU3IhCPVYVlQ0aSgGkgXvkLEdmBFkdVP
         YJvg==
X-Gm-Message-State: AOAM530iWl2LcvGvS2hUvdvyeroDlGcoP3JoSjczA/P31ZjaaYS9jCK2
        V9Gmqdz3U76vGzsggqQ/B+lilQ==
X-Google-Smtp-Source: ABdhPJyAgSAhmt4zPqV47R/uN2HyIfaw0kvLLeTkHktBsw5JQz044Jif9nZJrLioItZgzYZiwiQepQ==
X-Received: by 2002:a62:1c0e:0:b0:4a0:3492:37b5 with SMTP id c14-20020a621c0e000000b004a0349237b5mr5425509pfc.33.1636622343312;
        Thu, 11 Nov 2021 01:19:03 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id u10sm2240141pfh.49.2021.11.11.01.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Nov 2021 01:19:02 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:18:56 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: interconnect: Add Qualcomm QCM2290 NoC
 support
Message-ID: <20211111091855.GK7231@dragon>
References: <20211110120716.6401-1-shawn.guo@linaro.org>
 <20211110120716.6401-6-shawn.guo@linaro.org>
 <1636573460.901134.1783738.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636573460.901134.1783738.nullmailer@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 01:44:20PM -0600, Rob Herring wrote:
> On Wed, 10 Nov 2021 20:07:15 +0800, Shawn Guo wrote:
> > Add bindings for Qualcomm QCM2290 Network-On-Chip interconnect devices.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../bindings/interconnect/qcom,qcm2290.yaml   | 117 ++++++++++++++++++
> >  .../dt-bindings/interconnect/qcom,qcm2290.h   |  94 ++++++++++++++
> >  2 files changed, 211 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> >  create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/interconnect/qcom,qcm2290.example.dts:20:18: fatal error: dt-bindings/clock/qcom,gcc-qcm2290.h: No such file or directory
>    20 |         #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks for the report!

The header has just landed on mainline tree.  But the binding actually
doesn't need to include it.  I will drop it for the next posting.

Shawn
