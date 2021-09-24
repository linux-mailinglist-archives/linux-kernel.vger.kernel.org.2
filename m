Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88144417173
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbhIXMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:03:29 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34682
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244925AbhIXMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:03:25 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A45DB4019A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632484911;
        bh=TKyRV9O1Y/ljz5T9kCOw405tGOgzBL0k1lCSjTA1wYI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=L9HjsOhFCpjV5nJxzwpdhvyGToD7aFtNO2XR0c5uP3t3dWhCjDpO/cMZoD5mPLMRb
         kb4J/cQ7OMudK8bk5MeEJ3ZVfNWYhDLuvdlde/fAa2WIjkwF7jEanKpXwlqC5tGUy+
         TurNDf8oFF0Ssjze/OtyH3iPpm4vnsoimmEM1QW0vuS9diwUv4r2ucGRMspLeupCRl
         Kxks8MMChTA87dgtNfg9AXXCOf+H76g0ybWFOVk57gKOWIlbCNfu7TayxqwNqqMqVa
         nFy81nGJ3FF0dkXgHkbfy5Q+0BFcM+Dx9va1AOs2JDuY7AkBiqz1B3J0fTTVh3H11b
         cPW6T6gngurlA==
Received: by mail-wr1-f70.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so7844982wrg.17
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKyRV9O1Y/ljz5T9kCOw405tGOgzBL0k1lCSjTA1wYI=;
        b=FM47lEwXZIv3kygWwnizYCyZzP0YnKR+bV68JXeE9mSuDNdD4ToKkPOJwtN+R98fJq
         4VNj+qREHua7EvWzyJbc9JAM+btHoLzW+1QYpFbMCCcaVhlMyJz4OBrPBes1C7/giTsT
         2zFczVlgoZjMHzX/tkhSZ1B1ZV+Q97zNMsFHZ2imTIL4WeUgxaSgAZLyMIKB9kIaUrru
         RXs3kivt/syLTbOuOk2oELBs9b2G+RgzGrLs0wuRQghmdGZ+EhZnVi9LE03hiumG4kHe
         aMk3j+UilMHXeJ6eGzvHOMXTLWNdAoSX1UDhtLTn/ipK9sRxh1Gs/jc4/beIRpc0VsHT
         JZlg==
X-Gm-Message-State: AOAM533IJEArctiipgy2tLRLWT6d1pJyJfAzzavY+Fog3GyqdEek2aSA
        FHdpBmjcjEqTj5aA8sHvtvjSScMoS5fhPC+OHufpiFru+Oiq2dVCBfmPYshVX/ifJpFbdMWD0kw
        VOzLYp+I5vJC+xsqUxyiUpsiYwpu5hOUeBuTlTPguRw==
X-Received: by 2002:a05:6000:14d:: with SMTP id r13mr11212092wrx.420.1632484911240;
        Fri, 24 Sep 2021 05:01:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzquSMRBcbVZ+YVahWJFTiZdrKlthMmH22osg55fb8riVZxx8aZY78k3Bx0kxcH0Mf93sm1aw==
X-Received: by 2002:a05:6000:14d:: with SMTP id r13mr11212062wrx.420.1632484911102;
        Fri, 24 Sep 2021 05:01:51 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o7sm10100619wro.45.2021.09.24.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:01:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: rpc: renesas-rpc-if: Add support for the R8A779A0 RPC-IF
Date:   Fri, 24 Sep 2021 14:01:12 +0200
Message-Id: <163248485488.53812.2936557522765718572.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922085831.5375-1-wsa+renesas@sang-engineering.com>
References: <20210922085831.5375-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 10:58:31 +0200, Wolfram Sang wrote:
> 


Applied with added simple commit msg, thanks!

[1/1] dt-bindings: rpc: renesas-rpc-if: Add support for the R8A779A0 RPC-IF
      commit: 797f082738b10ff397c8d3b7804b747d766e62e6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
