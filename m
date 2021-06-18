Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF393AD213
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhFRS2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:28:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhFRS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1luJCC-0006jZ-0q; Fri, 18 Jun 2021 18:26:24 +0000
Subject: Re: gma500: issue with continue statement not doing anything useful
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9eff854f-92ed-3f09-997f-f81c78a8b5a3@canonical.com>
 <CAMeQTsaWZ8Y+sMr4BMS0r_xdwz3hJ+KRT3byyJmq+OeEo=5F1g@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <85da780c-404b-dd23-c9ab-39c139e717da@canonical.com>
Date:   Fri, 18 Jun 2021 19:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMeQTsaWZ8Y+sMr4BMS0r_xdwz3hJ+KRT3byyJmq+OeEo=5F1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 12:19, Patrik Jakobsson wrote:
> On Fri, Jun 18, 2021 at 12:26 PM Colin Ian King
> <colin.king@canonical.com> wrote:
>>
>> Hi,
> 
> Hi Colin
> 
>>
>> Static analysis with Coverity has found a rather old issue in
>> drivers/gpu/drm/gma500/oaktrail_crtc.c with the following commit:
> 
> Relevant code is in drivers/gpu/drm/gma500/oaktrail_lvds.c
> 
>>
>> commit 9bd81acdb648509dbbc32d4da0477c9fae0d6a73
>> Author: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
>> Date:   Mon Dec 19 21:41:33 2011 +0000
>>
>>     gma500: Convert Oaktrail to work with new output handling
>>
>> The analysis is as follows:
>>
>> 114        /* Find the connector we're trying to set up */
>> 115        list_for_each_entry(connector, &mode_config->connector_list,
>> head) {
>> 116                if (!connector->encoder || connector->encoder->crtc
>> != crtc)
>>
>>    Continue has no effect (NO_EFFECT)useless_continue: Statement
>> continue does not have any effect.
>>
>> 117                        continue;
>> 118        }
>> 119
>> 120        if (!connector) {
>> 121                DRM_ERROR("Couldn't find connector when setting mode");
>> 122                gma_power_end(dev);
>> 123                return;
>> 124        }
>>
>> Currently it appears the loop just iterates to the end of the list
>> without doing anything useful. I'm not sure what the original intent
>> was, so I'm not sure how this should be fixed.
> 
> The code assumes there is only one correct connector so when iterating
> over the connectors it checks for the connectors that does _not_ match
> our criteria (!connector->encoder || connector->encoder->crtc
>> != crtc). When the loop is done we end up with the correct connector set in the connector variable, hence the immediate check of "if (!connector) ...".
> 
> So the code is correct but perhaps unintuitive. You could do the
> opposite (if that makes more sense to you):
> 
> list_for_each_entry(connector, &mode_config->connector_list, head) {
>         if (connector->encoder && connector->encoder->crtc == crtc)
>                 break;
> }

OK, that makes sense. I'll send a fix for this shortly
> 
> -Patrik
> 
>>
>> Colin

