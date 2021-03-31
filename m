Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF5350536
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCaRDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhCaRDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:03:36 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0A5C061574;
        Wed, 31 Mar 2021 10:03:34 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so19580817oty.12;
        Wed, 31 Mar 2021 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=icCui8rsqz/tZGuqEappDQq0xmAo0yV1kkUMAs4W6mM=;
        b=lWkRYdwjN4R7a+YXGLKqNOjWFhOTt/d0OvDEB5z0cJe9KAne1AWbgnC2XXua+Qems8
         3htL7bJWDd49YxdFy9ylkC7LYfhtBZzz4tDtewpMjuhoTZVKfzqMCew8WSuvdUeGg4mL
         VBIGiKQkQxc809kXWXKLgJNWwJFyH7pxWWyjksm0K5LUt/bwvkXTntpJ/J9qAg8RH1gv
         v8L2tiEdP9bxfLYbBdWqTPegivRiN9nXdA32vIRHX9es5hn0LncmoDFl9eJPEDGJkOhC
         I37CuJi9mLUljjBT7XFihtmUt6oC4dFSkZMJyzb9zYiC4SvYIuZoEtAvM8cu07I9rPTk
         PbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=icCui8rsqz/tZGuqEappDQq0xmAo0yV1kkUMAs4W6mM=;
        b=M714+RzHhIG06H2SaoVwaGrAZbVl+6Q3XLjgAanGqOh9LOE5XhypqXs1Ugysf9hPj1
         X+R5J2UAEYhS/CSgMs5WsjyJSwBZh9QZFf1MxU+z6Sd7azlpiIGiUXfXkj/FN/4t/eyC
         W6BrmQsFtRMPMxednQd8l3/uOrDx5WCvXv8sa0XbqHPhznbP50MooeDxnK5S99MHCE9W
         aFacsKajdLFPz1hEegroKmmWIS1aqXSZ+jsZCPke25oNhCk4MErg6CvaQ/G7/sNNuhOL
         vh2hLxKXhGDPEsMX2d6GjbLnoOAxUT/3F02R2an3YB7ail11bvssRQ25etmYf8fqxnA8
         FiPw==
X-Gm-Message-State: AOAM53161zk5neZt4qfb3STrD8wSaKqX7/0RTRHEX19PLuQj1KhILdXz
        XqC11ho6QMnkL3kEUiiFcGfdC9LMcGg=
X-Google-Smtp-Source: ABdhPJyNTGAp7fsGtz96x/wu2SORusHzRcFhma/siMAT21Wv+R0xKGHN0pBqYoy3PJsb4on0w5u/vQ==
X-Received: by 2002:a05:6830:4121:: with SMTP id w33mr3325233ott.153.1617210214189;
        Wed, 31 Mar 2021 10:03:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j4sm517394oom.11.2021.03.31.10.03.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 10:03:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 31 Mar 2021 10:03:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Sebastian Oechsle <setboolean@icloud.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell Latitude 7440 to fan control
 whitelist
Message-ID: <20210331170332.GA25389@roeck-us.net>
References: <EE8F83B0-0C39-4E2A-B5FB-B94A1389588D@icloud.com>
 <20210331100211.jo56p4x2qm73fyed@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210331100211.jo56p4x2qm73fyed@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 12:02:11PM +0200, Pali Rohár wrote:
> On Tuesday 30 March 2021 19:02:55 Sebastian Oechsle wrote:
> > Allow manual PWM control on Dell Latitude 7440.
> > 
> > Signed-off-by: Sebastian Oechsle <setboolean@icloud.com <mailto:setboolean@icloud.com>>
> 
> Reviewed-by: Pali Rohár <pali@kernel.org>
> 
> (Btw, in commit message is small typo, model name is E7440, not 7440)
> 
> Guenter, would you take this patch?
> 

I'll take it.

Guenter

> > ---
> > drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
> > 1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > index 73b9db9e3aab..2970892bed82 100644
> > --- a/drivers/hwmon/dell-smm-hwmon.c
> > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > @@ -1210,6 +1210,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
> > 		},
> > 		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> > 	},
> > +	{
> > +		.ident = "Dell Latitude E7440",
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E7440"),
> > +		},
> > +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> > +	},
> > 	{ }
> > };
> > 
> > --
> > 2.31.1
