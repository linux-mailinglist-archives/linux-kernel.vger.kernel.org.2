Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296E2327366
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhB1Q5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 11:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhB1Q5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 11:57:51 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92734C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 08:57:10 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a22so23751389ejv.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 08:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BoRuHowPNqtXB3mouWVpPaU83FQxh6goxUzSFKTTnHU=;
        b=PDvWbcTPiFwkQ0ZQrx5QyVaESt1t9TkIWAa9uvEdceKWpWKNSAPCNmbSAbgMmXOCYA
         PbDJWYN8AxnUsBUtlHMNlQyiK85grYFjcfyCvEhHyAUgYwgnPCfr+36a4aZNXZmsB2Ki
         2eUshGL6EBTZO7P+CpJqqfw4MZdo3gcyz7HtI4m2wN8oh4dkIih2ucWIDhumHKLqJEDi
         OgHEAp/o/l3RYTYwSbb2LLrS4YfevQW/PnVxGz9NZSwu1UTM+0V0KIbEaeclRGmCpVs5
         HzwEO+DWykvWJUMgCAXiYMzHZPpw/xcaFqsuppDjTe8mISoOtb/kpecaj8lYZotwUXhu
         2C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BoRuHowPNqtXB3mouWVpPaU83FQxh6goxUzSFKTTnHU=;
        b=fC+8ZexTV1LvfY9kr0+x1nZczdB2TNIPiAlvsfkO1kDK4/gxsNNYpyMsSePYeeNgAI
         QnuHIEMSJu072OD8AeDk3mqgP5B/gbO6G77kY9rODGj7dq/hFpm6dDGEL2q5dECj6Z4a
         ZHc/v7BvJkBQU025HXZi7BLD2lV8+4/6UXDXW9Omu33TvkfCjK5YiDbS0OZXV2lzy+De
         MT3ld76iyjSmYBs8JoICjFNHEYUl5UiBNak9J0EauxlQDpeuSIfA5zJbeaejLFmyYz8N
         CCT4grq6CPAA8Xmdf8DrFob9r9rRH/abI+9BXdX14pB31kibvaW1n+Gxhorz6z0FmvB7
         TMqA==
X-Gm-Message-State: AOAM533gffhUzHfSAi07jWhtIJ/GlK/ridJvFspdExgORo7ichau03bY
        AOYQDNt1vJl5E14mV23PmZEBUsDmSw==
X-Google-Smtp-Source: ABdhPJwFbs33CmTorTIBY68iZQS5TslFYfK3IKACbVjh9KKioZNbESi2RSD9IEW3n6k8DjD/tkEihw==
X-Received: by 2002:a17:907:aba:: with SMTP id bz26mr12470219ejc.146.1614531429319;
        Sun, 28 Feb 2021 08:57:09 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id bv9sm4991696ejb.21.2021.02.28.08.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 08:57:08 -0800 (PST)
Date:   Sun, 28 Feb 2021 19:57:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH 00/11] pragma once: treewide conversion
Message-ID: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is bulk deletion of preprocessor include guards and conversion
to #pragma once directive.

See [PATCH 11/11] and [PATCH 12/11] for the script and rationale.
Everything else is trivial stuff.
