Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7975B40B295
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhINPKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhINPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:10:19 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C9C061574;
        Tue, 14 Sep 2021 08:09:02 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so18881545otk.9;
        Tue, 14 Sep 2021 08:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sg7LDb7clu8dL1nFJb4uHjtJUIj2GDqVqsngLGbcYjs=;
        b=MbCzzKC0XDB2q5FOYC1yE5Wlb3L+jpDDIyIUM1SsJYH8PfHaRxh0oD0a+/gD9bw88N
         wGqVY6FQYRYqBJL6QAF5nIfQxCZhlcFVLnkSZSKovQciFMe+Mpf7NIOU+/wWskEOiP3p
         TbtTKjbVNeUaVnZSGTQzrXybDgcj5mbmUWHhloh4YMTQttDZF0A21ME2Gd/2rBDTspTA
         I78Me/rzibAq4C24kS65eyVt7R90M0wpz4obRsK0iomF2BcwWMn5FCWtCpVWr3ZDp0uR
         lxHUIXwhe8/+oa1Ur9Yfi+ns3nypvKNn5mX9JxVJWVXi/pKOVi/wDx0aNKLLKtW6Fvet
         S2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sg7LDb7clu8dL1nFJb4uHjtJUIj2GDqVqsngLGbcYjs=;
        b=CM25rfQk1yh1fV+zltZ8THeP82Ka7eoEgWc8JSKctobEUfFKQym7gSBX/GufzxZVKH
         p+dJNAdC7DNyzVHGdusy9VRhaWAful8nNkWI16SXzPkeDqo26v4SeW82z9IffHkmGGGJ
         NBZqNCz04tedvQ/o/Z9W+SUvSJnRuTd50oGhCIEUvnilFnEwkkKNIUOsmc3irLhp7HLs
         pU4AZXd43JjlG1+Z5PfBj0tp3sWmHrJzj7h9bavmHeaDIzt7/fDGelwDztWFRWzuw1PN
         xQAjJ3kJ8YSRLEKB/CN67NWxHnOxkl+EZ3CESQRILXOdeUmtM6OkTnM1NCC0mNxk9fOV
         9B3g==
X-Gm-Message-State: AOAM53381Ze9yCGzrlK552IqMEhaCj+TiPutb534PNzafBq+y5AoJArX
        hmz662aWEC/RJWvAJFZdOay0QiEGexM=
X-Google-Smtp-Source: ABdhPJw3DWNsO/lWEWxG6QOPO0x9juHGzb/cQVeGjmug85LLqElS9k6e2lYsW4M5azePNVV8GfXxdw==
X-Received: by 2002:a9d:7052:: with SMTP id x18mr15006845otj.78.1631632141983;
        Tue, 14 Sep 2021 08:09:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm2692610ots.61.2021.09.14.08.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:09:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Sep 2021 08:08:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oskar Senft <osk@google.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <20210914150859.GB3457579@roeck-us.net>
References: <20210910130337.2025426-1-osk@google.com>
 <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
 <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net>
 <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:41:36AM -0400, Oskar Senft wrote:
> Hi Guenter
> 
> > https://lore.kernel.org/linux-hwmon/cover.1631021349.git.krzysztof.adamski@nokia.com/
> >
> > That specifically includes the ability to enable or disable channels
> > using the standard 'status' property. While that series is primarily
> > for the n-factor property supported by the tmp421, the same approach
> > can be used for [temperature] sensor properties on other chips as well.
> 
> Good pointer! I should be able to replicate that for the LTD (@0) and
> RTDs (1, 2, 3) in a similar way.
> 
> > I put [temperature] in [] because we'd need to find a means to express
> > if the sub-nodes are for temperature, voltage, or something else, but
> > I think the basic principle is sound.
> Following the example from tmp421, this could then be like this:
> 

Something like that, only we'll need something to distinguish
temperature sensors from other sensor types, eg voltage or current.
Maybe a "type" property. I'd suggest "sensor-type", but we have
non-sensor attributes such as fan count and pwm values which should
be covered as well. But it looks like a good start for a set of
generic sensor properties.

> i2c {
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     nct7802@28 {
>         compatible = "nuvoton,nct7802";
>         reg = <0x28>;
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         /* LTD */
>         input@0 {
>             reg = <0x0>;
>             status = "okay";

Not sure what the default is here ('okay' or 'disabled').
We'd also need to define what to do if there is no data
for a given sensor.

>             /* No "mode" attribute here*/
>             label = "local temp";
>         };
> 
>         /* RTD1 */
>         input@1 {
>             reg = <0x1>;
>             mode = <0x2>; /* 3904 transistor */
>             label = "voltage mode";

That isn't the idea for "label", as "label" would be expected to
show up as tempX_label (and a label of "voltage mode" would be odd).
The label should indicate where the sensor is located on a board,
such as "inlet" or "outlet".

>         };
> 
>         input@2 {
>             reg = <0x2>;
>             mode = <0x4>; /* thermistor */
>             label = "thermistor mode";
>         };
> 
>         /* RTD3 */
>         input@3 {
>             reg = <0x3>;
>             mode = <0x3>; /* thermal diode */
>             label = "current mode";
>             status = "disabled";
>         };
>     };
> };
> 
> I noticed that "nct7802_temp_is_visible" only allows the temperature
> sensor to be visible for current and thermistor but not voltage. Is
> that right?
> 
No, that is a bug.

> Before I go and change the driver further, I'd like to make sure we
> agree on the interface.
> 
> Also: Is nct7802_temp_is_visible called again after temp_type_store
> was called (I didn't try it)?
> 
No. That would not be the idea. If enabling / disabling a sensor
is supposed with the _enable attribute (and/or with devicetree),
the affected sensor should always be instantiated, and reading
sensor data should return -ENODATA if the sensor is disabled.

Thanks,
Guenter
