Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C86142A5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhJLNaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhJLNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:30:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31772C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 06:27:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id y3so33926624wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 06:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yuAFR7oMHRERVT1WGTjSkKtVpWlYtL7mEybz0eaEJQw=;
        b=YWgpR0MZYC7zaEcbKQlIoGR8mr+wX6ADq20a1X7bm05FQL8idhvBujWscs0dVE/f0Q
         BbPMcOzpfBEAa+tsTFNb9HdWppnUKjgUyyBnzF3Y+dplyItf0wSyoTAYQmUp5kLHWYAK
         GMvuPyoRT8nT23pb+sYrGXUDbQAO5HRbtkKrTDbvY3W97eNbUtMNknOM4dhf3VzY1x37
         9DDXuC9YmLK8nb9WusYGlu1NaAUtwO+AYvQ8982XhjzqH/9k6/5KxzPSeTuQ0mPLiTIw
         65Dojhc+OfqNmxpB42ewuT/so6thSrpHV+FXcrGmwWjKmfwUKWsVOyI4vOfGq1nF8OvV
         5NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yuAFR7oMHRERVT1WGTjSkKtVpWlYtL7mEybz0eaEJQw=;
        b=CxPThXDh8Bo4mZW/fwcMmFNZqCUSIlyVa2msRaLY60pQ8BjMEomHy+eZcGBAMlOXBW
         WWdhHrWg307dwhnUiUDykZsT0hqvxAzzCE2+QuMIx+2gJqGjR7AmLOTA87ypycmcyl5t
         K1+F7z2qeBWz8r7zWL8BZi/V+DgXtR++yuu5HkQ2N1Yy9ymY2aZFHD7O+SiC7Eo/i5jN
         Vn5Igi91IU1dPu0OLQs4sCf5UhTYGi/NTYzGyvcQFBeYauQnx1ZDRiIPRO4peHuQJOA7
         a0dqZD7hUmrX9EsHMnGTh/nrb6VcJFdJkIpRuYS/iM8OAuxQINmzr01zlLF0N+ad59vo
         2Ebw==
X-Gm-Message-State: AOAM531B7Dq+VuzLoDGm/tKa0jiWcNca12e2BqNHrgG2CrsAssJenvr4
        zyxTArhRG3mtjopbFBMhK5vG4A==
X-Google-Smtp-Source: ABdhPJxyMFv4LLCVKv9M3X6ZNauRpw5RZnr8yVPSg7Qb/W5sbaSAUD1op7cDnt+nL/nsEaD5mL2hsg==
X-Received: by 2002:a05:600c:4f92:: with SMTP id n18mr5670479wmq.22.1634045277651;
        Tue, 12 Oct 2021 06:27:57 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:4e93:9fa7:4d66:4f5c? ([2001:861:44c0:66c0:4e93:9fa7:4d66:4f5c])
        by smtp.gmail.com with ESMTPSA id z1sm1499817wrt.94.2021.10.12.06.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 06:27:57 -0700 (PDT)
Subject: Re: [PATCH v5 0/8] drm/omap: Add virtual-planes support
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
References: <20210923070701.145377-1-narmstrong@baylibre.com>
 <e7c295be-7a0c-877c-ba25-3b580d7d9521@ideasonboard.com>
 <a4e72823-6e92-cce1-0607-5506ddda42fa@baylibre.com>
 <99c11b0b-eab8-a7b9-8aab-8cc06be14cd5@ideasonboard.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <e5c37525-b150-2a8f-25f8-c3db3e249bf2@baylibre.com>
Date:   Tue, 12 Oct 2021 15:27:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <99c11b0b-eab8-a7b9-8aab-8cc06be14cd5@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/10/2021 12:36, Tomi Valkeinen wrote:
> On 12/10/2021 11:30, Neil Armstrong wrote:
>> On 12/10/2021 09:15, Tomi Valkeinen wrote:
>>> On 23/09/2021 10:06, Neil Armstrong wrote:
>>>> This patchset is the follow-up the v4 patchset from Benoit Parrot at [1].
>>>>
>>>> This patch series adds virtual-plane support to omapdrm driver to allow the use
>>>> of display wider than 2048 pixels.
>>>>
>>>> In order to do so we introduce the concept of hw_overlay which can then be
>>>> dynamically allocated to a plane. When the requested output width exceed what
>>>> be supported by one overlay a second is then allocated if possible to handle
>>>> display wider then 2048.
>>>>
>>>> This series replaces an earlier series which was DT based and using statically
>>>> allocated resources.
>>>>
>>>> This implementation is inspired from the work done in msm/disp/mdp5
>>>> driver.
>>>>
>>>> Changes since v4 at [1]:
>>>> - rebased on v5.15-rc2
>>>
>>> What is this based on? Doesn't apply to v5.15-rc2, and "error: sha1 information is lacking or useless".
>>
>> Indeed the sha1 info is useless, it's based on v5.15-rc2 on top of "HACK: drm/omap: increase DSS5 max tv pclk to 192MHz"
>> in order to validate on 2k monitors.
> 
> I'm personally fine with removing the HACK from that, and applying it too. I used the patch for a long time without any issues. However, I never found anyone to confirm that 192MHz is fine (or that it's not fine). Too old HW for finding HW engineers to look at it =).

Indeed it seems to be applied the TI trees for a long time now, will post it.

Thanks,
Neil

> 
>  Tomi

