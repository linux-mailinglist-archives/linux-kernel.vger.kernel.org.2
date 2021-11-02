Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B7442F05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhKBNXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:23:51 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44834 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKBNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:23:50 -0400
Received: by mail-ot1-f50.google.com with SMTP id o10-20020a9d718a000000b00554a0fe7ba0so24116084otj.11;
        Tue, 02 Nov 2021 06:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8DD3rCF6jBxu4k+OYCUU4GMceJRCBHyNxQokvIcdkO4=;
        b=lZC6dW+r0ykbpIFmBuVLXcuPRhyoKzOO7wIyiECOl1LCzz57KLM7iSo/BaMMVsZ0ol
         Q8Ne93DizisG0jzsRBufwzjKY/ib5viSPEvzRI9UNcEPDe01wovGpfWidWuTsqgcE0Sk
         4ujRcoWI5SDUeHulqLufqYTBkC1qtUsUWL6p7DYHnfp09eo3EXvbKaGZIGxXKJW0XpNY
         Ft4XennP3oxUU0ex3m0lDCcmfBRMfHGsmIkQOoKVRi7lWpqia3s5jNb042v/GOaZAtOe
         M6tUnKp45WAJfls0qj2feTyvOQT4uMF/EdwC8dKYC9J3jIU17+ojbe8IGBTYtaIJUMIV
         Kqsw==
X-Gm-Message-State: AOAM533Tef2eRhJr51otMSGJtXJDq2zbkLo7tdHc333cHXV6Bx6STHtN
        MczGTVZFhyCh6Uun9+/9dQ==
X-Google-Smtp-Source: ABdhPJyHOy9mKMNd012qXkVOWSu+GYz663s1Yp7e611ut1ZGm5A+ouAXTHU3DSQKL0pFSujy0eXx+w==
X-Received: by 2002:a05:6830:4033:: with SMTP id i19mr26131739ots.320.1635859275084;
        Tue, 02 Nov 2021 06:21:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 8sm5057177oix.29.2021.11.02.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:21:14 -0700 (PDT)
Received: (nullmailer pid 2714011 invoked by uid 1000);
        Tue, 02 Nov 2021 13:21:13 -0000
Date:   Tue, 2 Nov 2021 08:21:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Message-ID: <YYE7SV886ihwD31f@robh.at.kernel.org>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028140009.23331-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 16:00:08 +0200, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation. The compatible mandates a
> channel ID defined with property "linaro,optee-channel-id".
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v6:
>  - Remove maxItems from linaro,optee-channel-id description
> 
> No change since v5
> 
> Changes since v4:
>  - Fix sram node name in DTS example: s/-shm-/-sram-/
> 
> Changes since v3:
>  - Add description for linaro,optee-channel-id in patternProperties
>    specifying protocol can optionaly define a dedicated channel id.
>  - Fix DTS example (duplicated phandles issue, subnodes ordering)
>  - Fix typo in DTS example and description comments.
> 
> Changes since v2:
>  - Define mandatory property linaro,optee-channel-id
>  - Rebased on yaml description file
> 
> Changes since v1:
>  - Removed modification regarding mboxes property description.
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
