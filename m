Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB5319BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBLJLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBLJKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:10:10 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:09:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so5449964pfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XAYDMc2/fGV71iZYwesEww5xPiihWpiXeAmZAyvOe0k=;
        b=hSsb0sA9qQpjNsE1O9WW3n3zgpE9fpzB81h8j99+J32k+ZetDL8aV7g2Xnw1diPi+3
         /O9TzA6nFqLVjDMtZ4FUulDdOIyK18b29gZH9iGQ0ngFFF16O0wnvN7amLMJOF9XsRFY
         /h4WLS8edjsAJmgSPepLU1WiKv4aTlXIhF7u6vsMWVGlOEvL7mVlwdT8JC0oZW40xc5N
         fF4VmEh9dwgcztlN5HZE+JgqmHo5g/qHM54ahvkxM7fJbbEz+IQlCgsvsVjHvz+8kYFD
         rQ8uztveBTn86h/8VHnWk8eUKO/st+QUQXbbDftw4EuT47/dU4pjlzBjguefD8P2jfEC
         wbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XAYDMc2/fGV71iZYwesEww5xPiihWpiXeAmZAyvOe0k=;
        b=t8UrTKyKfsei7DYWhl1l/JvPZglqG4iuhg+i51s/4rCUsadWg2Tchq9EwyFXFlZt8n
         MFap1HP/CD7poS2dA+sFNo9UqHOAsFKVqo8+eMsUQnsAh7gfd9gNJ4hPDUzItttIoWsK
         QDE0t/TzriE76dYRpnoy/hKghgPFNmkZ3d7TLRS4yQ8B5K/rrbobzMK30kweVfNjZx+F
         TULQJNSBsVYroFiEww1e22uyjHd0fD8Cc7/5fuF9Awp+gAy29MCTsTOQVDJukNLb9cRK
         xN9lXF03KdDXyFshlpKFaYaLGbkQT4uDzszxEu6R1Bw+D9cIEUHIfzgRQjynk4351nHh
         GLkA==
X-Gm-Message-State: AOAM5306dbt0zkAm5emKATVjlakrR4++ASgFbsMPOOIjhR3p3h3trHjF
        XRiTn6sGHHCtSX/oWNInhu8PeA==
X-Google-Smtp-Source: ABdhPJxp/8XuwwBnaUORSj4eDUY++gP66F0IKT8Z2Gdj52KvxOWsoVMx9Y/TQ/f+hBeL6Ku5awMejA==
X-Received: by 2002:a63:3686:: with SMTP id d128mr2212533pga.240.1613120970332;
        Fri, 12 Feb 2021 01:09:30 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id lr7sm7067253pjb.56.2021.02.12.01.09.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 01:09:29 -0800 (PST)
Date:   Fri, 12 Feb 2021 14:39:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pritthijit Nath <pritthijit.nath@icloud.com>
Cc:     vireshk@kernel.org, gregkh@linuxfoundation.org, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: greybus: Fixed alignment issue in hid.c
Message-ID: <20210212090926.ox763j3btrqfzzzj@vireshk-i7>
References: <20210212081835.9497-1-pritthijit.nath@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212081835.9497-1-pritthijit.nath@icloud.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-02-21, 13:48, Pritthijit Nath wrote:
> This change fixes a checkpatch CHECK style issue for "Alignment should match
> open parenthesis".
> 
> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> ---
>  drivers/staging/greybus/hid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
> index ed706f39e87a..a56c3fb5d35a 100644
> --- a/drivers/staging/greybus/hid.c
> +++ b/drivers/staging/greybus/hid.c
> @@ -221,8 +221,8 @@ static void gb_hid_init_reports(struct gb_hid *ghid)
>  }
> 
>  static int __gb_hid_get_raw_report(struct hid_device *hid,
> -		unsigned char report_number, __u8 *buf, size_t count,
> -		unsigned char report_type)
> +				   unsigned char report_number, __u8 *buf, size_t count,
> +				   unsigned char report_type)
>  {
>  	struct gb_hid *ghid = hid->driver_data;
>  	int ret;

I can't even count the number of attempts we have seen in previous
years to make checkpatch --strict happy for greybus.

I say we make this change once and for all across greybus, so we don't
have to review or NAK someone afterwards.

Should I send a patch for this ?

-- 
viresh
