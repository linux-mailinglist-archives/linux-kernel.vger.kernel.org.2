Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FB335FF89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 03:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhDOB2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 21:28:37 -0400
Received: from gw.atmark-techno.com ([13.115.124.170]:36044 "EHLO
        gw.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhDOB2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 21:28:35 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 718408048E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 10:28:12 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id h15-20020a17090a054fb02900c66a1b9826so9523899pjf.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 18:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FOM9b0pdtnYk8Fnx4fGxxS9X4Bl0c34VqGJkMkPLCys=;
        b=f2q5AA2VPFvCF8vSvrH0QtkiOmqhH5/AAIwc2tW+osoZRgBQTu7sEH/8PDcieFsgkr
         AnUKRxkAbY9e78GTZUqV4lOOEd3k51QGgyXf856iPJ32aqJ6OVYMKvV2+wsgveR0cu44
         N+Vm9x9lfoQO285Md/1GrpAF/e1ZKye6VdoIOMIrDL2QTrgndDWNT1KFsMCFnlO+eRRb
         CegLBPc4CEQOZF/NwegWjQsE/ha+JV0VZHxvyW63gISSRLpMOYVZJN5Nt/ZyTan9hYwX
         hnhxoeQfpWZf3lKaPAbpr9xiajxFftetPn2IuCsVELeBq0HScHA9jII39Dz2ylWdkys8
         mn9A==
X-Gm-Message-State: AOAM533aSyFX366s6NXjFkzj8n8eQh512kDPONXyC6IkRg69gGtaQEuu
        Co5qoJ0QAG0sQ4YA6akQhtODhktZtAqZVl609LfzF1TM/Wp+KtxxujC9EYjAK1uj203mnmGCyjm
        4R2wzC4MMDOcqhlb2uRnUgYV7mj3f
X-Received: by 2002:aa7:9299:0:b029:21d:7ad1:2320 with SMTP id j25-20020aa792990000b029021d7ad12320mr936593pfa.22.1618450091301;
        Wed, 14 Apr 2021 18:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOS8ZF+FYzG7w9Mf8YFdOFOmZ/r+RgZwkgg5u3LbU7N9Rak2ehntN57YQtvkLegkVtKjlWww==
X-Received: by 2002:aa7:9299:0:b029:21d:7ad1:2320 with SMTP id j25-20020aa792990000b029021d7ad12320mr936569pfa.22.1618450090996;
        Wed, 14 Apr 2021 18:28:10 -0700 (PDT)
Received: from pc-0115 (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id e1sm643595pgl.25.2021.04.14.18.28.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 18:28:10 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94)
        (envelope-from <martinet@pc-0115>)
        id 1lWqng-004w4O-Qv; Thu, 15 Apr 2021 10:28:08 +0900
Date:   Thu, 15 Apr 2021 10:27:58 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] regression due to soc_device_match not handling defer
 (Was: [PATCH v4 4/4] soc: imx8m: change to use platform driver)
Message-ID: <YHeWnuDQo76rYoz5@atmark-techno.com>
References: <20201120101112.31819-4-alice.guo@nxp.com>
 <YGGZJjAxA1IO+/VU@atmark-techno.com>
 <AM6PR04MB60536EF0DEEE6EB64CF29390E27D9@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB60536EF0DEEE6EB64CF29390E27D9@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alice Guo (OSS) wrote on Tue, Mar 30, 2021 at 02:41:23AM +0000:
> Thanks for reporting this issue, I'll check and add a fix to handle defer probe.

I haven't seen any follow up on this, have you had a chance to take a
look?
If this won't make it for 5.12 (in a couple of week probably?) would it
make sense to revert 7d981405d0fd ("soc: imx8m: change to use platform
driver") for now?



While looking at the code earlier I also have an unrelated, late-review
on the patch itself:

> +static u32 __init imx8mq_soc_revision(struct device *dev)
> [...]
>  @@ -191,8 +223,16 @@ static int __init imx8_soc_init(void)
>         data = id->data;
>         if (data) {
>                 soc_dev_attr->soc_id = data->name;
> -               if (data->soc_revision)
> -                       soc_rev = data->soc_revision();
> +               if (data->soc_revision) {
> +                       if (pdev) {
> +                               soc_rev = data->soc_revision(&pdev->dev);
> +                               ret = soc_rev;
> +                               if (ret < 0)

I appreciate current soc_revision are "small enough" (looking at
include/soc/imx/revision.h we're talking < 256) so this actually works,
but would it make sense to either make soc_rev signed, or to have
soc_revision() return a s64, or have the revision filled in another *u32
argument to make sure the error is an error and not just a large rev?

This is most definitely fine for now but that kind of code patterns can
lead to weird errors down the road.

Thanks,
-- 
Dominique
