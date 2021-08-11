Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DCD3E9758
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhHKSLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:11:55 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34697 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHKSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:11:54 -0400
Received: by mail-pl1-f180.google.com with SMTP id d1so3757759pll.1;
        Wed, 11 Aug 2021 11:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1A9gzdbnn58lRehU+hUclDHaFNwYQNoEsi8rcFLZjN8=;
        b=O90UncPSkx8NEIc6958yp4hBRpwY/4VgbhrFlAfHaK/VehU6aj2lsGtuC7KHqGunEF
         WjXwbVz6wXeZYjrikuURARkiT69fsOe9ZVeUA/AI7nAA5liqCnCqXaFoLLtSW51xFoPo
         daVbPmdcQxJjb4frqe6dkUzVJsMKC8e1Ib0d/b7bhO9cBsQV4GTQhzmR2LIX84j19UBi
         BWcgD34MWlpH7/zaVnpPzzJf4ya1lhvTni//faQZ4eWY7tvuGqpobJjERDUj0FhwNvdf
         cIgdwLH7nIHF47q5jM1KeppPXI82u/J+PDr29gccDN/75/sGxroo0Ech/VPVtnbNxGG4
         kjRw==
X-Gm-Message-State: AOAM533O7LK1h+gzwSJIj7S1ILg68kyZmofzRctm4Zgk7xpkPA2KMJ8Q
        b0psq9+ZtokymKnujmXapw==
X-Google-Smtp-Source: ABdhPJylZYCNsi7aLdnU5BXGhlWKKRwa0qCJ5LYDWJSxKrWZNnd2izzg5emDhPlR1+rNNPVyexC6GA==
X-Received: by 2002:a63:a902:: with SMTP id u2mr174837pge.123.1628705489665;
        Wed, 11 Aug 2021 11:11:29 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id 66sm196425pfu.67.2021.08.11.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:11:28 -0700 (PDT)
Received: (nullmailer pid 15921 invoked by uid 1000);
        Wed, 11 Aug 2021 18:11:22 -0000
Date:   Wed, 11 Aug 2021 12:11:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        David Muller <d.mueller@elsoft.ch>, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Zev Weiss <zweiss@equinix.com>, Ingo Molnar <mingo@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: Add generic bindings for PECI
Message-ID: <YRQSyjFcS8bAfqDU@robh.at.kernel.org>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-4-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803113134.2262882-4-iwona.winiarska@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2021 13:31:22 +0200, Iwona Winiarska wrote:
> Add device tree bindings for the PECI controller.
> 
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
>  .../bindings/peci/peci-controller.yaml        | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-controller.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
