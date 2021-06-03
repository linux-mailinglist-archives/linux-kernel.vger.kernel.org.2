Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28D39A51D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFCP6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:58:06 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:41564 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFCP6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:58:04 -0400
Received: by mail-qv1-f46.google.com with SMTP id x2so2769310qvo.8;
        Thu, 03 Jun 2021 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4WFK+dAl3lP8zGBQG5Zuw/AtQ6TfxtGSujMpkMrnDbk=;
        b=bZZ0efbfToszLj45mbduNslRNzNQ3wrkp3cQX6z4EO1xt5mSQ+/Ti+Rgdz+tIHE1Ta
         pEPt5lr+zHNspt/Nsd0I9YYypkXeCE+MQQ1bWoT/019cF8jqjXaRtnr6iLF9InVyg5GT
         7tZ6CntLshbLjHa3GIFgMraMcmddIubypMp7UhO7uO+1O5BSR3Ukijwj4v3DE/jMXSXH
         2ftTu5KnN438ImF50wNIfVs8UHtVjWBNsGLR8qCZG7TCi4LtBC68s+oG9h1LH5K/s9pY
         NhQZAq6E62jyWuXxluoHCfsHQTWi9E3OXUmkLwHIDd3EjgPDMWMtxoflhnUiJCxQVnYU
         n3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=4WFK+dAl3lP8zGBQG5Zuw/AtQ6TfxtGSujMpkMrnDbk=;
        b=dx5qLwq80EItbMkzwCJgAIcvlPba9ZvAhL80fzRHwT3F71Obt/CuYOy40aHNh2avwk
         OeBjiT1PpKB3fbhz15Y97oy/WDjcwvJu8BcKkdC/zhZnIndHcQYWp/okPrz0pmEInYbs
         OoIX+YiCqiZ49peqyqH5zKSisuhBkgp9dbwz4zvmCpzjo9Xlcb06625kIhS1TCfuMpBX
         W6RlQmWKCFouew4ftYjSsDGw0jOCsO9xhcvyROVy34hGnUOoNXNCZZeOU5YkI1LoY8fH
         dQp1aZP1aT0oYxijZvuO5yTbRJd1MBN8jp/rAcGLgYbwgJxpDz24xiUZ4yVcsBLVZU5u
         n1fA==
X-Gm-Message-State: AOAM531jYfKI1KiCWciKbEAiuirBHW/i3suHYZq9c+xaY23KqZlJIKA0
        tQXeC50RiS0i7As1mg6qIQs=
X-Google-Smtp-Source: ABdhPJwerfV65PHdjX76NBh729oibc3vZsU6r9rNIZ8zUS2VzYYmWq1wpd8PLQ/40DwnCG8UCUC4XQ==
X-Received: by 2002:a0c:a323:: with SMTP id u32mr226377qvu.14.1622735719289;
        Thu, 03 Jun 2021 08:55:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm2135981qkj.123.2021.06.03.08.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 08:55:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 3 Jun 2021 08:55:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max31790) Add support for fanX_div
Message-ID: <20210603155516.GB3017129@roeck-us.net>
References: <20210603131421.67235-1-kubernat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210603131421.67235-1-kubernat@cesnet.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 03:14:21PM +0200, Václav Kubernát wrote:
> Right now, the divisor (which determines the speed range) can be only
> set by setting fanX_min or fanX_target. This is fine for RPM mode, but
> in other cases, it might not be enough. This patch makes it possible to
> set the divisor independently.
> 

Jan objected to patch 4/7 of the previous series, so anything from that
onward is a no-go at this time. I'll drop patches 4/7 to 7/7 from the
series for now. I will only be able to look into this further in about
a month.

Guenter
