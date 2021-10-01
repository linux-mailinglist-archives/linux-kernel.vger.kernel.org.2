Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086C841EA0B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353223AbhJAJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:47:21 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47156
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353128AbhJAJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:47:20 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C952840260
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633081535;
        bh=nyiRnY3elhBK73ooOJVOmC06zf7y6SkVvSwcrbkre8k=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=VvNWzCBK1u+EHfVcuw9ufCyerXXjOAThwphROSK1zH7ge7hXvoc53jy9ZggaWYr9y
         kU20TK+ERhFIwfQRIW5geDRbA3rBO0iJBwJTd85o2wDb8raZSxObs+nrQdr64IKlAh
         l8/Gat9XrRUAteq+HwyOXgN3flOzz+CDoyFERV/yzEiNVQzObfh/2hrX5qWj6pF216
         P9SWIrJe++D1fkqkd6Zpnd+yzXuOLViZiTXEaSijg4W9dYWC8+ZvNHRRl8Z5mcaM52
         Ihgbvu3mkBSQVOVkvgvw3gacGAtUHx94/RUvqpLJiyoImb/0gqLHAzazRT4RdWgGKN
         93eB3KvfEMkHg==
Received: by mail-lf1-f71.google.com with SMTP id h27-20020a0565123c9b00b003fca9e11144so8392902lfv.19
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 02:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nyiRnY3elhBK73ooOJVOmC06zf7y6SkVvSwcrbkre8k=;
        b=onFEyMDBVX7lZNQLuKdt4zFJOttjk854Z7l64hvw6FOICxI+EpWIp7d7/pAKet0E0G
         0BBcuK+uK4/0QRQbl8t2RLqhtr9S7A64cewKDPQrz9B59H4ilgYNqTJ0Q/Y7ZERdtOLX
         30GXOc9XsQM5XtjBilvD4v8C3+o0RVGAmX712lB831gmfj6MW/qBisCNCB18BrkXeKx5
         3y5rp9pTGPL8bLNRSVv1Th00Aeeq8W+IW04fJlqwkG7KFVWzFkkkzXzvu4wAhesF8Foa
         0Hwtsjw5HaED3G2WbnuUu14ge/3UqTUx+xr63VJ+w296QVCLy9+iCbQ8T0Xb6rgbbGZi
         uJUw==
X-Gm-Message-State: AOAM531JqybFIBBxpMTX/GuZ39GusY4PpzUr+Z2av36srXKz/SZgsjwF
        wnskLqHgX93soihTNAJJTkQc/Dapaaowx8DL3gCmqseIr7XRcL89uO0qFDl5s/tSu8+zto0w44q
        RI0uAhIZpcOhnE8Tvtxvo6J4Gzdhca1SCUkHP++2toQ==
X-Received: by 2002:a05:651c:228:: with SMTP id z8mr10685023ljn.507.1633081534966;
        Fri, 01 Oct 2021 02:45:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKxIyWWFkeio1hNSB5XH6CFTmHBcLzDsp3ogVtdLYpiKKaILO3Bn+smaXb0XrSby27toXy1g==
X-Received: by 2002:a05:651c:228:: with SMTP id z8mr10685010ljn.507.1633081534783;
        Fri, 01 Oct 2021 02:45:34 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id c14sm485059lfc.49.2021.10.01.02.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 02:45:34 -0700 (PDT)
Subject: Re: [PATCH 0/5] convert ifc binding to yaml and drop "simple-bus"
To:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211001000924.15421-1-leoyang.li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4697aa5c-35de-8331-e7a9-831837618477@canonical.com>
Date:   Fri, 1 Oct 2021 11:45:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001000924.15421-1-leoyang.li@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2021 02:09, Li Yang wrote:
> Convert the ifc binding to yaml schema, in the mean while remove the
> "simple-bus" compatible from the binding to make sure ifc device probes
> before any of the child devices.  Update the driver and existing DTSes
> accordingly.
> 
> DTS changes should be merged together with the driver/binding changes
> if DTS maintainer is ok with it or after the driver changes are applied.
> 

It's discouraged to merge DTS along with drivers (e.g. soc folks don't
accept such pull requests), so I propose to apply it in the next cycle.

Best regards,
Krzysztof
