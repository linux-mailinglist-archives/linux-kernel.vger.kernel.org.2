Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E534FA70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhCaHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:38:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54056 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhCaHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:37:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DA8CF1F45457
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: wilco_ec: convert stream-like files from nonseekable_open -> stream_open
Date:   Wed, 31 Mar 2021 09:37:44 +0200
Message-Id: <161717624818.4118309.1021101268567300865.b4-ty@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1612688918-63132-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1612688918-63132-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Feb 2021 17:08:38 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/platform/chrome/wilco_ec/telemetry.c:259:1-17: WARNING:
> telem_fops: .read() and .write() have stream semantic; safe to change
> nonseekable_open -> stream_open.

Applied, thanks!

[1/1] platform/chrome: wilco_ec: convert stream-like files from nonseekable_open -> stream_open
      commit: dbc334fb411f2e87ca0e812dc7ba13464aa89504

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
