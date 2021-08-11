Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE53E975C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhHKSMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:12:22 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:35418 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhHKSMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:12:20 -0400
Received: by mail-pl1-f181.google.com with SMTP id u15so1595938ple.2;
        Wed, 11 Aug 2021 11:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tbuRYB4uyFYBA1QXdZzfZOeTruC0CprKZZMaGFDPs34=;
        b=BtFjxq2TTLJlhXwBdwRjdseB91VycmLxM+HFFfB2jy1szky35Lm2wXUniJjGsL9KPu
         1CCzl17vEogNnSATYvXXSQiO2KDGXERm/ohkS1qQ4MxRkHre53utnzHq1zlPkuDbnPzw
         ZRua23ieW1lWA9GdF/zspoZR3Cq36akjLBnMbb8H8kZly8yimzPIBk31xJKmxgaA8Kj8
         qhUHRNJJE2g3/cuhnri9jd6FSlG2eWRIHZldquDL8h7xqekXoyG5YQHS3kqc3BDmHs7E
         3Ikm27M7OiGYb1e2jPCuxz3IC9nfm4Z7UTMAsOL69LtqBQWgqmkrRHwLWSMbQs+HNyf/
         /Kag==
X-Gm-Message-State: AOAM533OZsSlwP0feixhD3jsEsveIYG6zzuGs5xq381xjgb/hUCsgHRy
        zzrb9yK5NxF85TzZUEGE3A==
X-Google-Smtp-Source: ABdhPJx9VQykQ/6lrhYIHShi0cEVtld5ix0mGjvSn4jKASC9Y8ePHOmDGI6rN8ZRav52N3T1ZBpkAw==
X-Received: by 2002:aa7:9828:0:b029:3bd:dc3d:de5f with SMTP id q8-20020aa798280000b02903bddc3dde5fmr62738pfl.47.1628705516576;
        Wed, 11 Aug 2021 11:11:56 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id 23sm73377pgk.89.2021.08.11.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:11:55 -0700 (PDT)
Received: (nullmailer pid 16794 invoked by uid 1000);
        Wed, 11 Aug 2021 18:11:48 -0000
Date:   Wed, 11 Aug 2021 12:11:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-aspeed@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Zev Weiss <zweiss@equinix.com>, openbmc@lists.ozlabs.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        David Muller <d.mueller@elsoft.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 04/15] dt-bindings: Add bindings for peci-aspeed
Message-ID: <YRQS5IigFxo5DVCH@robh.at.kernel.org>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-5-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803113134.2262882-5-iwona.winiarska@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2021 13:31:23 +0200, Iwona Winiarska wrote:
> Add device tree bindings for the peci-aspeed controller driver.
> 
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
>  .../devicetree/bindings/peci/peci-aspeed.yaml | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
