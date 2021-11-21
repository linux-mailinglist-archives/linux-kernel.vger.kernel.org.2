Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF94584A2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhKUQSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 11:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbhKUQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 11:18:31 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0445C061714
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 08:15:26 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id j21so10038964ila.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 08:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=wYeCOd7p9kGBj7Q3Ct50Rhv3BWXTno7uUCRuqGjaPE4=;
        b=Q0yjIr8PAv1CU/miCaAGvQjCI5kOmOPSd4pZ29k4AEDg4yIkHgQMG25KFupr0/rWJd
         tBWpsmFKzXIL4PrM9gLwpsbdHvWmZ3jSDwCiJGDs0oObqwZ3aqf8Khv9jUflsHP5Ts6P
         jMqJa1+7D1oU1eIJ6OTwDVDGnb/UnyKN71ufWWR0du4HrMzH4xm9BRo7qRDypN+mToee
         RV3Or4olZGju35RzUCXTaGI3in31KGYFUaPx9uV57spxMnoNMUwXJr4VN2aCMbINFv10
         49yjfoGHGvRuoqZezEsqlIZ1Drj8YkfNMCjey8h4uemDMrQpT4TMbykNFK1PRrXC1sbm
         NEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=wYeCOd7p9kGBj7Q3Ct50Rhv3BWXTno7uUCRuqGjaPE4=;
        b=DrHbXukYPSsw9eOothQKWBFoEpkAsuJ2RWNScfYKX2H4uFT2Z1UYVzgzM6NsBT/unB
         +Na3Dba5xBpAp0nLcGXA2ji2Po2qkfurtNNEiu5cFMbXGQT+88ms5Pin3msjxLBAnzpa
         SdFaQQsACD5CUacOClxfP6HnXunHus1/TvipFYKiL2x6T8eqpGkAxGp/pRZIUlYLvqDg
         9eLiSTE/NNb52j9RX4UTEn3zK5mbRFQ9PHfF6G/a2yxPESQbMs7+1vJo1YhVHTyVqUa2
         alRAcsWUoXxUD/B+OnjLiLBXRK6asyMTE1M3AiEQKBiY6To1+3Zb3vM17LCP8vpg6rVE
         4S+w==
X-Gm-Message-State: AOAM531Guc/kmPSsixHb/MmwrhjCFdt98iThOpz3GgdRUh2bXArXbjqC
        g7mXkNZ/XhKTLT4wEzYrByKT
X-Google-Smtp-Source: ABdhPJx2we4xVeYk90vEZ5TVQsea/Kd8ENExI5kvo/4/A4Q/OPPwiF6+dgPl4HC/IZCFEKWGcL6NAA==
X-Received: by 2002:a92:cb11:: with SMTP id s17mr13105062ilo.321.1637511325854;
        Sun, 21 Nov 2021 08:15:25 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:2ba9:697d:eeec:13b? ([2601:281:8300:4e0:2ba9:697d:eeec:13b])
        by smtp.gmail.com with ESMTPSA id r14sm4534186iov.14.2021.11.21.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 08:15:25 -0800 (PST)
Message-ID: <5c6986c4e0c6ff34bfaf94c30b79c7f3dd21d1a3.camel@egauge.net>
Subject: Re: [PATCH v2 2/2] hwmon: (sht4x) Add device tree match table and
 document it
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Navin Sankar Velliangiri <navin@linumiz.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Nov 2021 09:15:21 -0700
In-Reply-To: <20211120215148.GA1291159@roeck-us.net>
References: <20211120204053.2299501-1-davidm@egauge.net>
         <20211120204053.2299501-2-davidm@egauge.net>
         <4ebe1f6a-575f-2d34-7839-9055545e5e6b@roeck-us.net>
         <5f5798b3f021c419e94714ba557be0e3a40c671e.camel@egauge.net>
         <20211120215148.GA1291159@roeck-us.net>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-11-20 at 13:51 -0800, Guenter Roeck wrote:
> On Sat, Nov 20, 2021 at 02:36:39PM -0700, David Mosberger-Tang wrote:
> > On Sat, 2021-11-20 at 13:12 -0800, Guenter Roeck wrote:
> > > On 11/20/21 12:40 PM, David Mosberger-Tang wrote:
> > > > This patch enables automatic loading of the sht4x module via a device
> > > > tree table entry.
> > > > 
> > > > Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
> > > > ---
> > > >   .../bindings/hwmon/sensirion,sht4x.yaml       | 50 +++++++++++++++++++
> > > >   drivers/hwmon/sht4x.c                         |  7 +++
> > > 
> > > This needs to be two separate patches, one the devicetree change and the other
> > > the source code change. DT maintainers need to be copied on the devicetree
> > > patch.
> > 
> > Isn't that going to be confusing if one but not the other patch makes
> > it into a repository?  Either you end up with an undocumented device
> > tree property or you end up with documentation for an unsupported
> > property.
> > 
> This is a trivial device, so that isn't really an issue. Otherwise,
> if there are real bindings to approve, I would not accept the patch
> making the code change unless the devicetree patch is approved,
> and I would typically apply both together.

Got it, thanks for the explanation.

  --david


