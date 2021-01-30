Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0355309909
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhA3XzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 18:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhA3Xxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:53:53 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF157C0617AA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:52:03 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so9399413pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Ui0BeJCwGOKq8ej5x7M1Q9u0lMO3l7TRN0DCBw5DBWc=;
        b=MzV7DeqSQEU06RPg78K/siciEFk1jfbTpumwWmLQl6H6Gtps4XMqo2d69/O5cLG2ib
         sWHVna8f+tRiTekQ27iMrabwakv/X6Gbl2kRVK/U/BGlRXp3T9i1yQQSuVnU6lr+dm/x
         8FEPu29yNnBux/VASHH7ScQ+Jl0IiYohkU6+RCuQUg1EgQPqAcab+9vyY4J5yCbNcTRR
         nr53UK6NJNWZfhq5VD+V3Le0HG/nMeKhW74bPHwhTL5zw+kABM4AX6dL+VwufuqFX1nq
         tUL0JTNvh8Ct349k+VfR9Xo8+biP3GeU+ESkvAHVcmQEBivIFsiEhTmpY/WaIHhwMGhe
         hhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Ui0BeJCwGOKq8ej5x7M1Q9u0lMO3l7TRN0DCBw5DBWc=;
        b=FPHtupHC9B/gfK6A/iz6Ptyn76polG0nT2Xi+ueAgRI8bAsUsiuYktznpiMkCv2fNH
         dwBtG37KcdLg49e3ljYpYh29oMOmm4KLaWJXRkGLZAYl3T2plfV04+F70HjX4LCNK9M+
         TFYkpZlqEgv8PDACO1MZ8XSs4BhH3dXkM5IwG90e3ZzPZfEDWnA9GYIcy1gRmi7j1QGe
         03ow473NEJ33b3+c5xBwd3VTAiqUt75DQNzdvubFTRkBqX/sk0VsVyA/RAAlqq+iwg1m
         ThkaWfL/dGfhsKc4cIJiMTO1sm9UoHJ1Vi08uY0Sr1toSgM1ftrVhikrEAskWm+L9F8R
         6vmA==
X-Gm-Message-State: AOAM531hL8IVpD7P9xgGPOJ21zLI5u/g8QoOv6G/5HuFsH0MI3Gf1/Gs
        iiAt54Rc9FtIyDoe91hJHhjk2A==
X-Google-Smtp-Source: ABdhPJwhLUNT7kvzAUWFbzT9Lc1dFYnkmDtxMuvH7NNwX3Q8WOwnNGrRfaRhmDarU4sLoHVBNmVU6w==
X-Received: by 2002:a63:7947:: with SMTP id u68mr3474320pgc.451.1612050723241;
        Sat, 30 Jan 2021 15:52:03 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id e12sm13104562pga.13.2021.01.30.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:52:02 -0800 (PST)
Date:   Sat, 30 Jan 2021 15:52:01 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
In-Reply-To: <20210130002438.1872527-6-ben.widawsky@intel.com>
Message-ID: <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-6-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> new file mode 100644
> index 000000000000..fe7b87eba988
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -0,0 +1,26 @@
> +What:		/sys/bus/cxl/devices/memX/firmware_version
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "FW Revision" string as reported by the Identify
> +		Memory Device Output Payload in the CXL-2.0
> +		specification.
> +
> +What:		/sys/bus/cxl/devices/memX/ram/size
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "Volatile Only Capacity" as reported by the
> +		Identify Memory Device Output Payload in the CXL-2.0
> +		specification.
> +
> +What:		/sys/bus/cxl/devices/memX/pmem/size
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "Persistent Only Capacity" as reported by the
> +		Identify Memory Device Output Payload in the CXL-2.0
> +		specification.

Aren't volatile and persistent capacities expressed in multiples of 256MB?
