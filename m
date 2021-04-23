Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8547368D76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbhDWG6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240903AbhDWG6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:58:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D53DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:57:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 707B11F437FD
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Add DP mode check
Date:   Fri, 23 Apr 2021 08:57:28 +0200
Message-Id: <161916102147.2605538.14826236313403198205.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210421042108.2002-1-pmalani@chromium.org>
References: <20210421042108.2002-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 21:21:09 -0700, Prashant Malani wrote:
> There are certain transitional situations where the dp_mode field in the
> PD_CONTROL response might not be populated with the right DP pin
> assignment value yet. Add a check for that to avoid sending an invalid
> value to the Type C mode switch.

Applied, thanks!

[1/1] platform/chrome: cros_ec_typec: Add DP mode check
      commit: c5bb32f57bf3a30ed03be51f7be0840325ba8b4a

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
