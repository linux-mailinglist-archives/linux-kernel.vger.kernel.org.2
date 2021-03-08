Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B858331414
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCHRFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:05:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32978 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCHRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:04:58 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJJJR-0002p7-Cz
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 17:04:57 +0000
Received: by mail-wr1-f69.google.com with SMTP id z17so5081751wrv.23
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BXtq859FRQFtajUaYN/vsNNVk2NCapuaGNff+HIq1fU=;
        b=bW5IlF3UCtXmrzgZwGeRdIvpokLp444c4GKyVnyRO5zEUbe59DsqI2guvb+Psr2ceI
         CVz0J+N/YDQreZFvNF2ck5rk0kK7lXRy2xmlm7MZBdSHF9bDn9+b09U+zMno1II+AxUK
         TgoEgmewGKNqyn6tfeERu71Xb/8BOOEwIXN5hPoVJj02n3+0GnS0blYtwKAFJgezwlC7
         l4VsdVadlBMOLc3d6rhabOrLYqmOnh2kgzSih2WWW0wL7fsYI1dVqmaccQuAOXh60oqk
         1CdeONYXVNgtfjisqntIMBm6QHY757ixggjVo5YXGqemIEyFrC1jorTecDMCVDaiD+Ao
         Re0g==
X-Gm-Message-State: AOAM5324z/trQ2Lyh5QMop4mdomCis+GoYcYLRFTC7HvoApgYMPvy3EO
        +wTmooOXL2i1okhgSPPOqUz+Iduq0pBK4PQd/jJ6kJkn+A0ueUg1Hy3wwhOZekxV6ZM409FlYhy
        SC1nQp1NhVfRUEfjGEdvFz5fUHySTkmIAjv/z11E4jw==
X-Received: by 2002:a05:600c:2282:: with SMTP id 2mr23166404wmf.93.1615223097148;
        Mon, 08 Mar 2021 09:04:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLrFBqic+DPXYmImXzmYhbuZCgb6qkVJhkld52yZQWkqYiOpDyptEHqsQ82up1jI+m7+KO/w==
X-Received: by 2002:a05:600c:2282:: with SMTP id 2mr23166377wmf.93.1615223096907;
        Mon, 08 Mar 2021 09:04:56 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v2sm13166218wru.85.2021.03.08.09.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:04:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
X-Google-Original-From: Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 8 Mar 2021 18:04:54 +0100
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH 00/10] arm64: dts: intel: socfpga: minor cleanups
Message-ID: <20210308170454.sbeylw5istqeglfl@kozik-lap>
References: <20210308162228.62614-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308162228.62614-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 05:22:18PM +0100, Krzysztof Kozlowski wrote:
> Hi Arnd and Olof,
> 
> This is just a resend of previous patch. Since I did not get replies
> from Intel maintainers, I assume this could go via soc tree directly.

Actually it is my bad because I think I skipped Dinh Nguyen. Let me
resend it one more time, hopefully to proper address.

Best regards,
Krzysztof
