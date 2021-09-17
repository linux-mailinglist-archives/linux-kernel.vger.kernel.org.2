Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686C940FF97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbhIQSrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242488AbhIQSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:47:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:46:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq5so36880232lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmA1sI+mOH+L74Z/ZCywczXpg8/UTn+pjaC69qTfoa8=;
        b=a7GArknKjR7dZ10Erg99lW47r6IBK+3lGenkiI1HyBESPEq2XouXaBvFK/SHIlGnjA
         qHJBx9g2tAR+7Ips1KIjq8SMDhDejuwFE2IN9xpdhgEPTv0YGB/kRg1Iai/qC6tGzgmg
         9KSfjXly2AnQt433q8p7vGmT08svnU9GX43pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmA1sI+mOH+L74Z/ZCywczXpg8/UTn+pjaC69qTfoa8=;
        b=yffv5GmHT38JiXja60y4ZzqPZJpuZejl1BZo0HeRJL29WPaOaHcd8f0ttJwFEw2iAt
         8gFyHUBGbIoSgldFhpf4yZgOzJDzNjlh/sy+r9AIZqv3HuTAeup/tQAJU8AxaAeCJSM3
         8Dlq+g1ihKHcljJ/MOdr8phbqzFr6pgk13BsRqhRBqP66FPo2GU6hrICveZdmAniNi+m
         4wWCOvHNyUbpEdp1KjjCzsmSwktmwmRlz5vceJg1mx4LRO/21VvTyDddfXALlaeGCD0Z
         3aS0HYNpDCC2NzDZ1vrhd0LxXsmYJTeOFBHYu7IDXBF1iLjZjGGurO1tgC//9wXBO7j0
         z6Wg==
X-Gm-Message-State: AOAM5315ahyyAVGNPGY6DRJfemQMTrnFOm3hqGafsR4t73SdQE3wFhKN
        Azx9DxLx6KEqIW1kl7DL/Bd7P5wIidYuBy0ulE4=
X-Google-Smtp-Source: ABdhPJyU8bicjbIO+t3BT+ge5WZ//TfYLEV4RILlKbeVfqfBOnzDeUg8bGrggZhgC1Gwdk6/kznWVA==
X-Received: by 2002:a2e:5811:: with SMTP id m17mr9374763ljb.279.1631904377271;
        Fri, 17 Sep 2021 11:46:17 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 17sm354301ljo.43.2021.09.17.11.46.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 11:46:16 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id p29so35878000lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:46:16 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr9023953lft.173.1631904376131;
 Fri, 17 Sep 2021 11:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210917151842.GA1716604@bjorn-Precision-5520>
In-Reply-To: <20210917151842.GA1716604@bjorn-Precision-5520>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 11:46:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE+ngSaKxv1MW+un1f=N4QnC0jFC46b3nNZinQRnZj0g@mail.gmail.com>
Message-ID: <CAHk-=wgE+ngSaKxv1MW+un1f=N4QnC0jFC46b3nNZinQRnZj0g@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v5.15
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 8:18 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - Defer VPD sizing until we actually need the contents; fixes a
>     boot-time slowdown reported by Dave Jones (Bjorn Helgaas)

This commit should have had the Reported-by: and Tested-by: tags from
Dave Jones.

Yes, it has the link to discussion and report, but for basic credits
people shouldn't have to go to some web browser.

Pulled, but I wanted to point out how bug reporting and testing is a
fundamental part of commit logs, not some secondary thing.

          Linus
