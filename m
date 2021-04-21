Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F266367243
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhDUSKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:10:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34528 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbhDUSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:10:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1lZHIK-0000dG-FZ
        for linux-kernel@vger.kernel.org; Wed, 21 Apr 2021 18:09:48 +0000
Received: by mail-il1-f197.google.com with SMTP id v3-20020a056e0213c3b029016165a33c15so16566699ilj.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 11:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWjwHxIOFRhofmysaApLRpmaeSuY0CQj1n7uMTgnl5Y=;
        b=cJEK5bneeD1I8zFU8h9t5UYDUjI4DxHmInVRL7es+OPtX/afqFqbsfUPAQwuG6cJsO
         NgC3oVB4aIhk97Or9VaqZ9KT2uL4byB5MiMBA09EWqoOjrPYkOPXfnHR2cObSG/55WZ7
         tZs99SMjtfNmryIra6tJwBD/VD1EpCHx9zsT0RNSo+3OTWafunENcel0EWRV/lUYt5iC
         oCcHOfJuiEKB+29UnZI/Pe5rNLACQbiBjnv//31u3maBEN5BIR3NXFI9QRgCPFUhPPTN
         W0jQ0beP9JFJWa4cdvAzNGgFSIpqpd974HVedf2cNMl2OfzYjw7zR599WqE8O5s4+Vb6
         qotQ==
X-Gm-Message-State: AOAM530u93c+SCBaIMNM4fjrmBr4lkUMLN/8cgnW9QYyEIxDgIhCJR/U
        Y50TjRC5AIFfN/6hqtC1MA2VMzEPo4aeJ7m/bVYpZk126Pi+wf+OujxiAmS9J4NE+pUe9LMyqP9
        c+oxqcxGhHRBCJP42vN6uQNlXlhVk4GvlUAdUAzDu5Q==
X-Received: by 2002:a05:6e02:2197:: with SMTP id j23mr27636500ila.269.1619028587539;
        Wed, 21 Apr 2021 11:09:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM+ERtaD+oau8p0ZRaMWgHV0MRuEys8xEYJcvbu541bBxY8/j4v6fYjRX2Gxi/8+mUU2hyQQ==
X-Received: by 2002:a05:6e02:2197:: with SMTP id j23mr27636486ila.269.1619028587247;
        Wed, 21 Apr 2021 11:09:47 -0700 (PDT)
Received: from xps13.dannf (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id x18sm81998ior.10.2021.04.21.11.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 11:09:46 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:09:44 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>, Fu Wei <wefu@redhat.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/2] arm64: ACPI GTDT watchdog fixes
Message-ID: <YIBqaPiLCrqc9f/c@xps13.dannf>
References: <20210421164317.1718831-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421164317.1718831-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:43:15PM +0100, Marc Zyngier wrote:
> Dann recently reported that his ThunderX machine failed to boot since
> 64b499d8df40 ("irqchip/gic-v3: Configure SGIs as standard
> interrupts"), with a not so pretty crash while trying to send an IPI.
> 
> It turned out to be caused by a mix of broken firmware and a buggy
> GTDT watchdog driver. Both have forever been buggy, but the above
> commit revealed that the error handling path of the driver was
> probably the worse part of it all.
> 
> Anyway, this short series has two goals:
> - handle broken firmware in a less broken way
> - make sure that the route cause of the problem can be identified
>   quickly
> 
> Thanks,
> 
> 	M.
> 
> Marc Zyngier (2):
>   ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure
>   ACPI: irq: Prevent unregistering of GIC SGIs
> 
>  drivers/acpi/arm64/gtdt.c | 10 ++++++----
>  drivers/acpi/irq.c        |  6 +++++-
>  2 files changed, 11 insertions(+), 5 deletions(-)

For the series:

Tested-by: dann frazier <dann.frazier@canonical.com>
