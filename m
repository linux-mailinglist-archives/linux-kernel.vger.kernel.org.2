Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C533DAFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 01:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhG2X3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 19:29:55 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:36450 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhG2X3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 19:29:53 -0400
Received: by mail-io1-f41.google.com with SMTP id f11so9212772ioj.3;
        Thu, 29 Jul 2021 16:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cC7vR3it4xiIwkxuLbk7VNsOyKGjwxRHv7pG7+HLJ8k=;
        b=BmRoV/WX5XZjNAm8O2DHGY8qwaJsj8CGPw8elBm5kCP5rPAKZDs25mFJ1ZOvL/FGMu
         nsckGM7ThGS/WCdDYn1i+BrkHRn3uijHtoZ7jFj7HurPw/xoJHbXAY81OmGlW2Pi8eyE
         HCWPWyAiejic6O+Wg6VU0RlX6GhXinUjX5Ju6tlr/gX7mwL803TW/igyOBYfVoJERche
         NZ8DVc/ZbA0KBXFFEnqg7yWp6fhO+IgWqWe8lQ5b0QSupYhMWWyayhRO/1iMMB2Q1hbO
         FJ2gU0pZVNKpCatBfTfNn854sQs+yyG8TIJPtLHIlFy5eWFThk2fs08k4IhW/eEYunz7
         mDwQ==
X-Gm-Message-State: AOAM531yqvMBn6NQMvAQMA+ZtaIqBmcLE/e4RYAvIx1uHwMriWdwT1z3
        qnwYm7ZfSZ58P8an2ow10w==
X-Google-Smtp-Source: ABdhPJws3bTH3yDQsR0ZrVWoiBj40dJIND+dOFQFaKXo+JHKOHtOL2T+WPopZcnSNnIL8QrD/e3pWg==
X-Received: by 2002:a05:6602:2424:: with SMTP id g4mr6141803iob.189.1627601388851;
        Thu, 29 Jul 2021 16:29:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r198sm3310089ior.7.2021.07.29.16.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:29:48 -0700 (PDT)
Received: (nullmailer pid 1113199 invoked by uid 1000);
        Thu, 29 Jul 2021 23:29:46 -0000
Date:   Thu, 29 Jul 2021 17:29:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com
Subject: Re: [PATCH 1/4] dt-bindings: perf: marvell: cn10k ddr performance
 monitor
Message-ID: <YQM56mlxM19UDu93@robh.at.kernel.org>
References: <20210726091027.798-1-bbhushan2@marvell.com>
 <20210726091027.798-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726091027.798-2-bbhushan2@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 02:40:24PM +0530, Bharat Bhushan wrote:
> Add binding documentation for the Marvell CN10k DDR
> performance monitor unit.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>  .../bindings/perf/marvell-cn10k-ddr.txt           | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.txt

Bindings are in DT schema format now.

Rob
