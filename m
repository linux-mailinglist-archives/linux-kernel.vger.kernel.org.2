Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3A458BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhKVJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:58:23 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37176
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239223AbhKVJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:58:14 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 943EE4001B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637574907;
        bh=zkumlnqNJKT+369TWNq+acNCTy9XczjMoYz/4LoM5wQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=hJh6exXTW04hkF6rrUALP8l/E5YJpvNlDt9827NiTi9aob1pB//n3JU9w/NMVA3DH
         DhkQvh5heeyWQbV0M7jd+JCDD8/MVERGFRslOQPMgCB+iE1r/NkPS8K9nx98WqwHmF
         sv+VrkhhK3fpTv8TaPKnHvgolM1q4chNq94CLONdd5I96hPIsUTBVGfJexjWuWZJOY
         35kmRv/YoFa+JB3keUkHr5NvV2STFnLuTA3j363+UB2b2s4GRHCWCvMuPneTjZaMtw
         l2BMnzS4isdyQ595DpLfHeSe0QgvuUePVBLrIy24OY0CxlRfVrJN+FNYl8Ob9M6Arm
         5rk5Oc0SMBuHQ==
Received: by mail-lf1-f72.google.com with SMTP id h40-20020a0565123ca800b00402514d959fso11816700lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkumlnqNJKT+369TWNq+acNCTy9XczjMoYz/4LoM5wQ=;
        b=yKKHy1F+7mtS46HCM7Ia3pBiVV0u+sXLNY4EKmN26eh/4iOmmQnU/W9H3MEJ60xtvc
         0WGnl5OHtXSIIA/E4Et47vkZ0bolJZZ+NJXrdIlJLOfcDpd8PHDUS0chn+KtRHk3AyUe
         S8S855CwHWiCSalgkdf9cxf1Y73h0TwsAxHVb8JeTNDWYrDzehuDiZ5i7rGl+zURxFZw
         AVYw5pMwXreX7Rf32MxTCmsHjwkMi2pHxDr4wggCtBqRH0sFp/i/DlRUG6LGOuu+CdnI
         b6AP0J1SBh6Sw2ByS1xuwEti7zEIFylQkrgD0i3R6lQyJts4Pg7oDaUWQScUNQoDe3sV
         M7Uw==
X-Gm-Message-State: AOAM533pdgR48Mdtm22fnE0DzshuV2L9+SmJB/Vk0XQX0hZxm3XUbfVl
        gGtvxgnGSe/udDaeOUgHBkGQjTciAv4vGvDe8ec3R0J2sgMqLINkdEajAMRhRtkgukpfNeH8CcP
        U8L4o2mcQE9GLQ1DnIiecqbYIGAQCwe7rw31dBLe4hg==
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr52044271lji.113.1637574906969;
        Mon, 22 Nov 2021 01:55:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdZHUyb3MDiG9TVAk44Ju/7cV1jt2q+jUzZuW6+cjZZY4uDIrKQ49ChR0NJyzshzLK/SZd4Q==
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr52044244lji.113.1637574906753;
        Mon, 22 Nov 2021 01:55:06 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u22sm908676lff.118.2021.11.22.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 01:55:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] memory: renesas-rpc-if: simplify register update
Date:   Mon, 22 Nov 2021 10:54:25 +0100
Message-Id: <163757486271.327364.11884683801809986745.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211117102902.20062-1-wsa+renesas@sang-engineering.com>
References: <20211117102902.20062-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 11:29:02 +0100, Wolfram Sang wrote:
> No need to open code regmap_update_bits().
> 
> 

Applied, thanks!

[1/1] memory: renesas-rpc-if: simplify register update
      commit: 2db468d6fda4c33d26ba9dde7c72e081b2b86ad1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
