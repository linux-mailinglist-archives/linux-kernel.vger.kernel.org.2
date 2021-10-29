Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE443F4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhJ2CCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:02:02 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40717 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhJ2CCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:02:01 -0400
Received: by mail-ot1-f53.google.com with SMTP id 71-20020a9d034d000000b00553e24ce2b8so6751887otv.7;
        Thu, 28 Oct 2021 18:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=679V0LQan3VkUil0jIPcNRBASsHaaaaTMVzGeGBh35U=;
        b=ARSMEqD0Q+CFVy3O+w9/Zi/HxFW3meGbVIdNPYdNa+E+HuOFNfFZXFVdeC4NUZEJHw
         HFD44HeOPiKEYd7Qbb89KJrVIQ1B+XjS3/+TyXjzI10dxRnxsvtHsOeRFw201r6woUsh
         1uYRPSHSj5lWbMcmHRZuVodRd3ijxJebWAtpVJiWOsgwdXchwv/8dowxsgCejxd9Zghl
         a8zF3QL7lp+or46QEcE7Zy0JPMCXlvhJIQN4LOKJ3TDBBBzPYH8aOYarYIYZZKwC3PKI
         Bpeust9QTxSnenHnJvEPDsnTfmKW8bnGp9z0DZGGUsqFgGvgRZR7bAZze7JzN+BORSi2
         g8SQ==
X-Gm-Message-State: AOAM532bYMDubcZ3n4RH+/Zggo2RAuTBIvjX+kt0BJdOZo0MPaOPfa8X
        wifpTHmTciekjdRfBDaB5Q==
X-Google-Smtp-Source: ABdhPJyo2u72HZKUw226OahRcJf7tAtei+dnzF8pfyNr8zXcn3ztgPqWVSy26IKbQmWeIuQB5+lzew==
X-Received: by 2002:a9d:bd0:: with SMTP id 74mr6372603oth.204.1635472773188;
        Thu, 28 Oct 2021 18:59:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bq10sm1659586oib.25.2021.10.28.18.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 18:59:32 -0700 (PDT)
Received: (nullmailer pid 1001882 invoked by uid 1000);
        Fri, 29 Oct 2021 01:59:31 -0000
Date:   Thu, 28 Oct 2021 20:59:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>, ~okias/devicetree@lists.sr.ht,
        Stephen Warren <swarren@nvidia.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: firmware: tlm,trusted-foundations:
 Convert txt bindings to yaml
Message-ID: <YXtVg+C+tE0AVo/B@robh.at.kernel.org>
References: <20211022232100.137067-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022232100.137067-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2021 01:21:00 +0200, David Heidelberg wrote:
> Convert Trusted Foundation binding to the YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm/firmware/tlm,trusted-foundations.txt  | 20 --------
>  .../arm/firmware/tlm,trusted-foundations.yaml | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/tlm,trusted-foundations.yaml
> 

Applied, thanks!
