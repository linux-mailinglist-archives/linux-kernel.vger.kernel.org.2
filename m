Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD53B666E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhF1QMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhF1QMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:12:15 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C45C061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:09:49 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so19343385ota.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8C0Zt6lzqm7Cr6/B2lVDa8JG9oCZyzFu7BcHonMqt1I=;
        b=lDiDyZDGCzNYEnqtmW7YtMOnLq3WQI6R/SGIbDezV2XMqhMiRJVFhn2g6rXVM9wcaV
         EEDEPb6iAdC1Lm5F/hU6x0UI8n35znv8WEWdjgdiChRsCgd0Z9ZnDG5njbA88YRq6BO9
         ZrBYGV+zGE4QNQ1nmmEBZgiOzZ5Knj6IKJKwyoeYG6z+t26t6D/2v9loRH9piTJd22gl
         EgyCgXdgrYatKIQTqLWTw4A4o8svbDkMLhuqBSXDu/waTQ7tO6OxRfuuyJuIcg3PVU+h
         RPfgnzoL1GBb9bC1uAHJFFIEaxvrdkB/jdwZEaZdX/aGg4dYC3VEAhRqzpoqQwRo7Zcq
         TtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8C0Zt6lzqm7Cr6/B2lVDa8JG9oCZyzFu7BcHonMqt1I=;
        b=lsieFBs/Y6cDkfrgssNd3y7GiUnwGKhbHn3WTBjzWyaSzMBbYJPBbS7WXZLghEJI9I
         AeyT/egVlnmKSxD442P8ksqD8yk8oWZdCV0hshzk55nTNAAjSYdz4pA0s03gmna65pVa
         AtfTIyFOAQiMW+e0hWSRdF/QxBJasC2lJ9Dk5/1OIzVsEjEd3KNNy2xB25t3S6DcF3Ro
         TIloihWQrpY5MabTk9mySIQxItTDwij2ZSax1FWBB9YEz5LvYHWJTlDbRIOpfBUTW9H5
         YVeWAea+Ete0tlu9t05qkwwPYAFoO2dICGHhT54b0yKeuWQjJujFZGipPPN5prYBvScp
         W1rQ==
X-Gm-Message-State: AOAM533qEgSaBOGwZDurq8vKZ78vNqm73+Ss7MYzLkg46+W8o13euUwC
        /DCVBZhTw5UVA8pLDJPoDnsREQ==
X-Google-Smtp-Source: ABdhPJy0D0v2WxhN6uSxEEarbT3wFq9+1/FiOEnDYD6Z1BdPEkPpWK1ozR6o+4669oBiKBVDSlNjDA==
X-Received: by 2002:a9d:2781:: with SMTP id c1mr316985otb.34.1624896588760;
        Mon, 28 Jun 2021 09:09:48 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k24sm3525002otp.55.2021.06.28.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 09:09:48 -0700 (PDT)
Date:   Mon, 28 Jun 2021 11:09:46 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sibi S <sibis@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: soc: qcom: aoss: Convert to YAML
Message-ID: <YNn0Sg5tjVbu01oy@yoga>
References: <20210625234018.1324681-1-bjorn.andersson@linaro.org>
 <20210625234018.1324681-3-bjorn.andersson@linaro.org>
 <20210628144908.GC4033@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628144908.GC4033@workstation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Jun 09:49 CDT 2021, Manivannan Sadhasivam wrote:

> On Fri, Jun 25, 2021 at 04:40:17PM -0700, Bjorn Andersson wrote:
> > Convert to YAML in order to allow validation.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > I'm aware that this conflicts with Sibi's removal of '#power-domain-cells', but
> > that's a trivial change regardless of which of the two patches gets in first.
> > 
> >  .../bindings/soc/qcom/qcom,aoss-qmp.txt       |  90 --------------
> >  .../bindings/soc/qcom/qcom,aoss-qmp.yaml      | 115 ++++++++++++++++++
> >  2 files changed, 115 insertions(+), 90 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
> > 
> 
> [...]
> 
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - mboxes
> > +  - "#clock-cells"
> 
> The old binding lists this property as optional but you're marking it
> as required. And by looking at the driver it seems to be optional only.
> 

You're right, missed that detail. Will respin accordingly.

> > +  - "#power-domain-cells"
> 
> This one was marked optional as well but the driver registers the pd's
> unconditionally, so I guess it is fine.
> 

I think this should be a required property, but the conversion should
convert the binding, so I'll update accordingly.

Also, Sibi has a series that drops the power-domains, due to some
unforeseen complications related to suspend, so there's no need to
follow up with a change to the binding in this regard.

Thanks,
Bjorn

> Thanks,
> Mani
> 
> > +
> > +additionalProperties: false
> > +
> > +patternProperties:
> > +  "^(cx|mx|ebi)$":
> > +    type: object
> > +    description:
> > +      The AOSS side channel also provides the controls for three cooling devices,
> > +      these are expressed as subnodes of the QMP node. The name of the node is
> > +      used to identify the resource and must therefor be "cx", "mx" or "ebi".
> > +
> > +    properties:
> > +      "#cooling-cells":
> > +        const: 2
> > +
> > +    required:
> > +      - "#cooling-cells"
> > +
> > +    additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    aoss_qmp: qmp@c300000 {
> > +      compatible = "qcom,sdm845-aoss-qmp", "qcom,aoss-qmp";
> > +      reg = <0x0c300000 0x100000>;
> > +      interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> > +      mboxes = <&apss_shared 0>;
> > +
> > +      #clock-cells = <0>;
> > +      #power-domain-cells = <1>;
> > +
> > +      cx_cdev: cx {
> > +        #cooling-cells = <2>;
> > +      };
> > +
> > +      mx_cdev: mx {
> > +        #cooling-cells = <2>;
> > +      };
> > +    };
> > +...
> > -- 
> > 2.29.2
> > 
