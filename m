Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895FA45A6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbhKWPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbhKWPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:54:14 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485EAC061574;
        Tue, 23 Nov 2021 07:51:06 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so34341348otk.13;
        Tue, 23 Nov 2021 07:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tJQKOiGB2vMuUqi1aD/KDeUab9z92lW/Lc4DaqZriqA=;
        b=f4kmgK0vVOxM7SUOOui9MCrPkzPqPGRFZjasT0mKmxH+SZ2MigxSi9obkrdIxo7jLy
         /7mWXJLAmnpXtrA3LJ9eyH8LSugnBNo3+nClOf7UiabcSD+YDAELoJVjX9yz3oQRnNnr
         FIjAUFb68dCPXF18UEP/k1DsHEte9I6kvSmnV+NWOW5VMUKtq+umbTtsLXr6mZ8bm7+Z
         3IOA7DurRDMTl6QBVE8LOkG9QD3ez0kWGIKJ4xlq3OmNpQOvDaKPU+jdXmhfSP86mssb
         1XmbZi52GRozESpCh9wtR9znEdP1RC9wBIPEbwFO4HtS3FU5LHrPQCWrqHzpHz293s9h
         Vpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tJQKOiGB2vMuUqi1aD/KDeUab9z92lW/Lc4DaqZriqA=;
        b=JHl5aUc9t+/vK9AEbzombMk4dWJ0PbFdhQzoSWcoOwBIX2boUI6QL9ffdf9T1u8n1h
         bXp+PqnDLqIieckEyC3WD2bAvQGp2vq9MlFgmjqAzMWnaB/BXIPKU9EDm+JpOLRSw0Tp
         gFhbR5A/Cif99XFvMT/zN86zt1WNM54+pToQE1sMwa2omlU7bgbmELZox37YMqXeE2x4
         RI0ooVEAi5a5hbrMuvOvntt6VI+a2M+oYYRinbgV7XpEeltChmWLlYNDzvQM2Zc411UX
         CxInoiBWNsslnbEbQaQH2z/FOJj2CffM6SekFPC9DoS+Grm0sQH4BUQtUaI0IoSypmhb
         uxUw==
X-Gm-Message-State: AOAM530XRXrZCjt3R2tT7txZZkPT2XdNw1Q5obHmbX/S38PCMsktkQ4W
        5LquiWZ+RZ5/XvnCFfyihr8=
X-Google-Smtp-Source: ABdhPJyhyAw55KSiewZGLoxSdgQk1C3eR3BBScfSyS28Z3a9YLYF+FAAzifxgRGw/7mzEoByrErOFA==
X-Received: by 2002:a05:6830:22d8:: with SMTP id q24mr5291559otc.170.1637682665727;
        Tue, 23 Nov 2021 07:51:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2sm2226111otr.69.2021.11.23.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:51:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Nov 2021 07:51:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH v4 10/13] hwmon: peci: Add cputemp driver
Message-ID: <20211123155104.GB2184678@roeck-us.net>
References: <20211123140706.2945700-1-iwona.winiarska@intel.com>
 <20211123140706.2945700-11-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123140706.2945700-11-iwona.winiarska@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 03:07:03PM +0100, Iwona Winiarska wrote:
> Add peci-cputemp driver for Digital Thermal Sensor (DTS) thermal
> readings of the processor package and processor cores that are
> accessible via the PECI interface.
> 
> The main use case for the driver (and PECI interface) is out-of-band
> management, where we're able to obtain the DTS readings from an external
> entity connected with PECI, e.g. BMC on server platforms.
> 
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>
