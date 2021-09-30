Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259E141D548
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349029AbhI3INt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:13:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348924AbhI3INq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:13:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 884551F44946
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Benson Leung <bleung@chromium.org>,
        Colin King <colin.king@canonical.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec: Fix spelling mistake "responsed" -> "response"
Date:   Thu, 30 Sep 2021 10:11:56 +0200
Message-Id: <163298950474.3274399.2608436689330613144.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210925171743.173219-1-colin.king@canonical.com>
References: <20210925171743.173219-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 18:17:43 +0100, Colin King wrote:
> There are spelling mistakes in dev_warn messages. Fix them.

Applied, thanks!

[1/1] platform/chrome: cros_ec: Fix spelling mistake "responsed" -> "response"
      commit: eb057514ccca92d44f37be057152c7d2791cdae0

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
