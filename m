Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93789322609
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhBWGsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhBWGsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:48:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5CBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:47:28 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 75so11770261pgf.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=acWenwMqc4rWq/OQX6AZ+7LCFpRmF0qZOd1EaMs9uvg=;
        b=MadCe1fqvLXAqcaXVCuwBlmzdYmEFfx0HZZ03GEvB/vC/nNUMhMaa1+udVT3Y/jxvc
         beYAcXgm/QJe5JcEeTbcdopzhCJs8YJAaVtl3ul3b5/ApXblqdeNEhM6FJy/FgfZQMvA
         D8kSzO99fZSxEEMcgak9bj73IhaymTLVWUwUPInChTFeAOM0yIoyhLC6Jc8YC1cALXtk
         UcmcNbUEYqHum0p8z7QzQDoc9D1wHfXhHbxMEi6n2ltvs9e+JoIGubanWdLPPHxDLIBM
         d5fKamb4HQFv+IUcRaZ4q1RJhQFprmX6kZELIqpXTvj9fDM/zj2L9wMFii7wJhZW0cLY
         zkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=acWenwMqc4rWq/OQX6AZ+7LCFpRmF0qZOd1EaMs9uvg=;
        b=nDNZXzNUwEqZ0Bf+nDqs0DMbk4WBvVN27Qgay+1VSEsZTKIMxOnMM8tqyqXXxUB6ap
         jh+glOs+sv4G3JlwOzqhAJIyZ3ZUWdBjJrKeLcvAX1pvRHc4Iz8DxuYQSHeLt6cHiI+m
         MRz+OvWi9DxYz3VsS92mIjXVlv6op5NHIJv8XreqC0/BfZEJEkK3YgLE4/7qi58XxB2z
         q5pZMDIdjjQTyFns5Du6otIAqMCbqalYU4eo5R+TZqo45hV4SsOYD5Jzx0bWt+1O9W9t
         R3iR+sIaPl+DBp/SKlQtIg9vNwCdaXXKEDLD53PcWf7lhTuAj07OpmQOwpqjO3mCy6M8
         BGTQ==
X-Gm-Message-State: AOAM532ZpDIHE5JQ1JkWP529S0eUcO4v98VtxSilCBKTrWknMKCshXBQ
        4XBjT9x06RkOzQzSwMgOi+pnM+bb8ooG3BvCz7E=
X-Google-Smtp-Source: ABdhPJzu2rGnxMppydDeVkpLk9X0oMbOyPgpzGu88h6pJuPte5KE4fAedf3TT6sx3J9r+twYdzG2Iw==
X-Received: by 2002:a63:1958:: with SMTP id 24mr23144158pgz.320.1614062848047;
        Mon, 22 Feb 2021 22:47:28 -0800 (PST)
Received: from ?IPv6:2409:4064:4e15:50e7:a908:6589:7ef3:8b39? ([2409:4064:4e15:50e7:a908:6589:7ef3:8b39])
        by smtp.gmail.com with ESMTPSA id w187sm21463969pgb.52.2021.02.22.22.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 22:47:27 -0800 (PST)
Subject: Re: [PATCH] sound: core: fixed coding style errors
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, sfr@canb.auug.org.au,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210222194156.26758-1-sssraj.sssraj@gmail.com>
 <s5hh7m3wanq.wl-tiwai@suse.de>
From:   Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
Message-ID: <dd561c0f-5622-10f3-5c8e-1156a1584612@gmail.com>
Date:   Tue, 23 Feb 2021 12:17:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5hh7m3wanq.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, I will resubmit the patch.
