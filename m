Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA979368D78
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbhDWG6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:58:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33184 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbhDWG6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:58:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CA7351F43800
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 1/2] platform/chrome: cros_ec: Add Type C hard reset
Date:   Fri, 23 Apr 2021 08:57:30 +0200
Message-Id: <161916102147.2605538.16322176456834391705.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420171617.3830902-1-pmalani@chromium.org>
References: <20210420171617.3830902-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 10:16:11 -0700, Prashant Malani wrote:
> Update the EC command header to include the new event bit. This bit
> is included in the latest version of the Chrome EC headers[1].
> 
> [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

Applied, thanks!

[1/2] platform/chrome: cros_ec: Add Type C hard reset
      commit: 67880f1bc342ed4c94e72cad7f8ca76e5121aae3
[2/2] platform/chrome: cros_ec_typec: Handle hard reset
      commit: 944b3a639573796debe3cd47298a5dd79810be73

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
