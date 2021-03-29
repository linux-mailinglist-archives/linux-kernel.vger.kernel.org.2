Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0834D9DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhC2WGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhC2WFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:05:46 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC066C061574;
        Mon, 29 Mar 2021 15:05:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n8so14511839oie.10;
        Mon, 29 Mar 2021 15:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cXchIXgTru6lEgHh29ZMONP+CbdmGHjLyQHJAiTIW2U=;
        b=a8Cr1k0CycqQLM2Ma1U9jdbx2hGmZw0zeVt2SeUQgvIDR6B4k7uEbkGC+GWzMeSDsu
         QMECj1qhIhsYmzPpshZPD6wLgusTOUlYjx6wn9saMpRTlI+3+pNc36F87X5p/I3WlmLq
         qqYUmzxf4mtfEoX7NqE8t72wPIf1Rytxbx4405JrzBbApg54M/3WNtn1gRlILnDgwhGX
         EhFXF7a1ntP7WU4y0G0SPZdBxHDDkKgGxaOVNzts2MlI/JYfVIdVqQMzWE4XtNfgrTG4
         xhmpeBYGLMGVD/UGtBCaLjhFY4vc6rIKrlV80Hm4t6WVsAYhxpSmc0vNA8fefOzS/LYn
         1mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cXchIXgTru6lEgHh29ZMONP+CbdmGHjLyQHJAiTIW2U=;
        b=A+85LCX+xAfcPg5c29JSTKzbYahTB+xYoeB/UjJOHPGUVGQ88F7Wm6cbRd31Zii7Js
         KCLqVW4zvr6/JfNhWPWBhbC7iywk86aTrmHNumli7lthkBuBEnaHqCaSQ9yKBRLjqfl5
         de0XaNQbGI5TPye/VzH2eKnNyqabAxHqj6DggUUwQ2HNvtfCod71K4tuHFXc4LVSztp8
         wE5MOUDfmyHaBkQzccHkHFkzrIeB3d3Oj85fB44H3o6d4VZm9aZIHoCLaJVyjl608KIT
         kR50cEKidskl02xNFpoXEu0+321bktAtei06ahMjqUNY0kmISRZzGM4X93zraR29x0jl
         FU5A==
X-Gm-Message-State: AOAM532M1zv7bUz6mp5bBE67S6C0zoL7XqnKlJPQGoEYOiK0hzv8eZXX
        pVlLG7Gjf9NRA0R6zObeKmw=
X-Google-Smtp-Source: ABdhPJztdEBSSuQSZFsyRHJNepwudmEUHnZH93iM79LGeDyrlm+PTSp84wHRniJzrNJifnCiFGpykg==
X-Received: by 2002:a05:6808:146:: with SMTP id h6mr905260oie.118.1617055546217;
        Mon, 29 Mar 2021 15:05:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g13sm4648933otq.3.2021.03.29.15.05.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Mar 2021 15:05:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Mar 2021 15:05:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] hwmon: (pmbus): Add driver for BluTek BPA-RS600
Message-ID: <20210329220544.GA222182@roeck-us.net>
References: <20210317040231.21490-1-chris.packham@alliedtelesis.co.nz>
 <20210317040231.21490-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317040231.21490-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:02:31PM +1300, Chris Packham wrote:
> The BPA-RS600 is a compact 600W AC to DC removable power supply module.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter
