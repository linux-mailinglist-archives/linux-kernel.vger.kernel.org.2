Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DEC45A704
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhKWQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhKWQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:00:38 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6566BC061574;
        Tue, 23 Nov 2021 07:57:30 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s139so45327651oie.13;
        Tue, 23 Nov 2021 07:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tDjoMJkmiCcFGdF6dcsQYg0MFBwPTTirRRHoT1oey7I=;
        b=F3h+p3rna1hgJMQ2amlf+ALUT7PuPQRM7rEmRW/imm8BDqtBQG4JoRrF1V9Tp2glRr
         U6t2ggtR4Fd1uYVhJPkOcUlzqnqXKrWbB+KuE1uGOt6ipPpCtoFnXsSDxYHn/dNJP8ke
         Izpox4iI3wq74SQSV+G7LR4wENLrD2IO1ucM4UDLVCCLxB9HNCTPuRjYUszH2gS3UC6p
         brm92l3sf68lTFh/owt4zVPiq2WRxkLUw8znWRHa1MomnmnsL37iFOz4W2JeMSab+mLR
         SMION44E+YLOBc32dEBpDxambbnB3gqr/RToWcm0ywR0XNic2D2WXbHNc0B2CdxR5yo5
         PpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tDjoMJkmiCcFGdF6dcsQYg0MFBwPTTirRRHoT1oey7I=;
        b=YgRa5pz4Jax4F9G8iQPLF60d1QQUSh7X+G7KlJVZ/Vw0AOer3QVJbQ/f0xCEgupg8G
         2N8Dk2zIpe174VRKBsDpEZi76aWUBlADM4GD8oRVlrFM3Xy39VwzV9fXYi94iZ9RuaBf
         wGaL+kE2ELlxvpSiFn4kw2vksx7H8Z6xb0QUCol3PArK+qHjStD51Wv/OtwcOp2DK3lG
         kdxaEQKVrtB2DRs9pxjAIz13M7WYH60+3OTDHs4/Mx3SIFfeJDpw2V1z1BMUo6aEvdDH
         k+Qf7VoFl9T1sOnrls76+Mu+fmPAc+D/2/HTSTsqCm5XsVEXF5qDdi8GqUkAm75ZC+3/
         6PQQ==
X-Gm-Message-State: AOAM533IcVQu/KOWLL7db7Yl0csMo9qmg48R+aFerrZnIgcMprTUGpOa
        6uVvgD5R26NkhCHReM1MBsme7qyZef4=
X-Google-Smtp-Source: ABdhPJyJEZGrtc0xcH378fpDYmIhdU3TWk/zSgIRsI4w8vfi4DX4cvdmiQV1eRnHYGTf+mpBnhA89Q==
X-Received: by 2002:aca:acc4:: with SMTP id v187mr3446169oie.35.1637683049879;
        Tue, 23 Nov 2021 07:57:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3sm2721498oiw.8.2021.11.23.07.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 07:57:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 12/13] docs: hwmon: Document PECI drivers
To:     Iwona Winiarska <iwona.winiarska@intel.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
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
References: <20211123140706.2945700-1-iwona.winiarska@intel.com>
 <20211123140706.2945700-13-iwona.winiarska@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d9dd9352-54e4-9837-b818-4bd38353e477@roeck-us.net>
Date:   Tue, 23 Nov 2021 07:57:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211123140706.2945700-13-iwona.winiarska@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 6:07 AM, Iwona Winiarska wrote:
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Add documentation for peci-cputemp driver that provides DTS thermal
> readings for CPU packages and CPU cores, and peci-dimmtemp driver that
> provides Temperature Sensor on DIMM readings.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


Acked-by: Guenter Roeck <linux@roeck-us.net>
