Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A34306515
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhA0U0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhA0UZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:25:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32625C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:25:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gx1so2103380pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rlmk7Ov7nnfuj7pxVxzad40PQjveYN2yuMGAEFRPmoc=;
        b=a3sslUf17Pg+mFGci5W5qE0vZF4WPlKgjxlag/9I/0XnjAgEutgvfYqLiBjFRHl08R
         tbXie8Ny+1Q6Z+E4HtfyYpbtZMFSlMd4skJnUeeYdfs/K0sW+jwHwOJ+26w86eS/EJyr
         cQ3T5q330UmYaKwhgv55l2IAteSHPcIXyxfEdhu7jmgf0n41AGoKGZqprjElpr9QT4uA
         UXt91ZOPxho7VUJj7MggyieaL4qkByeQeESC5L3vANqmk2Vr+sjAmORpyo+YFnXtnsAs
         RAS6s1ls6OlbFHAA37DOhl7qULKKMsqiZ/rQmMKPHve0XJ4Ubm9zlJWiqhp9rcmSCbA4
         Zocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rlmk7Ov7nnfuj7pxVxzad40PQjveYN2yuMGAEFRPmoc=;
        b=SoccEFc6mzzFZpsrHJu9pc+5+iXK7nmzLeXGO5XpFWInR9tPq0DFqlNvokCwWBTKj7
         t+FoqEdmHVKrGP5rzcQto4y35fTeE80dlZpunjp8SZ1SeH6Bc2XzCV291xq9jBSDn/Tx
         p1GEVdyYCNiptJ/hblWiZ2U1H3Pbctdd+fglOayRrKZrX4T0m9boHPXAF8bep6Ofz5A7
         ZznoXWkbR+0Qoe1Dqa2CAk6RZJsHlc57GVfge880ejENjXJhVe4iVm5yDpii7+3riJE1
         d2vwcPrlgZq8Q6maxxjxbjBlPn/YWvRLhWo6OcPIH4fMyF00ezsgf0/quWL/+M15MgNQ
         mVTA==
X-Gm-Message-State: AOAM531AQ1r5xNmUBr6ky+MqDhASlNMJis5xieEvugj+g+KTDzHWac9U
        YvwGPHGKPV7VTccFsG/6YZw=
X-Google-Smtp-Source: ABdhPJy+Rh6i6axNCsJNnX+AeXbpZY+kL7xAt5wrZmV/6qH/4J8qsaIRq4W5651fRwDaQ4qtEisGZg==
X-Received: by 2002:a17:90a:d487:: with SMTP id s7mr7688196pju.124.1611779104714;
        Wed, 27 Jan 2021 12:25:04 -0800 (PST)
Received: from [10.230.29.30] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b18sm3377500pfi.173.2021.01.27.12.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 12:25:03 -0800 (PST)
Subject: Re: [PATCH v7 1/2] ARM: PLT: Move struct plt_entries definition to
 header
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-2-alexander.sverdlin@nokia.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2c256ea6-b9c7-610c-9b91-ca625a77393b@gmail.com>
Date:   Wed, 27 Jan 2021 12:25:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210127110944.41813-2-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2021 3:09 AM, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> No functional change, later it will be re-used in several files.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
