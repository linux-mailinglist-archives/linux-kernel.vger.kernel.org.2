Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB630F34E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhBDMl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhBDMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:41:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA65C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:40:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d16so3270623wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=64Odycx55fXWJ9DTcxk1MDYnJPu/Ei16vGB2nFXKKDs=;
        b=QnIJfIeELhd2DJxZRhsEbuSaMIoBm0Sn402NgqI+4hX17Hmz2VKfQzF4C390gd9vUK
         al5/p4LxDW+qNiY+Bc/LVqOfYUsXG0GVESICaIl5BuRoYxLYCzMNYz09+zLl1PCNqtQK
         9QOLnlMJnyasDrYogtEVzOCZrLclCAr20W6++bSvdqCS0iks0vrFz1cMz+FTtrY2pK9K
         O5hy9uUoKMdoJ9Omr/hrmAOp51fPVTnhsjbP/oE9CjjwyDWLyTLtlB/WkIMpYtvXogUL
         OPz9gYYK6ZhISlvnvVo7EOdheIiU8gbIioNj792TMzozwhn6nel/u6bUGh97PKVigYeV
         KJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=64Odycx55fXWJ9DTcxk1MDYnJPu/Ei16vGB2nFXKKDs=;
        b=EmrR8vI/jAY2pdjUy4xG61VuIhvES4ISPuLrttUH7HHkKLz3j9uh7cOJ+0iFXWPiyJ
         WZutBMjDGoHwyjPUru/Qcd7Xqj8utYmpaFUEVf6qBfNlOCfFXKeeWqTzciSOnLOutyZD
         Ifrpe/oGPQLwJE2eo4NXKYifeUq0z6FyNOobmImpI+UzV+BlK7Vu+8YfZA1y8zwKGK9g
         csBvClkkWEhaiA0+gM1BTw+vkh7cEGZ0MnZzftOoTWWEUgUE7NREEQHwewaRIEiuZPpN
         J2DiWt/wmqN7WRM6fwGml1We2jvrcsEHexctvlrdRFG8QtUeLHRQLBV1rwxf2mQGyOCS
         iZIw==
X-Gm-Message-State: AOAM531bWBpk8153Yuk5KeTyF4BVVfW2BQ8t7/61OLTyR1++vRzHHMvn
        YHOtri/y7laSUCDlqYir9+StPw==
X-Google-Smtp-Source: ABdhPJwY2KA5oY8LjYkM8q3+aNSg4cx69BsDUl6PxpX0LT7eyytkdMjXYURZZLY0YQnBSHT7dHfu8g==
X-Received: by 2002:a5d:6a8f:: with SMTP id s15mr8733945wru.252.1612442442945;
        Thu, 04 Feb 2021 04:40:42 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ed14:cc3b:a388:5de? ([2a01:e34:ed2f:f020:ed14:cc3b:a388:5de])
        by smtp.googlemail.com with ESMTPSA id u142sm6231546wmu.3.2021.02.04.04.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 04:40:42 -0800 (PST)
Subject: Re: [PATCH] clocksource: davinci: move pr_fmt() before the includes
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20210111140814.3668-1-brgl@bgdev.pl>
 <CAMRc=MfeAokkWdHNS1HES07YBFX6kM_JZRFehk0F+sB552_UbQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ea8c409a-7544-133a-9407-a31a208033e3@linaro.org>
Date:   Thu, 4 Feb 2021 13:40:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfeAokkWdHNS1HES07YBFX6kM_JZRFehk0F+sB552_UbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 13:37, Bartosz Golaszewski wrote:
> On Mon, Jan 11, 2021 at 3:08 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We no longer need to undef pr_fmt if we define our own before including
>> any headers.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---

Applied.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
