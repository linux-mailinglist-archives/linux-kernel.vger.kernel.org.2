Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D217A3CBB47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhGPRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:37:47 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:45807 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhGPRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:37:44 -0400
Received: by mail-il1-f176.google.com with SMTP id b6so8966382iln.12;
        Fri, 16 Jul 2021 10:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iPb7ckziK4kV9zNM6d9iK4b7roci6qqd+Gv92I6XJVU=;
        b=tbgB/gC3RvWJ50XEdAA9hml3skG0957cBgZybHREB4YZJ2GKKGdna5KQdhvgb9jXi9
         DzP37qkyWMIPvHTlatMcibFcg4Ky2FEm//RYsnLRaTMX5jhT/JKW0HiuzT/FsA+5lstq
         s2lSqWmxBcfSvGvo6uXHhLVDCSfthy1akfNt96B/QVcoJvnMWt6VS+Z/gIDp1fIn2BQT
         6eXWyK15KuDsr86/wApAXTIX+37gSk0lvCdIVb3YCPLEpRZ/62lt7YJw4arJGG85A7Ur
         CIiji1FGN5M4UtPjDYPlEOmMagQzmMBvXTkfoAmGxzspMkRNzdULINEn4pwnJqHV5T3f
         zbEA==
X-Gm-Message-State: AOAM531C9xp3VmOso4yru1dhtIf4F/zi3HkxZkGtSJMLdJvL+t1EX/j7
        GGpJm9NAHlF5ZbdTWrUay4LjWkqw0g==
X-Google-Smtp-Source: ABdhPJyKVjf0100xt5UQ7F9dhFRP/lQhHl+nq9gAbSXPcH5nkSAeXz19sGCDD/0YQ2ZJLRqjQla1Qw==
X-Received: by 2002:a92:c504:: with SMTP id r4mr7106583ilg.131.1626456888668;
        Fri, 16 Jul 2021 10:34:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a11sm5100043ilf.79.2021.07.16.10.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:34:47 -0700 (PDT)
Received: (nullmailer pid 3643640 invoked by uid 1000);
        Fri, 16 Jul 2021 17:34:43 -0000
Date:   Fri, 16 Jul 2021 11:34:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Open Source Submission <patches@amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>,
        openbmc@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Phong Vo <phong@os.amperecomputing.com>,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro MFD driver
Message-ID: <20210716173443.GA3643583@robh.at.kernel.org>
References: <20210713060031.31568-1-quan@os.amperecomputing.com>
 <20210713060031.31568-2-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713060031.31568-2-quan@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2021 13:00:28 +0700, Quan Nguyen wrote:
> Adds device tree bindings for SMPro MFD driver found on the Mt.Jade
> hardware reference platform with Ampere's Altra Processor family.
> 
> The SMpro co-processor on Ampere Altra processor family is to monitor
> and report various data included hwmon-related info, RAS errors, and
> other miscellaneous information.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Changes in v5:
>   + Dropped ../bindings/hwmon/ampere,ac01-hwmon.yaml file [Quan]
>   + Removed patternProperties section and child DT nodes in example
>   section [Quan]
>   + Revised commit message [Quan]
> 
> Changes in v4:
>   + Revised the commit message to clarify how the specific info will
>     be handled commented by Rob.
> 
> Changes in v3:
>   + Supported list of compatible string [Rob]
>   + Introduced reg property in DT to specify reg offset [Rob]
>   + Updated description and other minor changes in yaml file [Rob]
> 
> Changes in v2:
>   + Changed "ampere,ac01-smpro" to "ampere,smpro" [Quan]
> 
>  .../devicetree/bindings/mfd/ampere,smpro.yaml | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
