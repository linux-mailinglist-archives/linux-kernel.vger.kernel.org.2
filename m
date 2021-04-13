Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB7C35E21C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbhDMO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:58:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58486 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbhDMO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:58:49 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWKUm-0005Dg-Oz
        for linux-kernel@vger.kernel.org; Tue, 13 Apr 2021 14:58:28 +0000
Received: by mail-ej1-f71.google.com with SMTP id l25so594616ejr.16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfeZqV0xjG4QFWbYQYxvJCmGV3BWK86EFet28LdHCaY=;
        b=nSmRuFYG3kNWv0qit9hWGnLQdWvOCZNY1d/P3HZC8RRzi23fGBdAGbPc1Qi+QDZJpe
         e30wLH+/rKIreQGiKG3eZGKX5xMmOCJsLWEpL9BCE54p5NwYcAfQg7dXxT0vdHLrMBTP
         g7QOZTOnFjY8lHTKZ6VzXWOsK5MyaATSW12zOwIgo0AO7mBAqZxEwrfa9dhLBx6e2y/C
         pu7kXdKm/+3eFwm3vMV9TFse0MaM7OznfVecbTUMXRC+1pHd3C1V9kfFIdmP0HLdwTtf
         NYBT8IYyKdbJGJFYjlahVBGTHSxodXnq6bRZVH0HFeqAltfv3nif02esaO29utiNPuyv
         /98A==
X-Gm-Message-State: AOAM531EgsypR0E3L+JEB1t8+T/FN3F85W8iwjab8xPHl4Npx1Op7Biy
        +SWeKweqKEn9qoA9gMZ6n5fBW/AP9aGO6K7XSXyBukCo6AKganzA63Y/3UuTUbQVNYKQZ01syA9
        ISXq7sWmIcebN538mThAV7hJ7mbiPfsU2R1PyTV+pow==
X-Received: by 2002:a17:906:5da:: with SMTP id t26mr31830814ejt.21.1618325908521;
        Tue, 13 Apr 2021 07:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzIUNQDs50I1K4hFsBuCH4hWVCgUJSoLaMmz97SzR+8OSWUxXcWsPq4sSIxMNaSNz5+K6LMw==
X-Received: by 2002:a17:906:5da:: with SMTP id t26mr31830810ejt.21.1618325908417;
        Tue, 13 Apr 2021 07:58:28 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id p3sm4395217ejd.65.2021.04.13.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:58:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] memory: renesas-rpc-if: fix possible NULL pointer dereference of resource
Date:   Tue, 13 Apr 2021 16:58:22 +0200
Message-Id: <161832589345.71964.9811013028966064079.b4-ty@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407154357.70200-1-krzysztof.kozlowski@canonical.com>
References: <20210407154357.70200-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 17:43:57 +0200, Krzysztof Kozlowski wrote:
> The platform_get_resource_byname() can return NULL which would be
> immediately dereferenced by resource_size().  Instead dereference it
> after validating the resource.

Applied, thanks!

[1/1] memory: renesas-rpc-if: fix possible NULL pointer dereference of resource
      commit: 59e27d7c94aa02da039b000d33c304c179395801

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
