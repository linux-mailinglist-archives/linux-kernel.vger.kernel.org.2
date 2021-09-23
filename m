Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7D41674A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbhIWVQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:16:10 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:47042 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243232AbhIWVQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:16:05 -0400
Received: by mail-ot1-f46.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so8333692ota.13;
        Thu, 23 Sep 2021 14:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tmw8eeob9/qu+zKGNe0aTnJO92cJvd0OqVCFygCfvS0=;
        b=YJ1wA5NHfI1wPU8fC1Jx7pCkStxTlnUMf7+Img+j+io2RUZd5fuPoA8dc5yDmPrZNc
         lyP6Yd96qc/zmnkRJbT/o4RhAXi+ec4XEi7ZtMdUelbNlhF0G9WgK2RCHjuVkxB8fXuH
         UgxSXU+z/ZNMQ7CU7236XKoQM95lePI5mJKEQS5wpZXGcJEy0D+tetJ5Jt3FkZBaCGy4
         QkmKbqc/GGy+OlQgho1PmFKAtuLi1jx+1DiF4ERuI/nFvPdeKlqOBugU1vBujJEDq9Ra
         2Md6YQoLUOPbeZ4dKhuZ5EjKyQsW8yVpKcp+xn1M9/I1ODAvuXZHSNKxQI0mkcLaamgH
         D7NQ==
X-Gm-Message-State: AOAM531dI+yR0FyYWHXTnN5KV1NCcjGOpZD+RqqQyP9YbKfX+wzg+cFS
        mf2wTekLtGATJIlUgkvkkQ==
X-Google-Smtp-Source: ABdhPJyXd+BnLwJh9UnA3MTjzOd0ehauTHIxctxIyxvAMuNl7s8D68oclo+bTBhbvdU31ZgN8PQJoA==
X-Received: by 2002:a05:6830:4d3:: with SMTP id s19mr736691otd.246.1632431672712;
        Thu, 23 Sep 2021 14:14:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k23sm1726600ook.45.2021.09.23.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:14:32 -0700 (PDT)
Received: (nullmailer pid 3535664 invoked by uid 1000);
        Thu, 23 Sep 2021 21:14:31 -0000
Date:   Thu, 23 Sep 2021 16:14:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: hwmon: hih6130: move to trivial devices
Message-ID: <YUzuN1YjvLDz7ZYM@robh.at.kernel.org>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
 <20210920182114.339419-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182114.339419-4-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 20:21:12 +0200, Krzysztof Kozlowski wrote:
> The hih6130 bindings are trivial, so it can be integrated into trivial
> devices bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/hwmon/hih6130.txt  | 12 ------------
>  .../devicetree/bindings/trivial-devices.yaml         |  2 ++
>  2 files changed, 2 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
