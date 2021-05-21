Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C6838CBA2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbhEURNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhEURNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:13:01 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F5C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:11:38 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so18623238oth.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 10:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e9JeVn1G8IdnIeIesci3+Ayk5EovOq0M3s+2FeKNFK0=;
        b=pvPG2IpXF0bJcf/z/J6X/Jv/vHW0axAut+lT9rP4IJIFi/HUxPlCmpuFAhpJqpu8Qm
         UKWNsaKRLrau75GJcP1RCp9U6Bjer9Z9dXkVlW74husfn10xGO2KrszYfsxXxprr0EXz
         Q2X7i3RQzM2yfE8HcE4/cfKQAUwL2f62pg9Q0FhUV3JfqIc6uD4J9EW7h4TLe5UwbpdY
         Ra3rqKrtZRBn9HfWadnIHfQ7Dz/cBqOK+eNhoShTmjYFetUdRqVcXACMtXFJFVv6gm2H
         /lpBq543BSbByfrbXjd1cCNvgLCnoxoVovGQfv96UBW+qBRctQ0R7dbuxielpsvbVPP/
         Qqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9JeVn1G8IdnIeIesci3+Ayk5EovOq0M3s+2FeKNFK0=;
        b=O5olDignrzEOLTY9pZ3nRIoBKAC0diUyaZv43rRXpViAp/1zo1fMsBmecWLAlCiL1q
         1HrXq18PI7EsDQdc1YJb9WSz9NMQLSB4cUZcsgDFno6a6Ld57a63qSSNVV4Tz8YTiqfH
         mhpoT7Rr1fE4FSwOUCdPphrlDnBRnAZ06wEl3SS5wcRJZ89VnQ9TbTjrYtzHgbQsseYF
         lBykEkq2X2NLI4OmAMZWvhTZFcwK2ytT8VA7vkW7a/ot8mX7vamvzMZ8TQ73P3551RNn
         I4JJ+2UJEL1TAdC+X5jLNC/DnRlkfmQKLEu5hGQUg85Zd9k2YBvDxeunY7xG4PoQ4ppM
         qz0w==
X-Gm-Message-State: AOAM531lvU4mlTcGJqcVoQakA7zKCWZRBkOMt0/l4bwJwKnezFsIclKy
        fdksxyaJZemxnk7olYEiLReuew==
X-Google-Smtp-Source: ABdhPJyr6YEiNQNOwzD5WfXzXxLiSfPTTV2nKIC0FlJZRbbESbv1j2UsCVQtzVFeDjV+o96hBm31nQ==
X-Received: by 2002:a9d:453:: with SMTP id 77mr9684827otc.31.1621617097435;
        Fri, 21 May 2021 10:11:37 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e26sm1209578oig.9.2021.05.21.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 10:11:36 -0700 (PDT)
Date:   Fri, 21 May 2021 12:11:34 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krishna Manikandan <mkrishn@codeaurora.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kalyan_t@codeaurora.org,
        tanmay@codeaurora.org, abhinavk@codeaurora.org,
        robdclark@gmail.com, swboyd@chromium.org, vinod.koul@linaro.org,
        dianders@chromium.org, khsieh@codeaurora.org, robh+dt@kernel.org,
        sean@poorly.run, robh@kernel.org
Subject: Re: [PATCH v17 1/4] dt-bindings: msm: disp: add yaml schemas for DPU
 bindings
Message-ID: <20210521171134.GB2484@yoga>
References: <1621592844-6414-1-git-send-email-mkrishn@codeaurora.org>
 <20210521160029.GA2484@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521160029.GA2484@yoga>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 May 11:00 CDT 2021, Bjorn Andersson wrote:

> On Fri 21 May 05:27 CDT 2021, Krishna Manikandan wrote:
> > diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml
> [..]
> > +      ports:
> > +        $ref: /schemas/graph.yaml#/properties/ports
> > +        description: |
> > +          Contains the list of output ports from DPU device. These ports
> > +          connect to interfaces that are external to the DPU hardware,
> > +          such as DSI, DP etc. Each output port contains an endpoint that
> > +          describes how it is connected to an external interface.
> > +
> > +        properties:
> > +          port@0:
> > +            $ref: /schemas/graph.yaml#/properties/port
> > +            description: DPU_INTF1 (DSI1)
> > +
> > +          port@2:
> > +            $ref: /schemas/graph.yaml#/properties/port
> > +            description: DPU_INTF0 (DP)
> 
> Why is port@0 INTF1 and why is port@2 INTF0? In the binding you're
> translating the two ports that are described are 0 and 1, representing
> INTF1 and INTF2, or DSI1 and DSI2, respectively.
> 
> Further more, I have a need for somehow describing the pairing of 4 DP
> INTFs (INTF 0, 3, 4 and 5) and how they are connected to the 3+1 DP+eDP
> controllers.
> 
> Downstream this seems to be handled by adding cell-index to the DP
> controllers and then matching that against the numbering in the driver's
> INTF array. But rather than adding cell-index to map this, can't we
> define that the port index is the INTF-number here?
> 
> 
> This would obviously break compatibility with existing DTBs, but we
> could start by doing it selectively for the new compatibles, fix up the
> existing dts files and then drop the selective application after 1 or 2
> LTS releases.
> 

In a chat with Rob I realized that my feedback here is unrelated to the
yaml conversion and any conclusions of this discussion should be a
separate patch anyways.

So with the two style issues below resolve you have my:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

[..]
> > +examples:
[..]
> > +                   ports {
> > +                           #address-cells = <1>;
> > +                           #size-cells = <0>;
> > +
> > +                           port@0 {
> > +                                   reg = <0>;
> > +                                   dpu_intf1_out: endpoint {
> > +                                                  remote-endpoint = <&dsi0_in>;
> > +                                   };
> > +                           };
> > +
> > +                            port@2 {
> > +                                    reg = <2>;
> > +                                    dpu_intf0_out: endpoint {
> > +                                                   remote-endpoint = <&dp_in>;
> > +                                    };
> > +                            };
> 
> The indentation is inconsistent among the ports.
> 
> > +                   };
> > +         };
> > +    };
> > +...
> > diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml
[..]
> > +      operating-points-v2: true
> 
> You have a blank line between all other properties, but not here.
> 
> > +      ports:

Regards,
Bjorn
