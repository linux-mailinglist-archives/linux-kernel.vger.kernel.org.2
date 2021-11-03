Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD67C444718
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCRdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhKCRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:33:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62FC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 10:31:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t30so4703036wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FbRhYZ6lLMWqngWf2cqxRUv8emxiI2fe6YSOeSSY8HY=;
        b=nvJNc3kB/aIJ8WA5Xc4dAfyJGXOUT9mCxG5OAo8haBSVue2iRvfBP+hqB6ahbX+ezi
         zqI15/N++dSJ6NlXr5VpwmG2D9my+DL6ow3oHvtGg8YATWsixC12aBHCHzV5MJ/3zA8U
         YiC82fphylyv3ro6WIM8eFAA/MzyMKQ28xkj9DUimMQBRmZ9ORq+fhracfulrKJXv6/a
         fLYj2Q/NRYDMZ6oG5j8v9ccvHrdJChuEY+bKa8Gc3SOOX17C/uToTT8RmeNkyfelbGJs
         TBz5ikILIVWAIYpHxulkY9g83YALDcES29WGuLv7K2d8cVrVi2/OdRJSBq4IZ0p5NSKZ
         uTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FbRhYZ6lLMWqngWf2cqxRUv8emxiI2fe6YSOeSSY8HY=;
        b=8MVzlfuMQqsKN+d6y4B65OyE3PriTao5Pob6Kztc8VpopjXR0Zdrp+RcY0rDK7+f91
         wR5z+BKrIgiCPLzeJl4ImbI4D9cJvagxSgJVVlbNYzcWAm2RUz5jmJbC7P8cTCFw4AiL
         ThyfWzB731TUgzoH7rHv6wZCtC+AkaEtRJanD899N0XqUYjaMptMNlXij3YTMZoRbTlE
         oVzd/yv9ymGXneO9MMRO0XEKUQebuM8fwYorq/Lrap4KKDn0HNCwVVttUwnKf9eGeT5+
         CsqbmcyZ/05cQm5TuALvwgpIC6WECNcfumakUIKrLfnENywUtWvDqsrjRH3fpOcaspdV
         n3sg==
X-Gm-Message-State: AOAM530lI39KnqmcKEEWNB+pOUrs/Mfv0fLe87nv3oJu4C7VFyq0jKSi
        tdsUUJrRjVHW6XaCjrv1UeHT7g==
X-Google-Smtp-Source: ABdhPJy6rnwrTz9baM7+pLMjNFPj2w5GZHKSc6LlHvcgadsD8ViZl7qmm+hRQaAogHkXjOwtekBfig==
X-Received: by 2002:adf:d4c2:: with SMTP id w2mr40778374wrk.225.1635960670132;
        Wed, 03 Nov 2021 10:31:10 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id a9sm2575261wrt.66.2021.11.03.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:31:09 -0700 (PDT)
Date:   Wed, 3 Nov 2021 17:31:07 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] backlight: lp855x: Add support ACPI enumeration
Message-ID: <20211103173107.xlchsysme5xzpn24@maple.lan>
References: <20211102225504.18920-1-hdegoede@redhat.com>
 <20211102225504.18920-3-hdegoede@redhat.com>
 <20211103171756.wxthncse2f4syeiz@maple.lan>
 <5d431db5-30dc-b51c-7abb-ab57a3de2f8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d431db5-30dc-b51c-7abb-ab57a3de2f8f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 06:28:15PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/3/21 18:17, Daniel Thompson wrote:
> > On Tue, Nov 02, 2021 at 11:55:04PM +0100, Hans de Goede wrote:
> >> The Xiaomi Mi Pad 2 tablet uses an ACPI enumerated LP8556 backlight
> >> controller for its LCD-panel, with a Xiaomi specific ACPI HID of
> >> "XMCC0001", add support for this.
> >>
> >> Note the new "if (id)" check also fixes a NULL pointer deref when a user
> >> tries to manually bind the driver from sysfs.
> >>
> >> When CONFIG_ACPI is disabled acpi_match_device() will always return NULL,
> >> so the lp855x_parse_acpi() call will get optimized away.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Thank you.
> 
> So what is the process for upstreaming backlight patches,
> do these go through drm-misc-next (in that case I can push
> the series myself), or will you pick these up ?

Lee Jones gathers up the backlight patches and sends a PR (but, except
in exceptional cases, treats my R-b as a pre-requisite before doing so).


Daniel.
