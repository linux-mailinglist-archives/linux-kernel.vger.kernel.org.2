Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427C2400C4D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 19:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhIDRte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 13:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbhIDRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 13:49:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFD1C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 10:48:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e16so2138743pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2j0yq0jM3MZ9jblvvClEiJOQFOZ/XchJrAeqMTqqoK4=;
        b=OOz/bMwmpdjR8/tDKvrWwRWIBNZJiX/9J+UlkbUfUdfS0TpqF5f83+l55pUbOcG2Hx
         I65dKckVijdktVYlmuc+Q2l/bCxvkXugg8qbtGcfLm2ko2/HAc1ooyS4phTg/KRhWNqe
         eL8kwKm4o1c8kxsX4PpLEQ7Op8s0WBWEGn3lJ+EYnAXHA+ShKf3wztNFtIGHnMRVLY1I
         a1LRdaE7cvOmZ4oStjnPKp6Fox4cC1WllwcZIgzlAuZ/IocLLuapkWfxL6TuOYJXqeLP
         n/2oIfnHXhStnmLAkNJxtMrbfBAR2CUAtlgyOJgVsbZISvoMNHtpuIIiZUdd63wL0Wol
         yWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2j0yq0jM3MZ9jblvvClEiJOQFOZ/XchJrAeqMTqqoK4=;
        b=Vcle867FtfRUkchOYvFsLoRzlK5gCuJvkAYI/7TdtIQOUw/GkpXepvaJKWo3RfjDBg
         Ee0gYv/W/wyaVdPyl4pTtSnk+NNx0aTO4jWRuN8iIgJ/6Ug6xYRIErgHG3zcPRtxJyZE
         o01jWpHFZDTOMaNxozsWsPmz1phZiDxbuAUMk/xkU38fVkxtwwvbJLCvOudVRYIhIll4
         8YMmpm5AjvNvlWchO+XuYzjR/IRPkgcpQm4SX2oUNbd4NGTXXsGSb8jb/pGW6hx9Y2w6
         tmTB9HUeQMdAadSXRkyh0YLrFf3rsSlsq+SWQp+GcZnslOgag7GLEIlwOgjeRaLSORaY
         S4Sg==
X-Gm-Message-State: AOAM533L9P/yGxO9HyP3eabxQhKnYkdkx6V2/Pd/i+6SO4gAN4qTki5J
        40O8g5+FV5+LWAahUBbsEZQV279i+8GOOg==
X-Google-Smtp-Source: ABdhPJwMmxuBzTZCIxTwlT3WiJKpNjQ772DDtIoUu2F9iPyi+m7GZZVHTl/TEMJA7gizt8u2yATduw==
X-Received: by 2002:a05:6a00:1a03:b0:414:5c97:777a with SMTP id g3-20020a056a001a0300b004145c97777amr1870773pfv.58.1630777694821;
        Sat, 04 Sep 2021 10:48:14 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b20sm2703128pfo.3.2021.09.04.10.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 10:48:14 -0700 (PDT)
Subject: Re: [PATCH v2] cdrom: update uniform CD-ROM maintainership in
 MAINTAINERS file
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org
References: <20210904174030.1103-1-phil@philpotter.co.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea1cf28e-bb38-94a3-5032-4302cec4c30d@kernel.dk>
Date:   Sat, 4 Sep 2021 11:48:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210904174030.1103-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/21 11:40 AM, Phillip Potter wrote:
> Update maintainership for the uniform CD-ROM driver from Jens Axboe to
> Phillip Potter in MAINTAINERS file, to reflect the attempt to pass on
> maintainership of this driver to a different individual. Also remove
> URL to site which is no longer active.

Applied, thanks.

-- 
Jens Axboe

