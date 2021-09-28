Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10AB41ADF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbhI1Lik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:38:40 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47725 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240172AbhI1Lij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:38:39 -0400
Received: (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 263B560003;
        Tue, 28 Sep 2021 11:36:57 +0000 (UTC)
Message-ID: <1d9d4de26d0c862acf3e579f14de9596027f3c3b.camel@hadess.net>
Subject: Re: [PATCH v11] asus-wmi: Add support for custom fan curves
From:   Bastien Nocera <hadess@hadess.net>
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
Date:   Tue, 28 Sep 2021 13:36:57 +0200
In-Reply-To: <20210907232232.5205-2-luke@ljones.dev>
References: <20210907232232.5205-1-luke@ljones.dev>
         <20210907232232.5205-2-luke@ljones.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-09-08 at 11:22 +1200, Luke D. Jones wrote:
> Add support for custom fan curves found on some ASUS ROG laptops.
> 
> These laptops have the ability to set a custom curve for the CPU
> and GPU fans via two ACPI methods.
> 
> This patch adds two pwm<N> attributes to the hwmon sysfs,
> pwm1 for CPU fan, pwm2 for GPU fan. Both are under the hwmon of the
> name `asus_custom_fan_curve`. There is no safety check of the set
> fan curves - this must be done in userspace.
> 
> The fans have settings [1,2,3] under pwm<N>_enable:
> 1. Enable and write settings out
> 2. Disable and use factory fan mode
> 3. Same as 2, additionally restoring default factory curve.
> 
> Use of 2 means that the curve the user has set is still stored and
> won't be erased, but the laptop will be using its default auto-fan
> mode. Re-enabling the manual mode then activates the curves again.
> 
> Notes:
> - pwm<N>_enable = 0 is an invalid setting.
> - pwm is actually a percentage and is scaled on writing to device.

I was trying to update:
https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/merge_requests/80
but I don't understand what files I need to check for what values to
detect whether custom fan curves were used.

Can you help me out here?

Also, was this patch accepted in the pdx86 tree?

Cheers

