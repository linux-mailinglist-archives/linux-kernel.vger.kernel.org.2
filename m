Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADAC427AFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhJIOyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:54:44 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48318
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233799AbhJIOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:54:38 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D55E43FFF6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633791160;
        bh=cUxQy0Bth8q+GCo4vniDh9W7ssLXht20HUqFZATsxok=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=O1cOJHu5S2s5g6CVxWSYXRFuVPLSXrSRx/BhizxvBYFUugeMj/mJzVsz4W+idzW2b
         yFEgw8CN5TaT37d8sSUrM3+65A1OR1p5V7MzbPVpRVtNsFRVCSJojzkqLzQQ1c5h02
         jWAAcCMMJAHpCx7AcRD+kPuCyS8tmf0u5xlFtaaJ9L62y7Fh+zGFyLK8Tg8WhUAoge
         hbfxFWoWo7AGawRzgC1UTJLFjz2ZCs7dyQxZ8Gtpihia2t7KO6rzA9V6u1mxzKxOQA
         9VbC3FJcP4CLqk8zMI/txxkUq5AzP0nsMGQZXo0YljKsvB7JHh6DjhX//reQCpDNUW
         wn/ZJiyZ9t4Tw==
Received: by mail-ed1-f69.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso11750427edf.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 07:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUxQy0Bth8q+GCo4vniDh9W7ssLXht20HUqFZATsxok=;
        b=jtc5S3jMzuKMQhtZlJUFQDpDJu6w8Zys/BhjNWAHewgd0qvDR+T3uR7vhXSFj2mvAY
         bpp0g0M7x0nJ6nnmQUyQOk3V+znhaTTaFO1kOhtZ2FynPeFNN9lix7y3uHL+DpOWiTjR
         U7/M6RfvaAM3t8kUv1Jkab72HoqmR3CjoPKbUxNVO2f+VYbsCRDDsGsy1OgbNQ82Li2l
         kZ40yvYqRXTq9Xlw+Hir/3VVYUCLi9iRxVFo/4h1aaTLCeUmnSVqOqAqRQl/Lh6CpvSg
         RttJ9T3JWII6OCu+CxU+W5F4Z247pUdJjlVFl04bkrsk7dRsbTQqwor3YIg5210I5/Yu
         sVdQ==
X-Gm-Message-State: AOAM530o5CXyxVhUWzC869ohcCAaj750UsrkO/Em5TFTPpwiDIEfrs6v
        dbTGvEHINxcs0NbGB4Sf3SMmUIca4Gr6D6K5+9yqa1Ygy2WwyF697dlH6aadQFU6Pu7YFhW2Jp3
        8FCiXLh7i+TrnNjMLosnjMFP8Wqwew9iaCdGqWw1ThA==
X-Received: by 2002:a17:906:4f96:: with SMTP id o22mr12106278eju.169.1633791160223;
        Sat, 09 Oct 2021 07:52:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQkyKpJO+752VWuzH558+pOz9Vyk2rpYND0quJOBJ3uvzM5hpazCy/T4WFK8NFjQUP0vkb3w==
X-Received: by 2002:a17:906:4f96:: with SMTP id o22mr12106249eju.169.1633791160026;
        Sat, 09 Oct 2021 07:52:40 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i4sm1307649edt.29.2021.10.09.07.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 07:52:39 -0700 (PDT)
Subject: Re: [PATCH v5 3/8] dt-bindings: memory-controllers: Introduce
 ti,gpmc-child
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh+dt@kernel.org, grygorii.strashko@ti.com, nm@ti.com,
        lokeshvutla@ti.com, nsekhar@ti.com, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211007120830.17221-1-rogerq@kernel.org>
 <20211007120830.17221-4-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a6478659-cea1-8c5a-287d-acc27b60a898@canonical.com>
Date:   Sat, 9 Oct 2021 16:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007120830.17221-4-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 14:08, Roger Quadros wrote:
> This binding is meant for the child nodes of the TI GPMC node. The node
> represents any device connected to the GPMC bus. It may be a Flash chip,
> RAM chip or Ethernet controller, etc. These properties are meant for
> configuring the GPMC settings/timings and will accompany the bindings
> supported by the respective device.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../memory-controllers/ti,gpmc-child.yaml     | 245 ++++++++++++++++++
>  1 file changed, 245 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
