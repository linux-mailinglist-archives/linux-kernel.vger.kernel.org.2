Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9DF41355D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhIUOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhIUOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:32:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3577C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:30:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t8so32808394wri.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qX3le7wOgeftfqn2Wh3W0qvOcl91OK3fsnMrCfg1wOA=;
        b=a2bQ3quHcXAqfWR7bWKiuP/2m3S6kuQVdxfdIYt/w+XEt2/mqBSzj4Qcf8UzRk2Eqf
         9+yu/MgiBzXBN40/29utalH68jOG7UBAAXfpybGON6WTKfWVmTn7c50lIp0mcAvcFGrU
         40clPI9JEAEVZuR+y58976MQtGMHWXc7yJcBDm1UTW5AERn+zsqMEdto0ww8hNmoQOsy
         ev5whuXjJOPPlkJrJEsIKMJ+AFNzJuCZf+60Tm6d3QOsOR3xH26MH6YeBAtp/xRRzxES
         vHN88AgJOczyrO6luhegZWHVEzPScLv4TgdWOIDfguzQ9Tlkb2V7XoXzNhAUgONI4K4g
         7+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qX3le7wOgeftfqn2Wh3W0qvOcl91OK3fsnMrCfg1wOA=;
        b=NIVCNP5FnLCQZNC7R4ZjkqTBthf3CWWs+6ZrJqZv7a37zKseuegmto4u5E/jDkQaxU
         KxLlU1EW6cuKxH12QlRBTzWdcBJhz3X6rwMBBnA8hG3SKyJxW22KecJp1ZuUjirkagx8
         9wE4J65DxOqjMLvEkSpwpBFodrWODvADVim1c4j0mYSfDb90qTyEJmtlmt1BbPdPjvuN
         ofBJsu0qEYTzoB1+XQ/OHLuvwOL4MsfuU+ivVLy51dq6xeZF8yVjlrmDl08dwLR08obw
         tsxrkAjKgI1z1RDBbFiGIZNZt7eINIICKOUZWq9dI+wNpopAV5SWm89kwzcAw32Y+E0B
         52/Q==
X-Gm-Message-State: AOAM530MlmXNyzvbLsxv7/A+AoNqPQAj4vzZzh5q8LkvL7G8T2ISvQNl
        KGwyHSoBfW2avhLATRInJS+dFshihAtMHw0X
X-Google-Smtp-Source: ABdhPJxCWG9Ylqms+1YIcO4oTOIslX8p5xuTX1I5380V7ogmjD3HUQIaS6R4pd7uxqilqKN4JPZfjw==
X-Received: by 2002:a7b:cbce:: with SMTP id n14mr4957433wmi.169.1632234641772;
        Tue, 21 Sep 2021 07:30:41 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:19bb:c937:2c91:f02? ([2001:861:44c0:66c0:19bb:c937:2c91:f02])
        by smtp.gmail.com with ESMTPSA id i2sm18915269wrq.78.2021.09.21.07.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 07:30:41 -0700 (PDT)
Subject: Re: [PATCH 0/3] drm/omap: add crtc properties
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210921141654.66550-1-narmstrong@baylibre.com>
 <44ecbd74-b125-6f96-316f-c79dfc052af2@ideasonboard.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <164729eb-c491-4d0f-ce5e-8eeea89d3ece@baylibre.com>
Date:   Tue, 21 Sep 2021 16:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <44ecbd74-b125-6f96-316f-c79dfc052af2@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 21/09/2021 16:28, Tomi Valkeinen wrote:
> Hi Neil,
> 
> On 21/09/2021 17:16, Neil Armstrong wrote:
>> This patchset adds the following CRTC properties:
>> - background color
>> - transparency keying property
>> - alpha blender on DSS3
>>
>> Tomi Valkeinen (3):
>>    drm/omap: add crtc background property
>>    drm/omap: add crtc transparency key property
>>    drm/omap: add alpha blender property
> 
> Nack, these don't comply with DRM uAPI rules. That's why I never sent them upstream.
> 
> https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-userspace-requirements

Thanks for the reply, I was wondering why !

Neil

> 
>  Tomi

