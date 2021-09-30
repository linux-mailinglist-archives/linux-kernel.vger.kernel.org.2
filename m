Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732DC41D393
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348376AbhI3Grz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348342AbhI3Grx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:47:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE1C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:46:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 228A11F44937
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros-ec-typec: Cleanup use of check_features
Date:   Thu, 30 Sep 2021 08:45:56 +0200
Message-Id: <163298432636.3251747.11446717418116580696.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210923200321.3623222-1-pmalani@chromium.org>
References: <20210923200321.3623222-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 13:03:21 -0700, Prashant Malani wrote:
> cros_ec_check_features() now returns a boolean. Remove the double NOT
> operator since it's not required anymore.
> 
> No functional changes are expected with this patch.

Applied, thanks!

[1/1] platform/chrome: cros-ec-typec: Cleanup use of check_features
      commit: 73eff8602ad10cb55cdb614241b18f3d842abbe1

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
