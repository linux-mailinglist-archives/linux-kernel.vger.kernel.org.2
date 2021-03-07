Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2313332FE66
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 02:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhCGBqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 20:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCGBqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 20:46:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9EC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 17:46:35 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t29so4749526pfg.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 17:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eIq+GxVtZxarjQGt9ar6dChG4GoMdEL7HfKpoddXB5w=;
        b=SzWFkGKrayAtI9lJUISvwrA1/pqIH3r4tIVebwx79MAbKzn3gScTuBcZr2U/Axvw30
         3zUUGfXqOsc5lOhyIhOS5wVpgc6SU7koqRXRPUpHFK1Y9JXQg1pUd/SY0hmR2cE+/YpL
         oi368sfnuMZbeQXgXUuxq/ajNlRmx8jylFjww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eIq+GxVtZxarjQGt9ar6dChG4GoMdEL7HfKpoddXB5w=;
        b=KH9eUlGBeGnKwBCJVMHrsmlHeH7O/dVO3QarbVtVBfONyWLiTieakIRP5BhVHwIHpZ
         M451mwuM7HBjVvsKFe1fTEMKtzYpYkUt6HxgGeQfE2EjTBjsMl4pXQz1sMBCv7DkJGe8
         Xw0FUOeY8egDX7+ggJlNlYd5/0K2j3w7c23XE8CIK2og1ORgDHYde/owzRGJQWZRzZ10
         u9tP8ciOUGEcSPzOqzTHC9njCYxlSevtwKfsL1egiXE7jbudEZSwD+B/VcVuxPZJL2A0
         hrJMxKwIAiOLG2KeLrtInoOCPwDuhFKh+cu1IlV3lMJTZ3mezHvcphfmocHUOJoTD8kH
         7yWQ==
X-Gm-Message-State: AOAM530bgxLzufCAxFu4+AaOF4HEDHRgVnxJQkli/C5mNNCsySP5PMuo
        UIq9APSduV+MaOrwQ6MWt8XA1Zvph/Vy2g==
X-Google-Smtp-Source: ABdhPJxvOId0xV4z5En2NoX4D88nEpafSAWG3lFdNrujJKbKDZowLVaivo8Q6ydJqkIiPsTlhzNFGg==
X-Received: by 2002:a63:ee4e:: with SMTP id n14mr14862459pgk.422.1615081594653;
        Sat, 06 Mar 2021 17:46:34 -0800 (PST)
Received: from braindead.localdomain (c-71-202-115-154.hsd1.ca.comcast.net. [71.202.115.154])
        by smtp.gmail.com with ESMTPSA id 35sm6053061pgm.64.2021.03.06.17.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 17:46:34 -0800 (PST)
Subject: Re: [PATCH] Expose the bus kernel docs to the build docs.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210307013301.39420-1-wt@penguintechs.org>
 <20210307014445.GT2723601@casper.infradead.org>
From:   Wren Turkal <wt@penguintechs.org>
Message-ID: <80cc4102-2abd-21e8-2140-a54919da3f3d@penguintechs.org>
Date:   Sat, 6 Mar 2021 17:46:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210307014445.GT2723601@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback. I will cut another patch in a sec.

On 3/6/21 5:44 PM, Matthew Wilcox wrote:
> Do you want to put a heading in front of it?  I did this in xarray.rst:
> 
> Functions and structures
> ========================
> 
> .. kernel-doc:: include/linux/xarray.h
> .. kernel-doc:: lib/xarray.c
> 
> Also, I see that drivers/base/bus.c is included in
> driver-api/infrastructure.rst, and I feel that they should probably be
> included together?
