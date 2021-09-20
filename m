Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084654110BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhITIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:16:36 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51134
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233811AbhITIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:16:35 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 41E453F4BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632125708;
        bh=RbnF5hAV4mmqgOMwbx5PeFWTjk5AbWZGdxLNmlZ/+u0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=JksSR1ZgccMORnY/fktNqkJzaCTW6uIg1wb4B4tPeAOwrdnWn1Hqwa71bu0W7MgPG
         M9rgxz3ycVEaVOfkVfRTCgJh/H0aWKeEjJybfuTlIURhiM7Jxdjk9iqLb1ONVDGgch
         NhvaUQowRwh+Fct+nXOjg9tx6lCxmcG/IkI3Y0ndJf+Aa+T3B7u6uygAG5+klETTbw
         5qDNeykZVmN4UeeMTSxi8uR1yY6iidOIKlSefZTMwqW9jXIOlXzyQniJKspe0xWomc
         Ylc4BJ2uqRZWvJwmjcc559hqAbWB3yqscdQmlyQp7LqnSh2qVmjNCSZkYdJ67thf2r
         pJGUqPox7Zarw==
Received: by mail-wr1-f72.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso5511521wra.23
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RbnF5hAV4mmqgOMwbx5PeFWTjk5AbWZGdxLNmlZ/+u0=;
        b=DbXI9a+Xd0tm0/IHl1CgsTZDK5b4C39qkuNaCtSORlkQ+7IbqZHL6JZ4dqwPeFg/BB
         aaPBfdheRCIY1Wgxx7puSUw8fkbvp7A0ftnR2rLZyVXa7DCvD1F/L47uOM5hQ4gC0Bce
         8FYuEPaQdUuzveAXX4eMPNtbT5CBJQXfu9THFD6qQ3Sb2H3uctYh90Vlh+1xugkktQrI
         GGrCWJQ2OQelwO0IB3bZt9INV9Ok8eoyluqi2Sh/FShMhQImlYJmZlqlerAQydd7JMEi
         0XuAQ92PIrB+dPYNkAdjLrQI/8EKQnd/Fig9R7pKTnLXqjQo9hzh+BjOM2a6xjd2x4ll
         qrZA==
X-Gm-Message-State: AOAM533BFLO/4V+lhzrtxy83Xwd99MR0/XH8UoK+uN53eF7TrNbL5CEV
        gLtMEJIFgluew07EhGbtVJWN2lvSp0vjkhpkBfxr6EnZBj3HXHCBp8MAR+gXO0oLcsrTN2J+Zi8
        7X43wvahQfBdZdjMhK4rc2AuAoTqhTxzqu85Bhcx2hA==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr27168662wrt.417.1632125708037;
        Mon, 20 Sep 2021 01:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI1Laop0HHhwm29eWDYQDKvcafzMKgfc+Q8LVzR67h+bw1jUc88e3rl9xSTyZK3r5x8IVxrg==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr27168627wrt.417.1632125707785;
        Mon, 20 Sep 2021 01:15:07 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id b207sm1947652wmb.29.2021.09.20.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 01:15:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH] ARM: s3c: Use strscpy to replace strlcpy
Date:   Mon, 20 Sep 2021 10:15:04 +0200
Message-Id: <163212570006.110243.10080683787518372101.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906134656.101088-1-wangborong@cdjrlc.com>
References: <20210906134656.101088-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2021 21:46:56 +0800, Jason Wang wrote:
> The strlcpy should not be used because it doesn't limit the source
> length. As linus says, it's a completely useless function if you
> can't implicitly trust the source string - but that is almost always
> why people think they should use it! All in all the BSD function
> will lead some potential bugs.
> 
> But the strscpy doesn't require reading memory from the src string
> beyond the specified "count" bytes, and since the return value is
> easier to error-check than strlcpy()'s. In addition, the implementation
> is robust to the string changing out from underneath it, unlike the
> current strlcpy() implementation.
> 
> [...]

Applied, thanks!

[1/1] ARM: s3c: Use strscpy to replace strlcpy
      commit: aa519471715ce73034ffaa52fc85681de31c1acf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
