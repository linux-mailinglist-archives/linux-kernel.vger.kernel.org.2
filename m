Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC03357A76
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 04:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDHChO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 22:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhDHChL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 22:37:11 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4BDC061763
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 19:37:00 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id j10-20020a4ad18a0000b02901b677a0ba98so155702oor.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 19:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sNt0N9k5A/iZhS6mLH3QqBzCSSb0518KO9+l8szb88c=;
        b=LUf8Eiojwyx3AkSHJqCIk3X+PIGMeWOQGjVQfUNYCrrKhnGPtxvNMeITP4theeZA4s
         TXvOTOWeYg9JjM4Q1J8GpAKIT9XqTZrCzvb7I5vwvfLR6j/RESBDguI0jSK1LEIuxZrf
         p6cSNv43h8Lp43xBgDvkuR1HanutyH1eCekF9EKytvEAkmjjUsyAPiG3NEZpk32F7UV/
         l3WRmf8e9Eb9ov6gjNMcAkuWOQjxZRR7O69/xXXVIV532y7tLSXjQtBn1XX4Z0GO3TZC
         HYCx0wNGD0llxL3YX20aku6rh3xYYZTPyRcpzkGPg2gPKaywceMWIxfh/53o77I7XJlU
         mCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sNt0N9k5A/iZhS6mLH3QqBzCSSb0518KO9+l8szb88c=;
        b=m5mkm1oGDyc3Bdg0aQjZ1p52J6rUtIoZgf0szrlfakmIBeD1KwSBzkX7/OU+AvfSsK
         8zRl2gz983DIsKzMQpfOkH+uiSH9wwA8HH7OOxb0HZIrqfENOiN1hKTxA+yC9biPd0VX
         c0aL3ie04LSUywMdCszJllItNo9IAnOvptV59M7ujT4z1AXhuYjnlSPyZbVmuB+3HDT6
         dPF92+bbpfMe0iz+W/WKWLNczrD9f/SjjgDSFfkohFkEJDbPbE1TGliusiejx+YucfYw
         Hp4fHjvSl2K2oeBo7JDZyhidZ12fVxTU98+/6j9yUfSg1zf+6xLBgtIZ1wtNQHIpObMB
         2Zbw==
X-Gm-Message-State: AOAM5312VLeEi73A8fZkFRF2LwUKJVgf12NnMzZ3jH9ei0QiRt+igDs2
        uhXtBXJXdcYIw77lEfFX/OSJhQ==
X-Google-Smtp-Source: ABdhPJxwHieceqi2i/XhpJhh/5S87/OOgtYfASCGY0aWMHBjw4edQyRluei4ZPIjwLYRu5LlhzIbpA==
X-Received: by 2002:a4a:d24c:: with SMTP id e12mr5522553oos.73.1617849419360;
        Wed, 07 Apr 2021 19:36:59 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 3sm4532103oti.30.2021.04.07.19.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 19:36:58 -0700 (PDT)
Date:   Wed, 7 Apr 2021 21:36:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     skakit@codeaurora.org, Rob Herring <robh+dt@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-rtc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH 2/3] dt-bindings: mfd: Convert pm8xxx bindings to yaml
Message-ID: <20210408023656.GM904837@yoga>
References: <1615447798-6959-1-git-send-email-skakit@codeaurora.org>
 <1615447798-6959-3-git-send-email-skakit@codeaurora.org>
 <YEpNV55KR2nlAXMP@builder.lan>
 <86f8d5dbdb8d5d6627b9deece1978d07@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f8d5dbdb8d5d6627b9deece1978d07@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Apr 10:37 CDT 2021, skakit@codeaurora.org wrote:

> Hi Bjorn,
> 
> On 2021-03-11 22:33, Bjorn Andersson wrote:
> > On Thu 11 Mar 01:29 CST 2021, satya priya wrote:
[..]
> > > +patternProperties:
> > > +  "rtc@[0-9a-f]+$":
> > 
> > Can we somehow link this to individual binding docs instead of listing
> > all the possible functions here?
> > 
> 
> you mean we should split this into two:
> qcom-pm8xxx.yaml and qcom-pm8xxx-rtc.yaml
> Please correct me if wrong.
> 

Right, I'm worried that it will be quite hard to maintain this document
once we start adding all the various pmic blocks to it. So if we somehow
can maintain a series of qcom-pm8xxx-<func>.yaml and just ref them into
the main PMIC definition.

@Rob, can you give us some guidance on how to structure this binding,
with the various PMICs described will have some defined subset of a
larger set of hardware blocks that's often shared between versions?

Regards,
Bjorn
