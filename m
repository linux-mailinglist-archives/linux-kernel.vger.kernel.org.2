Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCD3FAAA1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhH2J6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 05:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234835AbhH2J6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630231079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0K+G7pfYO0Ef+fomYcLnNjeeXSOSFqS366JUpbEaV6U=;
        b=THaAbFr04UdfU+NlQUtoIRscJTuOI3Nq4pA5S/Pgp9YX08p80t2hjjTxAe3T2oop9/g68U
        em/qxk4jCKKQSvDTvr5fE5TadhFVRaV8l/V0iZERLCXOcoIehQfxIwhV5gKn5NOH1G+JWJ
        f7hbpPnFElo+A2YavPmdElWjmxnPuOo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-_ReyzQT6OeeXdFxWQ9-MBQ-1; Sun, 29 Aug 2021 05:57:58 -0400
X-MC-Unique: _ReyzQT6OeeXdFxWQ9-MBQ-1
Received: by mail-ej1-f71.google.com with SMTP id o14-20020a1709062e8e00b005d37183e041so2934000eji.21
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 02:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0K+G7pfYO0Ef+fomYcLnNjeeXSOSFqS366JUpbEaV6U=;
        b=nvzxdyEDECl9+hdw4IBAGWMoftIDKr5yy7euVFJUlSmwRNdzTE3t1SxdtS1J/oc302
         G8vBR3P8qd+sagXW/fbhm8SW+kmWtZafwv6Qw+cRW9/imKgyyizGmIIxydKMW+QgHF+V
         xWQyMIJ5WsGQldrlNS1Aeqw2SmW2fVA4gFtIDN7NBssVncZpvG2zem8ciYe7MkukWClq
         CS86zHZmFBY+fWKdhPCAqlq5ZK1uZjtuE/R7mmLyGTaj6IAnrfzbh+6mo6hliQnBGwJZ
         7NNeEYq4Kp3BHlwBIiMkmvsMRCmu//I1UpewVEA4X+zGZhymQm3Ful1INdxGY6vNot9v
         JiIQ==
X-Gm-Message-State: AOAM53151cMXoG0JwiyqvvczcEQzjCBGi1fmDRUZ3oqhcfpKU4aTwEN+
        7VvnUElhbS7N37X4Tf3wVOJ1WQvN9KeGZIDsY4apW+mdWQXgy8GbfSd4QhkpFWrcxl7tpEVtm3J
        bptnwKbV8NHOWaUExVdzyoD01
X-Received: by 2002:a05:6402:215:: with SMTP id t21mr18767571edv.68.1630231077201;
        Sun, 29 Aug 2021 02:57:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVWp8z2OSwJE2Z5L5H11RpYQbR14sREThd8a94tP6IStunw69DzeSddSDgABlBKEp9fnnxCg==
X-Received: by 2002:a05:6402:215:: with SMTP id t21mr18767565edv.68.1630231077055;
        Sun, 29 Aug 2021 02:57:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y20sm3177621eje.113.2021.08.29.02.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 02:57:56 -0700 (PDT)
Subject: Re: [PATCH v6 0/1] asus-wmi: Add support for custom fan curves
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     pobrn@protonmail.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org
References: <20210829071402.576380-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cf42ddd7-29ed-ff8b-7d03-958187863b70@redhat.com>
Date:   Sun, 29 Aug 2021 11:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210829071402.576380-1-luke@ljones.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/29/21 9:14 AM, Luke D. Jones wrote:
> Add support for custom fan curves found on some ASUS ROG laptops.
> 
> - V1
>   + Initial patch work
> - V2
>   + Don't fail and remove wmi driver if error from
>     asus_wmi_evaluate_method_buf() if error is -ENODEV
> - V3
>   + Store the "default" fan curves
>   + Call throttle_thermal_policy_write() if a curve is erased to ensure
>     that the factory default for a profile is applied again
> - V4
>   + Do not apply default curves by default. Testers have found that the
>     default curves don't quite match actual no-curve behaviours
>   + Add method to enable/disable curves for each profile
> - V5
>   + Remove an unrequired function left over from previous iterations
>   + Ensure default curves are applied if user writes " " to a curve path
>   + Rename "active_fan_curve_profiles" to "enabled_fan_curve_profiles" to
>     better reflect the behavious of this setting
>   + Move throttle_thermal_policy_write_*pu_curves() and rename to
>     fan_curve_*pu_write()
>   + Merge fan_curve_check_valid() and fan_curve_write()
>   + Remove some leftover debug statements
> - V6
>   + Refactor data structs to store  array or u8 instead of strings.
>     This affects the entire patch except the enabled_fan_curves block
>   + Use sysfs_match_string in enabled_fan_curve block
>   + Add some extra comments to describe things
>   + Allow some variation in how fan curve input can be formatted
>   + Use SENSOR_DEVICE_ATTR_2_RW() to reduce the amount of lines per
>     fan+profile combo drastically

Thank you for your continued work on this. I read in the discussin of v5
that you discussed using the standard auto_point#_pwm, auto_point#_temp
pairs. I see here that you have decided to not go that route, may I ask
why ?

Regards,

Hans

