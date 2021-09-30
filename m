Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F4341D392
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbhI3Gry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbhI3Grx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:47:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E89C06176A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 23:46:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A1C4D1F44723
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Fix check_features ret val
Date:   Thu, 30 Sep 2021 08:45:55 +0200
Message-Id: <163298432635.3251747.6538622508689471214.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916014632.2662612-1-pmalani@chromium.org>
References: <20210916014632.2662612-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 18:46:27 -0700, Prashant Malani wrote:
> The kerneldoc for cros_ec_check_features() states that it returns 1 or 0
> depedending on whether a feature is supported or not, but it instead
> returns a negative error number in one case, and a non-1 bitmask in
> other cases.
> 
> Since all call-sites only check for a 1 or 0 return value, update
> the function to return boolean values.

Applied, thanks!

[1/1] platform/chrome: cros_ec_proto: Fix check_features ret val
      commit: d50497c4a05e73e76874fd0d4942036375a7ec0f

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
