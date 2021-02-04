Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6330F202
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhBDLY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbhBDLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:24:18 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E18C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:23:38 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id o20so1950407pfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kWktwHkmNgbcrakKHA5kohP3/z9DUgGEOz8CKK3eeS0=;
        b=DgduVr8cJzmFsXHxTvzZFKTJ2Jza9sJB0Tqh3chYu4pQENxomVBAM2I84I9xAKtqrX
         zXC4x3T/8Bo/fOih9/nCZVnk6GA+bUljjMJsaFZV54ABRJOK3GrmXP1bRN1fgl74OWZg
         ttf+CDj5QkxAwpVvw040NYGDReKKyNbTw3jSlD8qkGKbpX2pijzcGgBUJoWHWSgno6/g
         qI2ZyuckNSI9aZbNse3gE4MEZ7TpVJAuoXlxxzQ9PyEF+i2fNSfnPNybW2+/l5jugChq
         qNXi2paUkp2O9q7P4lnWvnTVdjqtZkftEts3re2vnptNOVy/udWm3ajyPl5stbVGcLAl
         uwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWktwHkmNgbcrakKHA5kohP3/z9DUgGEOz8CKK3eeS0=;
        b=mXiJIaDCUlqIiSzO7geKu2PIN8pAkBQvfLc5p+h2r0cXZ8ySuCAuM5GQuVShDwkfpW
         voGM2iFXXpERHPfQdeDlbVru/G3EJ9+FuIHRSrG2SM+zw7md+ukQdLLM6dyWzxpK4JTD
         pV37jFzrg8ATADf8/o3uQymfu+DUVSKY0tWHG8n6t4HE65VGsLwIpgTQcYw26It72Jit
         Bic66mBUU6p0mmR6/j8HwBz9BoX49Y06BXmO0R+yZuiXun4H+Nqt54erH06CHOwD5yvV
         +xvZAdVbSQSeic343So2mc8OikgTflA8DeL+cj9Y4BqD9+UcDhWJNhSJ0vsjS74V1TVM
         zn5g==
X-Gm-Message-State: AOAM530/L87IARLx7Stmt78h8bHFA95L+J+3OFVNYq6P4EF/9ZL38Ezd
        bwCBhL6HEU2wjKLRi6/XLjYTSQ==
X-Google-Smtp-Source: ABdhPJz2/skTqDVjYgyRSAEPr3+lkCmhFQf7c13jBGOkXYVn/svO6CGmftRXcBH+sx7oyHXa9oqsDQ==
X-Received: by 2002:a63:bd4a:: with SMTP id d10mr8429807pgp.18.1612437817964;
        Thu, 04 Feb 2021 03:23:37 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f76sm5160507pfa.150.2021.02.04.03.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 03:23:37 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:53:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v6 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20210204112335.wcmhgleh3vpts52h@vireshk-i7>
References: <20210204081424.2219311-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204081424.2219311-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-21, 16:14, Hsin-Yi Wang wrote:
> Saravana Kannan (3):
>   OPP: Add function to look up required OPP's for a given OPP
>   PM / devfreq: Cache OPP table reference in devfreq
>   PM / devfreq: Add required OPPs support to passive governor

I have applied all the patches with significant modifications, please
check the OPP tree and see if everything looks fine.

-- 
viresh
