Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00DD34FA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhCaHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:38:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbhCaHhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:37:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 59DBE1F45444
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for device within remove function
Date:   Wed, 31 Mar 2021 09:37:43 +0200
Message-Id: <161717624818.4118309.9224826406108424193.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319015103.3751672-1-pmalani@chromium.org>
References: <20210319015103.3751672-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 18:51:03 -0700, Prashant Malani wrote:
> In a couple of call sites, we use the same pattern of checking for a
> partner or cable device before attempting to remove it. Simplify this by
> moving those checks into the remove functions.

Applied, thanks!

[1/1] platform/chrome: cros_ec_typec: Check for device within remove function
      commit: 639ff208cb37c5a3f0198e62d04962b677d25c9c

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
