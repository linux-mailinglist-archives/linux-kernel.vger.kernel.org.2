Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382BA35098D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCaVdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCaVdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:33:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6178CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:33:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v186so210891pgv.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rk5hGcPQBnN1SN2dx/HkSBbBGNgs3jWmWn+abQ5G2Y8=;
        b=ZID5pYwBKnZsdQnnwpRR2fq/yxgzUjbWR+eMz0HyUAl33Yvno2whFZuIsSHGMN+AAA
         qFLI2n3BFzRa+Z1vjUFK6kLBYR5s43ZTXFok6gry+JBW8sQksfbhRMiAgRo1lGOHpCNK
         Nv0yE7bohpDU39HXuT4qxc3nOPg++9fcDhZxReFSiIonZpp+HsgDhEkRaWwNwxaxIy4n
         T6zCeSidKutLH7vemClxuFCSL2/Pz+bwpIoR3j4U3G6Z83Fl1xYI7bMwLri3ZcTXP9FH
         oGQdlc0B/Ixc5T6baouEL6TBK88YWVOjCV+tqdXjZRXRHSHSKBPy2aK+2g2a15jmSprN
         Mcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rk5hGcPQBnN1SN2dx/HkSBbBGNgs3jWmWn+abQ5G2Y8=;
        b=SkgWs+apnNr/73SFTdaDcX9SQDZFC07i8xXwl028dBsDWcHUeT+GKzx9Wue7YEXLDl
         5rQnhYYRwVoDKfVIFtgle977BtwzGkguawDBzeowXvfy49Fpr3/kLyb1eT5ca3mMSllg
         VJRWnban1GsMTmBsnDxH7sN4MobyBRMutmoZtrCWunTwh8CLg9nwaROzNqAs1a/r4vml
         SnAOe5kzpCylBD0RekhnbrG84P+7h4JKWSm4N2p4nTojtxc/l93WkOwwTFwKlOT9j00M
         nuR8AHKF/w8bXr5mc3Rn6XULavY/YYX7k280opKHa3R7NrPmDxMIUHxr5Fv8P05LYfXj
         eRjw==
X-Gm-Message-State: AOAM531JnVw7ksPxQzjQXfOEoSg+AhwWV8+9s5TD1p2/G1vSzjJCojLR
        9DVBybV3QWcD12lcIRPmiVEVfw==
X-Google-Smtp-Source: ABdhPJwRaTBqO5x1qiRNai5Zvd2mJUmOrhI1W6j8wTIptF68N5rP1lqmo+HXIilbqYcec1BfNjCPyw==
X-Received: by 2002:aa7:860f:0:b029:200:851:1bff with SMTP id p15-20020aa7860f0000b029020008511bffmr4789806pfn.64.1617226380862;
        Wed, 31 Mar 2021 14:33:00 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id a21sm3121545pfk.83.2021.03.31.14.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:33:00 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Hyeonki Hong <hhk7734@gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson: add GPIO line names to ODROID
 N2/N2+
In-Reply-To: <20210329161256.31171-4-christianshewitt@gmail.com>
References: <20210329161256.31171-1-christianshewitt@gmail.com>
 <20210329161256.31171-4-christianshewitt@gmail.com>
Date:   Wed, 31 Mar 2021 14:32:59 -0700
Message-ID: <7h35wbc8l0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Christian Hewitt <christianshewitt@gmail.com> writes:

> From: Hyeonki Hong <hhk7734@gmail.com>
>
> Add GPIO line-name identifiers to the ODROID N2/N2+ common dtsi.
>
> Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>

You need to add your SoB here also.

Kevin
