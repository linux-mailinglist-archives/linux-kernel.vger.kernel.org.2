Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB534D856
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhC2Te5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhC2Tel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:34:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71AFC061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:34:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t20so4900329plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4/AjcviJM+MN/+F8Vy+FJ7ln76QoDZiyxq5y8TMSkpE=;
        b=L2srLFum8RmHEw+td2eI6LO1Ehlsob/6OnhmJPb9xldC56tHgR9+SpUmCCf4q83+i/
         abpeKNTf2iWhHwOZeBskvs1/5uO2FaxsbGpMUyX7XzNaLvu3vJXjkylw0SYu48LWzpcn
         zChuKzk+1zZOYVBoZ/6n6BgjKUhdio/7Mzv7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4/AjcviJM+MN/+F8Vy+FJ7ln76QoDZiyxq5y8TMSkpE=;
        b=QZ5vsLFU5L3yT7avwNiJEJbx2NP62en1dFSF3kPVPd1PsiLgle0cYpWRgEWlHWItgo
         gA6O1nWyZ4mLDnYACfRj97GjF0GYE7obzkFpxxlyLNiwJjqZUCwvm0R5RQQG6MzKCdYb
         RJoQDJURrACxdGzXZSORm2g7PokxhbsxJSRpRG9Z1vCEEFu87DoqPJjq3rb5ZzTbw1qw
         pRf7gwmmoktA784Z9C2omdhquv6r17K4rwP8DITyHhmsLoA7ko5clwu1ry79d92qZixm
         8yqPec6USMz3l/zM2uuTxoEwJ6pzVFuMvlQbVEQpSAkgSTE+Cqx4/Tg6c+PlEyOCKpLK
         mOMw==
X-Gm-Message-State: AOAM530X06GQzqBI3NqnZ01rhm2lp3yuofoR30tlqQicNX3BsSBzhcfZ
        0KLU4HlOrAG1VOSU35TYZ03PFA==
X-Google-Smtp-Source: ABdhPJz3TidD50Ag7Kik9OP4JEultVxXJ9TyLE4CvKWcc8IlgTj554nkINbgbuyrv1G2biVaUOu2sA==
X-Received: by 2002:a17:90a:66c2:: with SMTP id z2mr673191pjl.139.1617046480184;
        Mon, 29 Mar 2021 12:34:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:4091:2b37:966b:1fca])
        by smtp.gmail.com with ESMTPSA id cp22sm323225pjb.15.2021.03.29.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 12:34:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5cd274f98b38d4b85c1ce212720b6b680f4a00f0.1616651305.git.schowdhu@codeaurora.org>
References: <cover.1616651305.git.schowdhu@codeaurora.org> <5cd274f98b38d4b85c1ce212720b6b680f4a00f0.1616651305.git.schowdhu@codeaurora.org>
Subject: Re: [PATCH V2 1/5] dt-bindings: Added the yaml bindings for DCC
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org,
        Souradeep Chowdhury <schowdhu@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Souradeep Chowdhury <schowdhu@codeaurora.org>
Date:   Mon, 29 Mar 2021 12:34:38 -0700
Message-ID: <161704647819.3012082.13027529193947275446@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Souradeep Chowdhury (2021-03-25 01:02:32)
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml b/Do=
cumentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> new file mode 100644
> index 0000000..c6e0a9c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,dcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Data Capture and Compare
> +
> +maintainers:
> +  - Souradeep Chowdhury <schowdhu@codeaurora.org>
> +
> +description: |
> +    DCC (Data Capture and Compare) is a DMA engine which is used to save
> +    configuration data or system memory contents during catastrophic fai=
lure
> +    or SW trigger.DCC is used to capture and store data for debugging pu=
rpose

Add space between trigger. and DCC?

> +
> +

Drop double newline?

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sm8150-dcc
> +      - const: qcom,dcc
> +
> +  reg:
> +    items:
> +      - description: DCC base register region
> +      - description: DCC RAM base register region
> +
> +  reg-names:
> +    items:
> +      - const: dcc
> +      - const: dcc-ram
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names

Do we really need reg names? Seems like we can assume the ordering.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dcc@10a2000{

dma@10a2000? Or debug@10a2000?

> +                compatible =3D "qcom,sm8150-dcc","qcom,dcc";
> +                reg =3D <0x010a2000  0x1000>,
> +                      <0x010ad000  0x2000>;
> +                reg-names =3D "dcc", "dcc-ram";
> +    };
