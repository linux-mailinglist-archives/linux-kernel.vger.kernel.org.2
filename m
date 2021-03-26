Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17055349DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCZAWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:22:14 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34730 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhCZAVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:21:43 -0400
Received: by mail-io1-f43.google.com with SMTP id x16so3743988iob.1;
        Thu, 25 Mar 2021 17:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWy8NXTw+pLAbpyPspl19i3Z5xWZ5aPkuYlAGNhEVnM=;
        b=PlUM6pUaThDe+YymqJGzSg2YF6bvpxNQcULm1yYZG+/PoB6DcVfHzHn/kywxVmWCGh
         MW5jjMZJ6jCIpr8JENWG7vS9R3RjXk3mWPCFpZj8cGrKqdzKanv3gvTfSZrWwEYgtl+l
         NPhY6D9QUMJum6P1n45Ldg2vos8o17xToBt9huXbaiONvyfmkKGMrogNI5gvMNjZmxsZ
         0VdeSoSjYmwXpHFNT9tpHcCo0epCaosQG12rrzMmMrmA3D6NIyV4/jBXmRnreYCAJvDF
         nvYzvTk0jJDpYiDVtwrSVW835RvhPAiYQXfgsCFGv+TNqSC8QCQTnuzPugFqdYaquR6H
         R2Kg==
X-Gm-Message-State: AOAM530PAyMBb3lFObVOH29eUwzrxK3//GXmh+6KoeZrswEfLpbwdT27
        p0aJbokgvbTJsm+rB6KAaz5kDGEhcA==
X-Google-Smtp-Source: ABdhPJxw3Xsrk/BggYGaqSuORLUB53KuZYbOOE4CrP2WFVxbma7fealCox2rE2qXaGUWPWE5BSJCmQ==
X-Received: by 2002:a05:6602:2d95:: with SMTP id k21mr8314148iow.123.1616718102405;
        Thu, 25 Mar 2021 17:21:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h6sm3353391ild.79.2021.03.25.17.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:21:41 -0700 (PDT)
Received: (nullmailer pid 2021603 invoked by uid 1000);
        Fri, 26 Mar 2021 00:21:38 -0000
Date:   Thu, 25 Mar 2021 18:21:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, dt@kernel.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH] devicetree: bindings: clock: Minor typo fix in the file
 armada3700-tbg-clock.txt
Message-ID: <20210326002138.GA2021512@robh.at.kernel.org>
References: <20210317100840.2449462-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317100840.2449462-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 15:38:40 +0530, Bhaskar Chowdhury wrote:
> 
> s/provde/provide/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  .../devicetree/bindings/clock/armada3700-tbg-clock.txt          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
